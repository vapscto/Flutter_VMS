import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_accomadation.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_payment_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_source.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_time_arrry.dart';

Future<void> getEditTour(
    {required String base,
    required int userId,
    required int hrmeId,
    required String ierId,
    required int vtadaaaId,
    required int miID,
    required TadaTourController tadaTourController}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.editTadaTour;
  logger.w(apiUrl);

   try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "HRME_Id": hrmeId,
      "IER_ID": ierId,
      "MI_Id": miID,
      "VTADAAA_Id": vtadaaaId,
      "userId": userId
    });
    logger.e({
      "HRME_Id": hrmeId,
      "IER_ID": ierId,
      "MI_Id": miID,
      "VTADAAA_Id": vtadaaaId,
      "userId": userId
    });
    if (tadaTourController.timeArrayList.isNotEmpty ||
        tadaTourController.sourcesList.isNotEmpty ||
        tadaTourController.accomdationList.isNotEmpty ||
        tadaTourController.paymentDetails.isNotEmpty) {
      tadaTourController.timeArrayList.clear();
      tadaTourController.sourcesList.clear();
      tadaTourController.paymentDetails.clear();
      tadaTourController.accomdationList.clear();
    }
    TadaTimeArray timeArrayList =
        TadaTimeArray.fromJson(response.data['timeArray']);
    tadaTourController.timeArrayList.addAll(timeArrayList.values!);

    TadaClientSources sourcList =
        TadaClientSources.fromJson(response.data['client_Master']);
    tadaTourController.sourcesList.addAll(sourcList.values!);

    TadaAccomodationModel tadaAccomodationModel =
        TadaAccomodationModel.fromJson(response.data['editArray']);
    tadaTourController.accomdationList.addAll(tadaAccomodationModel.values!);

    TadaPaymentDetailsModel paymentDetails =
        TadaPaymentDetailsModel.fromJson(response.data['editArrayTwo']);
    tadaTourController.paymentDetails.addAll(paymentDetails.values!);
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
