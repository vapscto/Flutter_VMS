import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../controller/auth_controller.dart';
import '../controller/global_utilities.dart';
import '../main.dart';
import '../screens/home.dart';
import 'card_widget.dart';
import 'custom_elevated_button.dart';

class EmailPasswordLogin extends StatefulWidget {
  const EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  State<EmailPasswordLogin> createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AuthenticationController authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5615,
      width: MediaQuery.of(context).size.width,
      child: CardWidget(
        enableScroll: false,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        padding: EdgeInsets.only(
            left: Get.width * 0.1588,
            right: Get.width * 0.1588,
            top: Get.height * 0.0399,
            bottom: Get.height * 0.0550),
        children: [
          SizedBox(
            // width: Get.width * 0.4953,
            child: Column(
              children: [
                Text(
                  "Verification",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Please enter your mobile number and Password",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: Get.height * 0.1298,
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          style: Theme.of(context).textTheme.labelMedium,
                          textAlignVertical: TextAlignVertical.center,
                          onSaved: (value) {
                            mobileNumber.value = value!;
                          },
                          onChanged: (value) {
                            if (value.length == 10) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: Get.height * 0.0309),
                            fillColor: Theme.of(context).cardTheme.color,
                            hintText: "Phone Number",
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          onSaved: (value) {
                            passWord.value = value!;
                          },
                          style: Theme.of(context).textTheme.labelMedium,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: Get.height * 0.0309),
                            fillColor: Theme.of(context).cardTheme.color,
                            hintText: "Password",
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0572,
                  width: MediaQuery.of(context).size.width * 0.6869,
                  child: CustomElevatedButton(
                    isGradient: false,
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    onPressed: () async {
                      var formState = _key.currentState;
                      formState!.save();
                      if (passWord.value.isNotEmpty) {
                        isPageLoading.value = true;
                        authController
                            .login(
                          mobileNumber: mobileNumber.value,
                          hashCode: await SmsAutoFill().getAppSignature,
                          passWord: passWord.value,
                        )
                            .then((value) {
                          isPageLoading.value = false;
                          if (value) {
                            Fluttertoast.showToast(
                                msg: "Logged in successfully");
                            logInBox!.put("isLoggedIn", true);
                            //Get.offAll(() => const Home());
                          } else {
                            print("Failed");
                          }
                        });
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please provide valid password",
                        );
                      }
                    },
                    child: Text(
                      "Submit",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
