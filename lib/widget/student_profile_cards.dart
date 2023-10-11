import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/model/student_profile_details_model.dart';
import 'package:m_skool_flutter/screens/school_details_screen.dart';

import 'package:m_skool_flutter/widget/custom_elevated_button.dart';
import 'package:m_skool_flutter/widget/profile_items_card_widget.dart';
import 'package:m_skool_flutter/widget/subject_teachers_popup.dart';

class StudentProfileCards extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final StudentProfileDetailsModel studentProfileDetails;
  const StudentProfileCards({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.studentProfileDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 18,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: [
        ProfileItemsCard(
          cardColor: const Color(0xFFECF8FF),
          logoAsset: "assets/images/SubjectTeacher.png",
          title: "Subject Teacher",
          onTap: () {
            Get.dialog(
              SubjectTeachersPopup(
                studentProfileDetails: studentProfileDetails,
                loginSuccessModel: loginSuccessModel,
                mskoolController: mskoolController,
              ),
            );
          },
        ),
        PopupMenuButton(
          offset: const Offset(0, 50),
          shape: const TooltipShape(),
          child: const ProfileItemsCard(
            cardColor: Color(0xFFFAEFFE),
            logoAsset: "assets/images/ClassTeacher.png",
            title: "Class Teacher",
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(
                              "assets/images/prof1.png",
                            ),
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                studentProfileDetails.classteacher == null &&
                                        studentProfileDetails
                                                .classteacher!.values ==
                                            null &&
                                        studentProfileDetails
                                            .classteacher!.values!.isEmpty
                                    ? "N/a"
                                    : studentProfileDetails.classteacher!
                                            .values!.first.empName ??
                                        "N/a",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30.0),
                      //       ),
                      //     ),
                      //     onPressed: () {},
                      //     child: const Text("Contact"))

                      // TextButton(onPressed: () {}, child: const Text("data")),
                      CustomElevatedButton(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const BoxShadow(),
                        onPressed: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) {
                          //   return InteractionHomeScreen(
                          //     loginSuccessModel: loginSuccessModel,
                          //     mskoolController: mskoolController,
                          //     role: studentProfileDetails
                          //         .classteacher!.values!.first.classTeacher,
                          //     hrmeId: studentProfileDetails
                          //         .classteacher!.values!.first.hRMEId!
                          //         .toInt(),
                          //   );
                          // }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5.0, 10, 5),
                          child: Text(
                            "Contact",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        ProfileItemsCard(
          cardColor: const Color(0xFFFFEBD4),
          logoAsset: "assets/images/SchoolDetails.png",
          title: "School Details",
          onTap: () {
            Get.to(
              () => SchoolDetailsScreen(
                loginSuccessModel: loginSuccessModel,
              ),
            );
          },
        ),
        ProfileItemsCard(
          cardColor: const Color(0xFFFFE1E1),
          logoAsset: "assets/images/WriteTo.png",
          title: "Write To",
          onTap: () {
            // Get.to(
            //   () => FeedBackHome(
            //     loginSuccessModel: loginSuccessModel,
            //     mskoolController: mskoolController,
            //   ),
            // );
          },
        )
      ],
    );
  }
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
