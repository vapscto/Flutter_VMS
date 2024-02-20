import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/api/get_lead_details.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/api/saveLead.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/controller/lead_controller.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/model/lead_details.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class LeadSelect extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const LeadSelect(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<LeadSelect> createState() => _LeadSelectState();
}

class _LeadSelectState extends State<LeadSelect> {
  RxString dropdownValue = "".obs;
  Rx<TextEditingController> controller = TextEditingController(text: "").obs;
  Rx<TextEditingController> remarkController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> executedController =
      TextEditingController(text: "").obs;    
  Rx<int>  selectrleId = Rx(0);
  final leadController = Get.put(LeadController());
   GetEmpDetailsController getEmpDetailsController =
      Get.put(GetEmpDetailsController());
    RxBool gpsLoction = RxBool(false); 
  @override
  void initState() {
    initApp();
    super.initState();
  }

  initApp() async {
          //    gpsLoction.value = true;
          
    await feacthLeadClient(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        controller: leadController,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!);

   await  getEmpDetailsController.getLocation().then(
          (value) {
            if(value){
              gpsLoction.value = value;
            }
          },
        );
        dropdownValue.value = leadController.getLeadList.first.iSMSLELeadName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Tour Lead Select").getAppBar(),
      body: Obx(
        ()=> SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: leadController.loading.isTrue?
       const  AnimatedProgressWidget(
                  animationPath: 'assets/json/default.json',
                  title: 'Loading...',
                  desc: "we are loading data",
                )
        : leadController.getLeadList.isEmpty ?
        const  AnimatedProgressWidget(
                  animationPath: 'assets/json/nodata.json',
                  title: 'No data',
                  desc: "there is no data",
                ):
           Column(children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: TypeAheadFormField<LeadCilentValues>(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: Get.textTheme.titleSmall!
                        .merge(const TextStyle(fontSize: 18)),
                    controller: controller.value,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(const TextStyle(
                              fontSize: 16,
                            )),
                        hintText: leadController.getLeadList.isNotEmpty
                            ? 'Search Client'
                            : 'No data available',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: const CustomDropDownLabel(
                          icon: 'assets/images/prof4.png',
                          containerColor: Color.fromRGBO(231, 223, 254, 1),
                          text: 'Client',
                          textColor: Color.fromRGBO(96, 40, 200, 1),
                        ),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 30,
                        )),
                  ),
                   suggestionsCallback: (pattern) {
                        return leadController.getLeadList.where((lead) =>
                          lead.iSMSLELeadName!.toLowerCase().contains(pattern.toLowerCase())
                        );
                      },

                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      onTap: () {
                        controller.value.text = suggestion.iSMSLELeadName!;
                        selectrleId.value = suggestion.iercleId!;
                        FocusScope.of(context).unfocus();
                      },
                      title: Text(
                        suggestion.iSMSLELeadName!,
                        style: Get.textTheme.titleSmall!
                            .merge(const TextStyle(fontSize: 20)),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    dropdownValue.value = suggestion.iSMSLELeadName!;
                  },
                  noItemsFoundBuilder: (context) {
                    return const SizedBox();
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 8,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: TextField(
                    maxLines: 1,
                     textInputAction: TextInputAction.go,
                    controller: executedController.value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      hintText: "DemoExecuted",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .merge(const TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                          )),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: const CustomDropDownLabel(
                        icon: 'assets/images/examnew.png',
                        containerColor: Color.fromRGBO(216, 229, 247, 1),
                        text: 'Demo Status',
                        textColor: Color.fromRGBO(7, 117, 219, 1),
                      ),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .merge(const TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  
                )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 8,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Scrollbar(
                    controller: ScrollController(),
                    isAlwaysShown: true,
                    radius: const Radius.circular(20),
                    trackVisibility: true,
                    thickness: 5.0,
                    child: TextField(
                       textInputAction: TextInputAction.go,
                      maxLines: 13,
                      controller: remarkController.value,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        hintText: "Enter Remark",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(const TextStyle(
                              fontSize: 16,
                               color: Colors.grey
                            )),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: const CustomDropDownLabel(
                          icon: 'assets/images/examnew.png',
                          containerColor: Color.fromRGBO(216, 229, 247, 1),
                          text: 'Remark',
                          textColor: Color.fromRGBO(7, 117, 219, 1),
                        ),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .merge(const TextStyle(
                            fontSize: 18,
                          )),
                    ),
                  ),
                  
                )),
                
            const SizedBox(
              height: 40,
            ),
            Visibility(
              visible: gpsLoction.value,
              child: MSkollBtn(
                title: "Save",
                onPress: () async{
                await  saveLeadClient(
                    base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
                    demostatus: executedController.value.text,
                    ierId:  selectrleId.value,
                    ierRemark: remarkController.value.text,
                    lat: "${getEmpDetailsController.latitude.value}",
                    longitude: "${getEmpDetailsController.longitude}",
                    miId: widget.loginSuccessModel.mIID!,
                    userId: widget.loginSuccessModel.userId!
                  ).then(
                    (value) {
                      if(value!="Save"){
                        Fluttertoast.showToast(msg: "Data Saved Successfully");
                      }else{
                         Fluttertoast.showToast(msg: "Data not Saved");
                      }
                    },
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
  @override
  void dispose() {
    leadController.getLeadList.clear();
    super.dispose();
  }
}

