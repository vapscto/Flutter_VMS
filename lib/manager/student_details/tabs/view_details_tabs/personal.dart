import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/manager/student_details/controller/view_student_details_controller.dart';
import 'package:m_skool_flutter/staffs/punch_report/widget/punch_report_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class PersonalTab extends StatelessWidget {
  final ViewStudentDetailsController controller;
  const PersonalTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isErrorOccured.value
          ? Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg": controller.status.value,
                },
              ),
            )
          : controller.isLoading.value
              ? Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    desc: controller.status.value,
                    title: "Please wait we are loading.",
                  ),
                )
              : controller.personalData.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Student Found",
                        desc:
                            "There is no personal available currently.. Please ask your technical team to add some",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 24.0,
                          ),
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                child: CustomContainer(
                                  color: const Color(0xFFEBF6FF),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.07,
                                      ),
                                      Text(
                                        "${controller.personalData.first.amstFirstName ?? "N/a"} ${controller.personalData.first.amstMiddleName ?? "N/a"} ${controller.personalData.first.amstLastName ?? "N/a"}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        controller.personalData.first.amstDob ==
                                                null
                                            ? "N/a"
                                            : "DOB: ${getFormatedDate(DateTime.parse(controller.personalData.first.amstDob!))}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!,
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        controller.personalData.first.amstSex ??
                                            "N/a",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!,
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                minRadius: 36.0,
                                child: controller.personalData.first
                                                .amsTPhotoName ==
                                            null ||
                                        controller.personalData.first
                                            .amsTPhotoName!.isEmpty
                                    ? Image.asset(
                                        "assets/images/prof2.png",
                                        height: 68.0,
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(34.0),
                                        child: Image.network(
                                          controller.personalData.first
                                              .amsTPhotoName!,
                                          height: 68.0,
                                        ),
                                      ),
                                // backgroundImage: NetworkImage(controller.personalData.first.),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Bio",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          CustomContainer(
                            color: const Color(0xFFFFEFF2),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  PunchReportItem(
                                    title: "Class",
                                    time: controller
                                            .personalData.first.classname ??
                                        "N/a",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  PunchReportItem(
                                    title: "Section",
                                    time: controller
                                            .personalData.first.sectionname ??
                                        "N/a",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  PunchReportItem(
                                    title: "Roll Number",
                                    time:
                                        "${controller.personalData.first.amayRollNo ?? "N/a"}",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  PunchReportItem(
                                    title: "Admission Number",
                                    time: controller
                                            .personalData.first.amstAdmNo ??
                                        "N/a",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  PunchReportItem(
                                      title: "Register Number",
                                      time: controller.personalData.first
                                              .amstRegistrationNo ??
                                          "N/a")
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "Contact Details",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          CustomContainer(
                            color: const Color(0xFFFEFAFF),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  PunchReportItem(
                                    title: "Father Name",
                                    time: controller
                                        .personalData.first.fathername ??"N/a",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  PunchReportItem(
                                    title: "Mother Name",
                                    time: controller
                                            .personalData.first.mothername ??
                                        "N/a",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  PunchReportItem(
                                    title: "Email Id",
                                    time: controller
                                            .personalData.first.amstEmailid ??
                                        "N/a",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  PunchReportItem(
                                    title: "Mobile Number",
                                    time:
                                        "${controller.personalData.first.amstMobile ?? "N/a"}",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  PunchReportItem(
                                      title: "Address",
                                      time:
                                          "${controller.personalData.first.address1 ?? "N/a"} ${controller.personalData.first.address2 ?? "N/a"} ${controller.personalData.first.address3 ?? "N/a"}")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
    });
  }
}
