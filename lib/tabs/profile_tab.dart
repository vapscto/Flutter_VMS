import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/get_profile_details.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/model/profile_model.dart';
import 'package:m_skool_flutter/model/student_profile_details_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/student_profile_cards.dart';

class ProfileTab extends StatelessWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final PageController pageController;
  const ProfileTab(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.chevron_left_rounded,
      //       color: Colors.white,
      //       size: 34,
      //     ),
      //     onPressed: () {
      //       pageController.animateToPage(0,
      //           duration: const Duration(milliseconds: 500),
      //           curve: Curves.fastLinearToSlowEaseIn);
      //     },
      //   ),
      //   leadingWidth: 30,
      //   title: const Text("Profile"),
      //   actions: [
      //     IconButton(
      //       icon: SvgPicture.asset('assets/svg/bell.svg'),
      //       onPressed: () {},
      //     ),
      //     const SizedBox(
      //       width: 8.0,
      //     ),
      //   ],
      // ),
      body: FutureBuilder<List<ProfileDataModelValues>>(
          future: GetProfileDetails.instance.getProfileData(
              miId: loginSuccessModel.mIID!,
              asmayId: loginSuccessModel.asmaYId!,
              amstId: loginSuccessModel.amsTId!,
              userId: loginSuccessModel.userId!,
              roleId: loginSuccessModel.roleId!,
              type: "mobile",
              base: baseUrlFromInsCode("portal", mskoolController)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: ErrWidget(err: {
                    "errorTitle": "No profile details available",
                    "errorMsg": ""
                  }),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: Get.height * 0.3, left: 16.0, right: 16.0),
                          width: double.infinity,
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5FBFF),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16.0),
                                bottomRight: Radius.circular(16.0)),
                            boxShadow: CustomThemeData.getShadow(),
                          ),
                          //height: 150,

                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              Text(
                                snapshot.data!.first.amsTFirstName ?? "N/a",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(
                                      const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "${snapshot.data!.first.amsTAdmNo} | ${snapshot.data!.first.asmcLClassName} ${snapshot.data!.first.asmCSectionName}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Date Of Birth",
                                    textAlign: TextAlign.end,
                                  )),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  const Text(":"),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Expanded(
                                      child: Text(
                                    snapshot.data!.first.amsTDOB == null
                                        ? "N/a"
                                        : getFormatedDate(DateTime.parse(
                                            snapshot.data!.first.amsTDOB!)),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Contact Number",
                                    textAlign: TextAlign.end,
                                  )),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  const Text(":"),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${snapshot.data!.first.amsTMobileNo ?? "N/a"}",
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "T-Pin",
                                    textAlign: TextAlign.end,
                                  )),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  const Text(":"),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Expanded(
                                      child: Text(
                                    snapshot.data!.first.aMSTTpin ?? "N/a",
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "Email Id",
                                    textAlign: TextAlign.end,
                                  )),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  const Text(":"),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Expanded(
                                      child: Text(
                                    snapshot.data!.first.amsTEmailId ?? "N/a",
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.34,
                          width: double.infinity,
                          //color: Colors.grey.shade100,
                          child: Stack(
                            children: [
                              loginSuccessModel.mIBackgroundImage == null
                                  ? const Text("No School Image available")
                                  : Image.network(
                                      loginSuccessModel.mIBackgroundImage!,
                                      height: Get.height * 0.3,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade100,
                                  radius: 40.0,
                                  backgroundImage: NetworkImage(snapshot
                                          .data!.first.amsTPhotoname ??
                                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 16.0,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   child: ListTile(
                    //     tileColor: const Color(0xFFDBFDF5).withOpacity(0.5),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(16.0),
                    //     ),
                    //     title: Text(
                    //       "Email Id",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .titleSmall!
                    //           .merge(const TextStyle(fontSize: 12.0)),
                    //     ),
                    //     subtitle: Text(
                    //       snapshot.data!.first.amsTEmailId!,
                    //       style: Theme.of(context).textTheme.titleSmall!.merge(
                    //           const TextStyle(fontWeight: FontWeight.w400)),
                    //     ),
                    //   ),
                    // ),

                    Container(
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16),
                        child: getProfileCardByUserType(
                          loginSuccessModel.roleforlogin!,
                        ))
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return ErrWidget(err: snapshot.error as Map<String, dynamic>);
            }
            return const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading Profile Details",
                desc: "We are under process to get your details from server.");
          }),
    );
  }

  Widget getProfileCardByUserType(String userType) {
    switch (userType) {
      case "Student":
        return FutureBuilder<StudentProfileDetailsModel>(
          future: GetProfileDetails.instance.getStudentProfileDetails(
            miId: loginSuccessModel.mIID!,
            asmayId: loginSuccessModel.asmaYId!,
            amstId: loginSuccessModel.amsTId!,
            userId: loginSuccessModel.userId!,
            roleId: loginSuccessModel.roleId!,
            base: baseUrlFromInsCode("portal", mskoolController),
          ),
          builder: (BuildContext context,
              AsyncSnapshot<StudentProfileDetailsModel> snapshot) {
            if (snapshot.hasData) {
              return StudentProfileCards(
                loginSuccessModel: loginSuccessModel,
                mskoolController: mskoolController,
                studentProfileDetails: snapshot.data!,
              );
            }
            if (snapshot.hasError) {
              return ErrWidget(err: snapshot.error as Map<String, dynamic>);
            }
            return Container();
          },
        );
      // break;
      default:
        return Container();
    }
  }
}
