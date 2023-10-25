import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/fee_reminder_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class FeeReminderApi {
  FeeReminderApi.init();
  static final FeeReminderApi instance = FeeReminderApi.init();

  showFeeReminder(
      {required int miId,
      required int asmayId,
      required int amstId,
      required int asmclId,
      required int asmsId,
      required String base,
      required BuildContext context,
      required LoginSuccessModel loginSuccessModel,
      required MskoolController mskoolController}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.stdFeeDue;

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId,
        "AMST_Id": amstId,
      });

      if (response.data['studentDue'] == null ||
          (response.data['studentDue']['\$values'] as List).isEmpty) {
        return null;
      }

      final FeeReminderModel feeReminderModel =
          FeeReminderModel.fromJson(response.data['studentDue']);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/clock.png',
                          height: 24.0,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Fee's Reminder",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F0),
                          borderRadius: BorderRadius.circular(24.0)),
                      child: Text(
                        "₹${feeReminderModel.values!.first.fINE}/Day",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(const TextStyle(color: Color(0xFFF5483E))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Image.asset(
                  "assets/images/money.png",
                  height: 80,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  "₹${feeReminderModel.values!.first.tobePaid}",
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        const TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFFFF385C),
                        ),
                      ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Due Date : ",
                        style: Theme.of(context).textTheme.titleSmall!),
                    Text(
                      getDate(
                        DateTime.parse(feeReminderModel.values!.first.dUEDATE!),
                      ),
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                          TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Installment : ",
                        style: Theme.of(context).textTheme.titleSmall!),
                    Text(
                      feeReminderModel.values!.first.tERMNAME!.split(" ").first,
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                          TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Pay Later",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MSkollBtn(
                          title: "Pay Now",
                          onPress: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (_) {
                            //   return OnlinePaymentScreen(
                            //     loginSuccessModel: loginSuccessModel,
                            //     mskoolController: mskoolController,
                            //     title: 'Online Fee Payment',
                            //   );
                            // }));
                          }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unexpected Error Occured",
        "errorMsg":
            "Sorry! but we are unable to connect to server right now, or server returned an error, Try again later"
      });
    }
  }

  String getDate(DateTime dt) {
    String re = "";
    if (dt.day < 10) {
      re += "0${dt.day}";
    } else {
      re += "${dt.day}-";
    }

    re += "${dt.month}-";
    re += "${dt.year}";
    return re;
  }
}
