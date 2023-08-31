import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';

import '../model/staff_detail_model.dart';

var dio = Dio();

Future<StaffDetailsModel?> getStaffList({
  required int miId,
  required int amstId,
  required int asmayId,
  required int userId,
  required String key,
  required String base,
}) async {
  var url = base + URLS.getStaffList;
  try {
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "MI_ID": miId,
        "AMST_Id": amstId,
        "ASMAY_Id": asmayId,
        "IVRMRT_Id": 7,
        "roleflg": 'student',
        "UserId": userId,
        "userflag": key,
      },
    );
    if (response.statusCode == 200) {
      StaffDetailsModel staffDetailsModel =
          StaffDetailsModel.fromJson(response.data);
      return staffDetailsModel;
    } else {
      return null;
    }
  } catch (e) {
    logger.d(e.toString());
    return null;
  }
}

Future<bool> saveDetail({
  required int miId,
  required int asmayId,
  required int amstId,
  required int userId,
  required String userFlg,
  required String subject,
  required String message,
  required int hrmeId,
  required String base,
  required String roleflg,
  required List<String> image,
}) async {
  var url = base + URLS.composeInteraction;

  try {
    Map<String, dynamic> ip = await getIpAddress();
    logger.d(ip);
    var response = await dio.post(
      url,
      options: Options(
        headers: getSession(),
      ),
      data: {
        "mI_ID": miId,
        "ASMAY_Id": asmayId,
        "AMST_Id": amstId,
        "roleflg": roleflg,
        "UserId": userId,
        "userflag": userFlg,
        "ISTINT_ToId": hrmeId,
        "ISMINT_ComposedByFlg": roleflg,
        "ISMINT_GroupOrIndFlg": "Individual",
        "ISMINT_Subject": subject,
        "ISMINT_Interaction": message,
        "HRME_Id": hrmeId,
        "ISMINT_MACAddress": await getMac(),
        "ISMINT_ISPIPAddress": ip['ip'],
        "images_paths": image.isNotEmpty ? image : ""
      },
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
