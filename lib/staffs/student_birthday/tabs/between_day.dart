import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/student_birthday/api/student_bday_report_api.dart';
import 'package:m_skool_flutter/staffs/student_birthday/controller/bday_controller.dart';
import 'package:m_skool_flutter/staffs/student_birthday/widget/bday_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class BetweenDays extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const BetweenDays(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<BetweenDays> createState() => _BetweenDaysState();
}

class _BetweenDaysState extends State<BetweenDays> {
  int color = 0;
  final BdayController bdayController = Get.put(BdayController());

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  RxInt changes = RxInt(-1);

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomContainer(
                  child: TextField(
                    readOnly: true,
                    controller: fromDate,
                    style: Theme.of(context).textTheme.titleSmall,
                    //controller: date,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(top: 48.0, left: 12),
                      border: const OutlineInputBorder(),
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: const Color(0xFFDFFBFE),
                        ),
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
                              "From Date",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xFF28B6C8),
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
                      suffixIcon: InkWell(
                          onTap: () async {
                            DateTime? selectedDT = await showDatePicker(
                              context: context,
                              initialDate:
                                  bdayController.fromSelectedDate.value,
                              firstDate: DateTime(DateTime.now().year, 01, 01),
                              lastDate: DateTime(DateTime.now().year, 12, 31),
                            );

                            if (selectedDT == null) {
                              Fluttertoast.showToast(
                                  msg: "You didn't selected the date");
                              return;
                            }
                            changes.value += 1;

                            bdayController.fromSelectedDate.value = selectedDT;
                            fromDate.text =
                                getDate(bdayController.fromSelectedDate.value);

                            if (changes.value > 1) {
                              await StudentBdayReportApi.instance.getBday(
                                  miId: widget.loginSuccessModel.mIID!,
                                  fromDate: bdayController
                                      .fromSelectedDate.value
                                      .toLocal()
                                      .toString(),
                                  toDate: bdayController.toSelectedDate.value
                                      .toLocal()
                                      .toString(),
                                  all1: 1,
                                  flag: "S",
                                  month: bdayController
                                      .fromSelectedDate.value.month
                                      .toString(),
                                  base: baseUrlFromInsCode(
                                      "admission", widget.mskoolController),
                                  type: 1,
                                  bdayController: bdayController);
                            }
                            //date.text = getFormatedDate(selectedDT);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              "assets/images/calendar.png",
                              height: 16.0,
                              width: 16.0,
                              color: const Color(0xFF28B6C8),
                              // color: Theme.of(context)
                              //     .textTheme
                              //     .titleMedium!
                              //     .color,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: CustomContainer(
                  child: TextField(
                    readOnly: true,
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: toDate,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(top: 48.0, left: 12),
                      border: const OutlineInputBorder(),
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: const Color(0xFFDFFBFE),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/calendar.png",
                                height: 24.0, color: const Color(0xFF28B6C8)),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "To Date",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF28B6C8)),
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
                      suffixIcon: InkWell(
                          onTap: () async {
                            if (changes.value == -1) {
                              Fluttertoast.showToast(
                                  msg: "Please Select from Date First");
                              return;
                            }
                            DateTime? selectedDT = await showDatePicker(
                              context: context,
                              initialDate:
                                  bdayController.fromSelectedDate.value,
                              firstDate: bdayController.fromSelectedDate.value,
                              lastDate: DateTime(DateTime.now().year, 12, 31),
                            );

                            if (selectedDT == null) {
                              Fluttertoast.showToast(
                                  msg: "You didn't selected the date");
                              return;
                            }

                            //date.text = getFormatedDate(selectedDT);
                            changes.value += 1;
                            bdayController.toSelectedDate.value = selectedDT;
                            toDate.text =
                                getDate(bdayController.toSelectedDate.value);

                            await StudentBdayReportApi.instance.getBday(
                                miId: widget.loginSuccessModel.mIID!,
                                fromDate: bdayController.fromSelectedDate.value
                                    .toLocal()
                                    .toString(),
                                toDate: bdayController.toSelectedDate.value
                                    .toLocal()
                                    .toString(),
                                all1: 1,
                                flag: "S",
                                month: bdayController
                                    .fromSelectedDate.value.month
                                    .toString(),
                                base: baseUrlFromInsCode(
                                    "admission", widget.mskoolController),
                                type: 1,
                                bdayController: bdayController);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              "assets/images/calendar.png",
                              height: 16.0,
                              width: 16.0,
                              color: const Color(0xFF28B6C8),
                              // color: Theme.of(context)
                              //     .textTheme
                              //     .titleMedium!
                              //     .color,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          // Obx(() {
          //   return changes.value <= 0
          //       ? const AnimatedProgressWidget(
          //           title: "Select From Date & To Date",
          //           desc:
          //               "When you select the date, you will see the bday of the student on that particular selection",
          //           animationPath: "assets/json/nodata.json",
          //           animatorHeight: 250,
          //         )
          //       : Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "Birthday Details",
          //               style: Theme.of(context).textTheme.titleSmall!.merge(
          //                   const TextStyle(fontWeight: FontWeight.w600)),
          //             ),
          //             const SizedBox(
          //               height: 16.0,
          //             ),
          //             StudentBdayBuilder(
          //               fromDate:
          //                   "${bdayController.fromSelectedDate.value.year}-${bdayController.fromSelectedDate.value.month}-${bdayController.fromSelectedDate.value.day}",
          //               loginSuccesModel: widget.loginSuccessModel,
          //               month: "${bdayController.fromSelectedDate.value.month}",
          //               mskoolController: widget.mskoolController,
          //               toDate:
          //                   "${bdayController.toSelectedDate.value.year}-${bdayController.toSelectedDate.value.month}-${bdayController.toSelectedDate.value.day}",
          //               type: 1,
          //             ),
          //           ],
          //         );
          // }),

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
