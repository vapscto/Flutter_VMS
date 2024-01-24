import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/api/get_planner_details_api.dart';
import 'package:m_skool_flutter/vms/dr_genration/api/get_task_check_list.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/dr_get_taskList_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_file_upload_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/add_extra_task.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/search_previous_task.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/widget/category_checkList.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/widget/dr_not_approved_popup.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/widget/drnotApprovedScreen.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/widget/drnotsent_screen.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/widget/tada_not_approved.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/widget/tada_not_approved_widget.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class DailyReportGenration extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const DailyReportGenration(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});

  @override
  State<DailyReportGenration> createState() => _DailyReportGenrationState();
}

class _DailyReportGenrationState extends State<DailyReportGenration> {
  final PlannerDetails _plannerDetailsController = Get.put(PlannerDetails());
  RxBool halfDay = RxBool(false);
  List<int> selectCheckbox = [];
  List<GetTaskDrListModelValues> fliteresList = [];
  final _formKey = GlobalKey<FormState>();

  bool deviation = false;
  DateTime todayDt = DateTime.now();
  var currentDate;
  DateTime newDt = DateTime.now();
  @override
  void initState() {
    currentDate = "${newDt.year}-${newDt.month}-${newDt.day} 00:00:00.000";
    logger.e(currentDate);
    init();
    fliteresList = _plannerDetailsController.getTaskDrList;
    _plannerDetailsController.plannernameDateController.value.text =
        '${todayDate.day}-${todayDate.month}-${todayDate.year}';
    super.initState();
  }

