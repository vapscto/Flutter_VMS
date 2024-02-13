import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/api/get_lead_details.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/controller/lead_controller.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/model/lead_details.dart';
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
  final leadController = Get.put(LeadController());
  @override
  void initState() {
    initApp();
    super.initState();
  }

  initApp() async {
    await feacthLeadClient(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        controller: leadController,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!);
        dropdownValue.value = leadController.getLeadList.first.iSMSLELeadName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Tour Lead Select").getAppBar(),
      body: Obx(
        ()=> SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
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
            MSkollBtn(
              title: "Save",
              onPress: () {},
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

