import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/coe/model/staff_coe_model.dart';
import 'package:m_skool_flutter/student/coe/screen/video_screen.dart';
import 'package:m_skool_flutter/student/coe/screen/view_image.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class StaffCoeItem extends StatelessWidget {
  final StaffCoeModelValues values;
  final Color color;
  const StaffCoeItem({Key? key, required this.values, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      //color: Colors.red,
      child: Container(
        //padding: const EdgeInsets.symmetric(vertical: 8.0),
        height: Get.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Row(
          children: [
            Container(
              height: Get.width * 0.35,
              width: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    values.coeEEStartDate == null
                        ? "N/A"
                        : "${DateTime.parse(values.coeEEStartDate!).day}",
                    style: Theme.of(context).textTheme.titleMedium!.merge(
                          TextStyle(
                            color: color,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    values.coeEEStartDate == null
                        ? "N/A"
                        : shortMonth.elementAt(
                            (DateTime.parse(values.coeEEStartDate!).month) - 1),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .merge(TextStyle(color: color)),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  (values.coeeVVideos == null && values.coeeIImages == null) ||
                          (values.coeeVVideos!.isEmpty &&
                              values.coeeIImages!.isEmpty)
                      ? const SizedBox()
                      : Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: PopupMenuButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.more_horiz),
                            splashRadius: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            itemBuilder: (_) {
                              List<PopupMenuEntry<dynamic>> popupItem = [];
                              PopupMenuItem video = PopupMenuItem(
                                value: "Video",
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () {
                                    logger.d(values.coeeVVideos);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => VideoScreen(
                                                videoUrl:
                                                    values.coeeVVideos!)));
                                  },
                                  title: Text(
                                    "View Video".tr,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              );
                              PopupMenuItem image = PopupMenuItem(
                                value: "Video",
                                // onTap: () {

                                //   // Get.to(() =>
                                //   //     VideoScreen(videoUrl: values.coeeVVideos!));

                                // },
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () {
                                    logger.d(values.coeeVVideos);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ViewImage(
                                                image: values.coeeIImages!)));
                                  },
                                  title: Text(
                                    "View File".tr,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              );
                              if (values.coeeVVideos == null &&
                                  values.coeeIImages == null) {
                                popupItem = [];
                              }
                              if (values.coeeVVideos != null &&
                                  values.coeeVVideos!.isNotEmpty) {
                                popupItem.add(video);
                              }
                              if (values.coeeIImages != null &&
                                  values.coeeIImages!.isNotEmpty) {
                                popupItem.add(image);
                              }

                              return popupItem;
                            },
                          ),
                        )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            values.eventName ?? "N/A",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/calendar_coe.png',
                                height: 22.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                values.coeEEStartDate == null
                                    ? "N/A"
                                    : getFormatedDate(
                                        DateTime.parse(values.coeEEStartDate!)),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4.0),
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.watch_later_outlined,
                              //   color: Theme.of(context)
                              //       .textTheme
                              //       .labelMedium!
                              //       .color,
                              // ),
                              Image.asset(
                                'assets/images/clock_coe.png',
                                height: 22.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: Text(
                                  "${values.cOEEEStartTime ?? "N/A"} - ${values.cOEEEEndTime ?? "N/A"}",
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  values.coeeIImages == null || values.coeeIImages!.isEmpty
                      ? const SizedBox(
                          width: 16.0,
                        )
                      : Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              logger.d(values.coeeVVideos);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ViewImage(
                                          image: values.coeeIImages!)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomContainer(
                                child: Container(
                                  height: Get.width * 0.28,
                                  width: Get.width * 0.20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(values.coeeIImages!)),
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                    color: Colors.blueAccent.shade100
                                        .withOpacity(0.2),
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
