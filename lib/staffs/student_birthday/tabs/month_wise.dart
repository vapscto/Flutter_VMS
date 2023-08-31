import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/student_birthday/api/student_bday_report_api.dart';
import 'package:m_skool_flutter/staffs/student_birthday/controller/bday_controller.dart';
import 'package:m_skool_flutter/staffs/student_birthday/widget/bday_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class MonthWise extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const MonthWise(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<MonthWise> createState() => _MonthWiseState();
}

class _MonthWiseState extends State<MonthWise> {
  Map<String, dynamic> selectedMonth = fullMonthsWithIndex.first;

  int color = -1;

  final BdayController bdayController = Get.put(BdayController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await StudentBdayReportApi.instance.getBday(
          miId: widget.loginSuccessModel.mIID!,
          fromDate: bdayController.fromSelectedDate.value.toLocal().toString(),
          toDate: bdayController.toSelectedDate.value.toLocal().toString(),
          all1: 0,
          flag: "S",
          month: fullMonthsWithIndex.first['day'].toString(),
          base: baseUrlFromInsCode("admission", widget.mskoolController),
          type: 0,
          bdayController: bdayController);
    });
  }

  @override
  void dispose() {
    Get.delete<BdayController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          CustomContainer(
            child: DropdownButtonFormField<Map<String, dynamic>>(
              value: selectedMonth,
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
                // labelStyle: TextStyle(color: Color(0xFF28B6C8)),
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
                        "assets/images/calendar.png",
                        height: 24.0,
                        color: const Color(0xFF28B6C8),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        "Select Month",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  backgroundColor: Color(0xFFDFFBFE),
                                  fontSize: 20.0,
                                  color: Color(0xFF28B6C8)),
                            ),
                      ),
                    ],
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
              icon: const Padding(
                padding: EdgeInsets.only(top: 4.5),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
              ),
              items: fullMonthsWithIndex.map((e) {
                logger.d(fullMonthsWithIndex.length);
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: e,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 5),
                    child: Text(
                      e['month'],
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .merge(const TextStyle(fontSize: 16.0)),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                selectedMonth = value!;
                StudentBdayReportApi.instance.getBday(
                    miId: widget.loginSuccessModel.mIID!,
                    fromDate: bdayController.fromSelectedDate.value
                        .toLocal()
                        .toString(),
                    toDate: bdayController.toSelectedDate.value
                        .toLocal()
                        .toString(),
                    all1: 0,
                    flag: "S",
                    month: selectedMonth['day'].toString(),
                    base: baseUrlFromInsCode(
                        "admission", widget.mskoolController),
                    type: 0,
                    bdayController: bdayController);
                //setState(() {});
                // debugPrint(selectedValue.toString());
              },
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            "Birthday Details",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .merge(const TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Obx(() {
            return bdayController.isErrorOccured.value
                ? ErrWidget(err: bdayController.errorMap.value)
                : bdayController.isLoadingBday.value
                    ? const Center(
                        child: AnimatedProgressWidget(
                          animationPath: "assets/json/default.json",
                          title: 'Loading Student Birthday',
                          desc:
                              'We are in process to get your birthday detail ready.',
                        ),
                      )
                    : bdayController.studentBdayList.isEmpty
                        ? const Center(
                            child: AnimatedProgressWidget(
                              title: "No Birthday to show",
                              desc:
                                  "You can try to change from date and to date to get birthday list",
                              animationPath: "assets/json/nodata.json",
                              animatorHeight: 250,
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              color += 1;
                              if (index % 6 == 0) {
                                color = 0;
                              }
                              if (color > 6) {
                                color = 0;
                              }
                              return BirthdayItem(
                                color: color,
                                value: bdayController.studentBdayList
                                    .elementAt(index),
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 16.0,
                              );
                            },
                            itemCount: bdayController.studentBdayList.length);
          }),
        ],
      ),
    );
  }
}
