import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class MyProfileScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ProfileController profileController;
  const MyProfileScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.profileController});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Profile",
          style: Get.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Obx(() {
        return widget.profileController.isProfileLoading.value
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading Profile Details",
                desc: "We are under process to get your details from server.")
            : widget.profileController.profileDataValue.isEmpty
                ? const AnimatedProgressWidget(
                    animatorHeight: 250,
                    animationPath: "assets/json/nodata.json",
                    title: "No Data Found",
                    desc:
                        "We are under process to get your details from server.")
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/images/vaps-about.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Get.height * 0.26,
                                      left: 16.0,
                                      right: 16.0),
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(24.0),
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFFF5FBFF),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 206, 245, 207),
                                        Color.fromARGB(255, 227, 205, 248),
                                      ],
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(16.0),
                                        bottomRight: Radius.circular(16.0)),
                                    boxShadow: CustomThemeData.getShadow(),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.04,
                                      ),
                                      Text(
                                        widget
                                                .profileController
                                                .profileDataValue
                                                .first
                                                .employeename ??
                                            "N/A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        " ${widget.profileController.profileDataValue.first.hRMDDepartmentName ?? "N/a"} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        " ${widget.profileController.profileDataValue.first.hRMDESDesignationName ?? "N/a"} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                              child: Text(
                                            "Contact Number",
                                            textAlign: TextAlign.end,
                                          )),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          const Text(":"),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          Expanded(
                                              child: Text(
                                            "${widget.profileController.profileDataValue.first.hRMEMNOMobileNo ?? "N/A"}",
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                              child: Text(
                                            "Employee Code",
                                            textAlign: TextAlign.end,
                                          )),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          const Text(":"),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          Expanded(
                                              child: Text(
                                            widget
                                                    .profileController
                                                    .profileDataValue
                                                    .first
                                                    .hRMEEmployeeCode ??
                                                "N/a",
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                              child: Text(
                                            "Email Id",
                                            textAlign: TextAlign.end,
                                          )),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          const Text(":"),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          Expanded(
                                              child: Text(
                                            widget
                                                    .profileController
                                                    .profileDataValue
                                                    .first
                                                    .hRMEEmailId ??
                                                "N/A",
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.3,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      // Image.network(
                                      //   widget.loginSuccessModel
                                      //           .mIBackgroundImage ??
                                      //       '',
                                      //   height: Get.height * 0.3,
                                      //   width: double.infinity,
                                      //   fit: BoxFit.cover,
                                      //   errorBuilder:
                                      //       (context, error, stackTrace) {
                                      //     return Align(
                                      //       alignment: Alignment.topCenter,
                                      //       child: Image.asset(
                                      //           "assets/images/vaps_bg_image.jpeg"),
                                      //     );
                                      //   },
                                      // ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey.shade100,
                                          radius: 40.0,
                                          child: ClipOval(
                                            child: Image.network(
                                              widget
                                                      .profileController
                                                      .profileDataValue
                                                      .first
                                                      .hRMEPhoto ??
                                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                              fit: BoxFit.cover,
                                              width: 80.0,
                                              height: 80.0,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return Center(
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                (loadingProgress
                                                                        .expectedTotalBytes ??
                                                                    1)
                                                            : null,
                                                        backgroundColor:
                                                            Colors.green,
                                                        color: Colors.red,
                                                        strokeWidth: 6,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                return Image.network(
                                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                                  fit: BoxFit.cover,
                                                  width: 80.0,
                                                  height: 80.0,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
      }),
    );
  }
}
