import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_section_model.dart';

class GetSectionApi {
  GetSectionApi.init();
  static final GetSectionApi instance = GetSectionApi.init();

  Future<void> getSection({
    required int miId,
    required int asmayId,
    required int asmclId,
    required String base,
    required StudentDetailsController controller,
  }) async {
    final String api = base + URLS.managerGetSection;
    final Dio ins = getGlobalDio();

    if (controller.isErrorOccuredWhileLoadingSection.value) {
      controller.updateIsErrorOccuredWhileLoadingSection(false);
    }
    controller.updateIsSectionLoading(true);
    controller.updateStatus("We are getting section's for selected class");
    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "ASMAY_Id": asmayId,
        "ASMCL_Id": asmclId,
      });

      if (response.data['getsection'] == null) {
        controller.updateIsErrorOccuredWhileLoadingSection(true);
        controller.updateIsSectionLoading(false);
        controller.updateStatus(
            "There is no section right now or may be deleted.. ask your tech team to provide");
        return;
      }

      final ManagerSectionModel managerClassModel =
          ManagerSectionModel.fromJson(response.data['getsection']);

      if (managerClassModel.values!.isNotEmpty) {
        controller.updateSelectedSection(managerClassModel.values!.first);
      }
      controller.updateSections(managerClassModel.values!);
      controller.updateIsSectionLoading(false);
    } on DioError catch (e) {
      logger.e(e.stackTrace);
      logger.e(e.message);
      controller.updateIsErrorOccuredWhileLoadingSection(true);
      controller.updateIsSectionLoading(false);
      controller.updateStatus(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
      controller.updateIsErrorOccuredWhileLoadingSection(true);
      controller.updateIsSectionLoading(false);
      controller.updateStatus(
          "An internal error occured while trying to create a view for you");
    }
  }
}
