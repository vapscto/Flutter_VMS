import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/model/student_dashboard_model.dart';
import 'package:m_skool_flutter/widget/card_widget.dart';

class DashboardTimetable extends StatefulWidget {
  final List<TimeTableListValues> timeTableList;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const DashboardTimetable({
    super.key,
    required this.timeTableList,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<DashboardTimetable> createState() => _DashboardTimetableState();
}

class _DashboardTimetableState extends State<DashboardTimetable> {
  @override
  Widget build(BuildContext context) {
    return (widget.timeTableList.isNotEmpty)
        ? CardWidget(
            padding: const EdgeInsets.all(8.0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Timetable",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  InkWell(
                      onTap: () {
                        //widget.timeTableList.values.first.tTMDDayName!;
                        // Get.to(() => TimeTableHome(
                        //       loginSuccessModel: widget.loginSuccessModel,
                        //       mskoolController: widget.mskoolController,
                        //       month: widget.timeTableList.first.tTMDDayName,
                        //     ));
                      },
                      child: const Icon(Icons.navigate_next_outlined))
                ],
              ),
              Text(widget.timeTableList.first.tTMDDayName ?? "N/a"),
              const SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(widget.timeTableList.length, (index) {
                      return SizedBox(
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: getDashBoardIconByName(widget
                                            .timeTableList
                                            .elementAt(index)
                                            .iSMSSubjectName
                                            .toString()
                                            .toLowerCase())
                                        .withOpacity(0.1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    child: SizedBox(
                                      width: 70,
                                      child: Text(
                                        widget.timeTableList
                                                .elementAt(index)
                                                .iSMSSubjectName ??
                                            "N/a",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: getDashBoardIconByName(widget
                                                .timeTableList
                                                .elementAt(index)
                                                .iSMSSubjectName
                                                .toString()
                                                .toLowerCase())),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 30,
                                child: DottedLine(
                                  dashColor: getDashBoardIconByName(widget
                                      .timeTableList
                                      .elementAt(index)
                                      .iSMSSubjectName
                                      .toString()
                                      .toLowerCase()),
                                  lineThickness: 2,
                                  direction: Axis.vertical,
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 10,
                                color: getDashBoardIconByName(widget
                                    .timeTableList
                                    .elementAt(index)
                                    .iSMSSubjectName
                                    .toString()
                                    .toLowerCase()),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  child: Text(widget.timeTableList
                                          .elementAt(index)
                                          .iSMSSubjectName ??
                                      "N/a"),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.timeTableList
                                        .elementAt(index)
                                        .tTMDPTEndTime ??
                                    "N/a",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              )
            ],
          )
        : Container();
    // ]);
  }
}
