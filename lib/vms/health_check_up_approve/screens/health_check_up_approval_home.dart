import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/health_check_up_approve_api.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/health_check_up_approve_controller.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_check_up_comments.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_check_up_inst_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_data_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/screens/health_check_up_approved.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/view_file_widget.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/screens/view_planer.dart';
import 'package:m_skool_flutter/vms/utils/save_btn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class HealthCheckUpApprovalHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const HealthCheckUpApprovalHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<HealthCheckUpApprovalHome> createState() =>
      _HealthCheckUpApprovalHomeState();
}

class _HealthCheckUpApprovalHomeState extends State<HealthCheckUpApprovalHome> {
  HealthCheckUpApproveController controller =
      Get.put(HealthCheckUpApproveController());
  _onLoad() async {
    controller.isInitialLoading.value = true;
    await HealthCheckUpApproveAPI.i.onLoadAPI(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        controller: controller);
    _allData(controller.selectedInstitution!.mIId!);
    controller.isInitialLoading.value = false;
  }

  _allData(int miId) async {
    controller.isDataLoading.value = true;
    await HealthCheckUpApproveAPI.i.allData(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: miId,
        controller: controller);
    for (int i = 0; i < controller.detailsList.length; i++) {
      isCheckedList.add(false);
      remarksList.add(TextEditingController(text: ""));
      selectedStatusList.add("");
    }
    controller.isDataLoading.value = false;
  }

  List<HealthCheckupDataModelValues> selectedDetailsList = [];
  @override
  void initState() {
    _onLoad();
    super.initState();
  }

