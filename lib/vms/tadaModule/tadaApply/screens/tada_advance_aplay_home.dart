import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/save_button.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_widget.dart';
import 'package:m_skool_flutter/student/gallery_view/widget/gallery_checkbox.container.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/api/tada_city_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/api/tada_state_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/model/city_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/model/clint_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/model/state_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tadaApply/widgets/tada_apply_table.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class TadaAdvanceApplyScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const TadaAdvanceApplyScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<TadaAdvanceApplyScreen> createState() => _TadaAdvanceApplyScreenState();
}

class _TadaAdvanceApplyScreenState extends State<TadaAdvanceApplyScreen> {
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final _startTime = TextEditingController();
  final _endTime = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool selectAll = false;
  bool checked = false;
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  final ScrollController _controller = ScrollController();
  final RxBool selectAllDepartment = RxBool(false);
  var dayCount;
  final _remarkController = TextEditingController();
  final _addressController = TextEditingController();

  StateListModelValues? stateLists;
  // ClintListModelValues? clintSelectedValue;
  CityListModelValues? citySelectedValue;

  TadaApplyController tadaApplyController = Get.put(TadaApplyController());
  bool isSelect = false;
  List selectedAll = [];
  List<TADAApplyTable> newTableData = <TADAApplyTable>[];
  num allAmount = 0;
  getStateList() async {
    tadaApplyController.stateLoading(true);
    tadaApplyController.cityListValues.clear();
    await TadaStateListAPI.instance.tadastateList(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('login', widget.mskoolController),
        tadaApplyController: tadaApplyController);
    if (tadaApplyController.stateList.isNotEmpty) {
      stateLists = tadaApplyController.stateList.first;
      getCity(stateLists!.ivrmmCId!, stateLists!.ivrmmSId!);
    }
    //  else if (tadaApplyController.clintListValues.isNotEmpty) {
    //   clintSelectedValue = tadaApplyController.clintListValues.first;
    // }
    tadaApplyController.stateLoading(false);
  }

  getCity(int countryId, int stateId) async {
    tadaApplyController.cityLoading(true);
    await TadaCityListAPI.instance.tadaCityList(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('login', widget.mskoolController),
        countryId: countryId,
        stateId: stateId,
        tadaApplyController: tadaApplyController);
    if (tadaApplyController.cityListValues.isNotEmpty) {
      citySelectedValue = tadaApplyController.cityListValues.last;
    }
    tadaApplyController.cityLoading(false);
  }

