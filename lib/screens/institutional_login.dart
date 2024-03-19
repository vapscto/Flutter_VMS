import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/institutional_code_api.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/institutional_code_model.dart';
import 'package:m_skool_flutter/screens/login_screen.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class InstitutionalLogin extends StatefulWidget {
  final MskoolController mskoolController;
  const InstitutionalLogin({super.key, required this.mskoolController});

  @override
  State<InstitutionalLogin> createState() => _InstitutionalLoginState();
}

class _InstitutionalLoginState extends State<InstitutionalLogin> {
  final TextEditingController insCode = TextEditingController();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    //user one time
    if (profileController.userDeviceId.value.isNotEmpty &&
        profileController.userDeviceId.value.characters.length > 3) {
      if (profileController.userDeviceId.value != deviceid) {
        Fluttertoast.showToast(msg: "User Already Logged In Other Device");
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    insCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 48.0),
                height: Get.height * 0.45,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Image.asset("assets/images/student.png")),
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              margin: EdgeInsets.only(top: Get.height * 0.39),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   "assets/images/vpslogo.png",
                      //   height: 40,
                      // ),
                      // const SizedBox(
                      //   width: 12.0,
                      // ),
                      Text(
                        "Vaps Management System", //I Vidyalaya Resource Management
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  Text(
                    "COMPANY ID",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextField(
                    controller: insCode,
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                            fontSize: 17)),
                    decoration: InputDecoration(
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
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      hintText: 'Company Id',
                      //label: Text("Institutional Code"),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/svg/open_book.svg',
                          height: 24.0,
                          width: 24.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.10,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            minimumSize: Size(Get.width * 0.6, 50)),
                        child: Text(
                          "Submit",
                          style: Theme.of(context).textTheme.labelLarge!.merge(
                                const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                        ),
                        onPressed: () {
                          if (insCode.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please provide an company code".tr);
                            return;
                          }

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: FutureBuilder<InstitutionalCodeModel>(
                                    future: InstitutionalCodeApi.instance
                                        .loginWithInsCode(insCode.text, false),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        widget.mskoolController
                                            .updateUniversalInsCodeModel(
                                                snapshot.data!);
                                        return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey.shade100,
                                                radius: 36.0,
                                                backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data!.institutioNLOGO),
                                              ),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              Text(
                                                snapshot.data!.institutioNNAME,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(
                                                      const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              Text(
                                                "We successfully found company with this code, you can now continue with next step",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .merge(TextStyle(
                                                        letterSpacing: 0.2,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .color,
                                                        fontSize: 14)),
                                              ),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: const Size(
                                                    double.infinity,
                                                    50,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  await importantIds!.put(
                                                      URLS.miId,
                                                      snapshot.data!.miId);
                                                  await importantIds!.put(
                                                      URLS.userId,
                                                      snapshot.data!.userId);

                                                  await importantIds!.put(
                                                      URLS.asmayId,
                                                      snapshot.data!.asmaYId);
                                                  await importantIds!
                                                      .put(URLS.ivrmrtId, 0);
                                                  await importantIds!.put(
                                                      URLS.amstId,
                                                      snapshot.data!.amstId);
                                                  // await importantIds!.put(URLS.hrmeId, snapshot.data)

                                                  // await importantIds!
                                                  //     .put(URLS.ivrmrtRole, "N/A");

                                                  institutionalCode!
                                                      .put(
                                                    "institutionalCode",
                                                    snapshot
                                                        .data!.institutecode,
                                                  )
                                                      .then(
                                                    (value) {
                                                      Navigator.pop(context);
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) {
                                                            return LoginScreen(
                                                              mskoolController:
                                                                  widget
                                                                      .mskoolController,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  );

                                                  // Navigator.pop(context);

                                                  // debugPrint(
                                                  //     snapshot.data!.institutecode);
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
                                        Map<String, dynamic> err = snapshot
                                            .error as Map<String, dynamic>;
                                        return ErrWidget(err: err);
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          AnimatedProgressWidget(
                                              title: "Please Wait",
                                              desc:
                                                  "We are getting into your institutional detail's",
                                              animationPath:
                                                  "assets/json/default.json"),
                                        ],
                                      );
                                    }),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