  List<bool> isCheckedList = [];
  List<TextEditingController> remarksList = [];
  List<String> statusList = ["Approved", "Rejected"];
  List<String> selectedStatusList = [];
  List<Map<String, dynamic>> selectdBody = [];
  RxBool isLoading = RxBool(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Health Checkup Approval", action: [
        Obx(() {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: (isLoading.value)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : BtnSave(
                    title: 'Save',
                    onPress: () async {
                      selectdBody.clear();
                      if (selectedDetailsList.isEmpty) {
                        Fluttertoast.showToast(msg: "Please Select Check Box");
                        return;
                      }
                      for (int i = 0; i < isCheckedList.length; i++) {
                        if (isCheckedList[i] && remarksList[i].text.isEmpty) {
                          Fluttertoast.showToast(
                            msg:
                                "Remarks cannot be empty for selected checkbox at index $i",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                          );
                          return;
                        } else if (selectedStatusList[i].isEmpty) {
                          Fluttertoast.showToast(
                            msg:
                                "Select Status for selected checkbox at index $i",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                          );
                          return;
                        }
                      }
                      if (selectedDetailsList.isNotEmpty) {
                        for (int i = 0; i < selectedDetailsList.length; i++) {
                          selectdBody.add({
                            "HWHCHUP_Id": selectedDetailsList[i].hWHCHUPId,
                            "Approved_Level":
                                selectedDetailsList[i].approvedLevel,
                            "ISMMCLT_Id": selectedDetailsList[i].iSMMCLTId,
                            "HRME_Id": selectedDetailsList[i].hRMEId,
                            "FinalFlag": selectedDetailsList[i].finalFlag,
                            "apprvlremarks": remarksList[i].text,
                            "approvalstatus": selectedStatusList[i]
                          });
                        }
                      }
                      isLoading.value = true;
                      await HealthCheckUpApproveAPI.i.approvehealthCheckup(
                          base: baseUrlFromInsCode(
                              "issuemanager", widget.mskoolController),
                          body: {
                            "MI_Id": widget.loginSuccessModel.mIID,
                            "ApprovalDetails_Temp": selectdBody
                          }).then((value) {
                        isLoading.value = false;
                        if (value == true) {
                          Fluttertoast.showToast(
                              msg: "Record Saved/Updated Successfully");
                          _onLoad();
                        } else {
                          Fluttertoast.showToast(
                              msg: "Failed To Save/Updated Record");
                        }
                      });
                    },
                  ),
          );
        })
      ]).getAppBar(),
      body: Obx(() {
        return controller.isInitialLoading.value
            ? const AnimatedProgressWidget(
                animationPath: 'assets/json/default.json',
                title: 'Loading data',
                desc: "Please wait we are loading data",
              )
            : (controller.institutionList.isEmpty)
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: 'assets/json/nodata.json',
                      title: 'No data Available',
                      desc: " ",
                      animatorHeight: 250,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        DropdownButtonFormField<HealthCheckupInstModelValues>(
                          value: controller.selectedInstitution,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.all(16.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: 'Select Institution',
                            hintStyle: Get.textTheme.titleSmall!
                                .copyWith(color: Colors.grey),
                            labelStyle: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 15),
                            labelText: "Institution",
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 30,
                          items: List.generate(
                            controller.institutionList.length,
                            (index) =>
                                DropdownMenuItem<HealthCheckupInstModelValues>(
                              value:
                                  controller.institutionList.elementAt(index),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 8, right: 8),
                                child: Text(
                                  controller.institutionList
                                          .elementAt(index)
                                          .mIName ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            ),
                          ),
                          onChanged: (s) async {
                            setState(() {
                              controller.selectedInstitution = s!;
                              _allData(s.mIId!);
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                            child: (controller.isDataLoading.value)
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                      backgroundColor: Colors.green,
                                      strokeWidth: 6,
                                    ),
                                  )
                                : (controller.detailsList.isEmpty)
                                    ? const Center(
                                        child: Text("Data is not Available"),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        padding:
                                            const EdgeInsets.only(bottom: 40),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: DataTable(
                                              showCheckboxColumn: true,
                                              headingRowColor:
                                                  MaterialStatePropertyAll(
                                                      Theme.of(context)
                                                          .primaryColor),
                                              headingTextStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              dataTextStyle:
                                                  Get.textTheme.titleSmall!,
                                              dataRowHeight:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.23,
                                              headingRowHeight:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                              horizontalMargin: 10,
                                              columnSpacing:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                              dividerThickness: 1,
                                              border: TableBorder.all(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  width: 0.5),
                                              columns: const [
                                                DataColumn(
                                                  label: Text("SL No."),
                                                ),
                                                DataColumn(
                                                  label: Text("Details"),
                                                ),
                                                DataColumn(
                                                  label: Text("Remarks"),
                                                ),
                                                DataColumn(
                                                  label:
                                                      Text("Approval Remarks"),
                                                ),
                                                DataColumn(
                                                  label: Text("Status"),
                                                ),
                                              ],
                                              rows: List.generate(
                                                  controller.detailsList.length,
                                                  (index) {
                                                var i = index + 1;
                                                var d = controller.detailsList
                                                    .elementAt(index);

                                                return DataRow(cells: [
                                                  DataCell(Row(
                                                    children: [
                                                      Text(i.toString()),
                                                      Checkbox(
                                                        fillColor:
                                                            MaterialStatePropertyAll(
                                                                Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        value: isCheckedList[
                                                            index],
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            isCheckedList[
                                                                index] = value!;
                                                            if (value == true) {
                                                              selectedDetailsList
                                                                  .add(d);
                                                            } else {
                                                              selectedDetailsList
                                                                  .remove(d);
                                                            }

                                                            if (!value) {
                                                              remarksList[index]
                                                                  .clear();
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  )),
                                                  DataCell(SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text.rich(TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      "Client:- ",
                                                                  style: Get
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Theme.of(context).primaryColor)),
                                                              TextSpan(
                                                                  text:
                                                                      d.iSMMCLTClientName ??
                                                                          "")
                                                            ])),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text.rich(TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      "Status:- ",
                                                                  style: Get
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Theme.of(context).primaryColor)),
                                                              TextSpan(
                                                                  text:
                                                                      d.hWHCHUPStauts ??
                                                                          "")
                                                            ])),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text.rich(TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      "Vosited Persion:- ",
                                                                  style: Get
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Theme.of(context).primaryColor)),
                                                              TextSpan(
                                                                  text:
                                                                      d.hRMEEmployeeFirstName ??
                                                                          "")
                                                            ])),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text.rich(TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      "Visited Date:- ",
                                                                  style: Get
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Theme.of(context).primaryColor)),
                                                              TextSpan(
                                                                  text:
                                                                      d.hWHCHUPDate ??
                                                                          "")
                                                            ])),
                                                        const SizedBox(
                                                            height: 3),
                                                        Row(
                                                          children: [
                                                            Text("Files:- ",
                                                                style: Get
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Theme.of(context)
                                                                            .primaryColor)),
                                                            InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await HealthCheckUpApproveAPI
                                                                      .i
                                                                      .fileView(
                                                                          base: baseUrlFromInsCode(
                                                                              "issuemanager",
                                                                              widget
                                                                                  .mskoolController),
                                                                          hwhchupId: d
                                                                              .hWHCHUPId!,
                                                                          miId: widget
                                                                              .loginSuccessModel
                                                                              .mIID!)
                                                                      .then(
                                                                          (value) {
                                                                    if (value!
                                                                        .isNotEmpty) {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return ViewHealthCheckupFileDialog(
                                                                              files: value);
                                                                        },
                                                                      );
                                                                    } else {
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "File is not Available");
                                                                    }
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ))
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 3),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "View Comments:- ",
                                                                style: Get
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Theme.of(context)
                                                                            .primaryColor)),
                                                            InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) {
                                                                    return Dialog(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      insetPadding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              16,
                                                                          vertical:
                                                                              30),
                                                                      child:
                                                                          ConstrainedBox(
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          maxHeight:
                                                                              MediaQuery.of(context).size.height * 0.4,
                                                                          minHeight:
                                                                              100,
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Expanded(
                                                                              child: FutureBuilder<List<HealthCheckupCommentsValues>?>(
                                                                                future: HealthCheckUpApproveAPI.i.comments(
                                                                                  base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
                                                                                  hwhchupId: d.hWHCHUPId!,
                                                                                  miId: widget.loginSuccessModel.mIID!,
                                                                                ),
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                    return const Center(
                                                                                      child: AnimatedProgressWidget(
                                                                                        title: "Loading",
                                                                                        desc: "",
                                                                                        animationPath: "assets/json/default.json",
                                                                                      ),
                                                                                    );
                                                                                  } else if (snapshot.hasError) {
                                                                                    return Center(
                                                                                      child: Text(
                                                                                        snapshot.error.toString(),
                                                                                        style: Get.textTheme.titleMedium,
                                                                                      ),
                                                                                    );
                                                                                  } else if (snapshot.hasData) {
                                                                                    final data = snapshot.data;
                                                                                    if (data!.isEmpty) {
                                                                                      return Center(
                                                                                        child: Text(
                                                                                          "Comment is not Available",
                                                                                          style: Get.textTheme.titleMedium,
                                                                                        ),
                                                                                      );
                                                                                    }
                                                                                    return ListView.separated(
                                                                                      padding: const EdgeInsets.all(16),
                                                                                      itemBuilder: (context, index) {
                                                                                        return Container(
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                            border: Border.all(color: Colors.grey),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(8),
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: [
                                                                                              Text.rich(TextSpan(children: [
                                                                                                TextSpan(
                                                                                                  text: "Approved User:- ",
                                                                                                  style: Get.textTheme.titleSmall!.copyWith(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: Theme.of(context).primaryColor,
                                                                                                  ),
                                                                                                ),
                                                                                                TextSpan(text: data[index].userName ?? ""),
                                                                                              ])),
                                                                                              const SizedBox(height: 3),
                                                                                              Text.rich(TextSpan(children: [
                                                                                                TextSpan(
                                                                                                  text: "Date:- ",
                                                                                                  style: Get.textTheme.titleSmall!.copyWith(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: Theme.of(context).primaryColor,
                                                                                                  ),
                                                                                                ),
                                                                                                TextSpan(text: getDate(DateTime.parse(data[index].visitedDate!))),
                                                                                              ])),
                                                                                              const SizedBox(height: 3),
                                                                                              Text.rich(TextSpan(children: [
                                                                                                TextSpan(
                                                                                                  text: "Remarks:- ",
                                                                                                  style: Get.textTheme.titleSmall!.copyWith(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: Theme.of(context).primaryColor,
                                                                                                  ),
                                                                                                ),
                                                                                                TextSpan(text: data[index].remarks ?? ""),
                                                                                              ])),
                                                                                              const SizedBox(height: 3),
                                                                                              Text.rich(TextSpan(children: [
                                                                                                TextSpan(
                                                                                                  text: "Level No.:- ",
                                                                                                  style: Get.textTheme.titleSmall!.copyWith(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: Theme.of(context).primaryColor,
                                                                                                  ),
                                                                                                ),
                                                                                                TextSpan(text: data[index].levelNo.toString()),
                                                                                              ])),
                                                                                              const SizedBox(height: 3),
                                                                                              Text.rich(TextSpan(children: [
                                                                                                TextSpan(
                                                                                                  text: "Status:- ",
                                                                                                  style: Get.textTheme.titleSmall!.copyWith(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: Theme.of(context).primaryColor,
                                                                                                  ),
                                                                                                ),
                                                                                                TextSpan(text: data[index].status ?? ""),
                                                                                              ])),
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      separatorBuilder: (context, index) {
                                                                                        return const SizedBox(height: 10);
                                                                                      },
                                                                                      itemCount: data.length,
                                                                                    );
                                                                                  } else {
                                                                                    return Center(
                                                                                      child: Text(
                                                                                        "Comment is not Available",
                                                                                        style: Get.textTheme.titleMedium,
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 10),
                                                                            Align(
                                                                              alignment: Alignment.bottomCenter,
                                                                              child: MSkollBtn(
                                                                                onPress: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: "Close",
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 10),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .visibility,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                                  DataCell(SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Text(
                                                      d.hWHCHUPRemarks ?? "",
                                                      maxLines: 6,
                                                    ),
                                                  )),
                                                  DataCell(
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (!isCheckedList[
                                                            index]) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Please select the checkbox to add remarks",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                          );
                                                        }
                                                      },
                                                      child: AbsorbPointer(
                                                        absorbing: !isCheckedList[
                                                            index], // Disable TextField if not checked
                                                        child: TextField(
                                                          controller:
                                                              remarksList[
                                                                  index],
                                                          style: Get.textTheme
                                                              .titleSmall,
                                                          maxLines: 6,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(6),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 6),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: DropdownButton<
                                                          String>(
                                                        style: Get.textTheme
                                                            .titleSmall,
                                                        value: selectedStatusList[
                                                                    index]
                                                                .isEmpty
                                                            ? null
                                                            : selectedStatusList[
                                                                index],
                                                        hint: Text(
                                                          "Select Status",
                                                          style: Get.textTheme
                                                              .titleSmall,
                                                        ),
                                                        underline:
                                                            const SizedBox(),
                                                        isExpanded: true,
                                                        items: statusList.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: Get
                                                                  .textTheme
                                                                  .titleSmall,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedStatusList[
                                                                    index] =
                                                                newValue!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ]);
                                              }),
                                            ),
                                          ),
                                        ),
                                      ))
                      ],
                    ),
                  );
      }),
      floatingActionButton: Obx(() {
        bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
        return (controller.loadedDataList.isEmpty || isKeyboardOpen)
            ? const SizedBox()
            : MSkollBtn(
                title: "Health CheckUp Approved Details",
                onPress: () {
                  Get.to(() => HealthCheckUpApprovedData(
                        data: controller.loadedDataList,
                        miId: widget.loginSuccessModel.mIID!,
                        mskoolController: widget.mskoolController,
                      ));
                },
              );
      }),
    );
  }
}
