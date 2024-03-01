import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';

class BirthDaySlider extends StatefulWidget {
  final ProfileController profileController;
  const BirthDaySlider({super.key, required this.profileController});

  @override
  State<BirthDaySlider> createState() => _BirthDaySliderState();
}

class _BirthDaySliderState extends State<BirthDaySlider> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return CarouselSlider(
        items: List.generate(widget.profileController.birthdayList.length,
            (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 171, 182, 247))),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/finalizedframe.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 11.0),
                        child: SizedBox(
                          height: 97,
                          width: 97,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: Image.network(
                              widget.profileController.birthdayList[index]
                                      .hrmEPhoto ??
                                  'https://dcampusstrg.blob.core.windows.net/files/17/EmployeeProfilePics/2209bab7-d9ec-4006-8a37-aed750a36457.jfif',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "HAPPY BIRTHDAY",
                              style: Get.textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              '${widget.profileController.birthdayList[index].hrmEEmployeeFirstName!} ${widget.profileController.birthdayList[index].middleName ?? ''} ${widget.profileController.birthdayList[index].hrmEEmployeeLastName ?? ''}',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                '${widget.profileController.birthdayList[index].hrmdeSDesignationName ?? ''} ',
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center,
                                style: Get.textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
        options: CarouselOptions(
          autoPlayAnimationDuration: const Duration(seconds: 3),
          autoPlayInterval: const Duration(seconds: 5),
          viewportFraction: 1,
          height: size.height * 0.2,
          autoPlay: true,
          enlargeCenterPage: false,
          enableInfiniteScroll: true,
          onPageChanged: (index, reason) {},
        ),
      );
    });
  }
}
