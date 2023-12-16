import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerWidget extends StatefulWidget {
  final String startDate;
  final String endDate;
  const DatePickerWidget(
      {super.key, required this.startDate, required this.endDate});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  List<String> dates = [];
  List<DateTime> selectedDates = <DateTime>[];
  final DateRangePickerController _controller = DateRangePickerController();

  void viewChanged(DateRangePickerViewChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      _controller.selectedDate = args.visibleDateRange.startDate;
    });
  }

  DateTime? min;
  DateTime? max;
  @override
  void initState() {
    selectedDates.add(DateTime.parse(widget.startDate));
    selectedDates.add(DateTime.parse(widget.endDate));
    max = DateTime.parse(widget.endDate);
    min = DateTime.parse(widget.startDate);
    logger.i(max);
    logger.i(min);
    super.initState();
  }

  List<DateTime> newSelectedDates = [];
  List<DateTime> getSelectedDates(DateTime start, DateTime end) {
    for (int i = start.day; i <= end.day; i++) {
      newSelectedDates.add(DateTime(start.year, start.month, i));
    }
    return newSelectedDates;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      content: WillPopScope(
        onWillPop: () => Future(() => false),
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfDateRangePicker(
                minDate: min,
                maxDate: max,
                controller: _controller,
                key: ValueKey(_controller.selectedDates?.length ?? 0),
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.multiple,
                selectionColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.white,
                initialSelectedDates: getSelectedDates(
                    DateTime.parse(widget.startDate),
                    DateTime.parse(widget.endDate)),
                initialDisplayDate: DateTime.parse(widget.startDate),
                initialSelectedDate: DateTime.parse(widget.startDate),
                enablePastDates: (newSelectedDates.length == 1) ? false : true,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  SchedulerBinding.instance.addPostFrameCallback((duration) {
                    setState(() {
                      dates.clear();
                      List selectedDate = args.value;
                      logger.d(selectedDate);
                      for (var i = 0; i < selectedDate.length; i++) {
                        DateTime date =
                            DateTime.parse(selectedDate[i].toString());
                        DateTime utcDate =
                            DateTime.utc(date.year, date.month, date.day);
                        dates.add(utcDate.toIso8601String());
                      }
                      dates.sort((a, b) {
                        return a.compareTo(b);
                      });
                      logger.e(dates);
                    });
                  });
                },
                onViewChanged: (DateRangePickerViewChangedArgs args) {
                  final PickerDateRange visibleDates = args.visibleDateRange;
                  final DateRangePickerView view = args.view;
                },
              ),
              Align(
                alignment: Alignment.center,
                child: MSkollBtn(
                    title: "OK",
                    onPress: () {
                      Get.back(result: dates);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
