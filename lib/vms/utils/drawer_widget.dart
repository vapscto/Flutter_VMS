import 'package:flutter/material.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import '../profile/controller/profile_controller.dart';

class StaffDrawerHeader extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final ProfileController profileController;
  const StaffDrawerHeader(
      {super.key,
      required this.loginSuccessModel,
      required this.profileController});

  @override
  State<StaffDrawerHeader> createState() => _StaffDrawerHeaderState();
}

class _StaffDrawerHeaderState extends State<StaffDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16.0, (MediaQuery.of(context).padding.top + 32.0), 16.0, 30.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40)),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // (widget.loginSuccessModel.roleforlogin == "ADMIN")
          //     ? CircleAvatar(
          //         backgroundColor: Colors.white,
          //         radius: 30.0,
          //         backgroundImage: (widget.profileController.profileDataValue
          //                         .first.hRMEPhoto ==
          //                     null ||
          //                 widget.profileController.profileDataValue.first
          //                     .hRMEPhoto!.isEmpty)
          //             ? null
          //             : NetworkImage(widget
          //                 .profileController.profileDataValue.first.hRMEPhoto!),
          //         child: (widget.profileController.profileDataValue.first
          //                         .hRMEPhoto ==
          //                     null ||
          //                 widget.profileController.profileDataValue.first
          //                     .hRMEPhoto!.isEmpty)
          //             ?
          //             // ?
          //             const Padding(
          //                 padding: EdgeInsets.all(8.0),
          //                 child: Icon(
          //                   Icons.person,
          //                   color: Colors.black,
          //                   size: 36.0,
          //                 ),
          //               )
          //             : null,
          //       )
          //     :
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30.0,
            backgroundImage: (widget.loginSuccessModel.userImagePath == null ||
                    widget.loginSuccessModel.userImagePath!.isEmpty)
                ? null
                : NetworkImage(widget.loginSuccessModel.userImagePath!),
            child: (widget.loginSuccessModel.userImagePath == null ||
                    widget.loginSuccessModel.userImagePath!.isEmpty)
                ?
                // ?
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 36.0,
                    ),
                  )
                : null,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.loginSuccessModel.roleforlogin == "ADMIN")
                    ? Text(
                        widget.loginSuccessModel.userName ?? "N/A",
                        style: Theme.of(context).textTheme.labelLarge!.merge(
                              const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      )
                    : Text(
                        widget.loginSuccessModel.studname ?? "N/A",
                        style: Theme.of(context).textTheme.labelLarge!.merge(
                              const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      ),
                const SizedBox(
                  height: 6.0,
                ),
                (widget.loginSuccessModel.roleforlogin == "ADMIN")
                    ? Text(
                        widget.loginSuccessModel.designation ?? "N/A",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      )
                    : Text(
                        widget.loginSuccessModel.designation ?? "N/A",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