  int uploadImageIndex = 0;
  List<Map<String, dynamic>> dailyReportGenaration = [];
  List<Map<String, dynamic>> todayDailyReportGenaration = [];
  List<Map<String, dynamic>> dailyReportStatus = [];
  final reasonController = TextEditingController();
  // int image = -2;
  DateTime todayDate = DateTime.now();
  List<dynamic> newValues = [];
  init() async {
    fliteresList.clear();
    _plannerDetailsController.uploadImages.clear();
    await getPlanerdetails(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        controller: _plannerDetailsController,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!);
    _plannerDetailsController.drnotSentdetailsList.isNotEmpty
        ? Get.dialog(AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            contentPadding: const EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
                width: Get.width,
                child: DrnotsentScreen(
                  mskoolController: widget.mskoolController,
                  loginSuccessModel: widget.loginSuccessModel,
                  plannerDetailsController: _plannerDetailsController,
                )),
          ))
        : null;
    (_plannerDetailsController.tadaApplyList.isNotEmpty)
        ? Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              contentPadding: const EdgeInsets.all(5),
              content: SizedBox(
                  width: Get.width,
                  child: TADANotApproveScreen(
                    mskoolController: widget.mskoolController,
                    loginSuccessModel: widget.loginSuccessModel,
                    data: _plannerDetailsController.tadaApplyList,
                  )),
            ))
        : null;
    _plannerDetailsController.drnotapprovedList.isNotEmpty
        ? Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(5),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              content: SizedBox(width: Get.width, child: DrnotApprovedScreen()),
            ))
        : null;
    if (_plannerDetailsController.getplannerdetails.isNotEmpty) {
      (_plannerDetailsController.getplannerdetails[0].ismtpLApprovalFlg ==
                  false &&
              _plannerDetailsController.getplannerdetails[0].ismtpLApprovedBy ==
                  0)
          ? Get.dialog(
              barrierDismissible: false,
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: const DrnotApproveScreen(
                  title:
                      'Still Your Planner Is Pending , So Kindly Contact Department Head',
                ),
              ))
          : null;
    } else {
      Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: const DrnotApproveScreen(
              title: 'Planner Not Created For This Week!!',
            ),
          ));
    }
    if (_plannerDetailsController.getplannerdetails.isNotEmpty) {
      (_plannerDetailsController.getplannerdetails[0].ismtpLApprovalFlg ==
                  false &&
              _plannerDetailsController.getplannerdetails[0].ismtpLApprovedBy! >
                  0)
          ? Get.dialog(
              barrierDismissible: false,
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: const DrnotApproveScreen(
                  title:
                      'Still Your Planner Is Rejected , So Kindly Contact Department Head',
                ),
              ))
          : null;
    }
    _plannerDetailsController.advanceApplyDataList.isNotEmpty
        ? Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              contentPadding: const EdgeInsets.all(5),
              content: SizedBox(
                  width: Get.width,
                  child: TADAAdvancenotApproveScreen(
                    mskoolController: widget.mskoolController,
                    loginSuccessModel: widget.loginSuccessModel,
                    data: _plannerDetailsController.advanceApplyDataList,
                  )),
            ))
        : null;
    if (_plannerDetailsController.closeTaskCoutnList.isNotEmpty) {
      _plannerDetailsController.closeTaskCoutnList[0].iSMEDWTCCTaskCount! > 0
          ? Get.dialog(
              barrierDismissible: false,
              WillPopScope(
                onWillPop: () {
                  return Future.value(false);
                },
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Update Task",
                        // ignore: use_build_context_synchronously
                        style: Theme.of(context).textTheme.titleLarge!.merge(
                            const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      )),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "You Did Not Closed The Completed Task. Kindly Go to Web and Close Your Completed Task",
                        // ignore: use_build_context_synchronously
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                            TextStyle(color: Theme.of(context).primaryColor)),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "OK",
                            style: Get.textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).primaryColor),
                          ))
                    ],
                  ),
                ),
              ))
          : null;
    }
  }

  List<Map<String, dynamic>> uploadImageList = [];
  saveDaetails() async {
    uploadImageList.clear();
    if (fliteresList.isNotEmpty) {
      // Calculate the total hours and minutes
      int totalHours = 0;
      int totalMinutes = 0;

      for (int i = 0; i < _plannerDetailsController.hoursEt.length; i++) {
        if (_plannerDetailsController.hoursEt[i].text.isNotEmpty) {
          totalHours += int.parse(_plannerDetailsController.hoursEt[i].text);
        }

        if (_plannerDetailsController.minutesEt[i].text.isNotEmpty) {
          totalMinutes +=
              int.parse(_plannerDetailsController.minutesEt[i].text);
        }
      }

      int excessHours = totalMinutes ~/ 60;
      totalHours += excessHours;
      totalMinutes %= 60;

      int currentDayOfWeek = 0;
      var totalworkinghrsflag = 0.0;
      int deviationId = 0;
      var totalhrs = 0.0;
      for (int index = 0;
          index < _plannerDetailsController.checkBoxList.length;
          index++) {
        var value = fliteresList.elementAt(index);
        DateTime currentDate = DateTime.now();
        currentDayOfWeek = currentDate.weekday;
        if (currentDayOfWeek == 6) {
          deviationId = 1;
        } else {
          deviationId = 2;
        }
        //

        if (_plannerDetailsController.uploadImages.isNotEmpty) {
          for (var j in _plannerDetailsController.uploadImages) {
            if (index == j.index) {
              logger.i(j.name);
              fileName = j.name;
              filePath = j.path;
              uploadImageIndex = j.index;
              uploadImageList.add({
                "ISMMTCATCL_Id": j.id,
                "checklistname": j.imageType,
                "comments": "",
                "filename": j.name,
                "filepath": j.path,
                "refno": '',
              });
            }
          }
          logger.i(uploadImageList.toList());
        }

        if (_plannerDetailsController.checkBoxList.elementAt(index) == true) {
          String countHr =
              (double.parse(_plannerDetailsController.minutesEt[index].text) *
                      0.0166667)
                  .toStringAsFixed(2);
          totalhrs =
              double.parse(_plannerDetailsController.hoursEt[index].text) +
                  double.parse(countHr);

          todayDailyReportGenaration.add({
            "ISMTPL_Id": (value.iSMTPLId != null)
                ? value.iSMTPLId
                : _plannerDetailsController.getplannerdetails[0].ismtpLId!,
            "ISMTCR_Id": value.iSMTCRId,
            "ISMDRPT_Remarks":
                _plannerDetailsController.etResponse.elementAt(index).text,
            "ISMDRPT_TimeTakenInHrs": '$totalhrs',
            "ISMDRPT_Status":
                _plannerDetailsController.statusEtField[index].text,
            "extraflag": 0,
            "ISMTPLTA_StartDate": value.iSMTPLTAStartDate,
            "ISMTPLTA_EndDate": value.iSMTPLTAEndDate,
            "ISMTPLTA_EffortInHrs": value.iSMTPLTAEffortInHrs,
            "deviationflag": deviation,
            "ISMDR_Id": int.parse(_plannerDetailsController
                .deveationIdEtField[index].text), //value.iSMDRId,
            "ISMDRPT_TimeTakenInHrsmin": "Hours",
            "periodicityendflag": value.periodicityendflag,
            "ISMTAPL_Periodicity": value.iSMTAPLPeriodicity,
            "ISMTPLTA_Id": value.iSMTPLTAId,
            "attachmentArray": null,
            "categorychecklist": uploadImageList,
            "Temp_TaskReponseList": null
          });
        }
        if (halfDay.value == false) {
          if (totalhrs >=
              double.parse(fliteresList
                  .elementAt(index)
                  .iSMTPLTAEffortInHrs
                  .toString())) {
            totalworkinghrsflag = 1;
          }

          if (totalhrs > 24) {
            Fluttertoast.showToast(
                msg:
                    "Effort Should Be  Less Than Equal To 24 Hours Per Day , Total Efforts Selected  $totalhrs  Hours");
            return;
          }
        } else if (halfDay.value == true) {
          var efforts = double.parse(value.effortss!) / 2;
          if (totalhrs == efforts) {
            totalworkinghrsflag = 1;
          }
        }
      }
      _plannerDetailsController.saveLoading(true);
      await saveDr(
              miID: widget.loginSuccessModel.mIID!,
              userId: widget.loginSuccessModel.userId!,
              roleId: widget.loginSuccessModel.roleId!,
              base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
              controller: _plannerDetailsController,
              ismdrptDate: _plannerDetailsController.day.value == 'Others'
                  ? todayDt.toIso8601String()
                  : currentDate,
              halfDayFlag: halfDay.value,
              ismtplId:
                  _plannerDetailsController.getplannerdetails[0].ismtpLId!,
              drList: todayDailyReportGenaration,
              deviationId: deviationId,
              endWeek:
                  _plannerDetailsController.getplannerdetails[0].ismtpLEndDate!,
              reasion: reasonController.text,
              startWeek: _plannerDetailsController
                  .getplannerdetails[0].ismtpLStartDate!,
              todayOrOthersDay: _plannerDetailsController.day.value,
              totalWorkingHrFlag: totalworkinghrsflag)
          .then((value) {
        _plannerDetailsController.saveLoading(false);
        if (value!) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Daily Report Genrated successfully',
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.back();
                            Get.back();
                          },
                          child: Text(
                            "OK",
                            style: Get.textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).primaryColor),
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          Fluttertoast.showToast(msg: "Daily Report is no save");
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Please Select Planner List");
    }
  }

  _getplannedData(DateTime todayDt) async {
    await othersDayTask(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "UserId": widget.loginSuccessModel.userId,
          "ISMDRPT_Date": todayDt.toIso8601String(),
          "roleId": widget.loginSuccessModel.roleId
        },
        controller: _plannerDetailsController);
    if (_plannerDetailsController.othersDayPlannerList.isEmpty) {
      // ignore: use_build_context_synchronously
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Planner Not Created For This Week!!',
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                          TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "OK",
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
          );
        },
      );
      _plannerDetailsController.updateDayRadio('today');
      _plannerDetailsController.plannernameDateController.value.text =
          '${todayDate.day}-${todayDate.month}-${todayDate.year}';
      return;
    }
  }

  String fileName = '';
  String filePath = '';
  int newselectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("DR Generation"),
          titleSpacing: 0,
          leading: const CustomGoBackButton(),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (_plannerDetailsController.isSaveLoading.value)
                  ? const SizedBox(
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : BtnSave(
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectCheckbox.isNotEmpty) {
                            if (_plannerDetailsController.day.value ==
                                'Others') {
                              if (_plannerDetailsController
                                      .plannernameDateController.value.text ==
                                  '${todayDate.day}-${todayDate.month}-${todayDate.year}') {
                                Fluttertoast.showToast(
                                    msg:
                                        "Other's Date Should Not Be Equal To Today's Date");
                                return;
                              }
                            }
                            saveDaetails();
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Select Check Box to Generate Daily Report");
                          }
                        } else {
                          logger.w("show damit");
                        }
                      },
                      title: "Save",
                    ),
            ),
          ],
        ),
        body: Obx(
          () => _plannerDetailsController.loadPlanerDeatails.isTrue
              ? const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    title: 'Loading data',
                    desc: "Please wait we are loading data",
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:
                      // ignore: prefer_is_empty
                      Column(
                    children: [
                      (_plannerDetailsController.closeTaskCoutnList.isNotEmpty)
                          ? (_plannerDetailsController.closeTaskCoutnList[0]
                                      .iSMEDWTCCTaskCount! >
                                  0)
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12, 12, 0),
                                  child: Text(
                                    "You Did Not Closed The Completed Task. Kindly Go to Web and Close Your Completed Task",
                                    style: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.red),
                                  ),
                                )
                              : const SizedBox()
                          : const SizedBox(),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 30),
                        child: CustomContainer(
                          child: Obx(
                            () => TextField(
                              controller: _plannerDetailsController
                                  .plannernameEditingController.value,
                              readOnly: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.3)),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color.fromARGB(
                                          255, 234, 239, 255)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        " Planner Name ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color.fromARGB(
                                                      255, 103, 118, 255)),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          child: CustomContainer(
                            child: Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child: RadioListTile(
                                      value: "today",
                                      groupValue:
                                          _plannerDetailsController.day.value,
                                      onChanged: (value) async {
                                        setState(() {
                                          _plannerDetailsController
                                              .updateDayRadio(value!);
                                          _getplannedData(todayDt);
                                          fliteresList =
                                              _plannerDetailsController
                                                  .getTaskDrList;
                                          _plannerDetailsController
                                                  .plannernameDateController
                                                  .value
                                                  .text =
                                              '${todayDate.day}-${todayDate.month}-${todayDate.year}';
                                          init();
                                        });
                                      },
                                      dense: true,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8),
                                      visualDensity:
                                          const VisualDensity(horizontal: -4.0),
                                      title: Text(
                                        "Today's",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.3)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child: RadioListTile(
                                      value: "Others",
                                      groupValue:
                                          _plannerDetailsController.day.value,
                                      dense: true,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8),
                                      visualDensity:
                                          const VisualDensity(horizontal: -4.0),
                                      title: Text(
                                        "Other's date",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.3)),
                                      ),
                                      onChanged: (value) {
                                        if (_plannerDetailsController
                                                    .deviationCount.value +
                                                3 >
                                            num.parse(_plannerDetailsController
                                                .otherDaysEditingController
                                                .value)) {
                                          _plannerDetailsController
                                              .updateDayRadio(value!);
                                          init();
                                        } else {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                title: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'Others Date Report Generation Is Not Available',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .merge(TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor)),
                                                        ),
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            "OK",
                                                            style: Get.textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                          _plannerDetailsController
                                              .updateDayRadio('today');
                                          return;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      (_plannerDetailsController.day.value == 'Others')
                          ? Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 10),
                              child: CustomContainer(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    }
                                  },
                                  controller: reasonController,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.3)),
                                  decoration: InputDecoration(
                                    hintText: "Enter reason",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300)),
                                    border: const OutlineInputBorder(),
                                    label: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          color: const Color.fromARGB(
                                              255, 212, 245, 206)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            " Reason ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color.fromARGB(
                                                          255, 20, 180, 15)),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 10),
                        child: CustomContainer(
                          child: Obx(
                            () => TextField(
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  firstDate:
                                      _plannerDetailsController.day.value ==
                                              'Others'
                                          ? DateTime(2000)
                                          : DateTime.now(),
                                  lastDate:
                                      _plannerDetailsController.day.value ==
                                              'Others'
                                          ? DateTime.now()
                                              .subtract(const Duration(days: 1))
                                          : DateTime.now(),
                                  initialDate:
                                      _plannerDetailsController.day.value ==
                                              'Others'
                                          ? DateTime.now()
                                              .subtract(const Duration(days: 1))
                                          : DateTime.now(),
                                ).then((newValue) async {
                                  _getplannedData(newValue!);
                                  _plannerDetailsController
                                      .plannernameDateController
                                      .value
                                      .text = await getDateNeed(newValue);
                                  todayDt = newValue;
                                });
                              },
                              controller: _plannerDetailsController
                                  .plannernameDateController.value,
                              readOnly: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.3)),
                              decoration: InputDecoration(
                                hintText: "Select Date",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                suffixIcon: const Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                  color: Color.fromARGB(255, 47, 175, 51),
                                ),
                                border: const OutlineInputBorder(),
                                label: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color.fromARGB(
                                          255, 212, 245, 206)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        " Date ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color.fromARGB(
                                                      255, 20, 180, 15)),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomContainer(
                          child: Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "No.of Daily Report Generated In Other's Date : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .merge(const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 16, 103, 233)))),
                                TextSpan(
                                    text: _plannerDetailsController
                                        .otherDaysEditingController.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .merge(const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 16, 103, 233)))),
                                TextSpan(
                                    text:
                                        ' [Extension: ${_plannerDetailsController.deviationCount.value}]',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .merge(const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 16, 103, 233))))
                              ])),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MSkollBtn(
                            title: "   Search Previous Daily Report :-  ",
                            onPress: () {
                              Get.to(() => SearchPreviousTask(
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                    controller: _plannerDetailsController,
                                  ));
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomContainer(
                            child: Obx(
                          () => Row(
                            children: [
                              Checkbox(
                                value: halfDay.value,
                                onChanged: (value) {
                                  halfDay.value = value!;
                                },
                                activeColor:
                                    const Color.fromARGB(255, 33, 54, 243),
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Text(
                                "Half Day Daily Report",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromARGB(
                                              255, 16, 103, 233)),
                                    ),
                              ),
                            ],
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomContainer(
                            child: Obx(
                          () => TextField(
                            onChanged: (value) {
                              filterFun(_plannerDetailsController
                                  .etSearchController.value.text);
                            },
                            controller: _plannerDetailsController
                                .etSearchController.value,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: "Search Task by Name and Task Number",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(
                                      fontSize: 14,
                                    ))),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(
                                  const TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromARGB(255, 27, 27, 27)),
                                ),
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Obx(
                        () => (fliteresList.isNotEmpty)
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: SingleChildScrollView(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        scrollDirection: Axis.horizontal,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: DataTable(
                                              dataTextStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.95),
                                                  fontWeight: FontWeight.w500),
                                              dataRowHeight: 160,
                                              headingRowHeight: 40,
                                              horizontalMargin: 10,
                                              columnSpacing: 30,
                                              dividerThickness: 1,
                                              headingTextStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                              border: TableBorder.all(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  width: 0.5),
                                              headingRowColor:
                                                  MaterialStateProperty.all(
                                                      Theme.of(context)
                                                          .primaryColor),
                                              columns: const [
                                                DataColumn(
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
                                                DataColumn(
                                                  label: Align(
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Task Details',
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
                                                      'Response',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                    label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Efforts"),
                                                )),
                                                DataColumn(
                                                    label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Status"),
                                                )),
                                                DataColumn(
                                                    label: Align(
                                                  alignment: Alignment.center,
                                                  child:
                                                      Text("Deviation Remarks"),
                                                ))
                                              ],
                                              rows: List.generate(
                                                  fliteresList.length, (index) {
                                                int i = index + 1;
                                                _plannerDetailsController
                                                    .uploadImages
                                                    .add(PlannerFileUpload(
                                                        '', '', -1, -1, ''));
                                                var startDate;
                                                if (fliteresList
                                                        .elementAt(index)
                                                        .iSMTPLStartDate !=
                                                    null) {
                                                  DateTime dt = DateTime.parse(
                                                      fliteresList
                                                          .elementAt(index)
                                                          .iSMTPLStartDate!);
                                                  startDate =
                                                      "${dt.day}-${dt.month}-${dt.year}";
                                                }
                                                var endDt;
                                                if (fliteresList
                                                        .elementAt(index)
                                                        .iSMTPLEndDate !=
                                                    null) {
                                                  DateTime newDt =
                                                      DateTime.parse(
                                                          fliteresList
                                                              .elementAt(index)
                                                              .iSMTPLEndDate!);
                                                  endDt =
                                                      "${newDt.day}-${newDt.month}-${newDt.year}";
                                                }
                                                DateTime endNewDate =
                                                    DateTime.parse(fliteresList
                                                        .elementAt(index)
                                                        .iSMTPLEndDate!);
                                                DateTime currentDt =
                                                    DateTime.now();
                                                DateTime? previousDt;
                                                int hours = fliteresList
                                                    .elementAt(index)
                                                    .iSMTPLTAEffortInHrs!
                                                    .floor();
                                                int minutes = ((fliteresList
                                                                .elementAt(
                                                                    index)
                                                                .iSMTPLTAEffortInHrs! -
                                                            hours) *
                                                        60)
                                                    .round();
                                                return DataRow(cells: [
                                                  DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('$i'))),
                                                  DataCell(Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Obx(
                                                            () => Checkbox(
                                                              shape: ContinuousRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              activeColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      21,
                                                                      46,
                                                                      189),
                                                              value: (fliteresList
                                                                          .elementAt(
                                                                              index)
                                                                          .drFlag ==
                                                                      1)
                                                                  ? true
                                                                  : _plannerDetailsController
                                                                          .checkBoxList[
                                                                      index],
                                                              onChanged:
                                                                  (value) {
                                                                newselectedIndex =
                                                                    index;

                                                                value == true
                                                                    ? getCategoryChecklistDetails(
                                                                            base:
                                                                                baseUrlFromInsCode("issuemanager", widget.mskoolController),
                                                                            controller: _plannerDetailsController,
                                                                            ismctrId: fliteresList.elementAt(index).iSMTCRId!,
                                                                            ismmcatId: fliteresList.elementAt(index).iSMMTCATId!)
                                                                        .then(
                                                                        (value) {
                                                                          if (value!
                                                                              .values!
                                                                              .isNotEmpty) {
                                                                            newValues =
                                                                                value.values!;
                                                                            Get.dialog(
                                                                                    CategoryCheckList(
                                                                                      value: value,
                                                                                      plannerDetailsController: _plannerDetailsController,
                                                                                      loginSuccessModel: widget.loginSuccessModel,
                                                                                      index: newselectedIndex,
                                                                                      newBool: _plannerDetailsController.checkBoxList[index],
                                                                                    ),
                                                                                    barrierDismissible: false)
                                                                                .then((value) {
                                                                              if (value == null) {
                                                                                _plannerDetailsController.checkBoxList[index] = false;
                                                                              } else {
                                                                                _plannerDetailsController.checkBoxList[index] = true;
                                                                              }
                                                                              setState(() {});
                                                                            });
                                                                          }
                                                                        },
                                                                      )
                                                                    : null;
                                                                _plannerDetailsController
                                                                        .checkBoxList[
                                                                    index] = value!;
                                                                if (value) {
                                                                  if (selectCheckbox
                                                                      .contains(
                                                                          index)) {
                                                                    selectCheckbox
                                                                        .remove(
                                                                            index);
                                                                  } else {
                                                                    selectCheckbox
                                                                        .add(
                                                                            index);
                                                                    String previousDateStr = fliteresList
                                                                        .elementAt(
                                                                            index)
                                                                        .iSMTPLEndDate!;
                                                                    DateTime
                                                                        previousDate =
                                                                        DateTime.parse(previousDateStr).add(const Duration(
                                                                            days:
                                                                                1));
                                                                    previousDt = DateTime.parse(
                                                                            previousDateStr)
                                                                        .add(const Duration(
                                                                            days:
                                                                                1));
                                                                    logger.e(
                                                                        "====$previousDt");
                                                                    DateTime
                                                                        currentDate =
                                                                        DateTime
                                                                            .now();
                                                                    if (currentDate
                                                                        .isAfter(
                                                                            previousDate)) {
                                                                      setState(
                                                                          () {
                                                                        deviation =
                                                                            true;
                                                                      });

                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return Center(
                                                                            child:
                                                                                Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                              height: 200,
                                                                              width: 300,
                                                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), shape: BoxShape.rectangle),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Text("Task End Date Is", style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(fontSize: 24, color: Color.fromARGB(255, 7, 85, 255)))),
                                                                                  Text(fliteresList.elementAt(index).iSMTPLEndDate.toString().replaceRange(10, null, ''), style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(fontSize: 24, color: Color.fromARGB(255, 7, 85, 255)))),
                                                                                  Text("Kindly Select Remarks", style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(fontSize: 24, color: Color.fromARGB(255, 7, 85, 255))))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    }
                                                                  }
                                                                } else {
                                                                  deviation =
                                                                      false;
                                                                  selectCheckbox
                                                                      .remove(
                                                                          index);
                                                                }
                                                              },
                                                            ),
                                                          )),
                                                      const SizedBox(height: 5),
                                                      (selectCheckbox
                                                              .isNotEmpty)
                                                          ? (_plannerDetailsController
                                                                  .uploadImages[
                                                                      index]
                                                                  .path
                                                                  .isNotEmpty)
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    createPreview(
                                                                        context,
                                                                        _plannerDetailsController
                                                                            .uploadImages[index]
                                                                            .path);
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .visibility_outlined),
                                                                )
                                                              : const SizedBox()
                                                          : const SizedBox(),
                                                    ],
                                                  )),
                                                  DataCell(Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Clipboard.setData(ClipboardData(
                                                                  text: fliteresList
                                                                      .elementAt(
                                                                          index)
                                                                      .iSMTCRTaskNo!))
                                                              .then((_) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Copied to your clipboard !')));
                                                          });
                                                        },
                                                        child: Text(
                                                          fliteresList
                                                              .elementAt(index)
                                                              .iSMTCRTaskNo!,
                                                          style: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .merge(const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          52,
                                                                          82,
                                                                          252),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          fliteresList
                                                              .elementAt(index)
                                                              .iSMTCRTitle!,
                                                          maxLines: 3,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .merge(const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Category : ${fliteresList.elementAt(index).taskcategoryname}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14)),
                                                      ),
                                                      (fliteresList
                                                                  .elementAt(
                                                                      index)
                                                                  .projectName !=
                                                              null)
                                                          ? Text(
                                                              "Project : ${fliteresList.elementAt(index).projectName}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .merge(const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14)),
                                                            )
                                                          : const SizedBox(),
                                                      Text(
                                                        "Task Start date : $startDate",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ),
                                                      Text(
                                                        "Task End date : $endDt",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14)),
                                                      )
                                                    ],
                                                  )),
                                                  DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 0,
                                                                vertical: 20),
                                                        child: SizedBox(
                                                          width: 150,
                                                          child: TextFormField(
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                if (selectCheckbox
                                                                    .contains(
                                                                        index)) {
                                                                  return 'Please  enter remark';
                                                                }
                                                              }

                                                              return null;
                                                            },
                                                            controller:
                                                                _plannerDetailsController
                                                                    .etResponse
                                                                    .elementAt(
                                                                        index),
                                                            maxLines: 6,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall,
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            .5))),
                                                          ),
                                                        ),
                                                      ))),
                                                  DataCell(Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "Actual Effort:- $hours.$minutes Hr"),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                              width: 80,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    if (selectCheckbox
                                                                        .contains(
                                                                            index)) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Please  enter hours';
                                                                      }
                                                                    }
                                                                  }

                                                                  return null;
                                                                },
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          '[0-9]'))
                                                                ],
                                                                keyboardType:
                                                                    const TextInputType
                                                                            .numberWithOptions(
                                                                        decimal:
                                                                            false),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .merge(
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.3,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                    )),
                                                                decoration:
                                                                    InputDecoration(
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                        hintText:
                                                                            " HH ",
                                                                        hintStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .titleSmall!
                                                                            .merge(const TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.3,
                                                                              overflow: TextOverflow.clip,
                                                                            ))),
                                                                controller:
                                                                    _plannerDetailsController
                                                                            .hoursEt[
                                                                        index],
                                                              )),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child:
                                                                TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (selectCheckbox
                                                                    .contains(
                                                                        index)) {
                                                                  if (value !=
                                                                          null &&
                                                                      int.tryParse(
                                                                              value) !=
                                                                          null &&
                                                                      int.parse(
                                                                              value) >
                                                                          59) {
                                                                    return ' Less then 59';
                                                                  }
                                                                }
                                                                setState(() {});
                                                                return null;
                                                              },
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        '[0-9]'))
                                                              ],
                                                              keyboardType:
                                                                  const TextInputType
                                                                          .numberWithOptions(
                                                                      decimal:
                                                                          false),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .merge(
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                  )),
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                hintText:
                                                                    " MM ",
                                                                hintStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .merge(
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.3,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                    )),
                                                              ),
                                                              controller:
                                                                  _plannerDetailsController
                                                                          .minutesEt[
                                                                      index],
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
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "HH",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .merge(
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.3,
                                                                          overflow:
                                                                              TextOverflow.clip,
                                                                        )),
                                                                  ))),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "MM",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .merge(
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.3,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                      )),
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                                  DataCell(SizedBox(
                                                    width: 180,
                                                    child: GestureDetector(
                                                      onTapUp: (details) {
                                                        final offset = details
                                                            .globalPosition;
                                                        showMenu(
                                                            context: context,
                                                            position:
                                                                RelativeRect
                                                                    .fromLTRB(
                                                              offset.dx,
                                                              offset.dy,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  offset.dx,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height -
                                                                  offset.dy,
                                                            ),
                                                            items:
                                                                List.generate(
                                                              _plannerDetailsController
                                                                  .statusDrList
                                                                  .length,
                                                              (i) {
                                                                return PopupMenuItem(
                                                                  onTap: () {
                                                                    _plannerDetailsController
                                                                            .statusEtField[
                                                                                index]
                                                                            .text =
                                                                        _plannerDetailsController
                                                                            .statusDrList[i]
                                                                            .ismmistSStatusName!;
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Text(
                                                                    _plannerDetailsController
                                                                        .statusDrList[
                                                                            i]
                                                                        .ismmistSStatusName!,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .merge(
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                        )),
                                                                  ),
                                                                );
                                                              },
                                                            ));
                                                      },
                                                      onTapDown:
                                                          (details) async {
                                                        final offset = details
                                                            .globalPosition;

                                                        showMenu(
                                                            context: context,
                                                            position:
                                                                RelativeRect
                                                                    .fromLTRB(
                                                              offset.dx,
                                                              offset.dy,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  offset.dx,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height -
                                                                  offset.dy,
                                                            ),
                                                            items:
                                                                List.generate(
                                                              _plannerDetailsController
                                                                  .statusDrList
                                                                  .length,
                                                              (i) {
                                                                return PopupMenuItem(
                                                                  onTap: () {
                                                                    _plannerDetailsController
                                                                            .statusEtField[
                                                                                index]
                                                                            .text =
                                                                        _plannerDetailsController
                                                                            .statusDrList[i]
                                                                            .ismmistSStatusName!;
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Text(
                                                                    _plannerDetailsController
                                                                        .statusDrList[
                                                                            i]
                                                                        .ismmistSStatusName!,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .merge(
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                        )),
                                                                  ),
                                                                );
                                                              },
                                                            ));
                                                      },
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            if (selectCheckbox
                                                                .contains(
                                                                    index)) {
                                                              return 'Please  select status';
                                                            }
                                                          }

                                                          return null;
                                                        },
                                                        controller:
                                                            _plannerDetailsController
                                                                .statusEtField
                                                                .elementAt(
                                                                    index),
                                                        readOnly: true,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                        decoration: InputDecoration(
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintText:
                                                                "Select status",
                                                            hintStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .merge(const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5))),
                                                      ),
                                                    ),
                                                  )),
                                                  DataCell(SizedBox(
                                                    width: 180,
                                                    child: GestureDetector(
                                                      onTapDown:
                                                          (details) async {
                                                        final offset = details
                                                            .globalPosition;
                                                        (currentDt.isAfter(DateTime.parse(
                                                                    fliteresList
                                                                        .elementAt(
                                                                            index)
                                                                        .iSMTPLEndDate!)
                                                                .add(const Duration(
                                                                    days: 1))))
                                                            ? showMenu(
                                                                context:
                                                                    context,
                                                                position:
                                                                    RelativeRect
                                                                        .fromLTRB(
                                                                  offset.dx,
                                                                  offset.dy,
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      offset.dx,
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height -
                                                                      offset.dy,
                                                                ),
                                                                items: List
                                                                    .generate(
                                                                  _plannerDetailsController
                                                                      .depWiseDevitnList
                                                                      .length,
                                                                  (i) {
                                                                    return PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        _plannerDetailsController
                                                                            .deveationEtField[index]
                                                                            .text = _plannerDetailsController.depWiseDevitnList[i].ismdRRemarks!;
                                                                        _plannerDetailsController.deveationIdEtField[index].text = _plannerDetailsController
                                                                            .depWiseDevitnList[i]
                                                                            .ismdRId!
                                                                            .toString();
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        _plannerDetailsController
                                                                            .depWiseDevitnList[i]
                                                                            .ismdRRemarks!,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .titleSmall!
                                                                            .merge(const TextStyle(
                                                                              fontSize: 16,
                                                                            )),
                                                                      ),
                                                                    );
                                                                  },
                                                                ))
                                                            : null;
                                                      },
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            if (selectCheckbox
                                                                .contains(
                                                                    index)) {
                                                              if (currentDt.isAfter(DateTime.parse(fliteresList
                                                                      .elementAt(
                                                                          index)
                                                                      .iSMTPLEndDate!)
                                                                  .add(const Duration(
                                                                      days:
                                                                          1)))) {
                                                                return 'Please  select Deviation';
                                                              }
                                                            }
                                                          }

                                                          return null;
                                                        },
                                                        controller:
                                                            _plannerDetailsController
                                                                    .deveationEtField[
                                                                index],
                                                        readOnly: true,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                        decoration: InputDecoration(
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintText:
                                                                "Select Deviation",
                                                            hintStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .merge(const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5))),
                                                      ),
                                                    ),
                                                  ))
                                                ]);
                                              }),
                                            )))))
                            : const AnimatedProgressWidget(
                                animationPath: 'assets/json/nodata.json',
                                title: 'No data available',
                                desc: " ",
                              ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 50,
                          width: 180,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                Get.to(AddExtraTaskScreen(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                  controller: _plannerDetailsController,
                                ));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Add Extra Task",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  filterFun(String query) {
    fliteresList = _plannerDetailsController.getTaskDrList.where((list) {
      return list.iSMTCRTaskNo!.toLowerCase().contains(query.toLowerCase()) ||
          list.iSMTCRTitle!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {});
  }

  @override
  void dispose() {
    fliteresList.clear();
    _plannerDetailsController.getTaskDrList.clear();
    _plannerDetailsController.statusDrList.clear();
    _plannerDetailsController.statusEtField.clear();
    _plannerDetailsController.depWiseDevitnList.clear();
    _plannerDetailsController.deveationEtField.clear();
    _plannerDetailsController.uploadImages.clear();
    super.dispose();
  }
}

Future<String> getDateNeed(DateTime dt) async {
  return "${dt.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
}
