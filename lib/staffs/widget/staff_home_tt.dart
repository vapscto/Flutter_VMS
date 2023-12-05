import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

import '../../constants/constants.dart';

class StaffHomeTT extends StatefulWidget {
  final DynamicAnalyticsController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffHomeTT(
      {super.key,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<StaffHomeTT> createState() => _StaffHomeTTState();
}

class _StaffHomeTTState extends State<StaffHomeTT> {
  int ttColor = -1;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        child: Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Timetable",
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "${widget.controller.dashboardTT.first.tTMDDayName ?? "N/A"} | ${getFormatedDate(DateTime.now()).substring(0, getFormatedDate(DateTime.now()).length - 2)}",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .merge(const TextStyle(fontSize: 12.0)),
                    ),
                  ],
                ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              ttColor += 1;
              if (ttColor % 6 == 0) {
                ttColor = 0;
              }
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
                            color: noticeBackgroundColor.elementAt(ttColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 4,
                              bottom: 4,
                            ),
                            child: SizedBox(
                              width: 40,
                              child: Text(
                                widget.controller.dashboardTT
                                        .elementAt(index)
                                        .classsection ??
                                    "N/a",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                        child: DottedLine(
                          dashColor: noticeColor.elementAt(ttColor),
                          lineThickness: 2,
                          direction: Axis.vertical,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 10,
                        color: noticeColor.elementAt(ttColor),
                        // child: const Padding(
                        //   padding: EdgeInsets.only(
                        //     left: 8.0,
                        //     right: 8.0,
                        //     top: 4,
                        //     bottom: 4,
                        //   ),
                        //   child: Text("VIII"),
                        // ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.controller.dashboardTT
                                .elementAt(index)
                                .tTMDPTStartTime ??
                            "N/A",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) {
              return const SizedBox(
                width: 8.0,
              );
            },
            itemCount: widget.controller.dashboardTT.length,
          ),
        )
      ],
    ));
  }
}
