import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/student_details/api/search_student_api.dart';
import 'package:m_skool_flutter/manager/student_details/model/search_result_model.dart';
import 'package:m_skool_flutter/manager/student_details/screen/view_individual_student_details.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/punch_report/widget/punch_report_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class SearchResultScreen extends StatelessWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final List<String> operators;
  final List<String> condition;
  final List<String> field;
  final List<String> values;
  final String status;
  const SearchResultScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.operators,
      required this.condition,
      required this.field,
      required this.values,
      required this.status});

  @override
  Widget build(BuildContext context) {
    int color = -1;
    return Scaffold(
      appBar: const CustomAppBar(title: "Search Details").getAppBar(),
      body: FutureBuilder<List<SearchResultModelValues>>(
          future: SearchStudentApi.instance.getStudents(
            base: baseUrlFromInsCode("admission", mskoolController),
            miId: loginSuccessModel.mIID!,
            operators: operators,
            conditions: condition,
            field: field,
            value: values,
            stuStatus: status,
          ),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const AnimatedProgressWidget(
                  title: "No Result Found",
                  desc: "There is no result corresponding to your values",
                  animationPath: 'assets/json/nodata.json',
                  animatorHeight: 250,
                );
              }
              return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (_, index) {
                    color += 1;
                    if (color % 6 == 0) {
                      color = 0;
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ViewStudentIndividualDetails(
                              asmayId: loginSuccessModel.asmaYId!,
                              amstId: snapshot.data!.elementAt(index).aMSTId!,
                              miId: loginSuccessModel.mIID!,
                              baseUrl: baseUrlFromInsCode(
                                  "portal", mskoolController));
                        }));
                      },
                      child: CustomContainer(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: noticeBackgroundColor
                                .elementAt(color)
                                .withOpacity(0.6),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    PunchReportItem(
                                      time:
                                          "${snapshot.data!.elementAt(index).amsTFirstName}",
                                      title: 'Name',
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    PunchReportItem(
                                      time:
                                          "${snapshot.data!.elementAt(index).amsTAdmNo}",
                                      title: 'Admission Number',
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    PunchReportItem(
                                      time:
                                          "${snapshot.data!.elementAt(index).asmcLClassName} & ${snapshot.data!.elementAt(index).asmCSectionName}",
                                      title: 'Class&Section',
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Theme.of(context).primaryColor),
                                child: const Icon(
                                  Icons.chevron_right_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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
                  itemCount: snapshot.data!.length);
            }

            if (snapshot.hasError) {
              return ErrWidget(
                err: snapshot.error as Map<String, dynamic>,
              );
            }
            return const AnimatedProgressWidget(
              title: "Loading Result",
              desc: "We are loading search result, it will appear here",
              animationPath: 'assets/json/default.json',
            );
          }),
    );
  }
}
