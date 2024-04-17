import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/driver_indent/api/driver_ind_api.dart';
import 'package:m_skool_flutter/vms/driver_indent/controller/driver_intent_controller.dart';
import 'package:m_skool_flutter/vms/driver_indent/driver_ind_approval_list.dart';
import 'package:m_skool_flutter/vms/driver_indent/widgets/indent_approve_popup.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
// import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class DriverIndentApproval extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const DriverIndentApproval(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<DriverIndentApproval> createState() => _DriverIndentApprovalState();
}

class _DriverIndentApprovalState extends State<DriverIndentApproval> {
  DriverIndentController controller = Get.put(DriverIndentController());
  load() async {
    controller.loadingData(true);
    await DriverIndentAPI.i.onload(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        controller: controller,
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "User_Id": widget.loginSuccessModel.userId,
          "roleId": widget.loginSuccessModel.roleId
        });
    controller.loadingData(false);
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  int bgColor = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Driver Indent Approval').getAppBar(),
      body: Obx(() {
        return (controller.isLoading.value)
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading",
                desc: "We are under process to get your details from server.")
            : (controller.indentApprovalList.isEmpty)
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "Driver indent is not available for approval ",
                    animatorHeight: 250,
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
                    itemBuilder: (context, index) {
                      bgColor += 1;
                      if (bgColor % 6 == 0) {
                        bgColor = 0;
                      }
                      var value =
                          controller.indentApprovalList.elementAt(index);
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: lighterColor.elementAt(bgColor),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(1, 2.1),
                                    blurRadius: 0,
                                    spreadRadius: 0,
                                    color: Colors.black12)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${value.hRMEEmployeeFirstName}',
                                      style: Get.textTheme.titleMedium,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Vehicle Name: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: value.tRMVVehicleName,
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Vehicle No.: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: value.tRMVVehicleNo,
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Date: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: dateFormat(DateTime.parse(
                                                  value.iSMDITDate!)),
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Quantity(Lts.): ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: value.iSMDITQty.toString(),
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Amount: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text:
                                                  value.iSMDITAmount.toString(),
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Opening(KM): ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: value.iSMDITOpeningKM
                                                  .toString(),
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Closing(KM): ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: value.iSMDITClosingKM
                                                  .toString(),
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Total KM: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: '${value.totalKM}',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Remarks: ',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: '${value.iSMDITRemark}',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    Get.dialog(IndentApprovePopup(
                                      loginSuccessModel:
                                          widget.loginSuccessModel,
                                      mskoolController: widget.mskoolController,
                                      controller: controller,
                                      values: controller.indentApprovalList
                                          .elementAt(index),
                                    ));
                                  },
                                  child: Chip(
                                      backgroundColor:
                                          noticeColor.elementAt(bgColor),
                                      label: Text(
                                        'Action',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.indentApprovalList.length);
      }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: (pageLoading == true)
      //       ? const Padding(
      //           padding: EdgeInsets.only(bottom: 10.0),
      //           child: SizedBox(
      //             height: 20,
      //             width: 20,
      //             child: CircularProgressIndicator(),
      //           ),
      //         )
      //       : MSkollBtn(
      //           title: 'Driver Indent Approval Details',
      //           onPress: () {
      //             moveToNextScreen();
      //             setState(() {});
      //           }),
      // ),
    );
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }

  bool pageLoading = false;
  void moveToNextScreen() async {
    setState(() {
      pageLoading = true;
    });
    await Future.delayed(const Duration(seconds: 10));
    Get.to(() => DriverIndentList(
          controller: controller,
        ));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => DriverIndentList(
    //             controller: controller,
    //           )),
    // );

    setState(() {
      pageLoading = false;
    });
  }
}
