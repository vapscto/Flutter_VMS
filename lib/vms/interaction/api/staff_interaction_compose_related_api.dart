import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/interaction/model/initialDropdownDetailModel.dart';
import 'package:m_skool_flutter/staffs/interaction/model/interactionSectionModel.dart';
import 'package:m_skool_flutter/staffs/interaction/model/interactionStudentListModel.dart';

var dio = Dio();
Future<InitialDropdownDetailModel?> getIntialDropdownDetails({
  required int asmayId,
  required int roleId,
  required int miId,
  required String roleFlag,
  required String selectedRadioButton,
  required String userId,
  required String base,
}) async {
  var url = base + URLS.composeOnload;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "IVRMRT_Id": roleId,
        "MI_Id": miId,
        "Role_flag": roleFlag,
        "userId": userId,
        "IINTS_Flag": selectedRadioButton,
        "roleflg": roleFlag,
        "userflag": selectedRadioButton
      },
    );
    if (response.statusCode == 200) {
      InitialDropdownDetailModel initialDropdownDetailModel =
          InitialDropdownDetailModel.fromJson(response.data);
      return initialDropdownDetailModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<InteractionSectionModel?> getInteractionSectionListData({
  required int asmayId,
  required int roleId,
  required int miId,
  required String roleFlag,
  required int userId,
  required int asmclId,
  required String base,
}) async {
  var url = base + URLS.onChangeOfClass;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "IVRMRT_Id": roleId,
        "MI_Id": miId,
        "Role_flag": roleFlag,
        "userId": userId,
        "ASMCL_Id": asmclId,
        "roleflg": roleFlag
      },
    );
    if (response.statusCode == 200) {
      InteractionSectionModel interactionSectionModel =
          InteractionSectionModel.fromJson(response.data);
      return interactionSectionModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<InteractionStudentListModel?> getInteractionStudentListData({
  required int asmayId,
  required int roleId,
  required int miId,
  required String roleFlag,
  required String userId,
  required int asmclId,
  required int asmsId,
  required String base,
}) async {
  var url = base + URLS.onChangeOfSection;
  logger.d(url);
  logger.d({
    "ASMAY_Id": asmayId,
    "IVRMRT_Id": roleId,
    "MI_Id": miId,
    "Role_flag": roleFlag,
    "userId": userId,
    "ASMCL_Id": asmclId,
    "ASMS_Id": asmsId
  });
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "ASMAY_Id": asmayId,
        "IVRMRT_Id": roleId,
        "MI_Id": miId,
        "Role_flag": roleFlag,
        "userId": userId,
        "ASMCL_Id": asmclId,
        "ASMS_Id": asmsId
      },
    );
    if (response.statusCode == 200) {
      InteractionStudentListModel interactionStudentListModel =
          InteractionStudentListModel.fromJson(response.data);
      return interactionStudentListModel;
    }
    return null;
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<bool> submitComposeStaff({
  required Map data,
  required String base,
}) async {
  var url = base + URLS.onSubmit;
  logger.d(data);
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    logger.d(e.toString());
    return false;
  }
}
