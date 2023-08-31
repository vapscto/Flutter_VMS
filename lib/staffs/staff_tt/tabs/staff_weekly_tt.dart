import 'dart:math';

import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/api/staff_weekly_tt.dart';
import 'package:m_skool_flutter/staffs/staff_tt/model/staff_weekly_tt_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/pdf/daily_pdf_generator.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class StaffWeeklyTT extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffWeeklyTT(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeeklyTTDataModel>(
        future: StaffWeeklyTTApi.instance.getWeeklyTT(
          asmayId: loginSuccessModel.asmaYId!,
          base: baseUrlFromInsCode("portal", mskoolController),
          miId: loginSuccessModel.mIID!,
          userId: loginSuccessModel.userId!,
        ),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomContainer(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0)),
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor,
                              ),
                              columnSpacing: 20,
                              border: TableBorder(
                                  verticalInside: BorderSide(
                                      color: Colors.grey.shade500, width: 0.4)),
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    "Days",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                snapshot.data!.periods.values!.length,
                                (index) => DataRow(
                                  color: MaterialStateColor.resolveWith(
                                    (states) =>
                                        timetablePeriodColor.elementAt(index),
                                  ),
                                  cells: [
                                    DataCell(Text(
                                      "P${snapshot.data!.periods.values!.elementAt(index).ttmPPeriodName}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 0.4,
                            width: 0.4,
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor,
                                  ),
                                  border: TableBorder(
                                      verticalInside: BorderSide(
                                          color: Theme.of(context).dividerColor,
                                          width: 0.4)),
                                  // columnSpacing: 20,
                                  columns: [
                                    // DataColumn(
                                    //   label: Text(
                                    //     "Days",
                                    //     style: Theme.of(context).textTheme.titleSmall!.merge(
                                    //           const TextStyle(
                                    //             color: Colors.white,
                                    //           ),
                                    //         ),
                                    //   ),
                                    // ),
                                    ...List.generate(
                                      snapshot.data!.days.values!.length,
                                      (index) => DataColumn(
                                        label: Text(
                                          snapshot.data!.days.values!
                                              .elementAt(index)
                                              .ttmDDayCode!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(
                                                const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                    snapshot.data!.periods.values!.length,
                                    (index) => DataRow(
                                      cells: [
                                        // DataCell(
                                        //   Container(
                                        //     width: double.infinity,
                                        //     height: 50,
                                        //     color: noticeColor.elementAt(index >= 7 ? 0 : index),
                                        //     child: Text(
                                        //       "P${snapshot.data!.periods.values!.elementAt(index).ttmPPeriodName}",
                                        //     ),
                                        //   ),
                                        // ),
                                        ...List.generate(
                                          snapshot.data!.days.values!.length,
                                          (e2) {
                                            DataCell dC =
                                                const DataCell(Text(""));
                                            for (int i = 0;
                                                i <
                                                    snapshot.data!.tt
                                                        .elementAt(e2)
                                                        .classesAt
                                                        .length;
                                                i++) {
                                              String period = snapshot
                                                  .data!.periods.values!
                                                  .elementAt(index)
                                                  .ttmPPeriodName!;
                                              String day = snapshot
                                                  .data!.days.values!
                                                  .elementAt(e2)
                                                  .ttmDDayName!
                                                  .toLowerCase()
                                                  .trim();

                                              if (snapshot.data!.tt
                                                          .elementAt(e2)
                                                          .classesAt
                                                          .elementAt(i)
                                                          .periodName ==
                                                      period &&
                                                  snapshot.data!.tt
                                                          .elementAt(e2)
                                                          .classesAt
                                                          .elementAt(i)
                                                          .dayName
                                                          .toLowerCase()
                                                          .trim() ==
                                                      day) {
                                                dC = DataCell(
                                                  Text(
                                                    "${snapshot.data!.tt.elementAt(e2).classesAt.elementAt(i).className} ${snapshot.data!.tt.elementAt(e2).classesAt.elementAt(i).sectionName}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(
                                                          TextStyle(
                                                            color:
                                                                timetablePeriodColor
                                                                    .elementAt(
                                                              Random()
                                                                  .nextInt(12),
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                );
                                              }
                                            }
                                            return dC;
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 36.0,
                    ),
                    MSkollBtn(
                        title: "Generate PDF",
                        onPress: () {
                          TTPdfGenerator.instance
                              .generateWeeklyTT(snapshot.data!);
                        }),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: AnimatedProgressWidget(
                title: "Loading Weekly Timetable",
                desc:
                    "Don't Worry you will not going to miss your classes, We are in process to get your timetable ready",
                animationPath: "assets/json/default.json"),
          );
        });
  }
}
