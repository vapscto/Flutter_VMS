import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/api/submit_dr.dart';

import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';

class DRApprovalScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String date;
  const DRApprovalScreen(
      {required this.loginSuccessModel,
      required this.mskoolController,
      required this.date,
      super.key});

  @override
  State<DRApprovalScreen> createState() => _DRApprovalScreenState();
}

class _DRApprovalScreenState extends State<DRApprovalScreen> {
  List<String> statusList = ['Approved', 'Rejected'];
  String? dropdownvalue;
  bool isLoadingTab=false;
  Map<String, dynamic> selectedemployeedetails = {};
  List<Map<String, dynamic>> getAllDrLists = [];
  DrDetailsCtrlr controller = Get.put(DrDetailsCtrlr());
  TextEditingController descTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    dropdownvalue = statusList.first;
  }

  loadListDr() async {
    getAllDrLists.clear();
           
   controller.updateTabLoading(true);
    double countToatalEffort = 0;
    for (int i = 0; i < controller.etRemakeList.length; i++) {
      getAllDrLists.add({
        "Approvedflag":
            controller.statusET[i].text == "Approved" ? true : false,
        "Efforts": int.parse(controller.etHoursList.elementAt(i).text),
        "HRME_Id": controller.drdList.elementAt(i).hRMEId,
        "ISMDRPT_Id": controller.drdList.elementAt(i).iSMDRPTId,
        "ISMDRPT_TimeTakenInHrsmin": "Hours",
        "ISMTCR_Id": controller.drdList.elementAt(i).iSMTCRId,
        "ISMTPLTA_Id": controller.drdList.elementAt(i).iSMTPLTAId,
        "Remarks": controller.etRemakeList.elementAt(i).text,
        "Task_Response": controller.statusET[i].text == "Approved" ? "" : "Open"
      });

      countToatalEffort +=
          double.parse(controller.etHoursList[i].text.toString());
    }

    selectedemployeedetails.addAll({
      "HRME_Id": controller.empDetails.first.hRMEId,
      "approvedefforts": countToatalEffort,
      "employeename": controller.empDetails.first.empName,
      "fromdate": widget.date,
      "remarks": descTextEditingController.text,
      "selectedapprovaldetails": getAllDrLists
    });
    // controller.updateTabLoading(true);
    await submitDrs(
      base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
      date: widget.date,
      userId: widget.loginSuccessModel.userId!,
      mi_id: widget.loginSuccessModel.mIID!,
      selectedemployeedetails: selectedemployeedetails,
      controller: controller,
    ).then((value) {
      if (value) {
        controller.updateTabLoading(false);
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomGoBackButton(),
          title: const Text(
            "Daily Report Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: [
             Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Obx(
              () => controller.drIsLoading.value
                  ? const SizedBox()
                  : BtnSave(
                      title:  'Submit',
                      onPress: () {
                       if(descTextEditingController.text.isNotEmpty){
                          loadListDr();  
                          }else{
                             Fluttertoast.showToast(msg: "Please enter overAll remark");
                          }
                         
                          logger.d(selectedemployeedetails);  
                      },
                    ),
            ),
          )
          //   Padding(
          //     padding:
          //         const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          //     child:  Obx(() => BtnSave(
          //               title: 'submit',
          //               onPress: () {
                          
          //                 if(descTextEditingController.text.isNotEmpty){
          //                 loadListDr();  
          //                 }else{
          //                    Fluttertoast.showToast(msg: "Please enter overAll remark");
          //                 }
                         
          //                 logger.d(selectedemployeedetails);
          //               },
          //             )),
          //   ),
           ],
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Obx(() => controller.drdList.isEmpty
                  ? const AnimatedProgressWidget(
                      animationPath: 'assets/json/default.json',
                      title: 'Loading data',
                      desc: "Please wait we are loading data",
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: SingleChildScrollView(
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
                              dataRowHeight: 150,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              columnSpacing: 30,
                              dividerThickness: 1,
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              columns: const [
                                // 1
                                DataColumn(
                                  numeric: true,
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'S.No',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                //2
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Task DR Detail',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                // 3
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'DR Response',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                // 4
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Effort',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                // 5
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Change Effort',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                // 6
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Status',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                // 7
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Remark',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(controller.drdList.length,
                                  (index) {
                                var i = index + 1;
                                return DataRow(
                                  cells: [
                                    DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text('$i'))),
                                    DataCell(Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller.drdList
                                                .elementAt(index)
                                                .iSMTCRTaskNo!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3,
                                                  overflow: TextOverflow.clip,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              controller.drdList
                                                  .elementAt(index)
                                                  .iSMTCRTitle!,
                                              maxLines: 3,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13.0,
                                                    letterSpacing: 0.3,
                                                    overflow: TextOverflow.clip,
                                                  )),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "DR Date : ${controller.drdList.elementAt(index).iSMDRPTDate!}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3,
                                                  overflow: TextOverflow.clip,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "DR Status : ${controller.drdList.elementAt(index).iSMDRPTStatus!}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3,
                                                  overflow: TextOverflow.clip,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Task Category : ${controller.drdList.elementAt(index).iSMMTCATTaskCategoryName}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3,
                                                  overflow: TextOverflow.clip,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ])),
                                    DataCell(SizedBox(
                                      width: 200,
                                      child: Scrollbar(
                                        radius: const Radius.circular(10),
                                        thickness: 2.0,
                                        interactive: true,
                                        thumbVisibility: false,
                                        trackVisibility: false,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            controller.drdList
                                                .elementAt(index)
                                                .iSMDRPTRemarks!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.3,
                                                  overflow: TextOverflow.clip,
                                                )),
                                          ),
                                        ),
                                      ),
                                    )),
                                    DataCell(Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Actual Effort',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3,
                                                overflow: TextOverflow.clip,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.drdList.elementAt(index).iSMTPLTAEffortInHrs!.toInt().toString().padLeft(2, '0')} Hrs : 00 Mins",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3,
                                                overflow: TextOverflow.clip,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Time Taken',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3,
                                                overflow: TextOverflow.clip,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${controller.drdList.elementAt(index).iSMDRPTTimeTakenInHrs!.toInt().toString().padLeft(2, '0')} Hrs : 00 Mins",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3,
                                                overflow: TextOverflow.clip,
                                              )),
                                        ),
                                      ],
                                    )),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 80,
                                                  child: TextField(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        )),
                                                    decoration: InputDecoration(
                                                        border:
                                                         const   OutlineInputBorder(),
                                                        hintText: " HH ",
                                                        hintStyle: Theme.of(
                                                                context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            ))),
                                                    controller: controller
                                                        .etHoursList
                                                        .elementAt(index),
                                                  )),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: 80,
                                                child: TextField(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      )),
                                                  decoration: InputDecoration(
                                                      border:
                                                        const  OutlineInputBorder(),
                                                      hintText: " MM ",
                                                      hintStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .merge(
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.3,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                          ))),
                                                  controller: controller
                                                      .etMinutesList
                                                      .elementAt(index),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 80,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "HH",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            )),
                                                      ))),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: 80,
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "MM",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .merge(
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.3,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                          )),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: DropdownMenu<String>(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                              letterSpacing: 0.3,
                                              overflow: TextOverflow.clip,
                                            )),
                                        controller: controller.statusET
                                            .elementAt(index),
                                        initialSelection:
                                            controller.sList.first,
                                        onSelected: (String? value) {
                                          setState(() {
                                            controller.statusET[index].text =
                                                value!;
                                          });
                                        },
                                        dropdownMenuEntries: controller.sList
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList(),
                                      ),
                                    )),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 120,
                                        height: 100,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder()),
                                          maxLines: 7,
                                          controller: controller.etRemakeList
                                              .elementAt(index),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3,
                                                overflow: TextOverflow.clip,
                                              )),
                                        ),
                                      ),
                                    )),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                  validator: (value) {
                    // if (value != null) {
                    //   return "";
                    // }
                    // return null;
                  },
                  controller: descTextEditingController,
                  maxLines: 6,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .merge(const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        letterSpacing: 0.3,
                        overflow: TextOverflow.clip,
                      )),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Write remark",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .merge(const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                            letterSpacing: 0.3,
                            overflow: TextOverflow.clip,
                          ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.drdList.clear();
    controller.statusET.clear();
    controller.etHoursList.clear();
    controller.etMinutesList.clear();
    controller.etRemakeList.clear();
    super.dispose();
  }
}
