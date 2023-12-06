import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/push_notification.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/overall_fee/screen/overall_fee_home.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/model/notification_model.dart';
import 'package:m_skool_flutter/notice/screen/notice_home.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/attendance_entry_home.dart';
import 'package:m_skool_flutter/staffs/coe/screens/coe_home.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/screen/hw_cw_home.dart';
import 'package:m_skool_flutter/staffs/marks_entry/screen/marks_entry_home.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/screen/notice_board_staff_home.dart';
import 'package:m_skool_flutter/staffs/online_leave/screen/online_leave_home.dart';
import 'package:m_skool_flutter/staffs/punch_report/screens/punch_report_home.dart';
import 'package:m_skool_flutter/staffs/salary_details/screen/salary_det_home.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/screen/student_attendance_staff_home.dart';
import 'package:m_skool_flutter/staffs/student_birthday/screens/bday_home.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/screen/verify_hw_cw_home.dart';
import 'package:m_skool_flutter/student/attendance/screens/home_page.dart';
import 'package:m_skool_flutter/student/certificates/screens/cert_home.dart';
import 'package:m_skool_flutter/student/classwork/screen/classwork_home_screen.dart';
import 'package:m_skool_flutter/student/coe/screen/coe_home.dart';
import 'package:m_skool_flutter/student/exam/screen/exam_home.dart';
import 'package:m_skool_flutter/student/fees/screens/fee_analysis_screen.dart';
import 'package:m_skool_flutter/student/fees/screens/fee_receipt_home.dart';
import 'package:m_skool_flutter/student/fees/screens/online_payment_screen.dart';
import 'package:m_skool_flutter/student/homework/screen/home_work_screen.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/student/interaction/screen/interaction_home.dart';
import 'package:m_skool_flutter/student/interaction/screen/messaging_section.dart';
import 'package:m_skool_flutter/student/library/screen/library_home.dart';
import 'package:m_skool_flutter/student/timetable/screens/time_table_home.dart';
import 'package:m_skool_flutter/vms/api/vms_notification_api.dart';
import 'package:m_skool_flutter/vms/interaction/screen/interaction_home.dart';
import 'package:m_skool_flutter/vms/model/vms_notification_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class NotificationScreen extends StatelessWidget {
  final String openFor;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwNbController? hwCwNbController;
  const NotificationScreen(
      {super.key,
      required this.openFor,
      required this.loginSuccessModel,
      required this.mskoolController,
      this.hwCwNbController});

  @override
  Widget build(BuildContext context) {
    MskoolController mskoolController = Get.find<MskoolController>();
    return Scaffold(
      appBar: const CustomAppBar(title: "Notification").getAppBar(),
      body: FutureBuilder<List<NotificationListModelValues>>(
        future: VMSPushNotification.instance.getAllNotification(
          miId: loginSuccessModel.mIID!,
          userId: loginSuccessModel.userId!,
          base: baseUrlFromInsCode(
            "issuemanager",
            mskoolController,
          ),
          asmayId: loginSuccessModel.asmaYId!,
          flag: 'S',
          ivrmrtId: loginSuccessModel.roleId!,
        ),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const AnimatedProgressWidget(
                animatorHeight: 250,
                animationPath: 'assets/json/nodata.json',
                desc:
                    'There is no notification right now, all your notification will appear here.',
                title: 'No Notification',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    // if (snapshot.data!.elementAt(index).pNSDHeaderFlg == null) {
                    //   Fluttertoast.showToast(
                    //       msg:
                    //           "Sorry but we are unable to redirect because page info is null");
                    //   return;
                    // }
                    // if (openFor.toLowerCase() == "student") {
                    //   logger.d(snapshot.data!.elementAt(index).pNSDHeaderFlg);
                    //   openUsingHeaderForStudent(
                    //       snapshot.data!.elementAt(index).pNSDHeaderFlg!,
                    //       snapshot.data!.elementAt(index).pNSDRedirectURL ?? "",
                    //       snapshot.data!.elementAt(index).pNSDTRANSACTIONID ??
                    //           0);
                    //   return;
                    // }

                    // if (openFor.toLowerCase() == "staff") {
                    //   openUsingHeaderForStaff(
                    //       snapshot.data!
                    //           .elementAt(index)
                    //           .pNSDHeaderFlg!
                    //           .capitalize!,
                    //       context,
                    //       snapshot.data!.elementAt(index).pNSDRedirectURL ?? "",
                    //       snapshot.data!.elementAt(index).pNSDTRANSACTIONID ??
                    //           0);
                    // }
                    // if (openFor.toLowerCase() == "hod") {
                    //   openUsingHeaderForStaff(
                    //       snapshot.data!
                    //           .elementAt(index)
                    //           .pNSDHeaderFlg!
                    //           .capitalize!,
                    //       context,
                    //       snapshot.data!.elementAt(index).pNSDRedirectURL ?? "",
                    //       snapshot.data!.elementAt(index).pNSDTRANSACTIONID ??
                    //           0);
                    // }

                    // if (openFor.toLowerCase() == "manager") {
                    //   openUsingHeaderForManager(
                    //     snapshot.data!
                    //         .elementAt(index)
                    //         .pNSDHeaderFlg!
                    //         .capitalize!,
                    //     context,
                    //     snapshot.data!.elementAt(index).pNSDRedirectURL ?? "",
                    //     snapshot.data!.elementAt(index).pNSDTRANSACTIONID ?? 0,
                    //   );
                    // }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color:
                          snapshot.data!.elementAt(index).iSMNOModeFlg == null
                              ? Colors.grey.shade300
                              : getNotificationItem(snapshot.data!
                                  .elementAt(index)
                                  .iSMNOModeFlg!)['bgColor'],
                    ),
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: snapshot.data!.elementAt(index).iSMNOModeFlg ==
                                  null
                              ? Colors.grey.shade300
                              : getNotificationItem(snapshot.data!
                                  .elementAt(index)
                                  .iSMNOModeFlg!)['color'],
                        ),
                        child:
                            snapshot.data!.elementAt(index).iSMNOModeFlg == null
                                ? const Icon(Icons.broken_image)
                                : Image.asset(
                                    getNotificationItem(snapshot.data!
                                        .elementAt(index)
                                        .iSMNOModeFlg!)['image'],
                                    color: Colors.white,
                                    width: 28.0,
                                    height: 28,
                                  ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.elementAt(index).createdby ??
                                  "N/a",
                              style:
                                  Theme.of(context).textTheme.titleSmall!.merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(snapshot.data!
                                    .elementAt(index)
                                    .iSMNONotification ??
                                "N/a"),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(snapshot.data!.elementAt(index).iSMNOModeFlg ??
                                "N/a"),
                            Text(snapshot.data!.elementAt(index).createdDate ==
                                    null
                                ? "N/a"
                                : snapshot.data!.elementAt(index).createdDate!),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 16.0,
                );
              },
            );
          }

          if (snapshot.hasError) {
            return ErrWidget(
              err: snapshot.error as Map<String, dynamic>,
            );
          }

          return const AnimatedProgressWidget(
            //animatorHeight: 250,
            animationPath: 'assets/json/default.json',
            desc:
                'We are loading your notification please wait while we load for you',
            title: 'Loading Notification',
          );
        },
      ),
    );
  }

  void openUsingHeaderForStudent(
      String headerName, String redirectUrl, num transactionId) {
    logger.d(headerName);

    switch (headerName.toLowerCase()) {
      case "attendance":
        Get.to(() => AttendanceHomeScreen(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController));
        break;
      case "fee details":
        // Get.to(() => FeeHomeScreen(
        //     loginSuccessModel:
        //         loginSuccessModel,
        //     mskoolController:
        //         mskoolController));
        break;
      case "fee payment":
        Get.to(
          () => OnlinePaymentScreen(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            title: "${headerName.capitalize}",
          ),
        );
        break;
      case "fee analysis":
        Get.to(
          () => FeeAnalysisScreen(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            title: "${headerName.capitalize}",
          ),
        );
        break;
      case "classwork":
        Get.to(() => ClassWorkHomeScreen(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            // hwCwNbController:
            //     widget.hwCwNbController,
            title: "${headerName.capitalize}"));
        break;
      case "homework":
        Get.to(
          () => HomeWorkScreen(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            // hwCwNbController:
            //     widget.hwCwNbController,
            title: "${headerName.capitalize}",
          ),
        );
        break;
      case "coe":
        Get.to(() => CoeHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              // hwCwNbController:
              //     widget.hwCwNbController,
              // title:
              //     "${headerName.capitalize}"
            ));
        break;
      case "notice board":
        Get.to(
          () => NoticeHome(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            hwCwNbController: hwCwNbController!,
            appBarTitle: "${headerName.capitalize}",
          ),
        );
        break;

      case "noticeboard":
        Get.to(
          () => NoticeHome(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            hwCwNbController: hwCwNbController!,
            appBarTitle: "${headerName.capitalize}",
          ),
        );
        break;
      case "library":
        String base = baseUrlFromInsCode("portal", mskoolController);
        Get.to(
          () => LibraryHome(
            miId: loginSuccessModel.mIID!,
            asmayId: loginSuccessModel.asmaYId!,
            asmtId: loginSuccessModel.amsTId!,
            base: base,
            title: "${headerName.capitalize}",
          ),
        );
        break;
      case "syllabus":
        break;
      case "exam":
        Get.to(() => ExamHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
            ));
        break;
      case "interaction":
        if (redirectUrl == "InteractionReply" && transactionId.toInt() != 0) {
          // logger.d("NO-> $transactionId");
          Get.to(() => MessagingScreen(
                ismintId: transactionId.toInt(),
                hrmeId: 0,
                ismintComposedById: 0,
                istintId: 0,
                loginSuccessModel: loginSuccessModel,
                mskoolController: mskoolController,
                isGroup: false,
              ));

          break;
        }
        Get.to(() => InteractionHomeScreen(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            animateToInbox: true));
        break;
      case "certificate":
        Get.to(() => CertificateHomeScreen(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
            ));
        break;
      case "time table":
        Get.to(() => TimeTableHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
            ));
        break;
      case "fee receipt":
        Get.to(
          () => FeeReceiptHome(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            title: "${headerName.capitalize}",
          ),
        );
        break;
      default:
        Fluttertoast.showToast(
            msg: "There is no page to open this notification");
    }
  }

  void openUsingHeaderForStaff(String headerName, BuildContext context,
      String redirectUrl, num transactionId) {
    if (headerName == "Attendance Entry") {
      Get.to(
        // () => const MonthWiseAttendanceEntryHomeScreen(),
        () => AttendanceEntryHomeScreen(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ),
        // () => const DayWiseAttendanceEntryHome(),
      );
    }
    if (headerName == "Student Attendance Staff") {
      Get.to(() => StudentAttendanceStaffHome(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
          ));
    }
    if (headerName == "Mark Entry") {
      Get.to(
        () => MarksEntryHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ),
      );
    }

    if (headerName == "Salary Details") {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return
            // SalarySlipHome(
            //   loginSuccessModel: loginSuccessModel,
            //   mskoolController: mskoolController,
            // );
            SalaryDetails(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        );
      }));
      return;
    }
    if (headerName == "Staff Birth Day Report") {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return StudentBdayHome(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        );
      }));
      return;
    }

    if (headerName == "Online Leave Apply") {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return OnlineLeaveApply(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
          title: "${headerName.capitalize}",
        );
      }));
      return;
    }

    if (headerName == "Notice Board") {
      // Navigator.push(context, MaterialPageRoute(builder: (_) {
      //   return ViewNoticeHome(
      //     loginSuccessModel: loginSuccessModel,
      //     mskoolController: mskoolController,
      //     title: loginSuccessModel
      //         .staffmobileappprivileges!.values!
      //         .elementAt(index)
      //         .pagename!,
      //   );
      // }));

      // Notice Board Staff
      Get.to(() => NoticeBoardStaffHome(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            title: "${headerName.capitalize}",
          ));
      return;
    }
    if (headerName == "Punch Report") {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return PunchReport(
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
          title: "${headerName.capitalize}",
        );
      }));
      return;
    }

    if (headerName == "Verify Homework") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return VerifyHwCwHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              title: "${headerName.capitalize}",
              forHw: true,
            );
          },
        ),
      );
      return;
    }
    if (headerName == "Verify Classwork") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return VerifyHwCwHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              title: "${headerName.capitalize}",
              forHw: false,
            );
          },
        ),
      );
      return;
    }
    if (headerName == "Classwork") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return HwCwHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              title: "${headerName.capitalize}",
              forHw: false,
              scroll: true,
            );
          },
        ),
      );
      return;
    }
    if (headerName == "Homework") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return HwCwHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              title: "${headerName.capitalize}",
              forHw: true,
              scroll: true,
            );
          },
        ),
      );

      return;
    }
    if (headerName == "Interaction") {
      if (redirectUrl == "InteractionReply" && transactionId.toInt() != 0) {
        logger.d("NO-> $transactionId");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return MessagingScreen(
                ismintId: transactionId.toInt(),
                hrmeId: 0,
                ismintComposedById: 0,
                istintId: 0,
                loginSuccessModel: loginSuccessModel,
                mskoolController: mskoolController,
                isGroup: false,
              );

              // return MessagingScreen(
              //   ismintId: ,
              // );
            },
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return InteractionHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              animateToInbox: true,
            );

            // return MessagingScreen(
            //   ismintId: ,
            // );
          },
        ),
      );
      return;
    }

    if (headerName == "COE") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return StaffCoeHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              title: "${headerName.capitalize}",
              //forHw: true,
            );
          },
        ),
      );
      return;
    }
    Fluttertoast.showToast(msg: "There is no page to open this notification");
  }

  void openUsingHeaderForManager(
      String s, BuildContext context, String redirectUrl, num transactionId) {
    if (s.toLowerCase().contains("student")) {
      // Navigator.push(context, MaterialPageRoute(builder: (_) {
      //   return ManagerStudentDetails(
      //     loginSuccessModel: loginSuccessModel,
      //     mskoolController: mskoolController,
      //     title: "Student Details",
      //   );
      // }));

      return;
    }

    if (s.toLowerCase().contains("notice")) {
      Get.to(() => NoticeBoardStaffHome(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController,
            title: "Notice Board",
          ));
    }

    if (s.toLowerCase().contains("fee")) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return OverallFeeHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              title: "Overall Fee",
            );
          },
        ),
      );

      return;
    }

    if (s.toLowerCase().contains("Interaction")) {
      if (redirectUrl == "InteractionReply" && transactionId.toInt() != 0) {
        logger.d("NO-> $transactionId");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return MessagingScreen(
                ismintId: transactionId.toInt(),
                hrmeId: 0,
                ismintComposedById: 0,
                istintId: 0,
                loginSuccessModel: loginSuccessModel,
                mskoolController: mskoolController,
                isGroup: false,
              );

              // return MessagingScreen(
              //   ismintId: ,
              // );
            },
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return InteractionHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
              animateToInbox: true,
            );

            // return MessagingScreen(
            //   ismintId: ,
            // );
          },
        ),
      );
      return;
    }
    Fluttertoast.showToast(msg: "There is no page to open this notification");
  }
}
