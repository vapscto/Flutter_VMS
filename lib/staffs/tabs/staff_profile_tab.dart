import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/api/get_profile_details.dart';
import 'package:m_skool_flutter/staffs/model/staff_profile_data_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class StaffProfileTab extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffProfileTab(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StaffProfileDataModelValues>>(
        future: GetStaffProfileDetail.instance.getDetails(
            miId: loginSuccessModel.mIID!,
            hrmeId: loginSuccessModel.empcode!,
            base: baseUrlFromInsCode("portal", mskoolController)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                              snapshot.data!.first.empName ?? "N/A",
                              style:
                                  Theme.of(context).textTheme.titleSmall!.merge(
                                        const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              " ${snapshot.data!.first.hRMDESDesignationName ?? "N/a"} ",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            // Row(
                            //   children: const [
                            //     Expanded(
                            //         child: Text(
                            //       "Date Of Birth",
                            //       textAlign: TextAlign.end,
                            //     )),
                            //     SizedBox(
                            //       width: 12.0,
                            //     ),
                            //     Text(":"),
                            //     SizedBox(
                            //       width: 12.0,
                            //     ),
                            //     Expanded(child: Text(
                            //         // getFormatedDate(DateTime.parse(
                            //         //     snapshot.data!.first.amsTDOB!)),
                            //         "N/A")),
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 12.0,
                            // ),
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
                                  "${snapshot.data!.first.hRMEMNOMobileNo ?? "N/A"}",
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
                                  "Employee Code",
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
                                  snapshot.data!.first.hRMEEmployeeCode ??
                                      "N/a",
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
                                  snapshot.data!.first.hRMEMEmailId ?? "N/A",
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
                                ? const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "No School image available",
                                      textAlign: TextAlign.center,
                                    ),
                                  )
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
                                        .data!.first.hRMEPhoto ??
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

                  // Container(
                  //     margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                  //     child: getProfileCardByUserType(
                  //       loginSuccessModel.roleforlogin!,
                  //     ))
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: ErrWidget(
                err: snapshot.error as Map<String, dynamic>,
                onPressed: null,
              ),
            );
          }
          return const AnimatedProgressWidget(
              animationPath: "assets/json/default.json",
              title: "Loading Profile Details",
              desc: "We are under process to get your details from server.");
        });
  }
}
