import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/controller/vms_common_controller.dart';
import 'package:m_skool_flutter/vms/model/institute_change_model.dart';

class InstituteListAPI {
  InstituteListAPI.init();
  static final InstituteListAPI instance = InstituteListAPI.init();
  instituteList(
      {required String base,
      required VmsTransationController controller,
      required int miId,
      required int userId,
      required int roleId}) async {
    var dio = Dio();
    var api = base + URLS.instituteList;
    try {
      controller.instituteLoading(true);
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: {"User_Id": userId});
      if (response.statusCode == 200) {
        InstituteChangeModel instituteChangeModel =
            InstituteChangeModel.fromJson(response.data['mIdata']);
        controller.indtituteListData(instituteChangeModel.values!);
        controller.instituteLoading(true);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
