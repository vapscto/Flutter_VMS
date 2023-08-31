import 'package:m_skool_flutter/main.dart';
import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
 
import 'package:m_skool_flutter/principal/Fee_collection/controller/fee_controller.dart';
import 'package:m_skool_flutter/principal/Fee_collection/model/detail_fee_model.dart';

class GetSectionListApi {
  GetSectionListApi.init();

  static final GetSectionListApi instance = GetSectionListApi.init();

Future<int>  getSectionListApi({
    required int miId,
    required int asmay,
    required String fromDate,
    required String toDate,
    required String base,
    required String classId,
    required String eventId,
    required FeeController controller,
  }) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.sectionlist;

    if (controller.isErrorOccured.value) {
      controller.updateIsErrorOccured(false);
    }

    controller.updateIsLoadingFee(true);

    logger.d(api);

    logger.d({
      {
        {
          "MI_Id": miId,
          "ASMAY_Id": asmay,
          "Fromdate": fromDate,
          "Todate": toDate,
          "event_Id": eventId,
          "class_Id": classId
        }
      }
    });

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
      "classid": classId,
      "ASMAY_Id": asmay,
      "fromdate": fromDate,
      "MI_Id":miId,
      "todate": toDate,
      "eventName": "C"
      });

      if (response.data['sectionarray'] != null) {
        controller.updateIsErrorOccured(true);
        controller.updateIsLoadingFee(false);
        
      }
  
      final DetailsFee feecollection =
          DetailsFee.fromJson(response.data['sectionarray']);
   print(feecollection.values!);
     // controller.updateIsLoadingFee(feecollection.values);
     controller.SectionList.addAll(feecollection.values!);
      controller.updateIsLoadingFee(false);
      return response.statusCode!;
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccured(true);
      controller.updateIsLoadingFee(false);
      return 0;
    }
  }
}
