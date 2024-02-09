import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/api/certificate_api.dart';
import 'package:m_skool_flutter/vms/certificate_approval/appvoval_page.dart';
import 'package:m_skool_flutter/vms/certificate_approval/certificate_approval_list.dart';
import 'package:m_skool_flutter/vms/certificate_approval/controller/certificate_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class CertificateApproval extends StatefulWidget {
  final String title;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const CertificateApproval(
      {super.key,
      required this.title,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<CertificateApproval> createState() => _CertificateApprovalState();
}

class _CertificateApprovalState extends State<CertificateApproval> {
  List<int> newData = [];
  List<int> newImage = [];
  final remarkController = TextEditingController();
  CertificateController controller = Get.put(CertificateController());
  _loadData() async {
    controller.certificatelist.clear();
    controller.certificateApprovalList.clear();
    controller.loading(true);
    await CertificateLoadAPI.instance.certificateLoad(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: controller,
        userId: widget.loginSuccessModel.userId!);
    controller.loading(false);
  }

  @override
  void initState() {
    _loadData();
    newData.add(1);
    newImage.add(1);
    super.initState();
  }

  int backgroundColor = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: widget.title).getAppBar(),
        body: Obx(() {
          return (controller.isLoading.value)
              ? const AnimatedProgressWidget(
                  animationPath: "assets/json/default.json",
                  title: "Loading",
                  desc: "We are under process to get your details from server.")
              : (controller.certificatelist.isEmpty)
                  ? const AnimatedProgressWidget(
                      animationPath: 'assets/json/nodata.json',
                      title: 'Data is not available',
                      desc: "Certificate is not available for approval ",
                      animatorHeight: 250,
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Certificate Process',
                            style: Get.textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                backgroundColor += 1;
                                if (backgroundColor % 6 == 0) {
                                  backgroundColor = 0;
                                }
                                var data =
                                    controller.certificatelist.elementAt(index);
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 8),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: lighterColor
                                          .elementAt(backgroundColor),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(1, 2.1),
                                            blurRadius: 0,
                                            spreadRadius: 0,
                                            color: Colors.black12)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Employee Name: ',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  TextSpan(
                                                      text: data
                                                          .hRMEEmployeeFirstname!
                                                          .trim(),
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith()),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Requested Date: ',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  TextSpan(
                                                      text:
                                                          ' ${dateFormat(DateTime.parse(data.iSMCERTREQRequestDate!))}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith()),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Receiving Mode: ',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  TextSpan(
                                                      text:
                                                          ' ${data.iSMCERTREQReceivingMode}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith()),
                                                ],
                                              ),
                                            ),
                                            (data.iSMCERTREQFilePath!
                                                    .isNotEmpty)
                                                ? Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('Document: ',
                                                          style: Get.textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                      IconButton(
                                                          onPressed: () {
                                                            createPreview(
                                                                context,
                                                                data.iSMCERTREQFilePath!);
                                                          },
                                                          icon: Icon(
                                                            Icons.visibility,
                                                            color: noticeColor
                                                                .elementAt(
                                                                    backgroundColor),
                                                            size: 30,
                                                          )),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => ApprovalPage(
                                                  controller: controller,
                                                  mskoolController:
                                                      widget.mskoolController,
                                                  loginSuccessModel:
                                                      widget.loginSuccessModel,
                                                  iSMCERTREQId:
                                                      data.iSMCERTREQId!,
                                                  hrmeId: data.hRMEId!,
                                                ));
                                            // showModalBottomSheet(
                                            //     useSafeArea: true,
                                            //     isScrollControlled: true,
                                            //     backgroundColor:
                                            //         Colors.transparent,
                                            //     shape: RoundedRectangleBorder(
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 20)),
                                            //     context: context,
                                            //     builder: (_) {
                                            //       return Padding(
                                            //         padding: EdgeInsets.only(
                                            //             bottom: MediaQuery.of(
                                            //                     context)
                                            //                 .viewInsets
                                            //                 .bottom),
                                            //         child:
                                            //             CertificateApprovalSheet(
                                            //           controller: controller,
                                            //           mskoolController: widget
                                            //               .mskoolController,
                                            //           loginSuccessModel: widget
                                            //               .loginSuccessModel,
                                            //           iSMCERTREQId:
                                            //               data.iSMCERTREQId!,
                                            //           hrmeId: data.hRMEId!,
                                            //         ),
                                            //       );
                                            //     });
                                          },
                                          child: Chip(
                                              backgroundColor: noticeColor
                                                  .elementAt(backgroundColor),
                                              label: Text(
                                                'Action',
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 16,
                                );
                              },
                              itemCount: controller.certificatelist.length),
                        )
                      ],
                    );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () {
            return (controller.certificateApprovalList.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => CertificateApprovalList(
                              data: controller.certificateApprovalList,
                            ));
                      },
                      child: CustomContainer(
                          color: const Color.fromARGB(255, 163, 175, 248),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12),
                            child: Row(
                              children: [
                                Text(
                                  "Certificate Approve or Reject Details",
                                  style: Get.textTheme.titleMedium!.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    color: Theme.of(context).primaryColor)
                              ],
                            ),
                          )),
                    ),
                  )
                : const SizedBox();
          },
        ));
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }

  List<DataColumn> createColumn() {
    return const [
      DataColumn(label: Text("SL.NO.")),
      DataColumn(label: Text("Employee Name")),
      DataColumn(label: Text("Requested Date")),
      DataColumn(label: Text("Receiving Mode")),
      DataColumn(label: Text("Document")),
      DataColumn(label: Text("Action")),
    ];
  }
}
