import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/interaction/api/staff_interaction_inbox_related_api.dart';
import 'package:m_skool_flutter/staffs/interaction/model/staffInboxModel.dart';

class StaffInteractionInboxController extends GetxController {
  RxList<GetinboxmsgValue> inboxList = <GetinboxmsgValue>[].obs;
  RxList<GetinboxmsgReadflgValue> inboxMsgReadFlagValue =
      <GetinboxmsgReadflgValue>[].obs;

  RxInt userHrmeId = RxInt(0);

  RxBool isInbox = RxBool(false);

  void isinboxloading(bool loading) async {
    isInbox.value = loading;
  }

  Future<bool> getStaffInboxList({
    required int miId,
    required int amstId,
    required int asmayId,
    required int roleId,
    required String role,
    required int userId,
    required String base,
  }) async {
    StaffInboxModel? staffInboxModel = await getStaffInbox(
        miId: miId,
        amstId: amstId,
        asmayId: asmayId,
        roleId: roleId,
        role: role,
        userId: userId,
        base: base);

    try {
      if (staffInboxModel!.getinboxmsg != null ||
          staffInboxModel.getinboxmsg!.values != null) {
        inboxList.clear();
        inboxMsgReadFlagValue.clear();
        userHrmeId.value = 0;

        userHrmeId.value = staffInboxModel.userhrmEId!;
        List<GetinboxmsgValue?>? inboxMessage =
            staffInboxModel.getinboxmsg!.values;
        List<GetinboxmsgReadflgValue?>? readFlags =
            staffInboxModel.getinboxmsgReadflg!.values;
        logger.d(readFlags!.length);
        for (var i = 0; i < readFlags.length; i++) {
          inboxMsgReadFlagValue.add(readFlags.elementAt(i)!);
        }
        for (var i = 0; i < inboxMessage!.length; i++) {
          final rf = readFlags.firstWhere(
              (value) => value!.ismintId == inboxMessage[i]!.ismintId);
          final readFlag = rf;
          int? readFlagValue;
          if (readFlag!.ismintId != null) {
            readFlagValue = readFlag.istintReadFlg;
          }
          if (inboxList.isEmpty) {
            inboxList.add(inboxMessage.elementAt(i)!);
          } else if (inboxList.isNotEmpty) {
            var alCnt = 0;
            for (var val in inboxList) {
              if (val.ismintId == inboxMessage[i]!.ismintId) {
                alCnt += 1;
              }
            }
            if (alCnt == 0) {
              inboxList.add(inboxMessage.elementAt(i)!);
            }
          }
        }
        logger.d(inboxList.length);
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
