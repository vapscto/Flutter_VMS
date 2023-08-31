import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_coe_data_model.dart';
import 'package:m_skool_flutter/staffs/widget/coe_staff_slider.dart';

class StaffCarasouel extends StatelessWidget {
  final List<DashboardCoeDataModelValues> mList;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final bool? forManager;
  const StaffCarasouel(
      {super.key,
      required this.mList,
      required this.loginSuccessModel,
      required this.mskoolController,
      this.forManager});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: mList.length,
      itemBuilder: (_, index, count) {
        return CoeStaffSlider(
          forManager: forManager,
          coeValue: mList.elementAt(index),
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        );
      },
      options: CarouselOptions(
          height: Get.height * 0.2,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          autoPlay: true),
    );
  }
}
