import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/screens/home_screen.dart';

class StaffHomeFab extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffHomeFab({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Get.offAll(() => StaffHomeScreen(
            loginSuccessModel: loginSuccessModel,
            mskoolController: mskoolController));
      },
      child: Image.asset(
        'assets/images/floatingicon.png',
        height: 30,
        color: Colors.white,
      ),
    );
  }
}
