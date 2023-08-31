import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/controller/payment_selection_tracking.dart';
import 'package:m_skool_flutter/student/fees/model/custom_grp_list.dart';
import 'package:m_skool_flutter/student/fees/model/disable_terms_model.dart';
import 'package:m_skool_flutter/student/fees/model/payment_gateway_detail.dart';

class GetPayablePaymentDetailApi {
  GetPayablePaymentDetailApi.init();
  static final GetPayablePaymentDetailApi instance =
      GetPayablePaymentDetailApi.init();

  Future<PaymentGateWayDetails> openPaymentGateWay({
    required int miId,
    required int amstId,
    required int asmayId,
    required int asmclId,
    required String base,
    required String gateWayType,
    required PaymentSelectionTracking paymentSelectionTracking,
  }) async {
    final String apiUrl = base + URLS.openPaymentGateWay;
    final Dio ins = getGlobalDio();

    Map<String, dynamic> responseBody = {};

    List<Map<String, dynamic>> selectedList = [];

    List<CustomgGrplistValues> group = [];

    for (int i = 0;
        i < paymentSelectionTracking.selectedInstallment.length;
        i++) {
      if (!group.contains(paymentSelectionTracking.selectedInstallment
          .elementAt(i)
          .groupInfo)) {
        group.add(paymentSelectionTracking.selectedInstallment
            .elementAt(i)
            .groupInfo);
      }
    }
    List<List<DisableTermsModelValues>> disable = [];
    for (int i = 0; i < group.length; i++) {
      List<DisableTermsModelValues> terms = [];
      for (int j = 0;
          j < paymentSelectionTracking.selectedInstallment.length;
          j++) {
        if (group.elementAt(i).fmgGId ==
            paymentSelectionTracking.selectedInstallment
                .elementAt(j)
                .disableTermsModelValues
                .fMGGId) {
          terms.add(paymentSelectionTracking.selectedInstallment
              .elementAt(j)
              .disableTermsModelValues);
        }
      }
      disable.add(terms);
    }

    // logger.d(disable);
    for (int i = 0; i < group.length; i++) {
      List<Map<String, dynamic>> trmList = [];

      for (int j = 0; j < disable.elementAt(i).length; j++) {
        trmList.add({
          "fmT_Id": disable.elementAt(i).elementAt(j).fmtId,
          "fmT_Name": disable.elementAt(i).elementAt(j).fMTName,
          "fmT_Order": disable.elementAt(i).elementAt(j).fMTOrder,
          "fmgG_GroupName": group.elementAt(i).fmgGGroupName,
          "fmgG_Id": group.elementAt(i).fmgGId,
          "preAdmFlag": false,
          "termdisablechk": true,
        });
      }
      selectedList.add({
        "grp": {
          "checkedgrplst": true,
          "fmgG_GroupName": group.elementAt(i).fmgGGroupName,
          "fmgG_Id": group.elementAt(i).fmgGId
        },
        "trm_list": trmList,
      });
    }

    // logger.d(selectedList);

    // for (int i = 0;
    //     i < paymentSelectionTracking.selectedInstallment.length;
    //     i++) {
    //   final CustomgGrplistValues grplistValues =
    //       paymentSelectionTracking.selectedInstallment.elementAt(i).groupInfo;
    //   final DisableTermsModelValues disableTermsModelValues =
    //       paymentSelectionTracking.selectedInstallment
    //           .elementAt(i)
    //           .disableTermsModelValues;

    //   selectedList.add({
    //     "grp": {
    //       "checkedgrplst": true,
    //       "fmgG_GroupName": grplistValues.fmgGGroupName,
    //       "fmgG_Id": grplistValues.fmgGId
    //     },
    //     "trm_list": [
    //       {
    //         //"checkedheadlst": true,
    //         "fmT_Id": disableTermsModelValues.fmtId,
    //         "fmT_Name": disableTermsModelValues.fMTName,
    //         "fmT_Order": disableTermsModelValues.fMTOrder,
    //         "fmgG_GroupName": grplistValues.fmgGGroupName,
    //         "fmgG_Id": grplistValues.fmgGId,
    //         "preAdmFlag": false,
    //         "termdisablechk": true,
    //       }
    //     ]
    //   });
    // }

    responseBody['selected_list'] = selectedList;
    responseBody.addAll({
      "MI_Id": miId,
      "AMST_Id": amstId,
      "ASMAY_Id": asmayId,
      "ASMCL_ID": asmclId,
      "onlinepaygteway": gateWayType,
      "automanualreceiptno": "Auto",
      "transnumbconfigurationsettingsss": {},
      "FYP_PayModeType": "MOBILE"
    });

    logger.d(responseBody);

    try {
      final Response response = await ins.post(apiUrl,
          options: Options(headers: getSession()), data: responseBody);
      final PaymentGateWayDetails gateWayDetails =
          PaymentGateWayDetails.fromJson(response.data);

      logger.d(gateWayDetails.toJson());

      return Future.value(gateWayDetails);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "We are currently unable to connect to the server, or server returned an error"
      });
    }
  }
}
