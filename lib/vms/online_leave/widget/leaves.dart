import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/online_leave/api/authorization.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/model/leave_name_model.dart';
import 'package:m_skool_flutter/vms/online_leave/model/task_deviation.dart';
import 'package:m_skool_flutter/vms/online_leave/screen/apply_leave.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class Leaves extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final List<LeaveNamesModelValues> leaves;
  final List<TaskDeviationModelValues> deviation;
  const Leaves(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.leaves,
      required this.deviation});

  @override
  State<Leaves> createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  final OpetionLeaveController leaveController =
      Get.put(OpetionLeaveController());

  int backgroundColor = -1;
  List<Color> bgColor = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 88,
        // width: double.infinity,
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            backgroundColor += 1;

            if (index % 6 == 0) {
              backgroundColor = 0;
            }
            if (backgroundColor > 6) {
              backgroundColor = 0;
            }
            bgColor.add(noticeColor.elementAt(backgroundColor));
            return InkWell(
              onTap: () async {
                if (widget.leaves.elementAt(index).hrelSCBLeaves == null) {
                  Fluttertoast.showToast(
                      msg:
                          "You can not apply.. because we are unable to verify your remaining leave");
                  return;
                }

                if (widget.leaves.elementAt(index).hrelSCBLeaves! <= 0) {
                  Fluttertoast.showToast(
                      msg: "You used all your leaves.. you can not apply");
                  return;
                }

                await checkAuthorizationLeave(
                    miId: widget.loginSuccessModel.mIID!,
                    userId: widget.loginSuccessModel.userId!,
                    base: baseUrlFromInsCode(
                      "leave",
                      widget.mskoolController,
                    ),
                    hrmlId: widget.leaves.elementAt(index).hrmLId!,
                    opetionLeaveController: leaveController);

                if (leaveController.particularLeaveAuthorization ==
                    "NotMapped") {
                  showPopup(
                      "You Can Not Apply This Leave Because Authorized Person Is Not Mapped For Approval, So Contact Administrator / HR");
                } else if (widget.leaves.elementAt(index).probationary ==
                        true &&
                    (widget.leaves.elementAt(index).hrmeDoc == null)) {
                  showPopup(
                      "As you are in the probationary period, you are not eligible to apply for ${widget.leaves.elementAt(index).hrmLLeaveName}");
                  return;
                } else if (widget.leaves.elementAt(index).hrmLLeaveCode ==
                    'COMPOFF') {
                  showPopup("Comp off will be auto adjested to lop");
                  return;
                } else if ((widget.leaves.elementAt(index).hrmLLeaveCode ==
                        "PL") &&
                    widget.deviation.isNotEmpty &&
                    widget.deviation.last.deviationPercentage! > 20) {
                  showPopup(
                      "You cannot apply for ${widget.leaves.elementAt(index).hrmLLeaveName} since your deviation is greater than 20 %.");
                  return;
                } else if ((widget.leaves.elementAt(index).hrmLLeaveCode ==
                        "CL") &&
                    widget.deviation.isNotEmpty &&
                    widget.deviation.last.deviationPercentage! > 30) {
                  showPopup(
                      "You cannot apply for ${widget.leaves.elementAt(index).hrmLLeaveName} since your deviation is greater than 30 %.");
                  return;
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ApplyForLeave(
                      values: widget.leaves.elementAt(index),
                      color: bgColor.elementAt(index),
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                    );
                  }));
                }
              },
              child: LeaveNames(
                backgroundColor: backgroundColor,
                leave: widget.leaves.elementAt(index),
              ),
            );
          },
          itemCount: widget.leaves.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 16.0,
            );
          },
        ),
      ),
    );
  }

  void showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Text(
            message,
            style: Get.textTheme.titleMedium,
          ),
          contentTextStyle: Get.textTheme.titleMedium,
          actions: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LeaveNames extends StatelessWidget {
  final LeaveNamesModelValues leave;
  const LeaveNames({
    Key? key,
    required this.backgroundColor,
    required this.leave,
  }) : super(key: key);

  final int backgroundColor;

  @override
  Widget build(BuildContext context) {
    double progressValue = (leave.hrelSTotalLeaves! - leave.hrelSCBLeaves!) /
        leave.hrelSTotalLeaves!;

    return SizedBox(
      width: Get.width * 0.42,
      child: CustomContainer(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progressValue.isFinite ? progressValue : 0.0,
                  backgroundColor: noticeBackgroundColor
                      .elementAt(backgroundColor)
                      .withOpacity(0.8),
                  color: noticeColor.elementAt(backgroundColor),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      leave.hrmLLeaveCode!.toLowerCase() == "sl"
                          ? "assets/images/sl.png"
                          : leave.hrmLLeaveCode!.toLowerCase() == "cl"
                              ? "assets/images/cl.png"
                              : leave.hrmLLeaveCode!.toLowerCase() == "el"
                                  ? "assets/images/el.png"
                                  : "assets/images/el.png",
                      color: noticeColor.elementAt(backgroundColor),
                      width: 24.0,
                    )),
              ],
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${leave.hrelSCBLeaves!}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "${leave.hrmLLeaveName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
