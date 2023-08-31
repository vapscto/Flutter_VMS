import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/section_detail_model.dart';

class GetSectionsApi {
  GetSectionsApi.init();
  static final GetSectionsApi instance = GetSectionsApi.init();

  getSections(
      {required int asmayId,
      required int ivrmrtId,
      required int userId,
      required int miId,
      required List<Map<String, dynamic>> classlsttwo,
      required String base,
      required NoticeBoardController noticeBoardController}) async {
    final Dio ins = getGlobalDio();
    final String api = base + URLS.getNoticeSection;

    if (noticeBoardController.isErrorOccuredWhileLoadingSection.value) {
      noticeBoardController.updateIsErrorOccuredWhileLoadingSection(false);
    }

    noticeBoardController.updateIsSectionLoading(true);
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "ASMAY_Id": asmayId,
        "UserId": userId,
        "IVRMRT_Id": ivrmrtId,
        "MI_Id": miId,
        "classlsttwo": classlsttwo,
      });

      final SectionDetailsModel sectionDetailsModel =
          SectionDetailsModel.fromJson(response.data['sectionlist']);
      if (sectionDetailsModel.values!.isNotEmpty) {
        if (noticeBoardController.selectedSections.isNotEmpty) {
          noticeBoardController.selectedSections.clear();
        }
        noticeBoardController.addToSection(sectionDetailsModel.values!.first);
      }
      noticeBoardController.updateSection(sectionDetailsModel.values!);
      noticeBoardController.updateIsSectionLoading(false);
    } on DioError catch (e) {
      logger.e(e.message);
      noticeBoardController.updateIsErrorOccuredWhileLoadingSection(true);
      noticeBoardController.updateViewWorkLoadingStatus(e.message);
      noticeBoardController.updateIsSectionLoading(false);
    } on Exception catch (e) {
      logger.e(e.toString());
      noticeBoardController.updateIsErrorOccuredWhileLoadingSection(true);
      noticeBoardController.updateViewWorkLoadingStatus(
          "An internal error occured while creating view for you");
      noticeBoardController.updateIsSectionLoading(false);
    }
  }
}
