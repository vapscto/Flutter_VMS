import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/model/upload_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/city_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/clint_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/state_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/check_apply_planner_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/city_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/state_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/tada_apply_allowense_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/tada_apply_edit_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/tada_apply_save_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/widgets/applied_table_widget.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/widgets/file_upload_widget.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/sava_task.dart';
import 'package:m_skool_flutter/vms/widgets/check_box_container.dart';
import 'package:m_skool_flutter/vms/widgets/container_title.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class TadaApplyWidget extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final int previousScreen;
  const TadaApplyWidget(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.previousScreen});

  @override
  State<TadaApplyWidget> createState() => _TadaApplyWidgetState();
}

class _TadaApplyWidgetState extends State<TadaApplyWidget> {
  TadaApplyDataController tadaApplyDataController =
      Get.put(TadaApplyDataController());
  final ScrollController _controller = ScrollController();
  final RxBool selectAllDepartment = RxBool(false);
  final _addressController = TextEditingController();
  final _remarkController = TextEditingController();
  final _extraAmountController = TextEditingController();
  //
  StateListModelValues? stateListModelValues;
  CityListModelValues? citySelectedValue;
  //
  List<StateListModelValues> stateNew = [];
  List<ClintListModelValues> clintlist = [];
  //
  List addAmount = ['Add Amount', 'Minus Amount'];
  bool amountSelectedValue1 = false;
  bool amountSelectedValue2 = false;
  //
  int stateId = 0;
  getStateList() async {
    tadaApplyDataController.stateLoading(true);
    tadaApplyDataController.cityListValues.clear();
    await StateListAPI.instance.tadastateList(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        tadaApplyController: tadaApplyDataController);
    if (tadaApplyDataController.stateList.isNotEmpty) {
      stateListModelValues = tadaApplyDataController.stateList.first;
      for (int i = 0; i < tadaApplyDataController.stateList.length; i++) {
        stateId = tadaApplyDataController.stateList.elementAt(i).ivrmmSId!;
      }
      getCity(stateListModelValues!.ivrmmCId!, stateListModelValues!.ivrmmSId!);
    }
    tadaApplyDataController.stateLoading(false);
  }

//After apply
  void getState(int query) {
    stateNew = tadaApplyDataController.stateList
        .where((value) => value.ivrmmSId! == (query))
        .toList();
  }

  void getClint(int query) {
    clintlist = tadaApplyDataController.clintListValues
        .where((value) => value.ismmclTId! == (query))
        .toList();
    for (int i = 0; i < clintlist.length; i++) {
      clint += '${clintlist[i].ismmclTClientName}, ';
    }
  }

  String state = '';
  String city = '';
  String clint = '';
  int advanceAmount = 0;
  int paidAmount = 0;
  int balanceAmount = 0;
  String address = '';
  String remarks = '';
  String date1 = '';
  String time1 = '';
  String date2 = '';
  String time2 = '';
  bool a = false;

  savedDataListAPI() async {
    if (tadaApplyDataController.tadaSavedData.isNotEmpty) {
      for (int index = 0;
          index < tadaApplyDataController.tadaSavedData.length;
          index++) {
        DateTime dt1 = DateTime.parse(tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAFromDate!);
        _startDate.text = '${dt1.day}:${dt1.month}:${dt1.year}';
        //
        DateTime dt2 = DateTime.parse(tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAToDate!);
        _endDate.text = '${dt2.day}:${dt2.month}:${dt2.year}';
        //
        TimeOfDay startTime = TimeOfDay(
            hour: int.parse(tadaApplyDataController
                .tadaSavedData[index].vtadaaADepartureTime!
                .split(":")[0]),
            minute: int.parse(tadaApplyDataController
                .tadaSavedData[index].vtadaaADepartureTime!
                .split(":")[1]));
        _startTime.text =
            '${startTime.hourOfPeriod}:${startTime.minute} ${startTime.period.name.toUpperCase()}';
        //
        TimeOfDay startTime2 = TimeOfDay(
            hour: int.parse(tadaApplyDataController
                .tadaSavedData[index].vtadaaADepartureTime!
                .split(":")[0]),
            minute: int.parse(tadaApplyDataController
                .tadaSavedData[index].vtadaaADepartureTime!
                .split(":")[1]));
        _endTime.text =
            '${startTime2.hourOfPeriod}:${startTime2.minute} ${startTime2.period.name.toUpperCase()}';
        //
        getState(
            tadaApplyDataController.tadaSavedData.elementAt(index).ivrmmSId!);
        getClint(tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAClientId!);
        city =
            tadaApplyDataController.tadaSavedData.elementAt(index).ivrmmcTName!;

        advanceAmount = tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaATotalAppliedAmount!
            .toInt();
        paidAmount = tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaATotalPaidAmount!
            .toInt();
        balanceAmount = ((advanceAmount) - (paidAmount));
        allAmount += balanceAmount;
        address =
            '${tadaApplyDataController.tadaSavedData.elementAt(index).vtadaaAToAddress}';
        remarks =
            '${tadaApplyDataController.tadaSavedData.elementAt(index).vtadaaARemarks}';
      }
    }
  }

//
  getCity(int countryId, int stateId) async {
    tadaApplyDataController.cityLoading(true);
    await CityListAPI.instance.tadaCityList(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        countryId: countryId,
        stateId: stateId,
        tadaApplyController: tadaApplyDataController);
    if (tadaApplyDataController.cityListValues.isNotEmpty) {
      citySelectedValue = tadaApplyDataController.cityListValues.last;
      getAllowenseData(citySelectedValue!.ivrmmcTId!);
    }
    tadaApplyDataController.cityLoading(false);
  }

