import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'dart:ui' as ui;

import '../config/themes/theme_data.dart';

class DashboardProfile extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  const DashboardProfile({required this.loginSuccessModel, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Get.height / 1.7,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: Get.height / 3,
            child: CustomPaint(
              painter: ProfilePaint(),
              child: Stack(
                children: [
                  Positioned(
                    top: (Get.height / 9) - 49,
                    left: (Get.width / 2) - 47,
                    child: CircleAvatar(
                      radius: 49,
                      backgroundImage: loginSuccessModel.userImagePath != null
                          ? NetworkImage(loginSuccessModel.userImagePath!)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: (Get.height / 3) - 90,
            left: (Get.width * 0.1),
            child: Column(
              children: [
                Text(loginSuccessModel.userName ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 15),
                _detailCard(),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CarouselBanner(),
          )
        ],
      ),
    );
  }

  Widget _detailCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: Get.width * 0.8,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('2012-055  |  IX A',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text("Attendance",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            Spacer(),
                            Text("80 %",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15))
                          ],
                        ),
                        const SizedBox(height: 8),
                        const LinearProgressIndicator(
                            value: 0.8,
                            minHeight: 7,
                            color: Color(0xffBFECE1),
                            backgroundColor: Color(0xffBFECE1),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff2EA689))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text("Fee",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            Spacer(),
                            Text("56 %",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15))
                          ],
                        ),
                        const SizedBox(height: 8),
                        const LinearProgressIndicator(
                          value: 0.5,
                          minHeight: 7.5,
                          color: Color(0xffFF8B00),
                          backgroundColor: Color(0xffFFEBD4),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselBanner extends StatelessWidget {
  const CarouselBanner({super.key});
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> slideNotifier = ValueNotifier<int>(0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
              itemCount: 4,
              itemBuilder: (_, i, j) => Container(
                    padding: const EdgeInsets.all(5.0),

                    decoration: BoxDecoration(
                      boxShadow: CustomThemeData.getShadow(),
                      color: const Color(0xffFFE8E7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: Get.width * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 10,
                                        height: 10,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffDD2025),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    const Text("Announcement",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18.5,
                                            letterSpacing: 2.1)),
                                  ],
                                ),
                                const Text.rich(TextSpan(
                                    text:
                                        "School will remain closed on 09 Nov 2022 due to Bharth bandh",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)))
                              ],
                            ),
                          ),
                          Container(
                            width: Get.width * 0.17,
                            height: Get.width * 0.17,
                            decoration: BoxDecoration(
                              color: const Color(0xffDD2025),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SvgPicture.asset(
                                "assets/svg/announcement.svg",
                                height: Get.width * 0.17,
                                width: Get.width * 0.17),
                          )
                        ],
                      ),
                    ),
                  ),
              options: CarouselOptions(
                aspectRatio: 3.43,
                autoPlay: true,
                initialPage: 0,
                onPageChanged: (index, reason) => slideNotifier.value = index,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
              )),
          const SizedBox(height: 10),
          ValueListenableBuilder<int>(
              valueListenable: slideNotifier,
              builder: (context, value, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 4; i++)
                      AnimatedContainer(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        duration: const Duration(milliseconds: 100),
                        decoration: BoxDecoration(
                            color: value == i
                                ? const Color(0xff1E38FC)
                                : const Color(0xffDFEFFD),
                            borderRadius: BorderRadius.circular(15)),
                      )
                  ],
                );
              })
        ],
      ),
    );
  }
}

class ProfilePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = const Color(0xffDFEFFD));
    canvas.drawCircle(
        Offset((size.width / 2) + 46, (size.height / 3) + 43),
        16,
        Paint()
          ..color = const Color(0xff00308F)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8);

    canvas.drawCircle(Offset((size.width / 2) + 6, (size.height / 3)), 62,
        Paint()..color = const Color(0xffF9F5EF));
    canvas.drawCircle(
        Offset((size.width / 2) + 6, (size.height / 3) + 4),
        49,
        Paint()
          ..color = Colors.white
          ..shader = ui.Gradient.radial(
              Offset((size.width / 2) + 6, (size.height / 3) + 4),
              49,
              [Colors.black.withOpacity(0.4), Colors.white]));
    for (int i = 0; i < 6; i++) {
      var paint = Paint()
        ..color = const Color(0xff00308F)
        ..style = PaintingStyle.stroke;
      if (i == 4) {
        paint.strokeWidth = 3;
      } else {
        paint.strokeWidth = 0.7;
      }
      canvas.drawCircle(
          Offset((size.width / 2) - 34, (size.height / 3) - 30), i * 6, paint);
    }
    // canvas.save();
    canvas.rotate(-0.48);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(-110, size.height - (size.height * 0.5), 90, 90),
            const Radius.circular(6)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = const Color.fromARGB(144, 54, 89, 158));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(-90, size.height - (size.height * 0.6), 90, 90),
            const Radius.circular(6)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = const Color.fromARGB(144, 54, 89, 158));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(
                size.width - 118, size.height - (size.height * 0.15), 100, 100),
            const Radius.circular(6)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = const Color.fromARGB(144, 54, 89, 158));
    // canvas.rotate(-0.45);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(
                size.width - 140, size.height - (size.height * 0.25), 100, 100),
            const Radius.circular(6)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = const Color.fromARGB(144, 54, 89, 158));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
