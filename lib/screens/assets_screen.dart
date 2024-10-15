import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/profile/api/profile_api.dart';
import 'package:m_skool_flutter/vms/profile/model/assets_list_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class AssetsList extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const AssetsList(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<AssetsList> createState() => _AssetsListState();
}

class _AssetsListState extends State<AssetsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Assets Dashboard", action: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            " ₹ $totalAmount",
            style: Get.textTheme.titleSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ]).getAppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                "assets/images/vaps-about.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          FutureBuilder<AssetsListModel?>(
            future: assetsList(
              base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
              miId: widget.loginSuccessModel.mIID!,
              hrmeId: widget.loginSuccessModel.empcode!,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: AnimatedProgressWidget(
                      title: "Loading Assets List",
                      desc: "",
                      animationPath: "assets/json/default.json"),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.red),
                  ),
                );
              } else if (snapshot.hasData) {
                final assetsList = snapshot.data;

                if (assetsList == null) {
                  return Center(
                    child: Text(
                      'Assets List is not available',
                      style: Get.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: const Color.fromARGB(255, 33, 6, 184)),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: assetsList.employeedetails!.values!.length,
                  itemBuilder: (context, index) {
                    final item = assetsList.employeedetails!.values![index];

                    bgColor += 1;
                    if (bgColor % 6 == 0) {
                      bgColor = 0;
                    }
                    return Card(
                      color: lighterColor.elementAt(bgColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Item-Name:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: item.iNVMIItemName ?? "",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: noticeColor.elementAt(bgColor))),
                            ])),
                            const SizedBox(height: 5),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Asset-Id:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: item.iNVAATAssetId ?? "",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ])),
                            const SizedBox(height: 5),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Amount:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: item.iNVTGRNPurchaseRate.toString(),
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: timetablePeriodColor
                                          .elementAt(bgColor))),
                            ])),
                            const SizedBox(height: 5),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Company Name:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: item.mIName ?? "",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ])),
                            const SizedBox(height: 5),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "CheckOut-Qty:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: item.iNVATCOCheckOutQty.toString(),
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ])),
                            const SizedBox(height: 5),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Location RoomName:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: item.iNVMLOLocationRoomName ?? "",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ])),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'Assets List is not available',
                    style: Get.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  int bgColor = -1;
}