  //Controller
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final _startTime = TextEditingController();
  final _endTime = TextEditingController();
  final _key = GlobalKey<FormState>();
  //Food
  final foodTotalSlotController = TextEditingController();
  final foodRemarksController = TextEditingController();
  bool isFoodSelected = false;
  //Accommodation
  final accommodationTotalSlotController = TextEditingController();
  final accommodationRemarksController = TextEditingController();
  bool isAccommodationSelected = false;
  //others
  final otherAmountController = TextEditingController();
  final otherremarksController = TextEditingController();
  bool isOthersSelected = false;
  //Date and time
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  String fromSelectedDate = '';
  String toSelectedDate = '';
  int dayCount = 0;
  List<Map<String, dynamic>> allowanceData = [];
  List<Map<String, dynamic>> uploadArray = [];
  int allAmount = 0;
//
  int foodAmt = 0;
  int accommodationAmount = 0;
  getAllowenseData(int ctId) async {
    tadaApplyDataController.allowenseLoading(true);
    await TadaAllowenceAPI.instance.getApplyAllowense(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        ivrmCtId: ctId,
        tadaApplyController: tadaApplyDataController);
    if (tadaApplyDataController.allowenseData.isNotEmpty) {}
    tadaApplyDataController.allowenseLoading(false);
  }

  //
  var foodSlot;
  var accommudationSlot;

  void calculateHour(String newStartDate, String startTime, String newEndDate,
      String endtime) {
    String startDateStr = '$newStartDate $startTime';
    String endDateStr = '$newEndDate $endtime';
    DateFormat dateFormat = DateFormat('dd:MM:yyyy hh:mm a');
    DateTime startDate = dateFormat.parse(startDateStr);
    DateTime endDate = dateFormat.parse(endDateStr);
    Duration duration = endDate.difference(startDate);
    double totalHours = duration.inSeconds / 3600.0;
    print('Total hours between the two dates: $totalHours hours');
    var fSlot = totalHours / 8;
    var aSlot = totalHours / 24;
    foodSlot = fSlot.toStringAsFixed(0);
    accommudationSlot = aSlot.toStringAsFixed(0);
  }

  List<UploadHwCwModel> uploadAttachment = [];

//
  saveData(
    int clintId,
  ) async {
    tadaApplyDataController.saveData(true);

    for (var element in tadaApplyDataController.addListBrowser) {
      try {
        uploadAttachment.add(await uploadAtt(
            miId: widget.loginSuccessModel.mIID!,
            file: File(element.file!.path)));
      } catch (e) {
        return Future.error({
          "errorTitle": "An Error Occured",
          "errorMsg":
              "While trying to upload attchement, we encountered an error"
        });
      }
    }
    for (var element in uploadAttachment) {
      uploadArray.add(
          {"VTADAAF_FilePath": element.path, "VTADAAF_FileName": element.name});
    }

    TadaSaveApi.instance.tadaApplySave(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        ctId: citySelectedValue!.ivrmmcTId!,
        fromDate: fromDate!.toIso8601String(),
        toDate: toDate!.toIso8601String(),
        clintId: 0,
        totalAppliedAmount: double.parse(allAmount.toString()),
        toAddress: _addressController.text,
        remarks: _remarkController.text,
        vtadaaaId: citySelectedValue!.vtadaaAId!,
        departureTime: _startTime.text,
        arrivalTime: _endTime.text,
        clintMultiple: clintName,
        allowanceArray: allowanceData,
        tadaApplyController: tadaApplyDataController,
        fileList: uploadArray);

    getStateList();
    tadaApplyDataController.saveData(false);
  }

//
  checkPlanner() async {
    tadaApplyDataController.plannerCreate(true);
    await CheckPlannerAPI.instance.applyCheckPlannerAPI(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        fromDate: fromSelectedDate,
        toDate: toSelectedDate,
        tadaApplyController: tadaApplyDataController);
    if (tadaApplyDataController.checkPlanner.isEmpty) {
      Get.dialog(showPopup());
      _startDate.clear();
      _endDate.clear();
    }
    tadaApplyDataController.plannerCreate(false);
  }

//
  editData(int id) {
    tadaApplyDataController.editData(true);
    TadaEditAPI.instance.tadaApplyEditData(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        vtadaaaId: id,
        tadaApplyController: tadaApplyDataController);
    getStateList();
    tadaApplyDataController.editData(false);
  }

