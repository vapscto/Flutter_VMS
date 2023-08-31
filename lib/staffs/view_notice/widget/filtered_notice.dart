import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/view_notice/api/view_notice_filter.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/screens/view_notice_details.dart';
import 'package:m_skool_flutter/staffs/view_notice/widget/view_notice_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class FilteredNotice extends StatefulWidget {
  final ViewNoticeDataController datController;
  final String base;
  final int miId;
  final int hrmeId;
  final int asmayId;
  final String startDt;
  final String endDt;
  const FilteredNotice(
      {super.key,
      required this.datController,
      required this.base,
      required this.miId,
      required this.hrmeId,
      required this.asmayId,
      required this.startDt,
      required this.endDt});

  @override
  State<FilteredNotice> createState() => _FilteredNoticeState();
}

class _FilteredNoticeState extends State<FilteredNotice> {
  int backgroundColor = -1;
  List<int> addedColor = [];

  @override
  void initState() {
    ViewNoticeFilterApi.instance.getFilteredNotice(
        base: widget.base,
        hrme: widget.hrmeId,
        asmayId: widget.asmayId,
        miId: widget.miId,
        start: widget.startDt,
        end: widget.endDt,
        controller: widget.datController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.datController.isErrorOccuredWhileLoadingFilteration.value
          ? const Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg":
                      "While getting filtered notice we encountered an error.",
                },
              ),
            )
          : widget.datController.isFilterationLoading.value
              ? Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.25,
                    ),
                    const AnimatedProgressWidget(
                      title: "Loading Fitered Data",
                      desc: "Please wait while we load new data for you",
                      animationPath: "assets/json/Noticeboard.json",
                    ),
                  ],
                )
              : widget.datController.filterList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Notice Found",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Text(
                              "We couldn't find any notice for these filtration")
                        ],
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (_, index) {
                        backgroundColor += 1;
                        if (backgroundColor % 6 == 0) {
                          backgroundColor = 0;
                        }
                        addedColor.add(backgroundColor);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) {
                                return ViewNoticeDetailsScreen(
                                  bgColor: lighterColor.elementAt(
                                    addedColor.elementAt(index),
                                  ),
                                  chipColor: noticeColor.elementAt(
                                    addedColor.elementAt(index),
                                  ),
                                  val: widget.datController.filterList
                                      .elementAt(index),
                                  intBId: widget.datController.filterList
                                      .elementAt(index)
                                      .intBId!,
                                  base: widget.base,
                                );
                              }),
                            );
                          },
                          child: ViewNoticeItem(
                            color: backgroundColor,
                            title: widget.datController.filterList
                                        .elementAt(index)
                                        .intBTitle ==
                                    null
                                ? "N/A"
                                : widget.datController.filterList
                                    .elementAt(index)
                                    .intBTitle!,
                            date: widget.datController.filterList
                                        .elementAt(index)
                                        .intBStartDate ==
                                    null
                                ? "N/A"
                                : getDate(
                                    DateTime.parse(
                                      widget.datController.filterList
                                          .elementAt(index)
                                          .intBStartDate!,
                                    ),
                                  ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                      itemCount: widget.datController.filterList.length,
                    );
    });
  }
}
