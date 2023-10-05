import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          "Note:",
          style: Get.textTheme.titleMedium!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 8),
        Text(
          "* TA-DA Should Be Applied with 48 Hours of Arrival",
          style: Get.textTheme.titleSmall!.copyWith(color: Colors.red),
        ),
        Text(
          "* If Daily Report Not Generated TADA Not Applicable",
          style: Get.textTheme.titleSmall!.copyWith(color: Colors.red),
        ),
        Text(
          "* New TADA is not applicable until previous TADA is settled",
          style: Get.textTheme.titleSmall!.copyWith(color: Colors.red),
        ),
        const SizedBox(height: 8),
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
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3050),
                        selectableDayPredicate: (day) =>
                            day.weekday == 7 || day.weekday == 7 ? false : true,
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
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
                            dayCount = toDate!.difference(fromDate!).inDays + 1;
                            toSelectedDate =
                                '${numberList[toDate!.month]}-${numberList[toDate!.day]}-${toDate!.year}';
                          });
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Please Select Start Date");
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
                                dayCount =
                                    toDate!.difference(fromDate!).inDays + 1;
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      if (_endDate.text.isNotEmpty) {
                        fromTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.dialOnly,
                            builder: (context, childWidget) {
                              return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: childWidget!);
                            });

                        if (fromTime != null) {
                          _startTime.text =
                              '${numberList[fromTime!.hourOfPeriod]}:${numberList[fromTime!.minute]} ${fromTime!.period.name.toUpperCase()}';
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Please select Data");
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                hour: fromTime!.hour, minute: fromTime!.minute),
                            builder: (context, childWidget) {
                              return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: childWidget!);
                            });
                        if (toTime != null) {
                          _endTime.text =
                              '${numberList[toTime!.hourOfPeriod]}:${numberList[toTime!.minute]} ${toTime!.period.name.toUpperCase()}';
                          calculateHour(_startDate.text, _startTime.text,
                              _endDate.text, _endTime.text);
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Please Select Start Time");
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
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
        const SizedBox(height: 30),
      ],
    );
  }
}
