import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/student_birthday/api/student_bday_report_api.dart';
import 'package:m_skool_flutter/staffs/student_birthday/model/student_bday_model.dart';
import 'package:m_skool_flutter/staffs/student_birthday/widget/bday_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class StudentBdayBuilder extends StatelessWidget {
  final LoginSuccessModel loginSuccesModel;
  final MskoolController mskoolController;
  final int type;
  final String fromDate;
  final String toDate;
  final String month;
  const StudentBdayBuilder(
      {super.key,
      required this.loginSuccesModel,
      required this.mskoolController,
      required this.type,
      required this.fromDate,
      required this.toDate,
      required this.month});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StudentBdayModelValues>>(
      future: StudentBdayReportApi.instance.getMonthWiseBday(
          miId: loginSuccesModel.mIID!,
          fromDate: fromDate,
          toDate: toDate,
          all1: type,
          flag: "S",
          month: month,
          base: baseUrlFromInsCode("admission", mskoolController),
          type: type),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          int color = -1;
          return ListView.separated(
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
                  value: snapshot.data!.elementAt(index),
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
          return ErrWidget(err: snapshot.error as Map<String, dynamic>);
        }
        return const AnimatedProgressWidget(
            title: "Loading Birthday's",
            desc:
                "We are celebrating, while getting birthday, after our celebration you will get your view",
            animationPath: "assets/json/default.json");
      },
    );
  }
}
