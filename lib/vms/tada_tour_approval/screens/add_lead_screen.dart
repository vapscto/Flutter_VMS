import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/api/add_lead.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/clientLead_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_planerdata.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_getcategory.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class AddLeadScreen extends StatefulWidget {
  TadaTourController tadaTourController;
  final MskoolController mskoolController;
  final int hrmeId;
  final int userId;
  final int miID;
  AddLeadScreen(
      {required this.mskoolController,
      required this.hrmeId,
      required this.userId,
      required this.miID,
      required this.tadaTourController,
      super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  RxInt selectCatId = RxInt(0);
  RxString categoryName = "".obs;
  RxList<int> checkedList = <int>[].obs;
  Rx<TextEditingController> serachEt = TextEditingController(text: "").obs;
  RxList<LeadsModelValues> fillterLeads =  <LeadsModelValues>[].obs;
  @override
  void initState() {
    selectCatId.value =
        widget.tadaTourController.getTadaCategory.first.iMRCCategoryId!.toInt();
    categoryName.value = widget.tadaTourController.getTadaCategory.first.iMRCCategoryName!;    
    super.initState();
    initApi();
    fillterLeads.value = widget.tadaTourController.leadList;
  }

  initApi() async {
    await getLead(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        catId: selectCatId.value,
        hrmeId: widget.hrmeId,
        userId: widget.userId,
        miID: widget.miID,
        tadaTourController: widget.tadaTourController);
  }
  addToLead(){ 
    //getPlanerListData
    for(int i=0; i<checkedList.length;i++){
    widget.tadaTourController.getPlanerListData.add(
      TadaPlanerDataValues(
        iSMSLEId: fillterLeads.elementAt( checkedList[i]).iSMSLEId,
        iMRCCategoryId:   selectCatId.value,
        iSMSLELeadName: fillterLeads.elementAt(checkedList[i]).iSMSLELeadName,
        iSMSLEStudentStrength: fillterLeads.elementAt(checkedList[i]).iSMSLEStudentStrength,
        iSMSLEStaffStrength: fillterLeads.elementAt(checkedList[i]).iSMSLEStaffStrength,
        iSMSMPRId: fillterLeads.elementAt(checkedList[i]).iSMSMPRId,
        iSMSMPRProductName: fillterLeads.elementAt(checkedList[i]).iSMSMPRProductName,
        sourceName: fillterLeads.elementAt(checkedList[i]).sourceName,
        iVRMMSName: fillterLeads.elementAt(checkedList[i]).iVRMMSName,
        demoEmployeeFirstName: "",
        hRMEEmployeeFirstName: "",
        iERID: 0,
        iMRCCategoryName:categoryName.value,
        iVRMMSId: 0,
    )
    );
    }
    if(widget.tadaTourController.getPlanerListData.length > widget.tadaTourController.adminTotal.value){
        widget.tadaTourController.adminFlag.value =true;
    }
    Get.back();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: "Leads",
      action: [
        MSkollBtn(title: "Add Leads", onPress:  () {
           addToLead();
        },)
      ]).getAppBar(),
      body: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 40, left: 16, right: 16, bottom: 16),
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
                child: DropdownButtonFormField<TadaGetCategoryModelValues>(
                  value: widget.tadaTourController.getTadaCategory.first,
                  decoration: InputDecoration(
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
                    isDense: true,
                    hintText:
                        widget.tadaTourController.getTadaCategory.isNotEmpty
                            ? 'Select category'
                            : 'No data available',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: const CustomDropDownLabel(
                      icon: 'assets/images/sectionnew.png',
                      containerColor: Color.fromRGBO(223, 251, 254, 1),
                      text: 'Select Category',
                      textColor: Color.fromRGBO(40, 182, 200, 1),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    ),
                  ),
                  iconSize: 30,
                  items: List.generate(
                      widget.tadaTourController.getTadaCategory.length,
                      (index) {
                    return DropdownMenuItem(
                      value: widget.tadaTourController.getTadaCategory
                          .elementAt(index),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, left: 5),
                        child: Text(
                          widget.tadaTourController.getTadaCategory
                              .elementAt(index)
                              .iMRCCategoryName!,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    );
                  }),
                  onChanged: (s) async {
                    selectCatId.value = s!.iMRCCategoryId!;
                    categoryName.value = s.iMRCCategoryName!;
                    if (widget.tadaTourController.leadList.isNotEmpty) {
                     widget.tadaTourController.leadList.clear();
                    }
                    initApi();
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  filterLead(value);
                },
                controller: serachEt.value,
                style: Theme.of(context).textTheme.titleSmall!,
                decoration: InputDecoration(border:const OutlineInputBorder(),
                hintText: "Search...",
                prefixIcon:const Icon(Icons.search),
                hintStyle: Theme.of(context).textTheme.bodySmall),
              ).paddingSymmetric(horizontal: 20),
              const SizedBox(
                height: 20,
              ),
             fillterLeads.isNotEmpty
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: DataTable(
                          dataTextStyle: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 0.95),
                              fontWeight: FontWeight.w500),
                          dataRowHeight: 50,
                          headingRowHeight: 40,
                          horizontalMargin: 10,
                          columnSpacing: 30,
                          dividerThickness: 1,
                          headingTextStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                          border: TableBorder.all(
                              borderRadius: BorderRadius.circular(10),
                              width: 0.5),
                          headingRowColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          columns: const [
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text("All"),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text("SL.No"),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text("Lead Name"),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text("Student Strenth"),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text("Product Name"),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text("Source Name"),
                              ),
                            ),
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text("State Name"),
                              ),
                            ),
                          ],
                          rows: List.generate(
                             fillterLeads.length,
                              (index) {
                            int nums = index + 1;
                            return DataRow(cells: [
                              DataCell(Align(
                                child: Text("$nums"),
                              )),
                              DataCell(Align(
                                child: Checkbox(
                                  activeColor:const Color.fromARGB(255, 6, 26, 209),
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  value:widget
                                      .tadaTourController.checkBoxList[index],
                                  onChanged: (value) {
                                    widget.tadaTourController
                                        .checkBoxList[index] = value!;
                                    if (checkedList.contains(index)) {
                                      checkedList.remove(index);
                                      logger.w("${checkedList.toList()}");
                                    } else {
                                      checkedList.add(index);
                                      logger.w("${checkedList.toList()}");
                                    }
                                  },
                                ),
                              )),
                              DataCell(Align(
                                child: Text(
                                 fillterLeads
                                      .elementAt(index)
                                      .iSMSLELeadName!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )),
                              DataCell(Align(
                                child: Text(
                                 fillterLeads
                                      .elementAt(index)
                                      .iSMSLEStudentStrength!
                                      .toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )),
                              DataCell(Align(
                                child: Text(
                                 fillterLeads
                                      .elementAt(index)
                                      .iSMSMPRProductName!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )),
                              DataCell(Align(
                                child: Text(
                                 fillterLeads
                                      .elementAt(index)
                                      .sourceName!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )),
                              DataCell(Align(
                                child: Text(
                                 fillterLeads
                                      .elementAt(index)
                                      .iVRMMSName!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ))
                            ]);
                          }),
                        ),
                      ))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> filterLead(String Query)async{
   fillterLeads.value =  widget.tadaTourController.leadList.where((p0) {
     return p0.iVRMMSName!.contains(Query) || p0.sourceName!.contains(Query) ||  p0.iSMSLELeadName!.contains(Query)
     || p0.iSMSMPRProductName!.contains(Query);
   },).toList();
  }
  @override
  void dispose() {
   fillterLeads.clear();
  // widget.tadaTourController.getPlanerListData.clear();
    super.dispose();
  }
}
