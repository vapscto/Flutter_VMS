import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_get_work.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/api/view_notice_filter.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';

class FilterControllerWidget extends StatelessWidget {
  final HwCwNbController hwCwNbController;
  final RxBool showFilter;
  final bool forHwCw;
  final bool? forHw;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwController? hwCwController;
  final ViewNoticeDataController? datController;
  const FilterControllerWidget(
      {super.key,
      required this.hwCwNbController,
      required this.showFilter,
      required this.forHwCw,
      required this.loginSuccessModel,
      required this.mskoolController,
      this.hwCwController,
      this.forHw,
      this.datController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .merge(const TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      // DateTime firstDate = DateTime(
                      //   DateTime.now().month == 1
                      //       ? DateTime.now().year - 1
                      //       : DateTime.now().year,
                      //   DateTime.now().month == 1
                      //       ? 12
                      //       : DateTime.now().day == 1
                      //           ? DateTime.now().month - 1
                      //           : DateTime.now().month,
                      // );

                      DateTime firstDate = DateTime(
                        DateTime.now().year - 1,
                      );

                      DateTime endDate = DateTime.now();
                      if (hwCwNbController.dtList.length > 1) {
                        endDate = hwCwNbController.dtList.last;
                      }
                      final DateTime? startDate = await showDatePicker(
                          context: context,
                          initialDate: hwCwNbController.dtList.isNotEmpty
                              ? hwCwNbController.dtList.first
                              : DateTime.now(),
                          firstDate: firstDate,
                          lastDate: endDate);
                      if (startDate == null) {
                        Fluttertoast.showToast(msg: "Please select start date");
                        return;
                      }
                      hwCwNbController.updateStartDateProvided(true);
                      if (hwCwNbController.dtList.isEmpty) {
                        hwCwNbController.updateStartBy(
                            "${startDate.day}-${startDate.month}-${startDate.year}");
                        hwCwNbController.dtList.add(startDate);
                      }

                      if (hwCwNbController.dtList.length == 1) {
                        hwCwNbController.dtList.first = startDate;
                        hwCwNbController.updateStartBy(
                            "${startDate.day}-${startDate.month}-${startDate.year}");
                      }

                      if (hwCwNbController.dtList.length > 1) {
                        hwCwNbController.dtList.first = startDate;
                        hwCwNbController.updateStartBy(
                            "${startDate.day}-${startDate.month}-${startDate.year}");
                        hwCwNbController.updateShowFilter(
                            hwCwNbController.filter.value + 1);
                        showFilter.value = false;

                        Fluttertoast.showToast(
                            msg:
                                "Filter Applied.. now you will see the filtered result");
                        await filter();
                      }
                      //hwCwNbController.dtList.add(startDate);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Builder(builder: (context) {
                        return Obx(() {
                          return Text(
                            hwCwNbController.startBy.value,
                            style: Theme.of(context).textTheme.titleSmall,
                          );
                        });
                      }),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () async {
                    if (!hwCwNbController.startDateProvided.value) {
                      Fluttertoast.showToast(
                          msg:
                              "Please provide start date before selecting end date");
                      return;
                    }
                    DateTime firstDate = DateTime(
                      DateTime.now().month == 1
                          ? DateTime.now().year - 1
                          : DateTime.now().year,
                      DateTime.now().month == 1
                          ? 12
                          : DateTime.now().day == 1
                              ? DateTime.now().month - 1
                              : DateTime.now().month,
                    );
                    firstDate = hwCwNbController.dtList.first;
                    final DateTime? endDate = await showDatePicker(
                        context: context,
                        initialDate: hwCwNbController.dtList.isNotEmpty &&
                                hwCwNbController.dtList.length > 1
                            ? hwCwNbController.dtList.last
                            : DateTime.now(),
                        firstDate: firstDate,
                        lastDate: DateTime.now());

                    if (endDate == null) {
                      Fluttertoast.showToast(
                          msg: "Please select end date to start filter");
                      return;
                    }

                    if (hwCwNbController.dtList.first.day > endDate.day &&
                        hwCwNbController.dtList.first.month > endDate.month) {
                      Fluttertoast.showToast(
                          msg: "End Date must not be less than start date");
                      return;
                    }
                    hwCwNbController.updateEndby(
                        "${endDate.day}-${endDate.month}-${endDate.year}");
                    hwCwNbController.dtList.add(endDate);

                    // hwCwNbController
                    //     .updateStartDateProvided(false);
                    // hwCwNbController.updateStartBy("Start Date");
                    // hwCwNbController.updateEndby("End Date");

                    hwCwNbController.dtList.add(endDate);
                    hwCwNbController
                        .updateShowFilter(hwCwNbController.filter.value + 1);
                    showFilter.value = false;

                    Fluttertoast.showToast(
                        msg:
                            "Filter Applied.. now you will see the filtered result");

                    await filter();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Obx(() {
                      return Text(
                        hwCwNbController.endBy.value,
                        style: Theme.of(context).textTheme.titleSmall,
                      );
                    }),
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  filter() async {
    if (forHwCw) {
      await GetHomeWorks.instance.getFilteredHwCw(
        miId: loginSuccessModel.mIID!,
        asmayId: loginSuccessModel.asmaYId!,
        hrmeId: loginSuccessModel.empcode!,
        startDate: hwCwNbController.dtList.first.toLocal().toString(),
        endDate: hwCwNbController.dtList.last.toLocal().toString(),
        base: baseUrlFromInsCode("portal", mskoolController),
        controller: hwCwController!,
        forHw: forHw!,
      );
      return;
    }
    ViewNoticeFilterApi.instance.getFilteredNotice(
        base: baseUrlFromInsCode("portal", mskoolController),
        hrme: loginSuccessModel.empcode!,
        asmayId: loginSuccessModel.asmaYId!,
        miId: loginSuccessModel.mIID!,
        start: hwCwNbController.dtList.first.toLocal().toString(),
        end: hwCwNbController.dtList.last.toLocal().toString(),
        controller: datController!);
  }
}
