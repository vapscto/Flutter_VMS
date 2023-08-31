import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/view_notice/controller/view_notice_data_controller.dart';
import 'package:m_skool_flutter/staffs/view_notice/screens/view_notice_details.dart';
import 'package:m_skool_flutter/staffs/view_notice/widget/view_notice_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class CircularNoticeWidget extends StatefulWidget {
  final String base;
  final ViewNoticeDataController datController;
  final String moduleName;
  const CircularNoticeWidget({
    super.key,
    required this.datController,
    required this.moduleName,
    required this.base,
  });

  @override
  State<CircularNoticeWidget> createState() => _CircularNoticeWidgetState();
}

class _CircularNoticeWidgetState extends State<CircularNoticeWidget> {
  int color = -1;
  List<int> addedColor = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget
              .datController.isErrorOccuredWhileLoadingCircularContent.value
          ? const ErrWidget(err: {
              "errorTitle": "An Error Occured",
              "errorMsg":
                  "While Loading Content for selected academic year. We encountered an error"
            })
          : widget.datController.isLoadingCircularContent.value
              ? Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    AnimatedProgressWidget(
                        title: "Loading ${widget.moduleName} ",
                        desc:
                            "We are loading timetable's , it will be displayed here.",
                        animationPath: "assets/json/Noticeboard.json"),
                  ],
                )
              : widget.datController.circularList.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        AnimatedProgressWidget(
                          title: "No ${widget.moduleName} Available",
                          desc:
                              "Hi sir/ma'am there is no timetable available for this session, you can try with other.",
                          animationPath: "assets/json/nodata.json",
                          animatorHeight: 250,
                        ),
                      ],
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (_, index) {
                        color += 1;
                        if (color % 6 == 0) {
                          color = 0;
                        }
                        addedColor.add(color);
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
                                  values: widget.datController.circularList
                                      .elementAt(index),
                                  intBId: widget.datController.circularList
                                      .elementAt(index)
                                      .iNTBId!,
                                  base: widget.base,
                                );
                              }),
                            );
                          },
                          child: ViewNoticeItem(
                            color: color,
                            title: widget.datController.circularList
                                        .elementAt(index)
                                        .iNTBTitle ==
                                    null
                                ? "N/A"
                                : widget.datController.circularList
                                    .elementAt(index)
                                    .iNTBTitle!,
                            date: widget.datController.circularList
                                        .elementAt(index)
                                        .iNTBStartDate ==
                                    null
                                ? "N/A"
                                : getDate(
                                    DateTime.parse(
                                      widget.datController.circularList
                                          .elementAt(index)
                                          .iNTBStartDate!,
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
                      itemCount: widget.datController.circularList.length,
                    );
    });
  }
}
