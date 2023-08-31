import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/student_dashboard_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_coe_data_model.dart';
import 'package:m_skool_flutter/widget/bday_slider_item.dart';
import 'package:m_skool_flutter/widget/coe_slider_item.dart';

import '../model/login_success_model.dart';

class HomePageCarasouel extends StatefulWidget {
  final List<BirthdayListValues> bdayList;
  final List<DashboardCoeDataModelValues> coeList;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const HomePageCarasouel(
      {super.key,
      required this.bdayList,
      required this.coeList,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<HomePageCarasouel> createState() => _HomePageCarasouelState();
}

class _HomePageCarasouelState extends State<HomePageCarasouel> {
  final List<Map<String, dynamic>> carasouelList = [];

  final List<String> coeBanners = [
    "assets/images/new_coe_banner.png",
    "assets/images/new_coe_without.png"
  ];

  int coeIndex = -1;

  @override
  void initState() {
    for (int i = 0; i < widget.bdayList.length; i++) {
      carasouelList.add({"type": 1, "data": widget.bdayList.elementAt(i)});
    }
    for (int i = 0; i < widget.coeList.length; i++) {
      carasouelList.add(
        {
          "type": 0,
          "data": widget.coeList.elementAt(i),
        },
      );
    }

    carasouelList.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.2,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: carasouelList.length,
        itemBuilder: (_, index, pos) {
          Map<String, dynamic> coeBannerType = {};

          // if (carasouelList.elementAt(index)['type'] == 0) {
          //   coeIndex += 1;
          //   if (coeIndex % 2 == 0) {
          //     coeIndex = 0;
          //   }
          //   if (coeIndex == 0) {
          //     coeBannerType
          //         .addAll({"BT": 0, "BA": coeBanners.elementAt(coeIndex)});
          //   } else {
          //     coeBannerType
          //         .addAll({"BT": 1, "BA": coeBanners.elementAt(coeIndex)});
          //   }
          // }
          return carasouelList.elementAt(index)['type'] == 0
              ? CoeSliderItem(
                  coeValue:
                      carasouelList.elementAt(index)['data'] as CalListValues,
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  bannerAsset: coeBannerType,
                )
              : BdaySliderItem(
                  value: carasouelList.elementAt(index)['data'],
                );
        },
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          autoPlay: false,
          initialPage: 0,
          onPageChanged: (i, _) {},
          viewportFraction: 1,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
        ),
      ),
    );
  }
}