  @override
  void initState() {
    setState(() {
      getStateList();
    });
    newTableData.add(TADAApplyTable(false, 'Food', 250, 1, 3, 750));
    newTableData
        .add(TADAApplyTable(false, 'Accomodation Amount', 250, 1, 3, 350));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TA-DA Advance Apply').getAppBar(),
      body: Obx(() {
        return tadaApplyController.isStateLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading TA-DA Entry",
                    desc:
                        "Please wait while we load TA-DA entry and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : RefreshIndicator(
                onRefresh: () {
                  getStateList();
                  return Future<void>.delayed(const Duration(seconds: 2));
                },
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
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
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(3050),
                                    selectableDayPredicate: (day) =>
                                        day.weekday == 7 || day.weekday == 7
                                            ? false
                                            : true,
                                  );

                                  if (fromDate != null) {
                                    setState(() {
                                      _startDate.text =
                                          "${numberList[fromDate!.day]}-${numberList[fromDate!.month]}-${fromDate!.year}";
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
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(3050),
                                        selectableDayPredicate: (day) =>
                                            day.weekday == 7 || day.weekday == 7
                                                ? false
                                                : true,
                                      );

                                      if (fromDate != null) {
                                        setState(() {
                                          _startDate.text =
                                              "${numberList[fromDate!.day]}-${numberList[fromDate!.month]}-${fromDate!.year}";
                                        });
                                      }
                                    },
                                    icon: SvgPicture.asset(
                                      "assets/svg/calendar_icon.svg",
                                      color: const Color(0xFF3E78AA),
                                      height: 18,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      top: 40.0, left: 12),
                                  border: const OutlineInputBorder(),
                                  label: Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                  if (fromDate != null) {
                                    toDate = await showDatePicker(
                                      context: context,
                                      helpText: "Select Date",
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(3050),
                                    );
                                    if (toDate != null) {
                                      setState(() {
                                        _endDate.text =
                                            "${numberList[toDate!.day]}-${numberList[toDate!.month]}-${toDate!.year}";
                                        dayCount = toDate!
                                            .difference(fromDate!)
                                            .inDays;
                                        logger.i('===$dayCount');
                                        var hourCount = toDate!
                                            .difference(fromDate!)
                                            .inHours;
                                        logger.i('=++$hourCount');
                                      });
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Start Date");
                                  }
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                      top: 40.0, left: 12),
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (fromDate != null) {
                                        toDate = await showDatePicker(
                                          context: context,
                                          helpText: "Select Date",
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(3050),
                                        );
                                        if (toDate != null) {
                                          setState(() {
                                            _endDate.text =
                                                "${numberList[toDate!.day]}-${numberList[toDate!.month]}-${toDate!.year}";
                                            dayCount = toDate!
                                                .difference(fromDate!)
                                                .inDays;
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
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                      margin: const EdgeInsets.only(top: 30),
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
                                  fromTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      initialEntryMode:
                                          TimePickerEntryMode.dialOnly,
                                      builder: (context, childWidget) {
                                        return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                    alwaysUse24HourFormat:
                                                        false),
                                            child: childWidget!);
                                      });

                                  if (fromTime != null) {
                                    _startTime.text =
                                        '${numberList[fromTime!.hourOfPeriod]}:${numberList[fromTime!.minute]} ${fromTime!.period.name.toUpperCase()}';
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.watch_later_outlined,
                                    color: Color(0xFF3E78AA),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      top: 40.0, left: 12),
                                  border: const OutlineInputBorder(),
                                  label: Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      alwaysUse24HourFormat:
                                                          false),
                                              child: childWidget!);
                                        });
                                    if (toTime != null) {
                                      _endTime.text =
                                          '${numberList[toTime!.hourOfPeriod]}:${numberList[toTime!.minute]} ${toTime!.period.name.toUpperCase()}';
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
                                  contentPadding: const EdgeInsets.only(
                                      top: 40.0, left: 12),

                                  border: const OutlineInputBorder(),
                                  label: Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                    tadaApplyController.stateList.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 30, bottom: 0),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
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
                                  value: stateLists,
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
                                        tadaApplyController.stateList.isNotEmpty
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
                                      tadaApplyController.stateList.length,
                                      (index) {
                                    return DropdownMenuItem(
                                      value:
                                          tadaApplyController.stateList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 13, left: 5),
                                        child: Text(
                                          tadaApplyController
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
                                    stateLists = s!;
                                    getCity(stateLists!.ivrmmCId!,
                                        stateLists!.ivrmmSId!);
                                  },
                                ),
                              ),
                              tadaApplyController.isCityLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : tadaApplyController
                                          .cityListValues.isNotEmpty
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 30, bottom: 0),
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.3)),
                                              hintText: tadaApplyController
                                                      .cityListValues.isNotEmpty
                                                  ? 'Select City'
                                                  : "No data available.",
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              label: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFDFFBFE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 6.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 30,
                                              ),
                                            ),
                                            iconSize: 30,
                                            items: List.generate(
                                                tadaApplyController
                                                    .clintListValues
                                                    .length, (index) {
                                              return DropdownMenuItem(
                                                value: tadaApplyController
                                                    .cityListValues[index],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 13, left: 5),
                                                  child: Text(
                                                    tadaApplyController
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
                                                            letterSpacing:
                                                                0.3)),
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
                              tadaApplyController.clintListValues.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 30),
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
                                              thumbColor:
                                                  const Color(0xFF1E38FC),
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
                                                child: Column(
                                                  children: [
                                                    // SizedBox(
                                                    //     height: 30,
                                                    //     child: Obx(() {
                                                    //       return CheckboxListTile(
                                                    //         controlAffinity:
                                                    //             ListTileControlAffinity
                                                    //                 .leading,
                                                    //         checkboxShape: RoundedRectangleBorder(
                                                    //             borderRadius:
                                                    //                 BorderRadius
                                                    //                     .circular(
                                                    //                         6)),
                                                    //         dense: true,
                                                    //         activeColor: Theme
                                                    //                 .of(context)
                                                    //             .primaryColor,
                                                    //         contentPadding:
                                                    //             const EdgeInsets
                                                    //                     .symmetric(
                                                    //                 horizontal:
                                                    //                     8),
                                                    //         visualDensity:
                                                    //             const VisualDensity(
                                                    //                 horizontal:
                                                    //                     -4.0),
                                                    //         title: Text(
                                                    //           "Select All",
                                                    //           style: Theme.of(
                                                    //                   context)
                                                    //               .textTheme
                                                    //               .labelSmall!
                                                    //               .merge(const TextStyle(
                                                    //                   fontWeight:
                                                    //                       FontWeight
                                                    //                           .w400,
                                                    //                   fontSize:
                                                    //                       14.0,
                                                    //                   letterSpacing:
                                                    //                       0.3)),
                                                    //         ),
                                                    //         value:
                                                    //             selectAllDepartment
                                                    //                 .value,
                                                    //         onChanged:
                                                    //             (bool? value) {
                                                    //           setState(() {
                                                    //             tadaApplyController
                                                    //                 .clintSelectedValues
                                                    //                 .clear();
                                                    //             selectAllDepartment
                                                    //                     .value =
                                                    //                 value!;
                                                    //             if (value) {
                                                    //               tadaApplyController
                                                    //                   .clintSelectedValues
                                                    //                   .addAll(tadaApplyController
                                                    //                       .clintListValues);
                                                    //             }
                                                    //           });
                                                    //         },
                                                    //       );
                                                    //     })),
                                                    // const SizedBox(
                                                    //   height: 6.0,
                                                    // ),
                                                    ListView.builder(
                                                      itemCount:
                                                          tadaApplyController
                                                              .clintListValues
                                                              .length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                            height: 35,
                                                            child: Obx(() {
                                                              return CheckBoxContainer(
                                                                  sectionName:
                                                                      "${tadaApplyController.clintListValues.elementAt(index).ismmclTClientName}",
                                                                  func: (b) {
                                                                    setState(
                                                                        () {
                                                                      if (b) {
                                                                        tadaApplyController.addSelectedValues(tadaApplyController
                                                                            .clintListValues
                                                                            .elementAt(index));

                                                                        tadaApplyController.addAddress(tadaApplyController
                                                                            .clintListValues
                                                                            .elementAt(index)
                                                                            .ismmclTAddress!);
                                                                        int count =
                                                                            0;
                                                                        _addressController
                                                                            .clear();
                                                                        for (int i =
                                                                                0;
                                                                            i < tadaApplyController.addressListController.length;
                                                                            i++) {
                                                                          count++;
                                                                          _addressController.text +=
                                                                              ' $count ) ${tadaApplyController.addressListController[i]}  ';
                                                                        }
                                                                      } else {
                                                                        _addressController
                                                                            .clear();
                                                                        selectAllDepartment.value =
                                                                            false;
                                                                        tadaApplyController.removeSelectedValues(tadaApplyController
                                                                            .clintListValues
                                                                            .elementAt(index));
                                                                        for (int i =
                                                                                0;
                                                                            i < tadaApplyController.addressListController.length;
                                                                            i++) {
                                                                          tadaApplyController
                                                                              .addressListController
                                                                              .removeAt(i);
                                                                          _addressController.text +=
                                                                              '${i + 1} ) ${tadaApplyController.addressListController.elementAt(i)} ';
                                                                        }
                                                                      }
                                                                    });
                                                                  },
                                                                  isChecked:
                                                                      RxBool(
                                                                    tadaApplyController
                                                                        .clintSelectedValues
                                                                        .contains(
                                                                      tadaApplyController
                                                                          .clintListValues
                                                                          .elementAt(
                                                                              index),
                                                                    ),
                                                                  ));
                                                            }));
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 16.0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const ContainerTitle(
                                            iT: Color(0xFFFF6F67),
                                            bg: Color.fromARGB(
                                                255, 255, 236, 235),
                                            image:
                                                'assets/images/subjectfielicon.png',
                                            title: 'Select Clint',
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              Container(
                                margin: const EdgeInsets.only(top: 30),
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
                                              " Remark",
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
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 30),
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
                                              " Address",
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
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(top: 20),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: DataTable(
                                      dataRowHeight: 50,
                                      headingRowHeight: 40,
                                      columnSpacing: 20,
                                      headingTextStyle:
                                          const TextStyle(color: Colors.white),
                                      border: TableBorder.all(
                                        color: Colors.black,
                                        width: 0.6,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Theme.of(context)
                                                  .primaryColor),
                                      columns: const [
                                        DataColumn(label: Text("Select")),
                                        DataColumn(label: Text("Particulars")),
                                        DataColumn(label: Text("Amount")),
                                        DataColumn(label: Text("Days")),
                                        DataColumn(label: Text("Total Sots")),
                                        DataColumn(label: Text("Slots")),
                                        DataColumn(label: Text("Total Amount")),
                                        DataColumn(label: Text("Remark")),
                                      ],
                                      rows: List.generate(newTableData.length,
                                          (index) {
                                        return DataRow(cells: [
                                          DataCell(Checkbox(
                                            onChanged: (value) {
                                              setState(() {
                                                selectedAll.clear();
                                                isSelect = value!;
                                                tadaApplyController
                                                    .totalAmountController
                                                    .clear();

                                                if (value) {
                                                  selectedAll.add(newTableData
                                                      .elementAt(index));
                                                  tadaApplyController
                                                      .totalAmountController
                                                      .add(
                                                          TextEditingController(
                                                              text: newTableData
                                                                  .elementAt(
                                                                      index)
                                                                  .amount
                                                                  .toString()));
                                                  allAmount += num.parse(
                                                      tadaApplyController
                                                          .totalAmountController
                                                          .elementAt(index)
                                                          .text);
                                                } else {
                                                  selectedAll.remove(
                                                      newTableData
                                                          .elementAt(index));
                                                  // tadaApplyController
                                                  //     .totalAmountController
                                                  //     .removeAt(index);
                                                  allAmount -= num.parse(
                                                      tadaApplyController
                                                          .totalAmountController[
                                                              index]
                                                          .text);
                                                  //  num.parse(
                                                  //     tadaApplyController
                                                  //         .totalAmountController
                                                  //         .elementAt(index)
                                                  //         .text);
                                                }
                                              });
                                            },
                                            value: isSelect,
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                          )),
                                          DataCell(Text(newTableData
                                              .elementAt(index)
                                              .particulars)),
                                          DataCell(Text(newTableData
                                              .elementAt(index)
                                              .amount
                                              .toString())),
                                          DataCell(Text(newTableData
                                              .elementAt(index)
                                              .days
                                              .toString())),
                                          DataCell(Text(newTableData
                                              .elementAt(index)
                                              .totalSlot
                                              .toString())),
                                          DataCell(SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: TextFormField(
                                                  // controller: tadaApplyController.slotController
                                                  //     .elementAt(index),
                                                  ),
                                            ),
                                          )),
                                          DataCell(Text(newTableData
                                              .elementAt(index)
                                              .totalAmount
                                              .toString())),
                                          DataCell(SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: TextFormField(
                                                autocorrect: true,
                                                // controller: tadaApplyController
                                                //     .remarksController
                                                //     .elementAt(index),
                                              ),
                                            ),
                                          )),
                                        ]);
                                      }),
                                    )),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Total Amount: ",
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: " ₹ $allAmount",
                                    style: Get.textTheme.titleSmall),
                              ])),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: MSkollBtn(
                                  title: "Save",
                                  onPress: () {},
                                ),
                              )
                            ],
                          )
                        : const Center(
                            child: AnimatedProgressWidget(
                              title: "No data Found",
                              desc: " ",
                              animationPath: "assets/json/nodata.json",
                              animatorHeight: 250,
                            ),
                          )
                  ],
                ),
              );
      }),
    );
  }
}
