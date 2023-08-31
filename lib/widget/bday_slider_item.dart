import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_skool_flutter/model/student_dashboard_model.dart';
import 'package:m_skool_flutter/widget/date_shape.dart';

class BdaySliderItem extends StatelessWidget {
  final BirthdayListValues value;
  const BdaySliderItem({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            //color: const Color(0xFFFFF2F2),
            // boxShadow: CustomThemeData.getShadow(),
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
                image: AssetImage('assets/images/finalizedframe.png'),
                fit: BoxFit.cover)),
        child: Row(
          children: [
            Expanded(
                child: Transform.translate(
              offset: const Offset(-22.5, 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: Get.width * 0.156,
                    backgroundImage: value.aMSTPhotoname == null
                        ? null
                        : NetworkImage(value.aMSTPhotoname!.isEmpty
                            ? "https://images.unsplash.com/photo-1558636508-e0db3814bd1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"
                            : value.aMSTPhotoname!),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      "assets/images/cake.png",
                      height: Get.width * 0.2,
                    ),
                  )
                ],
              ),
            )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 8),
                    child: Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.06),
                      child: Text("Happy",
                          style: GoogleFonts.bubblegumSans(fontSize: 20.0)),
                    ),
                  ),
                  Text(
                    "Birthday",
                    style: GoogleFonts.moonDance(
                        fontSize: 48.0,
                        color: const Color(0xFFFF6F67),
                        height: 1.12),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.06, right: Get.width * 0.02),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(value.aMSTFirstName ?? "N/a",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.bubblegumSans(
                              fontSize: 20.0, height: 0.9)),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.02),
                    child: CustomPaint(
                      size: Size(
                          Get.width * 0.3,
                          (Get.width * 0.3 * 0.3103448275862069)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: RPSCustomPainter(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          value.amstdob == null
                              ? "N/a"
                              : "${DateTime.parse(value.amstdob!).day}.${DateTime.parse(value.amstdob!).month}.${DateTime.parse(value.amstdob!).year}",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                        ),
                      ),
                    ),
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
