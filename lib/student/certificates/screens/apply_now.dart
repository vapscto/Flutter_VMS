import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/certificates/api/get_certificate_type.dart';
import 'package:m_skool_flutter/student/certificates/api/submit_cert_request_api.dart';
import 'package:m_skool_flutter/student/certificates/model/cert_list_model.dart';
import 'package:m_skool_flutter/student/certificates/model/certlist_asca_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:m_skool_flutter/widget/pgr_widget.dart';
import 'package:m_skool_flutter/widget/success_widget.dart';
import 'package:video_player/video_player.dart';

class ApplyNow extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final VideoPlayerController controller;
  const ApplyNow(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<ApplyNow> createState() => _ApplyNowState();
}

class _ApplyNowState extends State<ApplyNow> {
  CertificateListValues? selectedValue;
  final TextEditingController reason = TextEditingController();
  final TextEditingController date = TextEditingController();

  @override
  void initState() {
    widget.controller.initialize().then((value) {
      widget.controller.play();
      widget.controller.setLooping(true);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        16.0,
      ),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 4.0,
              ),
              FutureBuilder<CertListAsca>(
                  future: GetCertificateType.instance.getCertificateType(
                    miId: widget.loginSuccessModel.mIID!,
                    asmayId: widget.loginSuccessModel.asmaYId!,
                    ivrmrtId: widget.loginSuccessModel.roleId!,
                    amstId: widget.loginSuccessModel.amsTId!,
                    baseUrl: baseUrlFromInsCode(
                      "portal",
                      widget.mskoolController,
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.certificateList.values == null ||
                          snapshot.data!.certificateList.values!.isEmpty) {
                        return const Center(
                          child: AnimatedProgressWidget(
                            title: "No Certificate Found",
                            desc:
                                "Certificate values are not available, you cannot apply now..",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        );
                      }

                      selectedValue =
                          snapshot.data!.certificateList.values!.first;

                      return Column(
                        children: [
                          CustomContainer(
                            child:
                                DropdownButtonFormField<CertificateListValues>(
                              value:
                                  snapshot.data!.certificateList.values!.first,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                // labelStyle: TextStyle(color: Color(0xFF28B6C8)),
                                label: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDFFBFE),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/cert.png",
                                        height: 24.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Certificate Type ".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  backgroundColor:
                                                      Color(0xFFDFFBFE),
                                                  fontSize: 20.0,
                                                  color: Color(0xFF28B6C8)),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                              icon: const Padding(
                                padding: EdgeInsets.only(top: 4.5),
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  size: 30,
                                ),
                              ),
                              items: List.generate(
                                snapshot.data!.certificateList.values!.length,
                                (index) {
                                  CertificateListValues
                                      certificateDropDownValues = snapshot
                                          .data!.certificateList.values!
                                          .elementAt(index);
                                  return DropdownMenuItem<
                                      CertificateListValues>(
                                    value: certificateDropDownValues,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 5),
                                      child: Text(
                                        certificateDropDownValues
                                                .acertapPCertificateName ??
                                            "N/a",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                fontSize: 16.0)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              onChanged: (value) {
                                selectedValue = value!;
                                debugPrint(selectedValue.toString());
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 28.0,
                          ),
                          CustomContainer(
                            child: TextField(
                              style: Theme.of(context).textTheme.titleSmall,
                              controller: reason,
                              maxLines: 4,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 48.0, left: 12),
                                border: const OutlineInputBorder(),
                                label: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color(0xFFFFEBEA)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/reason.png",
                                        height: 24.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Reason ".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFFFF6F67)),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: 'Type your reason here.'.tr,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          CustomContainer(
                            child: TextField(
                              readOnly: true,
                              style: Theme.of(context).textTheme.titleSmall,
                              controller: date,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 48.0, left: 12),
                                border: const OutlineInputBorder(),
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color(0xFFE5FFF3)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/calendar.png",
                                        height: 24.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Date ".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF43C788)),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: 'Select Date'.tr,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                suffixIcon: InkWell(
                                    onTap: () async {
                                      DateTime? selectedDT =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1998, 10, 12),
                                        lastDate: DateTime.now(),
                                      );

                                      if (selectedDT == null) {
                                        Fluttertoast.showToast(
                                            msg: "You didn't selected the date"
                                                .tr);
                                        return;
                                      }

                                      date.text = getFormatedDate(selectedDT);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "assets/images/calendar.png",
                                        height: 20.0,
                                        width: 20.0,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .color,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 36.0,
                          ),
                          MSkollBtn(
                              title: "Apply Now",
                              onPress: () {
                                if (selectedValue == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please select a certificate type");
                                  return;
                                }
                                if (reason.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please provide reason for generating certificate");
                                  return;
                                }

                                if (date.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please provide date for generating certificate");
                                  return;
                                }
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) {
                                      // logger.d(DateTime.now().toString());
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: FutureBuilder(
                                          future: SubmitCertRequestApi.instance
                                              .submitRequest(
                                            miId:
                                                widget.loginSuccessModel.mIID!,
                                            asmayId: widget
                                                .loginSuccessModel.asmaYId!,
                                            amstId: widget
                                                .loginSuccessModel.amsTId!,
                                            acertapId:
                                                selectedValue!.acertapPId!,
                                            ascaReason: reason.text,
                                            applyDate: DateTime.now()
                                                .toLocal()
                                                .toString(),
                                            ascaId: 0,
                                            baseUrl: baseUrlFromInsCode(
                                                "portal",
                                                widget.mskoolController),
                                          ),
                                          builder: (_, snapshot) {
                                            if (snapshot.hasData) {
                                              return SuccessWidget(
                                                title:
                                                    "Request Sent Successfully",
                                                message:
                                                    "We Successfully sent a request to generate your certificate",
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  reason.text = "";
                                                  date.text = "";
                                                },
                                              );
                                            }

                                            if (snapshot.hasError) {
                                              return ErrWidget(
                                                err: snapshot.error
                                                    as Map<String, dynamic>,
                                              );
                                            }
                                            return const ProgressWidget();
                                          },
                                        ),
                                      );
                                    });
                              }),
                          // const SizedBox(
                          //   height: 36.0,
                          // ),
                          AspectRatio(
                              aspectRatio: widget.controller.value.aspectRatio,
                              child: VideoPlayer(widget.controller)),
                        ],
                      );
                    }

                    if (snapshot.hasError) {
                      return ErrWidget(
                          err: snapshot.error as Map<String, dynamic>);
                    }

                    return Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.25,
                        ),
                        const AnimatedProgressWidget(
                            title: "Getting Certificates",
                            desc:
                                "Please wait while we load certificate's details",
                            animationPath: "assets/json/Certificate.json"),
                      ],
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
