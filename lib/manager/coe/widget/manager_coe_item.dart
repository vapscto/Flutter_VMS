import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/manager/coe/model/coe_event_data_model.dart';
import 'package:m_skool_flutter/student/coe/screen/video_screen.dart';
import 'package:m_skool_flutter/student/coe/screen/view_image.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ManagerCoeItem extends StatelessWidget {
  final Color color;
  final CoeDataModelValues values;
  const ManagerCoeItem({super.key, required this.color, required this.values});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      //color: Colors.red,
      child: Container(
        //padding: const EdgeInsets.symmetric(vertical: 8.0),
        height: Get.width * 0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Row(
          children: [
            Container(
              height: Get.width * 0.28,
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
                    values.cOEEEStartDate == null
                        ? "N/a"
                        : "${DateTime.parse(values.cOEEEStartDate!).day}",
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
                    values.cOEEEStartDate == null
                        ? "N/a"
                        : shortMonth.elementAt(
                            (DateTime.parse(values.cOEEEStartDate!).month) - 1),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .merge(TextStyle(color: color)),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  (values.cOEEVVideos == null && values.cOEEIImages == null) ||
                          (values.cOEEVVideos!.isEmpty &&
                              values.cOEEIImages!.isEmpty)
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
                                    // logger.d(values.coeeVVideos);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => VideoScreen(
                                                videoUrl:
                                                    values.cOEEVVideos!)));
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
                                    // logger.d(values.coeeVVideos);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ViewImage(
                                                image: values.cOEEIImages!)));
                                  },
                                  title: Text(
                                    "View File".tr,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              );
                              if (values.cOEEVVideos == null &&
                                  values.cOEEIImages == null) {
                                popupItem = [];
                              }
                              if (values.cOEEVVideos != null &&
                                  values.cOEEVVideos!.isNotEmpty) {
                                popupItem.add(video);
                              }
                              if (values.cOEEIImages != null &&
                                  values.cOEEIImages!.isNotEmpty) {
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
                            values.cOEMEEventName ?? "N/a",
                            maxLines: 2,
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
                                values.cOEEEStartDate == null
                                    ? "N/a"
                                    : getFormatedDate(
                                        DateTime.parse(values.cOEEEStartDate!)),
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
                                  "${values.cOEEEStartTime} - ${values.cOEEEEndTime}",
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
                  values.cOEEIImages == null || values.cOEEIImages!.isEmpty
                      ? const SizedBox(
                          width: 16.0,
                        )
                      : Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              // logger.d(values.coeeVVideos);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ViewImage(
                                          image: values.cOEEIImages!)));
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
                                            NetworkImage(values.cOEEIImages!)),
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
