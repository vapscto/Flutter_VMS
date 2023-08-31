import 'package:get/get.dart';
import 'package:m_skool_flutter/model/institutional_code_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';

class MskoolController extends GetxController {
  Rx<InstitutionalCodeModel>? universalInsCodeModel;

  Rx<LoginSuccessModel>? loginSuccessModel;

  void updateUniversalInsCodeModel(InstitutionalCodeModel newValue) {
    universalInsCodeModel = Rx<InstitutionalCodeModel>(newValue);
  }

  void updateLoginSuccessModel(LoginSuccessModel newValue) {
    loginSuccessModel = Rx<LoginSuccessModel>(newValue);
  }
}
