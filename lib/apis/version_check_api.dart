import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/api_url_constants.dart';
import '../controller/global_utilities.dart';
import '../main.dart';
import '../model/VersionControlModel.dart';
import '../widget/app_update_alert_popup.dart';

Future<VersionControlModel?> versionPermissionApi() async {
  var dio = Dio();
  VersionControlModel? model;
  var url = URLS.base + URLS.userPath + URLS.versionControl;
  try {
    var response = await dio.get(url, options: Options(headers: getSession()));
    if (response.statusCode == 200) {
      model = VersionControlModel.fromJson(response.data);
    }
  } catch (e) {
    logger.e(e.toString());
  }
  return model;
}

Future checkVersionPermission() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String numberVersion = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  VersionControlModel? version = await versionPermissionApi();
  if (version?.data?.responseCode == 109) {
    if (Platform.isAndroid) {
      Version? android = version?.data?.setting?.version
          ?.firstWhere((element) => element.name == "android");
      if (android?.version != numberVersion) {
        if (android?.forceUpdate == true) {
          return await Get.dialog(
            AppUpdateAlertDialog(
              onConfirm: () async {
                await launchUrl(
                  Uri.parse(android?.redirectUrl ?? ''),
                  mode: LaunchMode.externalNonBrowserApplication,
                );
              },
            ),
          );
        } else {
          return await Get.dialog(AppUpdateAlertDialog(
            onConfirm: () async {
              await launchUrl(
                Uri.parse(android?.redirectUrl ?? ''),
                mode: LaunchMode.externalNonBrowserApplication,
              );
            },
            onCancel: () async {
              Get.back(result: true);
            },
          ));
        }
      }
      return true;
    } else if (Platform.isIOS) {
      Version? ios = version?.data?.setting?.version
          ?.firstWhere((element) => element.name == "ios");
      if (ios?.version != numberVersion) {
        if (ios?.forceUpdate == true) {
          return await Get.dialog(
            AppUpdateAlertDialog(
              onConfirm: () async {
                await launchUrl(
                  Uri.parse(ios?.redirectUrl ?? ''),
                  mode: LaunchMode.externalNonBrowserApplication,
                );
              },
            ),
          );
        } else {
          return await Get.dialog(AppUpdateAlertDialog(
            onConfirm: () async {
              await launchUrl(
                Uri.parse(ios?.redirectUrl ?? ''),
                mode: LaunchMode.externalNonBrowserApplication,
              );
            },
            onCancel: () async {
              Get.back(result: true);
            },
          ));
        }
      }
      return true;
    } else {
      return true;
    }
  }
}