  //
  bool checked = false;
  String clintId = '';
  String clintName = '';
  //
  @override
  void initState() {
    getStateList();
    logger.e("===${widget.previousScreen}");
    savedDataListAPI();
    super.initState();
  }

  @override
  void dispose() {
    tadaApplyDataController.tadaSavedData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (tadaApplyDataController.isStateLoading.value)
          ? const Center(
              child: AnimatedProgressWidget(
                  title: "Loading TA-DA Entry",
                  desc:
                      "Please wait while we load TA-DA entry and create a view for you.",
                  animationPath: "assets/json/default.json"),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note:",
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "* TA-DA Should Be Applied with 48 Hours of Arrival",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.red, fontSize: 10),
                      ),
                      Text(
                        "* If Daily Report Not Generated TADA Not Applicable",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.red, fontSize: 10),
                      ),
                      Text(
                        "* New TADA is not applicable until previous TADA is settled",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.red, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomContainer(
                          child: TextField(
                            style: Theme.of(context).textTheme.titleSmall,
                            readOnly: true,
                            controller: _startDate,
                            onTap: () async {
                              fromDate = await showDatePicker(
                                context: context,
                                helpText: "Select Data",
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3050),
                                // selectableDayPredicate: (day) =>
                                //     day.weekday == 7 || day.weekday == 7
                                //         ? false
                                //         : true,
                              );
                              if (fromDate != null) {
                                setState(() {
                                  _startDate.text =
                                      "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                                  fromSelectedDate =
                                      '${numberList[fromDate!.month]}-${numberList[fromDate!.day]}-${fromDate!.year}';
                                });
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  fromDate = await showDatePicker(
                                    helpText: "Select Data",
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3050),
                                    // selectableDayPredicate: (day) =>
                                    //     day.weekday == 7 || day.weekday == 7
                                    //         ? false
                                    //         : true,
                                  );

                                  if (fromDate != null) {
                                    setState(() {
                                      _startDate.text =
                                          "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                                      fromSelectedDate =
                                          '${numberList[fromDate!.month]}-${numberList[fromDate!.day]}-${fromDate!.year}';
                                    });
                                  }
                                },
                                icon: SvgPicture.asset(
                                  "assets/svg/calendar_icon.svg",
                                  color: const Color(0xFF3E78AA),
                                  height: 18,
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsets.only(top: 40.0, left: 12),
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color(0xFFE5F3FF)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/calendar_icon.svg",
                                      color: const Color(0xFF3E78AA),
                                      height: 18,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " Start Date ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                              fontSize: 18.0,
                                              color: Color(0xFF3E78AA),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Select Date',
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
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: CustomContainer(
                          child: TextField(
                            readOnly: true,
                            style: Theme.of(context).textTheme.titleSmall,
                            controller: _endDate,
                            onTap: () async {
                              if (_startDate.text.isNotEmpty) {
                                toDate = await showDatePicker(
                                  context: context,
                                  helpText: "Select Date",
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3050),
                                );
                                if (toDate != null) {
                                  setState(() {
                                    _endDate.text =
                                        "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                    dayCount =
                                        toDate!.difference(fromDate!).inDays +
                                            1;
                                    toSelectedDate =
                                        '${numberList[toDate!.month]}-${numberList[toDate!.day]}-${toDate!.year}';
                                    checkPlanner();
                                  });
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please Select Start Date");
                              }
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.only(top: 40.0, left: 12),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  if (_startDate.text.isNotEmpty) {
                                    toDate = await showDatePicker(
                                      context: context,
                                      helpText: "Select Date",
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(3050),
                                    );
                                    if (toDate != null) {
                                      setState(() {
                                        _endDate.text =
                                            "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                        dayCount = toDate!
                                                .difference(fromDate!)
                                                .inDays +
                                            1;
                                        toSelectedDate =
                                            '${numberList[toDate!.month]}-${numberList[toDate!.day]}-${toDate!.year}';
                                        checkPlanner();
                                      });
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Start Date");
                                  }
                                },
                                icon: SvgPicture.asset(
                                  "assets/svg/calendar_icon.svg",
                                  color: const Color(0xFF3E78AA),
                                  height: 18,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color(0xFFE5F3FF)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/calendar_icon.svg",
                                      color: const Color(0xFF3E78AA),
                                      height: 18,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " End Date ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                                fontSize: 18.0,
                                                color: Color(0xFF3E78AA)),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Select Date',
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
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomContainer(
                          child: TextField(
                            style: Theme.of(context).textTheme.titleSmall,
                            readOnly: true,
                            controller: _startTime,
                            onTap: () async {
                              if (_endDate.text.isNotEmpty) {
                                fromTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    initialEntryMode:
                                        TimePickerEntryMode.dialOnly,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: false),
                                          child: childWidget!);
                                    });

                                if (fromTime != null) {
                                  _startTime.text =
                                      '${numberList[fromTime!.hourOfPeriod]}:${numberList[fromTime!.minute]} ${fromTime!.period.name.toUpperCase()}';
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please select Data");
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.watch_later_outlined,
                                color: Color(0xFF3E78AA),
                              ),
                              contentPadding:
                                  const EdgeInsets.only(top: 40.0, left: 12),
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color(0xFFE5F3FF)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      color: Color(0xFF3E78AA),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " Start Time ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                              fontSize: 18.0,
                                              color: Color(0xFF3E78AA),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Select Time',
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
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: CustomContainer(
                          child: TextField(
                            readOnly: true,
                            style: Theme.of(context).textTheme.titleSmall,
                            controller: _endTime,
                            onTap: () async {
                              if (fromTime != null) {
                                toTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: fromTime!.hour,
                                        minute: fromTime!.minute),
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: false),
                                          child: childWidget!);
                                    });
                                if (toTime != null) {
                                  _endTime.text =
                                      '${numberList[toTime!.hourOfPeriod]}:${numberList[toTime!.minute]} ${toTime!.period.name.toUpperCase()}';
                                  calculateHour(
                                      _startDate.text,
                                      _startTime.text,
                                      _endDate.text,
                                      _endTime.text);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please Select Start Time");
                              }
                            },
                            decoration: InputDecoration(
                              // isDense: true,
                              suffixIcon: const Icon(
                                Icons.watch_later_outlined,
                                color: Color(0xFF3E78AA),
                              ),
                              contentPadding:
                                  const EdgeInsets.only(top: 40.0, left: 12),

                              border: const OutlineInputBorder(),

                              label: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color(0xFFE5F3FF)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      color: Color(0xFF3E78AA),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " Arrival Time ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                                fontSize: 18.0,
                                                color: Color(0xFF3E78AA)),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: 'Select Time',
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
                    ],
                  ),
                ),
                (widget.previousScreen == 0)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tadaApplyDataController.stateList.isEmpty
                              ? const SizedBox()
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: 30, bottom: 0, left: 16, right: 16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 8,
                                        color: Colors.black12,
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonFormField<
                                      StateListModelValues>(
                                    value: stateListModelValues,
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
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              letterSpacing: 0.3)),
                                      hintText: tadaApplyDataController
                                              .stateList.isNotEmpty
                                          ? 'Select State'
                                          : "No data available.",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      label: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDFFBFE),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 6.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/cap.png",
                                              height: 28.0,
                                            ),
                                            const SizedBox(
                                              width: 6.0,
                                            ),
                                            Text(
                                              " State",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .merge(
                                                    const TextStyle(
                                                        backgroundColor:
                                                            Color(0xFFDFFBFE),
                                                        fontSize: 20.0,
                                                        color:
                                                            Color(0xFF28B6C8)),
                                                  ),
                                            ),
                                          ],
                                        ),
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
                                        tadaApplyDataController
                                            .stateList.length, (index) {
                                      return DropdownMenuItem(
                                        value: tadaApplyDataController
                                            .stateList[index],
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 13, left: 5),
                                          child: Text(
                                            tadaApplyDataController
                                                .stateList[index].ivrmmSName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .merge(const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.3)),
                                          ),
                                        ),
                                      );
                                    }),
                                    onChanged: (s) {
                                      stateListModelValues = s!;
                                      getCity(stateListModelValues!.ivrmmCId!,
                                          stateListModelValues!.ivrmmSId!);
                                    },
                                  ),
                                ),
                          tadaApplyDataController.isCityLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : tadaApplyDataController
                                      .cityListValues.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          top: 30,
                                          bottom: 0,
                                          right: 16,
                                          left: 16),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            blurRadius: 8,
                                            color: Colors.black12,
                                          ),
                                        ],
                                      ),
                                      child: DropdownButtonFormField<
                                          CityListModelValues>(
                                        value: citySelectedValue,
                                        decoration: InputDecoration(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          isDense: true,
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .merge(const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.3)),
                                          hintText: tadaApplyDataController
                                                  .cityListValues.isNotEmpty
                                              ? 'Select City'
                                              : "No data available.",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          label: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDFFBFE),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 6.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  "assets/images/cap.png",
                                                  height: 28.0,
                                                ),
                                                const SizedBox(
                                                  width: 6.0,
                                                ),
                                                Text(
                                                  " City",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .merge(
                                                        const TextStyle(
                                                            backgroundColor:
                                                                Color(
                                                                    0xFFDFFBFE),
                                                            fontSize: 20.0,
                                                            color: Color(
                                                                0xFF28B6C8)),
                                                      ),
                                                ),
                                              ],
                                            ),
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
                                            tadaApplyDataController
                                                .cityListValues
                                                .length, (index) {
                                          return DropdownMenuItem(
                                            value: tadaApplyDataController
                                                .cityListValues[index],
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 13, left: 5),
                                              child: Text(
                                                tadaApplyDataController
                                                    .cityListValues[index]
                                                    .ivrmmcTName
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.3)),
                                              ),
                                            ),
                                          );
                                        }),
                                        onChanged: (s) {
                                          citySelectedValue = s!;
                                          getAllowenseData(
                                              citySelectedValue!.ivrmmcTId!);
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                          tadaApplyDataController.clintListValues.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 30, left: 16, right: 16),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 160,
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 4,
                                              color: Colors.black12,
                                            ),
                                          ],
                                        ),
                                        child: RawScrollbar(
                                          thumbColor: const Color(0xFF1E38FC),
                                          trackColor: const Color.fromRGBO(
                                              223, 239, 253, 1),
                                          trackRadius:
                                              const Radius.circular(10),
                                          trackVisibility: true,
                                          radius: const Radius.circular(10),
                                          thickness: 14,
                                          thumbVisibility: true,
                                          controller: _controller,
                                          child: SingleChildScrollView(
                                            controller: _controller,
                                            child: ListView.builder(
                                              itemCount: tadaApplyDataController
                                                  .clintListValues.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return SizedBox(
                                                    height: 35,
                                                    child: Obx(() {
                                                      return CheckBoxContainer(
                                                          sectionName:
                                                              "${tadaApplyDataController.clintListValues.elementAt(index).ismmclTClientName}",
                                                          func: (b) {
                                                            setState(() {
                                                              if (b) {
                                                                tadaApplyDataController.addSelectedValues(
                                                                    tadaApplyDataController
                                                                        .clintListValues
                                                                        .elementAt(
                                                                            index));
                                                                clintId =
                                                                    '${tadaApplyDataController.clintListValues.elementAt(index).ismmclTId!}';
                                                                clintName +=
                                                                    '${index + 1} ) ${tadaApplyDataController.clintListValues.elementAt(index).ismmclTClientName} ';

                                                                tadaApplyDataController.addAddress(tadaApplyDataController
                                                                    .clintListValues
                                                                    .elementAt(
                                                                        index)
                                                                    .ismmclTAddress!);
                                                                int count = 0;
                                                                _addressController
                                                                    .clear();
                                                                for (int i = 0;
                                                                    i <
                                                                        tadaApplyDataController
                                                                            .addressListController
                                                                            .length;
                                                                    i++) {
                                                                  count++;
                                                                  _addressController
                                                                          .text +=
                                                                      ' $count ) ${tadaApplyDataController.addressListController[i]}  ';
                                                                }
                                                              } else {
                                                                _addressController
                                                                    .clear();
                                                                selectAllDepartment
                                                                        .value =
                                                                    false;
                                                                tadaApplyDataController.removeSelectedValues(
                                                                    tadaApplyDataController
                                                                        .clintListValues
                                                                        .elementAt(
                                                                            index));
                                                                tadaApplyDataController.removeAddress(tadaApplyDataController
                                                                    .clintListValues
                                                                    .elementAt(
                                                                        index)
                                                                    .ismmclTAddress!);
                                                                for (int i = 0;
                                                                    i <
                                                                        tadaApplyDataController
                                                                            .addressListController
                                                                            .length;
                                                                    i++) {
                                                                  _addressController
                                                                          .text =
                                                                      '${i + 1} ) ${tadaApplyDataController.addressListController.elementAt(i)} ';
                                                                }
                                                              }
                                                            });
                                                          },
                                                          isChecked: RxBool(
                                                            tadaApplyDataController
                                                                .clintSelectedValues
                                                                .contains(
                                                              tadaApplyDataController
                                                                  .clintListValues
                                                                  .elementAt(
                                                                      index),
                                                            ),
                                                          ));
                                                    }));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const ContainerTitle(
                                        iT: Color(0xFFFF6F67),
                                        bg: Color.fromARGB(255, 255, 236, 235),
                                        image:
                                            'assets/images/subjectfielicon.png',
                                        title: 'Select Clint',
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 30, left: 16, right: 16),
                            child: CustomContainer(
                              child: TextFormField(
                                controller: _remarkController,
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 15),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter Remark",
                                  label: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDFFBFE),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 6.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/cap.png",
                                          height: 28.0,
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          " Remark",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(
                                                const TextStyle(
                                                    backgroundColor:
                                                        Color(0xFFDFFBFE),
                                                    fontSize: 20.0,
                                                    color: Color(0xFF28B6C8)),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 30, left: 16, right: 16),
                            child: CustomContainer(
                              child: TextFormField(
                                controller: _addressController,
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 15),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter Address",
                                  label: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDFFBFE),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 6.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/cap.png",
                                          height: 28.0,
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          " Address",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(
                                                const TextStyle(
                                                    backgroundColor:
                                                        Color(0xFFDFFBFE),
                                                    fontSize: 20.0,
                                                    color: Color(0xFF28B6C8)),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          tadaApplyDataController.allowenseData.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 16, right: 16),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: DataTable(
                                          dataRowHeight: 50,
                                          headingRowHeight: 40,
                                          columnSpacing: 20,
                                          headingTextStyle: const TextStyle(
                                              color: Colors.white),
                                          border: TableBorder.all(
                                            color: Colors.black,
                                            width: 0.6,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Theme.of(context)
                                                      .primaryColor),
                                          columns: const [
                                            DataColumn(label: Text("Select")),
                                            DataColumn(
                                                label: Text("Particulars")),
                                            DataColumn(label: Text("Amount")),
                                            DataColumn(label: Text("Days")),
                                            DataColumn(
                                                label: Text("Total Sots")),
                                            DataColumn(label: Text("Slots")),
                                            DataColumn(
                                                label: Text("Total Amount")),
                                            DataColumn(label: Text("Remark")),
                                          ],
                                          rows: [
                                            DataRow(cells: [
                                              DataCell(
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Checkbox(
                                                    visualDensity:
                                                        const VisualDensity(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    onChanged: (value) {
                                                      if (foodTotalSlotController
                                                              .text.isEmpty ||
                                                          foodRemarksController
                                                              .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Enter slots and remarks");
                                                      } else {
                                                        setState(() {
                                                          isFoodSelected =
                                                              value!;

                                                          if (value) {
                                                            allAmount +=
                                                                foodAmt;
                                                          } else {
                                                            allAmount -=
                                                                foodAmt;
                                                            foodTotalSlotController
                                                                .clear();
                                                            foodRemarksController
                                                                .clear();
                                                          }
                                                        });
                                                      }
                                                    },
                                                    value: isFoodSelected,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              const DataCell(Text('Food')),
                                              DataCell(Text(
                                                  tadaApplyDataController
                                                      .foodAmount.value
                                                      .toString())),
                                              DataCell(
                                                  Text(dayCount.toString())),
                                              DataCell(Text('$foodSlot')),
                                              DataCell(
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextField(
                                                      controller:
                                                          foodTotalSlotController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          foodAmt = (tadaApplyDataController
                                                                      .foodAmount
                                                                      .value /
                                                                  3 *
                                                                  num.parse(
                                                                      value))
                                                              .toInt();
                                                        });
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor))),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                  Text(foodAmt.toString())),
                                              DataCell(
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextField(
                                                      controller:
                                                          foodRemarksController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor))),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Checkbox(
                                                    visualDensity:
                                                        const VisualDensity(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    onChanged: (value) {
                                                      if (accommodationTotalSlotController
                                                              .text.isEmpty ||
                                                          accommodationRemarksController
                                                              .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Enter slots and remarks");
                                                      } else {
                                                        setState(() {
                                                          isAccommodationSelected =
                                                              value!;

                                                          if (value == true) {
                                                            allAmount +=
                                                                accommodationAmount;
                                                          } else {
                                                            allAmount -=
                                                                accommodationAmount;
                                                            accommodationTotalSlotController
                                                                .clear();
                                                            accommodationRemarksController
                                                                .clear();
                                                          }
                                                        });
                                                      }
                                                    },
                                                    value:
                                                        isAccommodationSelected,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              const DataCell(
                                                  Text('Accommodation Amount')),
                                              DataCell(Text(
                                                  tadaApplyDataController
                                                      .accomodationAmount.value
                                                      .toString())),
                                              DataCell(
                                                  Text(dayCount.toString())),
                                              DataCell(
                                                  Text('$accommudationSlot')),
                                              DataCell(
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextField(
                                                      controller:
                                                          accommodationTotalSlotController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          accommodationAmount =
                                                              (tadaApplyDataController
                                                                          .accomodationAmount
                                                                          .value *
                                                                      num.parse(
                                                                          value))
                                                                  .toInt();
                                                        });
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor))),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                  Text('$accommodationAmount')),
                                              DataCell(
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextField(
                                                      controller:
                                                          accommodationRemarksController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor))),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]),
                                            DataRow(cells: [
                                              DataCell(
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Checkbox(
                                                    visualDensity:
                                                        const VisualDensity(
                                                            horizontal: 0,
                                                            vertical: 0),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isOthersSelected =
                                                            value!;
                                                        if (value) {
                                                          allAmount += int.parse(
                                                              otherAmountController
                                                                  .text);
                                                        } else {
                                                          allAmount -= int.parse(
                                                              otherAmountController
                                                                  .text);
                                                          otherAmountController
                                                              .clear();
                                                          otherremarksController
                                                              .clear();
                                                        }
                                                      });
                                                    },
                                                    value: isOthersSelected,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              const DataCell(
                                                  Text('Other Amount')),
                                              DataCell(
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextField(
                                                      controller:
                                                          otherAmountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor))),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const DataCell(Text('')),
                                              const DataCell(Text('')),
                                              const DataCell(Text('')),
                                              const DataCell(Text('')),
                                              DataCell(
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: TextField(
                                                      controller:
                                                          otherremarksController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor))),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]),
                                          ])),
                                )
                              : const SizedBox(),
                        ],
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 16, right: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: CustomContainer(
                                    child: Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "State : ",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          Text(stateNew.first.ivrmmSName!,
                                              style: Get.textTheme.titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "City : ",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          Text(city,
                                              style: Get.textTheme.titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Clint : ",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          Text(clint,
                                              style: Get.textTheme.titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Advance Amount : ",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          Text(advanceAmount.toString(),
                                              style: Get.textTheme.titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Paid Amount : ",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          Text(paidAmount.toString(),
                                              style: Get.textTheme.titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Balance Amount : ",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          Text(balanceAmount.toString(),
                                              style: Get.textTheme.titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Address : ",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          Text(address,
                                              style: Get.textTheme.titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Remarks : ",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              child: Text(remarks,
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      Get.textTheme.titleSmall),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          fillColor: MaterialStatePropertyAll(
                                              Theme.of(context).primaryColor),
                                          visualDensity: const VisualDensity(
                                              horizontal: 0),
                                          value: amountSelectedValue1,
                                          onChanged: (value) {
                                            setState(() {
                                              amountSelectedValue1 = value!;
                                              amountSelectedValue2 = false;
                                              if (amountSelectedValue1 ==
                                                  true) {
                                                allAmount += int.parse(
                                                    _extraAmountController
                                                        .text);
                                              }
                                            });
                                          }),
                                      Text(
                                        addAmount[0],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          fillColor: MaterialStatePropertyAll(
                                              Theme.of(context).primaryColor),
                                          visualDensity: const VisualDensity(
                                              horizontal: 0),
                                          value: amountSelectedValue2,
                                          onChanged: (value) {
                                            setState(() {
                                              amountSelectedValue2 = value!;
                                              amountSelectedValue1 = false;
                                              if (amountSelectedValue2 ==
                                                  true) {
                                                allAmount -= int.parse(
                                                    _extraAmountController
                                                        .text);
                                              }
                                            });
                                          }),
                                      Text(
                                        addAmount[1],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomContainer(
                              child: TextFormField(
                                controller: _extraAmountController,
                                onChanged: (value) {},
                                keyboardType: TextInputType.multiline,
                                style: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 15),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Extra Amount",
                                  label: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDFFBFE),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 6.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/cap.png",
                                          height: 28.0,
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          " Extra Amount",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(
                                                const TextStyle(
                                                    backgroundColor:
                                                        Color(0xFFDFFBFE),
                                                    fontSize: 20.0,
                                                    color: Color(0xFF28B6C8)),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Total Amount: ",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Theme.of(context).primaryColor)),
                    TextSpan(
                        text: " ₹ $allAmount", style: Get.textTheme.titleSmall),
                  ])),
                ),
                const SizedBox(
                  height: 16,
                ),
                FileUploadWidget(
                  tadaApplyDataController: tadaApplyDataController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MSkollBtn(
                      title: "Save",
                      onPress: (_remarkController.text.isNotEmpty ||
                              _addressController.text.isNotEmpty ||
                              _startDate.text.isNotEmpty ||
                              _endDate.text.isNotEmpty ||
                              _startTime.text.isNotEmpty ||
                              _endTime.text.isNotEmpty)
                          ? () {
                              int foodamountId = 0;
                              int accamountId = 0;
                              int othersamountId = 0;

                              if (isFoodSelected == true) {
                                foodamountId =
                                    (foodamountId == null || foodamountId == "")
                                        ? 0
                                        : foodamountId;
                                allowanceData.add({
                                  "Type": "Food",
                                  "Amount": foodAmt,
                                  "Remarks": foodRemarksController.text,
                                  "VTADAAAD_Id": foodamountId,
                                  "VTADAAAD_TotalSlots": foodSlot,
                                  "VTADAAAD_Slots":
                                      foodTotalSlotController.text,
                                });
                              }

                              if (isAccommodationSelected == true) {
                                accamountId =
                                    (accamountId == null || accamountId == "")
                                        ? 0
                                        : accamountId;
                                allowanceData.add({
                                  "Type": "Accommodation",
                                  "Amount": accommodationAmount,
                                  "Remarks":
                                      accommodationRemarksController.text,
                                  "VTADAAAD_Id": accamountId,
                                  "VTADAAAD_TotalSlots": accommudationSlot,
                                  "VTADAAAD_Slots":
                                      accommodationTotalSlotController.text,
                                });
                              }
                              if (isOthersSelected == true) {
                                othersamountId = (othersamountId == null ||
                                        othersamountId == "")
                                    ? 0
                                    : othersamountId;
                                allowanceData.add({
                                  "Type": "Other",
                                  "Amount": otherAmountController.text,
                                  "Remarks": otherremarksController.text,
                                  "VTADAAAD_Id": othersamountId,
                                });
                              }
                              if (tadaApplyDataController
                                  .addListBrowser.isNotEmpty) {
                                for (int i = 0;
                                    i <
                                        tadaApplyDataController
                                            .addListBrowser.length;
                                    i++) {
                                  uploadArray.add({
                                    // "VTADAAF_FileName": tadaApplyDataController
                                    //     .addListBrowser[i].file!.name,
                                    // "VTADAAF_FilePath": tadaApplyDataController
                                    //     .addListBrowser[i].file!.path,
                                    "VTADAAF_Remarks": tadaApplyDataController
                                        .newRemarksController
                                        .elementAt(i)
                                        .text
                                  });
                                }
                              }
                              saveData(int.parse(clintId));
                            }
                          : () =>
                              Fluttertoast.showToast(msg: "Enter all Fields"),
                    ),
                  ),
                ),
                (tadaApplyDataController.getSavedData.isEmpty)
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: AppliedTableWidget(
                          tadaApplyDataController: tadaApplyDataController,
                        ),
                      ),
              ],
            );
    });
  }

  showPopup() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      contentPadding: const EdgeInsets.all(10),
      content: WillPopScope(
        onWillPop: () async => false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Planer Is Not Create Between Dates !",
                style: Get.textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 40),
              MSkollBtn(
                  title: "OK",
                  onPress: () {
                    setState(() {
                      Get.back();
                      getStateList();
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
