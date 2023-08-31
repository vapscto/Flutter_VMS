import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/interaction/apis/inbox_tab_related_api.dart';
import 'package:m_skool_flutter/student/interaction/model/inbox_model.dart';

class InboxController extends GetxController {
  RxList<GetinboxmsgValue> inboxList = <GetinboxmsgValue>[].obs;
  RxList<GetinboxmsgValue> unReadList = <GetinboxmsgValue>[].obs;
  RxList<GetinboxmsgReadflgValue> messageFlagList =
      <GetinboxmsgReadflgValue>[].obs;
  RxInt userHrmeId = RxInt(0);
  RxBool isInboxLoading = RxBool(false);

  void isInboxloading(bool loading) async {
    isInboxLoading.value = loading;
  }

  RxBool isUnreadLoading = RxBool(false);

  void isUnreadloading(bool loading) async {
    isUnreadLoading.value = loading;
  }

  Future<bool> getInboxList({
    required int miId,
    required int amstId,
    required int asmayId,
    required int userId,
    required int roleId,
    required String role,
    required String base,
  }) async {
    try {
      InboxDataModel? inboxDataModel = await getInboxData(
          miId: miId,
          amstId: amstId,
          asmayId: asmayId,
          userId: userId,
          role: role,
          roleId: roleId,
          base: base);
      if (inboxDataModel!.getinboxmsg != null ||
          inboxDataModel.getinboxmsg!.values != null) {
        messageFlagList.clear();
        inboxList.clear();
        userHrmeId.value = 0;

        userHrmeId.value = inboxDataModel.userhrmEId!;
        List<GetinboxmsgValue>? inboxMessage =
            inboxDataModel.getinboxmsg!.values;

        var readFlags = inboxDataModel.getinboxmsgReadflg!.values;
        for (var i = 0; i < readFlags!.length; i++) {
          messageFlagList.add(readFlags.elementAt(i));
        }
        for (var i = 0; i < inboxMessage!.length; i++) {
          final rf = readFlags.firstWhere(
              (value) => value.ismintId == inboxMessage[i].ismintId);
          final readFlag = rf;
          int? readFlagValue;
          if (readFlag.ismintId != null) {
            readFlagValue = readFlag.istintReadFlg;
          }
          if (inboxList.isEmpty) {
            inboxList.add(inboxMessage.elementAt(i));
          } else if (inboxList.isNotEmpty) {
            var alCnt = 0;
            for (var val in inboxList) {
              if (val.ismintId == inboxMessage[i].ismintId) {
                alCnt += 1;
              }
            }
            if (alCnt == 0) {
              inboxList.add(inboxMessage.elementAt(i));
            }
          }
        }
        // logger.d(inboxList.elementAt(0).istintId);
        return true;
      }
      Fluttertoast.showToast(
          msg:
              "There is no getInboxMsg array in the database... Contact your tech team");
      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  // Future<bool> getUnread({
  //   required int miId,
  //   required int amstId,
  //   required int asmayId,
  //   required int userId,
  //   required String base,
  // }) async {
  //   try {
  //     InboxDataModel? inboxDataModel = await getInboxData(
  //         miId: miId,
  //         amstId: amstId,
  //         asmayId: asmayId,
  //         userId: userId,
  //         base: base);
  //     if (inboxDataModel!.getinboxmsg != null ||
  //         inboxDataModel.getinboxmsg!.values != null) {
  //       unReadList.clear();
  //       logger.d(inboxDataModel.getinboxmsg!.values!.length.toString());
  //       for (var i = 0; i < inboxDataModel.getinboxmsg!.values!.length; i++) {
  //         if (inboxDataModel.getinboxmsg!.values!.elementAt(i).istintReadFlg ==
  //             0) {
  //           unReadList.add(inboxDataModel.getinboxmsg!.values!.elementAt(i));
  //         }
  //       }
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     logger.e(e.toString());
  //     return false;
  //   }
  // }
}
