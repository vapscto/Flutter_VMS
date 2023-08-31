import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/global_utilities.dart';
import '../widget/email_password_login.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);
  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  List<Widget> authTabs = [
    // const SubmitOtpWidget(),
    const EmailPasswordLogin(),
  ];
  @override
  void initState() {
    currentAuthTab.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1339),
                      child: Center(
                        child: SizedBox(
                          // width: Get.width * 0.64252,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/icons/logo1.png"),
                              // SizedBox(
                              //   width: Get.width * 0.64252,
                              //   child: Text(
                              //     "One stop shop for all your medicines & health products",
                              //     textAlign: TextAlign.center,
                              //     style:
                              //         Theme.of(context).textTheme.titleMedium,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    authTabs[currentAuthTab.value],
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isPageLoading.value,
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
