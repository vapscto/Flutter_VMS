import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tour_mapping/api/demo_response_api.dart';
import 'package:m_skool_flutter/vms/tour_mapping/api/tour_lead_list.dart';
import 'package:m_skool_flutter/vms/tour_mapping/api/tour_lead_name_api.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';
import 'package:m_skool_flutter/vms/tour_mapping/screen/demo_respose.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class TourMapingList extends StatefulWidget {
  LoginSuccessModel loginSuccessModel;
  MskoolController mskoolController;
  TourMapingList(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});

  @override
  State<TourMapingList> createState() => _TourMapingListState();
}

class _TourMapingListState extends State<TourMapingList> {
  TourLeadController controller = Get.put(TourLeadController());
  String category = '';
  int ismsLEDMID = 0;
  int ierID = 0;
  String statusName = "";
  int iSMSLEId = 0;
  int categoryId = 0;
  @override
  void initState() {
    intiApi();
    super.initState();
  }

  void intiApi() async {
    await featchTourName(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        controller: controller,
        userId: widget.loginSuccessModel.userId!);
    if (controller.listLeadName.isNotEmpty) {
      await featchTourNameLeadList(
          base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
          controller: controller,
          iredId: controller.listLeadName.first.iERID!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Tour Maping").getAppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: controller.tourLeadListLoading.value
              ? const AnimatedProgressWidget(
                  animationPath: 'assets/json/default.json',
                  title: 'Loading data',
                  desc: "Please wait we are loading data",
                )
              : Column(
                  children: [
                    controller.listLeadName.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 20),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(14.0),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 8,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Planer Name: ${controller.listLeadName.elementAt(0).iERPlanName.toString()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(fontSize: 14)),
                                ).paddingSymmetric(horizontal: 10),
                              ),
                            ))
                        : const SizedBox(
                            height: 20,
                          ),
                    controller.listTourListName.isNotEmpty
                        ? SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: DataTable(
                                  dataTextStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(0, 0, 0, 0.95),
                                      fontWeight: FontWeight.w500),
                                  dataRowHeight: 40,
                                  headingRowHeight: 40,
                                  horizontalMargin: 10,
                                  columnSpacing: 20,
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
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Category Name',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Lead Name',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Student Strength',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Staff Strength',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Product Name',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Source Name',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'State Name',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Action',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'TADA Document',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                      controller.listTourListName.length,
                                      (index) {
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              controller.listTourListName
                                                  .elementAt(index)
                                                  .iMRCCategoryName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black))))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              controller.listTourListName
                                                  .elementAt(index)
                                                  .iSMSLELeadName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black))))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              controller.listTourListName
                                                  .elementAt(index)
                                                  .iSMSLEStudentStrength!
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black))))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              controller.listTourListName
                                                  .elementAt(index)
                                                  .iSMSLEStaffStrength
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black))))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              controller.listTourListName
                                                  .elementAt(index)
                                                  .iSMSMPRProductName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black))))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              controller.listTourListName
                                                  .elementAt(index)
                                                  .sourceName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black))))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              controller.listTourListName
                                                  .elementAt(index)
                                                  .iVRMMSName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black))))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            onTap: () async {
                                              category = controller
                                                  .listTourListName
                                                  .elementAt(index)
                                                  .iMRCCategoryName!;
                                              ismsLEDMID = controller
                                                  .listTourListName
                                                  .elementAt(index)
                                                  .iSMSLEDMId!;
                                              ierID = controller
                                                  .listTourListName
                                                  .elementAt(index)
                                                  .iERID!;
                                              statusName = controller
                                                  .listTourListName
                                                  .elementAt(index)
                                                  .iVRMMSName!;
                                              iSMSLEId = controller
                                                  .listTourListName
                                                  .elementAt(index)
                                                  .iSMSLEId!;
                                              categoryId = controller
                                                  .listTourListName
                                                  .elementAt(index)
                                                  .iMRCCategoryId!;
                                              if (controller.listDemoRespose
                                                      .isNotEmpty &&
                                                  controller.listDemoStatus
                                                      .isNotEmpty) {
                                                controller.listDemoRespose
                                                    .clear();
                                                controller.listDemoStatus
                                                    .clear();
                                                controller.demoRemarkEdt
                                                    .clear();
                                                controller.demoNegotiateList
                                                    .clear();
                                                controller.checkBoxList.clear();
                                                controller.demoCancelList
                                                    .clear();
                                                controller.demoNegotiate
                                                    .clear();
                                                controller.demoMouList.clear();
                                                controller.demoDropDown.clear();
                                                controller.cheackedCheckBox
                                                    .clear();
                                                controller.demoQutionFlag
                                                    .clear();
                                              }
                                              await featchDemoResponse(
                                                base: baseUrlFromInsCode(
                                                    "issuemanager",
                                                    widget.mskoolController),
                                                controller: controller,
                                                ismsle: controller
                                                    .listTourListName
                                                    .elementAt(index)
                                                    .iSMSLEId!,
                                                ismsledm: controller
                                                    .listTourListName
                                                    .elementAt(index)
                                                    .iSMSLEDMId!,
                                                miId: controller
                                                    .listTourListName
                                                    .elementAt(index)
                                                    .iVRMMSId!,
                                              );
                                            },
                                            child: Text(
                                              "View Demo Respose",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blue)),
                                            ),
                                          ))),
                                      const DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.visibility,
                                            color: Colors.blue,
                                          ))),
                                    ]);
                                  }),
                                )))
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.listDemoRespose.isNotEmpty
                        ? DemoResponsePage(
                            controller: controller,
                            loginSuccessModel: widget.loginSuccessModel,
                            mskoolController: widget.mskoolController,
                            category: category,
                            ismsLEDMID: ismsLEDMID,
                            iredId: ierID,
                            stataName: statusName,
                            iSMSLEId: iSMSLEId,
                            categoryId: categoryId,
                          )
                        : const SizedBox()
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.listTourListName.clear();
    controller.listLeadName.clear();
    super.dispose();
  }
}
