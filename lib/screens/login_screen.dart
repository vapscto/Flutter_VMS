import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/authenticate_user_api.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/forgotpassword/screens/forgot_password_screen.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/categories_api_item.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/common_home_screen.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class LoginScreen extends StatefulWidget {
  final MskoolController mskoolController;
  const LoginScreen({super.key, required this.mskoolController});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  RxBool showPassword = RxBool(false);

  bool policyAccepted = false;
  String deviceToken = '';
  @override
  void initState() {
    // getDeviceTokenForFCM();
    super.initState();
  }

  // getDeviceTokenForFCM() async {
  //   deviceToken = await getDeviceToken();
  //   logger.d('Device Id : $deviceToken');
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,

      // ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                //padding: const EdgeInsets.only(bottom: 128.0),
                height: Get.height * 0.39,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Image.asset(
                  "assets/images/stars.png",
                  //height: Get.width * 0.2,
                  fit: BoxFit.cover,
                )),
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.36),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          widget.mskoolController.universalInsCodeModel!.value
                              .institutioNLOGO,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Text(
                            "${widget.mskoolController.universalInsCodeModel!.value.institutioNNAME} ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "USER ID",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextField(
                      controller: userName,
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color,
                              fontSize: 17)),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18.0),
                        filled: true,
                        isDense: false,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        hintText: 'User Id',
                        //label: Text("Institutional Code"),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(bottom: 2.0),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/svg/profile.svg',
                              color: const Color.fromARGB(188, 30, 60, 194),
                              height: 24.0,
                              width: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      "PASSWORD",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Obx(() {
                      return TextField(
                        controller: password,
                        obscureText: !showPassword.value,
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                                fontSize: 17)),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(18.0),
                            isDense: true,
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            hintText: 'Password',
                            //label: Text("Institutional Code"),
                            prefixIcon: Container(
                              margin: const EdgeInsets.only(bottom: 2.0),
                              child: const Icon(
                                Icons.lock_outline,
                                color: Color.fromARGB(188, 30, 60, 194),
                                size: 24,
                              ),
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  showPassword.value = !showPassword.value;
                                },
                                child: showPassword.value
                                    ? Icon(
                                        Icons.visibility,
                                        size: 24.0,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : Icon(
                                        Icons.visibility_off_outlined,
                                        size: 24.0,
                                        color: Theme.of(context).primaryColor,
                                      ))),
                      );
                    }),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return ForgotPasswordScreen(
                                    mskoolController: widget.mskoolController,
                                    forExpire: false,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            "FORGOT PASSWORD ?",
                            style:
                                Theme.of(context).textTheme.labelSmall!.merge(
                                      const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFF666FB0),
                                      ),
                                    ),
                          )),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            activeColor: Theme.of(context).primaryColor,
                            value: policyAccepted,
                            onChanged: (v) {
                              policyAccepted = v!;
                              setState(() {});
                            }),
                        RichText(
                            text: TextSpan(
                                text: 'I agree to all your ',
                                style: Theme.of(context).textTheme.titleSmall,
                                children: [
                              TextSpan(
                                  text: "T&C",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const TextSpan(text: " and "),
                              TextSpan(
                                  text: "Privacy Policy",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)
                            ]))
                      ],
                    ),
                    const SizedBox(
                      height: 36.0,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (userName.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please provide a valid username");
                            return;
                          }
                          if (password.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please provide a valid password");
                            return;
                          }

                          if (!policyAccepted) {
                            Fluttertoast.showToast(
                                msg: "Please accept T&C and Privacy Policy");
                            return;
                          }

                          String loginBaseUrl = "";
                          for (int i = 0;
                              i <
                                  widget.mskoolController.universalInsCodeModel!
                                      .value.apiarray.values.length;
                              i++) {
                            final CategoriesApiItem apiItem = widget
                                .mskoolController
                                .universalInsCodeModel!
                                .value
                                .apiarray
                                .values
                                .elementAt(i);
                            if (apiItem.iivrscurLAPIName.toLowerCase() ==
                                "login") {
                              loginBaseUrl = apiItem.iivrscurLAPIURL;
                            }
                          }
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (_) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: FutureBuilder<LoginSuccessModel>(
                                      future: AuthenticateUserApi.instance
                                          .authenticateNow(
                                              userName.text,
                                              password.text,
                                              widget
                                                  .mskoolController
                                                  .universalInsCodeModel!
                                                  .value
                                                  .miId,
                                              loginBaseUrl,
                                              deviceToken),
                                      builder: (_, snapshot) {
                                        if (snapshot.hasData) {
                                          return Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                 snapshot.data!
                                                          .userImagePath !=null?
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade100,
                                                  radius: 36.0,
                                                  backgroundImage: NetworkImage(
                                                      snapshot.data!
                                                          .userImagePath!),
                                                ):CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade100,
                                                  radius: 36.0,
                                                  child: Icon(Icons.person)),
                                                const SizedBox(
                                                  height: 16.0,
                                                ),
                                                Text(
                                                  snapshot.data!.userName!,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .merge(
                                                        const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                Text(
                                                  "Welcom back ${snapshot.data!.userName}, you can now continue to home screen",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .merge(TextStyle(
                                                          letterSpacing: 0.2,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium!
                                                                  .color,
                                                          fontSize: 14)),
                                                ),
                                                const SizedBox(
                                                  height: 16.0,
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize: Size(
                                                      Get.width * 0.5,
                                                      50,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);

                                                    logInBox!.put(
                                                        "isLoggedIn", true);
                                                    Get.off(() =>
                                                        CommonHomeScreen(
                                                          loginSuccessModel:
                                                              snapshot.data!,
                                                          mskoolController: widget
                                                              .mskoolController,
                                                        ));
                                                  },
                                                  child: Text(
                                                    "Continue",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .merge(
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }

                                        if (snapshot.hasError) {
                                          final Map<String, dynamic> err =
                                              snapshot.error
                                                  as Map<String, dynamic>;
                                          return err['type'] == "exp"
                                              ? ErrWidget(
                                                  err: err,
                                                  btnTitle: "Update Password",
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) {
                                                          return ForgotPasswordScreen(
                                                            mskoolController: widget
                                                                .mskoolController,
                                                            forExpire: true,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                )
                                              : ErrWidget(
                                                  err: err,
                                                );
                                        }
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            AnimatedProgressWidget(
                                                title: "Please Wait",
                                                desc:
                                                    "We are trying to loging you in.",
                                                animationPath:
                                                    "assets/json/default.json")
                                          ],
                                        );
                                      }),
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            minimumSize: Size(Get.width * 0.5, 50)),
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// late FirebaseMessaging firebaseMessage;
// Future getDeviceToken() async {
//   String deviceToken = '';
//   firebaseMessage = FirebaseMessaging.instance;
//   await firebaseMessage.getToken().then((value) {
//     (value == null) ? "" : deviceToken = value;
//     logger.i('====$deviceToken');
//   });
//   return deviceToken;
// }
