import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_palner_details.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_view_model.dart';

Future<void> getViewList(
    {required String base,
    required int userId,
    required TadaTourController tadaTourController}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getTourViews;
  logger.w(apiUrl);

  tadaTourController.viewLoading.value = true;
  try {
    final Response response = await ins.post(apiUrl,
        options: Options(headers: getSession()), data: {"userId": userId});
    GetTourView views = GetTourView.fromJson(response.data['getadvancetada']);
    if (tadaTourController.planerName.isNotEmpty &&
        tadaTourController.getTourPlanDetails.isNotEmpty) {
      tadaTourController.planerName.clear();
      tadaTourController.getTourPlanDetails.clear();
    }
    tadaTourController.getTourViewList.addAll(views.values!);
    GetTourPlanDetails getTourPlanDetails =
        GetTourPlanDetails.fromJson(response.data['tourPlanDetails']);
    tadaTourController.getTourPlanDetails.addAll(getTourPlanDetails.values!);
    if (response.data['getadvancetada'] != null) {
      tadaTourController.viewLoading.value = false;
    }

    for (var item in tadaTourController.getTourViewList) {
      for (var element in tadaTourController.getTourPlanDetails) {
        if (item.iERID.toString() == element.ieRID.toString()) {
          if (!tadaTourController.planerName
              .any((element) => element.ieRID == item.iERID)) {
            tadaTourController.planerName
                .add(TourMap(element.ieRID!.toString(), element.ieRPlanName));
          }
        }
      }
      if (!tadaTourController.planerName
          .any((element) => element.ieRID == item.iERID)) {
        tadaTourController.planerName.add(TourMap(item.iERID.toString(), ""));
      }
    }
    for (var element in tadaTourController.planerName) {
      logger.w(element.locationName);
    }
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
