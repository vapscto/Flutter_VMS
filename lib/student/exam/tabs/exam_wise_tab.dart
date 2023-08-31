import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/exam/controller/exam_controller.dart';
import 'package:m_skool_flutter/student/exam/widget/exam_wise_graph.dart';
import 'package:m_skool_flutter/student/exam/widget/result_analysis_item.dart';

import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

import '../model/academic_year_model.dart';
import '../model/exam_list_model.dart';

class ExamWiseTab extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ExamWiseTab({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<ExamWiseTab> createState() => _ExamWiseTabState();
}

class _ExamWiseTabState extends State<ExamWiseTab> {
  final examController = Get.put(ExamController());

  int color = -1;

  RxBool showGraph = RxBool(false);
  getExamList(int asmayID) async {
    examController.examList.clear();
    examController.isloading(true);
    await examController
        .getExamListData(
            miID: widget.loginSuccessModel.mIID!,
            amstID: widget.loginSuccessModel.amsTId!,
            asmayID: asmayID,
            base: baseUrlFromInsCode(
              'portal',
              widget.mskoolController,
            ))
        .then((value) {
      if (value) {
        getMarkOverviewData(examController.examList.first.emEId!);
      }
    });
    examController.isloading(false);
  }

  getMarkOverviewData(int emeID) async {
    examController.examwiseMarkOverview.clear();
    examController.isDataListloading(true);
    await examController.getMarkOverviewData(
        miID: widget.loginSuccessModel.mIID!,
        asmayID: examController.selectedYear!.asmaYId!,
        asmtID: widget.loginSuccessModel.amsTId!,
        emeID: emeID,
        base: baseUrlFromInsCode(
          'portal',
          widget.mskoolController,
        ));
    examController.isDataListloading(false);
  }

  getAcademicYear() async {
    examController.isloading(true);
    await examController
        .getAcademicYearData(
            miID: widget.loginSuccessModel.mIID!,
            amstID: widget.loginSuccessModel.amsTId!,
            base: baseUrlFromInsCode(
              'portal',
              widget.mskoolController,
            ))
        .then((value) async {
      if (value) {
        await examController
            .getExamListData(
                miID: widget.loginSuccessModel.mIID!,
                amstID: widget.loginSuccessModel.amsTId!,
                asmayID: examController.selectedYear!.asmaYId!,
                base: baseUrlFromInsCode(
                  'portal',
                  widget.mskoolController,
                ))
            .then((value) async {
          if (value) {
            examController.examwiseMarkOverview.clear();
            examController.isDataListloading(true);
            await examController.getMarkOverviewData(
                miID: widget.loginSuccessModel.mIID!,
                asmayID: examController.selectedYear!.asmaYId!,
                asmtID: widget.loginSuccessModel.amsTId!,
                emeID: examController.examList.first.emEId!,
                base: baseUrlFromInsCode(
                  'portal',
                  widget.mskoolController,
                ));
            examController.isDataListloading(false);
          }
        });
      }
    });
    examController.isloading(false);
  }

  @override
  void initState() {
    getAcademicYear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Obx(
        () => examController.isLoading.value
            ? Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.25,
                  ),
                  const AnimatedProgressWidget(
                      title: "Loading Examwise Details",
                      desc:
                          "Please wait while we gather exam data form examination department.",
                      animationPath: "assets/json/exam.json"),
                ],
              )
            // ? const Center(
            //     child: CircularProgressIndicator(),
            //   )
            : Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Column(
                    children: [
                      Container(
                        //padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<AcademicYearValues>(
                          isExpanded: true,
                          value: examController.selectedYear,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(12.0),
                            // ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 12.0),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            hintText: examController.academicYearList.isNotEmpty
                                ? 'select year'
                                : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),

                            label: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: const Color(0xFFDFFBFE)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    "assets/images/cap.png",
                                    height: 28.0,
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    "Academic Year".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(const TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xFF28B6C8))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 30,
                          isDense: true,
                          items: List.generate(
                            examController.academicYearList.length,
                            (index) {
                              return DropdownMenuItem<AcademicYearValues>(
                                value: examController.academicYearList
                                    .elementAt(index),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 13, left: 5),
                                  child: Text(
                                    examController.academicYearList
                                        .elementAt(index)
                                        .asmaYYear!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3,
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                          onChanged: (s) {
                            examController.selectedYear = s;
                            getExamList(s!.asmaYId!);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<ExamListValue>(
                          isExpanded: true,
                          value: examController.selectedExam,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(12.0),
                            // ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 12.0),
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
                            isDense: true,
                            hintText: examController.examList.isNotEmpty
                                ? 'select exam'
                                : 'No exam available for selected year',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            label: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: const Color(0xFFFFEBEA)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/exam_icon_.svg',
                                    height: 24.0,
                                  ),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Text(
                                    'Select Exam',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(const TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFFFF6F67),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 30,
                          items: List.generate(examController.examList.length,
                              (index) {
                            return DropdownMenuItem(
                              value: examController.examList.elementAt(index),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  examController.examList
                                      .elementAt(index)
                                      .emEExamName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) {
                            examController.selectedExam = s;
                            getMarkOverviewData(s!.emEId!);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  examController.isDataListLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Marks Overview',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(
                                          const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 1.5)),
                                    child: Row(
                                      children: [
                                        Obx(() {
                                          return InkWell(
                                            onTap: () {
                                              showGraph.value = false;
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 6.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                    24.0,
                                                  ),
                                                  bottomLeft:
                                                      Radius.circular(24.0),
                                                ),
                                                color: showGraph.value
                                                    ? Colors.transparent
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                              child: Text(
                                                "Static",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(TextStyle(
                                                        color: showGraph.value
                                                            ? Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .color
                                                            : Colors.white)),
                                              ),
                                            ),
                                          );
                                        }),
                                        Obx(() {
                                          return InkWell(
                                            onTap: () {
                                              showGraph.value = true;
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 6.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topRight: Radius.circular(
                                                    24.0,
                                                  ),
                                                  bottomRight:
                                                      Radius.circular(24.0),
                                                ),
                                                color: showGraph.value
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.transparent,
                                              ),
                                              child: Text(
                                                "Graph",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(TextStyle(
                                                        color: showGraph.value
                                                            ? Colors.white
                                                            : Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .color)),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              examController.examwiseMarkOverview.isNotEmpty
                                  ? Obx(() {
                                      color = -1;
                                      return showGraph.value
                                          ? ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: examController
                                                  .examwiseMarkOverview.length,
                                              itemBuilder: (_, index) {
                                                color += 1;
                                                if (index % 4 == 0) {
                                                  color = 0;
                                                }
                                                if (color > 4) {
                                                  color = 0;
                                                }
                                                return CustomContainer(
                                                  child:
                                                      GraphResultAnalysisItem(
                                                    datamodel: examController
                                                        .examwiseMarkOverview
                                                        .elementAt(index),
                                                    chipColor: chipColor
                                                        .elementAt(color),
                                                    textColor: textColor
                                                        .elementAt(color),
                                                    gradeColor: pieColor
                                                        .elementAt(color),
                                                    containerColor:
                                                        examCardColor
                                                            .elementAt(color),
                                                    obtainedColor: pieColor
                                                        .elementAt(color),
                                                    pieColor: examCardColor
                                                        .elementAt(color),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                  height: 16.0,
                                                );
                                              },
                                            )
                                          : ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: examController
                                                  .examwiseMarkOverview.length,
                                              itemBuilder: (context, index) {
                                                color += 1;
                                                if (index % 4 == 0) {
                                                  color = 0;
                                                }
                                                if (color > 4) {
                                                  color = 0;
                                                }
                                                return ResultAnalysisItem(
                                                  datamodel: examController
                                                      .examwiseMarkOverview
                                                      .elementAt(index),
                                                  chipColor: examController
                                                      .chipColor
                                                      .elementAt(color),
                                                  containerColor: examController
                                                      .containerColor
                                                      .elementAt(color),
                                                  gradeColor: examController
                                                      .gradeColor
                                                      .elementAt(color),
                                                );
                                              },
                                            );
                                    })
                                  : Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Text(
                                          'No data for selected Exam....',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(
                                                TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                ],
              ),
      ),
    );
  }
}
