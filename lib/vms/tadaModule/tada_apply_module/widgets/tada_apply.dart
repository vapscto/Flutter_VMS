import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_widget.dart';
import 'package:m_skool_flutter/student/gallery_view/widget/gallery_checkbox.container.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/city_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/state_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/city_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/state_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/widgets/file_upload_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class TadaApplyWidget extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const TadaApplyWidget(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<TadaApplyWidget> createState() => _TadaApplyWidgetState();
}

class _TadaApplyWidgetState extends State<TadaApplyWidget> {
  TadaApplyDataController tadaApplyDataController =
      Get.put(TadaApplyDataController());
  final ScrollController _controller = ScrollController();
  final RxBool selectAllDepartment = RxBool(false);
  final _addressController = TextEditingController();
  final _totalAmountController = TextEditingController();
  //
  StateListModelValues? stateListModelValues;
  CityListModelValues? citySelectedValue;
  //
  getStateList() async {
    tadaApplyDataController.stateLoading(true);
    tadaApplyDataController.cityList.clear();
    await StateListAPI.instance.tadastateList(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        tadaApplyController: tadaApplyDataController);
    if (tadaApplyDataController.stateList.isNotEmpty) {
      stateListModelValues = tadaApplyDataController.stateList.first;
      getCity(stateListModelValues!.ivrmmCId!, stateListModelValues!.ivrmmSId!);
    }
  }

  getCity(int countryId, int stateId) async {
    tadaApplyDataController.cityLoading(true);
    await CityListAPI.instance.tadaCityList(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        countryId: countryId,
        stateId: stateId,
        tadaApplyController: tadaApplyDataController);
    if (tadaApplyDataController.cityList.isNotEmpty) {
      citySelectedValue = tadaApplyDataController.cityList.last;
    }
    tadaApplyDataController.cityLoading(false);
  }

  //Controller
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final _startTime = TextEditingController();
  final _endTime = TextEditingController();
  final _key = GlobalKey<FormState>();
  //Date and time
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  String fromSelectedDate = '';
  String toSelectedDate = '';
  int dayCount = 0;
//
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
    // foodSlot = fSlot.toStringAsFixed(0);
    // accommudationSlot = aSlot.toStringAsFixed(0);
  }

  //

  //
  @override
  void initState() {
    getStateList();
    super.initState();
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
                                selectableDayPredicate: (day) =>
                                    day.weekday == 7 || day.weekday == 7
                                        ? false
                                        : true,
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
                                    selectableDayPredicate: (day) =>
                                        day.weekday == 7 || day.weekday == 7
                                            ? false
                                            : true,
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
                tadaApplyDataController.stateList.isEmpty
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.only(
                            top: 30, bottom: 0, left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<StateListModelValues>(
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
                            hintText:
                                tadaApplyDataController.stateList.isNotEmpty
                                    ? 'Select State'
                                    : "No data available.",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                    " State",
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
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 30,
                          items: List.generate(
                              tadaApplyDataController.stateList.length,
                              (index) {
                            return DropdownMenuItem(
                              value: tadaApplyDataController.stateList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
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
                    : tadaApplyDataController.cityList.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.only(
                                top: 30, bottom: 0, right: 16, left: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<CityListModelValues>(
                              value: citySelectedValue,
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
                                hintText:
                                    tadaApplyDataController.cityList.isNotEmpty
                                        ? 'Select City'
                                        : "No data available.",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                        " City",
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
                              icon: const Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30,
                                ),
                              ),
                              iconSize: 30,
                              items: List.generate(
                                  tadaApplyDataController.cityList.length,
                                  (index) {
                                return DropdownMenuItem(
                                  value:
                                      tadaApplyDataController.cityList[index],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 13, left: 5),
                                    child: Text(
                                      tadaApplyDataController
                                          .cityList[index].ivrmmcTName
                                          .toString(),
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
                                citySelectedValue = s!;
                              },
                            ),
                          )
                        : const SizedBox(),
                tadaApplyDataController.clintListValues.isNotEmpty
                    ? Container(
                        margin:
                            const EdgeInsets.only(top: 30, left: 16, right: 16),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 160,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(16.0),
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
                                trackColor:
                                    const Color.fromRGBO(223, 239, 253, 1),
                                trackRadius: const Radius.circular(10),
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
                                                      tadaApplyDataController
                                                          .addSelectedValues(
                                                              tadaApplyDataController
                                                                  .clintListValues
                                                                  .elementAt(
                                                                      index));
                                                      // clintId =
                                                      //     '${tadaApplyDataController.clintListValues.elementAt(index).ismmclTId!}';
                                                      // clintName +=
                                                      //     '${index + 1} ) ${tadaApplyDataController.clintListValues.elementAt(index).ismmclTClientName} ';

                                                      tadaApplyDataController.addAddress(
                                                          tadaApplyDataController
                                                              .clintListValues
                                                              .elementAt(index)
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
                                                          .value = false;
                                                      tadaApplyDataController
                                                          .removeSelectedValues(
                                                              tadaApplyDataController
                                                                  .clintListValues
                                                                  .elementAt(
                                                                      index));
                                                      tadaApplyDataController
                                                          .removeAddress(
                                                              tadaApplyDataController
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
                                                        .elementAt(index),
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
                              image: 'assets/images/subjectfielicon.png',
                              title: 'Select Clint',
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  child: CustomContainer(
                    child: TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      style: Get.textTheme.titleSmall!.copyWith(fontSize: 15),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                          backgroundColor: Color(0xFFDFFBFE),
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
                  margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  child: CustomContainer(
                    child: TextFormField(
                      controller: _totalAmountController,
                      keyboardType: TextInputType.multiline,
                      style: Get.textTheme.titleSmall!.copyWith(fontSize: 15),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Total Amount",
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
                                "Total Amount",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                          backgroundColor: Color(0xFFDFFBFE),
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
                    child: MSkollBtn(title: "Save", onPress: () {}),
                  ),
                ),
              ],
            );
    });
  }
}
