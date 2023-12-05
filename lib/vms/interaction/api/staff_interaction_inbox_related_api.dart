// import 'package:dio/dio.dart';
// import 'package:m_skool_flutter/constants/api_url_constants.dart';
// import 'package:m_skool_flutter/controller/global_utilities.dart';
// import 'package:m_skool_flutter/main.dart';
// import 'package:m_skool_flutter/staffs/interaction/model/staffInboxModel.dart';

// var dio = Dio();

// Future<StaffInboxModel?> getStaffInbox({
//   required int miId,
//   required int amstId,
//   required int asmayId,
//   required int roleId,
//   required String role,
//   required int userId,
//   required String base,
// }) async {
//   var url = base + URLS.getInbox;
//   logger.d(url);
//   logger.d({
//     "MI_Id": miId,
//     "AMST_Id": amstId.toString(),
//     "ASMAY_Id": asmayId.toString(),
//     "Role_flag": "I",
//     "IVRMRT_Id": roleId,
//     "IVRMRT_Role": role,
//     "userId": userId.toString(),
//   });
//   try {
//     var response = await dio.post(
//       url,
//       options: Options(
//         headers: getSession(),
//       ),
//       data: {
//         "MI_Id": miId,
//         "AMST_Id": amstId.toString(),
//         "ASMAY_Id": asmayId.toString(),
//         "Role_flag": "I",
//         "IVRMRT_Id": roleId,
//         "IVRMRT_Role": role,
//         "userId": userId.toString(),
//       },
//     );
//     if (response.statusCode == 200) {
//       StaffInboxModel staffInboxModel = StaffInboxModel.fromJson(response.data);
//       return staffInboxModel;
//     }
//     return null;
//   } catch (e) {
//     logger.d(e.toString());
//     return null;
//   }
// }
