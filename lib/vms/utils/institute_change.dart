import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/authenticate_user_api.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/common_home_screen.dart';
import 'package:m_skool_flutter/screens/splash_screen.dart';
import 'package:m_skool_flutter/vms/controller/vms_common_controller.dart';

instituteChange(
    BuildContext context,
    VmsTransationController vmsTransationController,
    LoginSuccessModel loginSuccessModel,
    MskoolController mskoolController) async {
  Get.bottomSheet(
    Obx(() {
      return vmsTransationController.isInstitudeLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : vmsTransationController.indtituteListData.isEmpty
              ? Container(
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                      color: Colors.white),
                  height: 242,
                  child: const Center(
                    child: Text('No Data'),
                  ),
                )
              : Container(
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Companies",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .merge(const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 4, 0, 255))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  vmsTransationController
                                      .indtituteListData.length, (index) {
                                var v = vmsTransationController
                                    .indtituteListData
                                    .elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: InkWell(
                                    onTap: () async {
                                      importantIds!.put(URLS.miId, v.mIId);
                                      logger.w(importantIds!.get(URLS.miId));
                                      // institutionalCode!.put(
                                      //     'institutionalCode', v.mISubdomain);

                                      Fluttertoast.showToast(msg: v.mIName!);
                                      Get.offAll(() => SplashScreen(
                                            miIdNew: v.mIId!,
                                            // loginSuccessModel:
                                            //     loginSuccessModel,
                                            // mskoolController: mskoolController,
                                          ));
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          v.mIName!,
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: (importantIds!
                                                              .get(URLS.miId) ==
                                                          v.mIId)
                                                      ? Colors.red
                                                      : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          )
                        ]),
                  ),
                );
    }),
  );
}
