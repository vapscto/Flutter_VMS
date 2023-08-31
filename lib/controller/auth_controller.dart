import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../apis/authentication_api.dart';
import '../apis/version_check_api.dart';
import '../main.dart';
import '../screens/authentication_screen.dart';
import 'global_utilities.dart';

class AuthenticationController extends GetxController {
  Future<bool> login(
      {required String mobileNumber,
      required String passWord,
      required String hashCode}) async {
    if (await checkConnectivity()) {
      await checkVersionPermission();
      var value = await LoginServices.login(
          mobileNumber: mobileNumber, hashCode: hashCode, passWord: passWord);
      if (value!.data!.responseCode == 103) {
        Fluttertoast.showToast(msg: "User not found, Account not created".tr);
        return false;
      } else if (value.data!.responseCode == 105) {
        return true;
      } else if (value.data!.responseCode == 104) {
        Fluttertoast.showToast(msg: "Incorrect password".tr);
        return false;
      } else if (value.data!.responseCode == 107) {
        Fluttertoast.showToast(msg: "Exceeded password attempts".tr);
        return false;
      }
      if (value.data!.responseCode == 108) {
        Fluttertoast.showToast(msg: "Exceeded password attempts".tr);
        return false;
      } else {
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Not connected to internet".tr);
      return false;
    }
  }

  Future<bool> signUp(
      {required String firstName,
      required String lastName,
      required String mobileNumber,
      required String email}) async {
    if (await checkConnectivity()) {
      var value = await LoginServices.signUp(
          firstName: firstName,
          lastName: lastName,
          mobileNumber: mobileNumber,
          email: email);
      if (value!.data!.responseCode == 114) {
        Fluttertoast.showToast(msg: "User already exist".tr);
        currentAuthTab.value = 0;
        return false;
      } else if (value.data!.responseCode == 109) {
        return true;
      } else {
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Not connected to internet".tr);
      return false;
    }
  }

  Future<bool> otpVerification({required String otpValue}) async {
    if (await checkConnectivity()) {
      var value = await LoginServices.otpVerification(otpValue: otpValue);
      if (value!.data!.responseCode == 118) {
        Fluttertoast.showToast(msg: "invalid".tr);
        return false;
      } else if (value.data!.responseCode == 109) {
        return true;
      } else if (value.data!.responseCode == 108) {
        Fluttertoast.showToast(msg: "Not valid".tr);
        return false;
      } else {
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Not connected to internet".tr);
      return false;
    }
  }

  Future<bool> loginVerification() async {
    if (await checkConnectivity()) {
      var value = await LoginServices.loginVerification();
      if (value!.data!.responseCode == 108) {
        logInBox!.put("isLoggedIn", false);
        Get.offAll(() => const AuthenticationScreen());
        Fluttertoast.showToast(msg: "Session Expired".tr);
        return false;
      } else if (value.data!.responseCode == 109) {
        logInBox!.put("userData", value.data!.user!.toJson());
        return true;
      } else {
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Not connected to internet".tr);
      return false;
    }
  }

  Future<bool> logout() async {
    if (await checkConnectivity()) {
      var value = await LoginServices.logout();
      if (value!.data!.responseCode == 108) {
        Fluttertoast.showToast(msg: "Couldn't logout".tr);
        return false;
      } else if (value.data!.responseCode == 109) {
        Fluttertoast.showToast(msg: "Logged out successfully".tr);
        return true;
      } else {
        Fluttertoast.showToast(msg: "Couldn't logout".tr);
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Not connected to internet".tr);
      return false;
    }
  }
}
