import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/student/exam/model/result_model.dart';

class ResultDetail extends StatefulWidget {
  final int resultType;

  const ResultDetail({super.key, required this.resultType});

  @override
  State<ResultDetail> createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail> {
  List<String> dummySession = [
    "2017-2018",
    "2018-2019",
    "2019-2020",
    "2020-2021",
    "2021-2022",
  ];

  String selectedValue = "2021-2022";

  List<String> exam = [
    "First Exam",
    "Second Exam",
    "Third Exam",
  ];

  String examSelectValue = "First Exam";

  List<String> Subject = [
    "Biology",
    "Physics",
    "Chemistry",
  ];

  List<ResultModel> resultModel = [
    ResultModel(title: "Mark Obtained".tr, value: "20"),
    ResultModel(title: "Grade".tr, value: "A+"),
    ResultModel(title: "Class Highest".tr, value: "20"),
    ResultModel(title: "Section Highest".tr, value: "20"),
    ResultModel(title: "class Avg".tr, value: "16.05"),
    ResultModel(title: "Section Avg".tr, value: "15.8"),
  ];

  final List<String> dropDownValue = [];
  @override
  void initState() {
    if (widget.resultType == 0) {
      dropDownValue.addAll(exam);
    } else {
      dropDownValue.addAll(Subject);
    }
    super.initState();
  }

  String subjectSelectValue = "Biology";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //         title:
      //             widget.resultType == 0 ? "Exam Wise".tr : "Subject Wise".tr)
      //     .getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                    child: DropdownButtonFormField<String>(
                      value: selectedValue,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(12.0),
                        // ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
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

                        label: Text(
                          "Academic Year".tr,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .merge(TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 19.0,
                              )),
                        ),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      ),
                      iconSize: 30,
                      items: List.generate(
                        dummySession.length,
                        (index) => DropdownMenuItem(
                          value: dummySession.elementAt(index),
                          child: Text(
                            dummySession.elementAt(index),
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
                      ),
                      onChanged: (s) {},
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Container(
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
                    child: DropdownButtonFormField<String>(
                      value: widget.resultType == 0
                          ? examSelectValue
                          : subjectSelectValue,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(12.0),
                        // ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),

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

                        label: Text(
                          widget.resultType == 0
                              ? "Select Exam".tr
                              : "Select Subject".tr,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .merge(TextStyle(
                                color: Colors.grey.shade600,
                              )),
                        ),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      ),
                      iconSize: 30,
                      items: List.generate(
                        dropDownValue.length,
                        (index) => DropdownMenuItem(
                          value: dropDownValue.elementAt(index),
                          child: Text(
                            dropDownValue.elementAt(index),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    letterSpacing: 0.3)),
                          ),
                        ),
                      ),
                      onChanged: (s) {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            // ResultContainerWidget(
            //     title: "English Literature", resultModel: resultModel)

            // ResultAnalysisItem(
            //     color: Colors.red.shade100, type: "English Literature"),
          ],
        ),
      ),
    );
  }
}
