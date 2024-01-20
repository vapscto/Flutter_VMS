import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/certificates/screens/cert_home.dart';
import 'package:m_skool_flutter/student/coe/screen/coe_home.dart';
import 'package:m_skool_flutter/student/fees/screens/fee_analysis_screen.dart';
import 'package:m_skool_flutter/student/fees/screens/fee_receipt_home.dart';
import 'package:m_skool_flutter/student/fees/screens/online_payment_screen.dart';
import 'package:m_skool_flutter/student/interaction/screen/interaction_home.dart';
import 'package:m_skool_flutter/student/interaction/screen/messaging_section.dart';
import 'package:m_skool_flutter/vms/api/vms_notification_api.dart';
import 'package:m_skool_flutter/vms/model/vms_notification_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class NotificationScreen extends StatelessWidget {
  final String openFor;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const NotificationScreen({
    super.key,
    required this.openFor,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

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
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: InkWell(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.elementAt(index).createdby ?? "N/a",
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

      case "coe":
        Get.to(() => CoeHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController,
            ));
        break;

      case "syllabus":
        break;
      case "exam":
        break;
      case "interaction":
        if (redirectUrl == "InteractionReply" && transactionId.toInt() != 0) {
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
}
