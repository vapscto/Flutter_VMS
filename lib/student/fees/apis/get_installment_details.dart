// ignore_for_file: library_prefixes

import 'package:dio/dio.dart' as Diio;
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/apis/payment_gateway_model.dart';
import 'package:m_skool_flutter/student/fees/controller/pay_online_data_controller.dart';
import 'package:m_skool_flutter/student/fees/controller/payment_selection_tracking.dart';
import 'package:m_skool_flutter/student/fees/model/custom_grp_list.dart';
import 'package:m_skool_flutter/student/fees/model/disable_terms_model.dart';
import 'package:m_skool_flutter/student/fees/model/fill_student_model.dart';
import 'package:m_skool_flutter/student/fees/model/installment_model.dart';

class GetInstallmentDetails {
  GetInstallmentDetails.init();
  static final GetInstallmentDetails instance = GetInstallmentDetails.init();

  getInstallmentDetails(
      {required int miId,
      required int asmayId,
      required int amstId,
      required String configSet,
      required String base,
      required PayOnlineDataController payOnlineDataController,
      required PaymentSelectionTracking tracking}) async {
    final String api = base + URLS.getInstallmentDetails;
    final Diio.Dio dio = getGlobalDio();
    logger.d(api);
    logger.d({
      "MI_Id": miId,
      "AMST_Id": amstId,
      "ASMAY_Id": asmayId,
      "configset": "T"
    });
    try {
      final Diio.Response response = await dio.post(api,
          options: Diio.Options(headers: getSession()),
          data: {
            "MI_Id": miId,
            "AMST_Id": amstId,
            "ASMAY_Id": asmayId,
            "configset": "T"
          });

      if (response.data['fillpaymentgateway'] == null ||
          response.data['disableterms'] == null ||
          response.data['customgrplist'] == null ||
          response.data['fillstudent'] == null) {
        payOnlineDataController.updateInstallment([]);
        payOnlineDataController.updateIsInstallmentDetailLoaded(true);
        return;
      }

      final DisableTermsModel disableTermsModel =
          DisableTermsModel.fromJson(response.data['disableterms']);
      final CustomgGrplist customgGrplist =
          CustomgGrplist.fromJson(response.data['customgrplist']);
      final FillStudentModel fillStudentModel =
          FillStudentModel.fromJson(response.data['fillstudent']);
      final PaymentGatewayDetails gateWay =
          PaymentGatewayDetails.fromJson(response.data['fillpaymentgateway']);
      logger.d(gateWay.toJson());

      payOnlineDataController.updateFillStudent(fillStudentModel.values!);

      List<InstallmentModel> installments = [];

      for (int i = 0; i < customgGrplist.values!.length; i++) {
        logger.d(customgGrplist.values!.elementAt(i).fmgGGroupName);
        List<DisableTermsModelValues> disableTermsModelList = [];
        for (int j = 0; j < disableTermsModel.values!.length; j++) {
          if (customgGrplist.values!.elementAt(i).fmgGId ==
              disableTermsModel.values!.elementAt(j).fMGGId) {
            disableTermsModelList.add(disableTermsModel.values!.elementAt(j));
          }
        }
        installments.add(InstallmentModel(
            gateway: gateWay.values!,
            grplistValues: customgGrplist.values!.elementAt(i),
            disableTermsModelValues: disableTermsModelList));
      }
      int index = -1;
      if (tracking.selectedCheckBox.isNotEmpty) {
        tracking.selectedCheckBox.clear();
      }
      for (int i = 0; i < installments.length; i++) {
        logger.d(installments.elementAt(i).grplistValues.toJson());
        for (int j = 0;
            j < installments.elementAt(i).disableTermsModelValues.length;
            j++) {
          index = index + 1;
          logger.d(index);
          tracking.selectedCheckBox.add(
            Selections(
              fmggId: installments
                  .elementAt(i)
                  .disableTermsModelValues
                  .elementAt(j)
                  .fMGGId!,
              fmtId: installments
                  .elementAt(i)
                  .disableTermsModelValues
                  .elementAt(j)
                  .fmtId!,
              isDisabled: installments
                          .elementAt(i)
                          .disableTermsModelValues
                          .elementAt(j)
                          .paid! >=
                      installments
                          .elementAt(i)
                          .disableTermsModelValues
                          .elementAt(j)
                          .payable!
                  ? RxBool(true)
                  : RxBool(false),
              isChecked: installments
                          .elementAt(i)
                          .disableTermsModelValues
                          .elementAt(j)
                          .paid! >=
                      installments
                          .elementAt(i)
                          .disableTermsModelValues
                          .elementAt(j)
                          .payable!
                  ? RxBool(true)
                  : RxBool(false),
              index: index,
            ),
          );
        }
      }
      payOnlineDataController.updateInstallment(installments);
      payOnlineDataController.updateIsInstallmentDetailLoaded(true);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
