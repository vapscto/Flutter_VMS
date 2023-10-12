import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/profile/model/profile_model.dart';

class ProfileController extends GetxController {
  RxBool isErrorLoading = RxBool(false);
  RxBool isProfileLoading = RxBool(false);
  void errorLoading(bool loading) {
    isErrorLoading.value = loading;
  }

  void profileLoading(bool loading) {
    isProfileLoading.value = loading;
  }

  RxList<ProfileDataModelValues> profileDataValue =
      <ProfileDataModelValues>[].obs;
  void getProfile(List<ProfileDataModelValues> profile) {
    if (profileDataValue.isNotEmpty) {
      profileDataValue.clear();
    }
    for (int i = 0; i < profile.length; i++) {
      profileDataValue.add(profile.elementAt(i));
    }
  }
}
