import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/staff_leave_approval/api/approve_leave.dart';
import 'package:m_skool_flutter/manager/staff_leave_approval/api/get_leaves_api.dart';
import 'package:m_skool_flutter/manager/staff_leave_approval/model/leave_approval_model.dart';
import 'package:m_skool_flutter/manager/staff_leave_approval/widget/leave_approval_item.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class StaffLeaveApproval extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;

  const StaffLeaveApproval(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<StaffLeaveApproval> createState() => _StaffLeaveApprovalState();
}

class _StaffLeaveApprovalState extends State<StaffLeaveApproval> {
  final RxBool selectAll = RxBool(false);
  final List<LeaveApprovalModelValues> selected = [];

  final TextEditingController remark = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      floatingActionButton: const HomeFab(),
      body: FutureBuilder<List<LeaveApprovalModelValues>>(
          future: GetAppliesLeavesApi.instance.getAppliedLeaves(
            base: baseUrlFromInsCode("leave", widget.mskoolController),
            miId: widget.loginSuccessModel.mIID!,
            loginId: widget.loginSuccessModel.userId!,
          ),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Leave Found",
                        desc:
                            "No one applied for leave ... applied leaves will appear here",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(() {
                            return CheckboxListTile(
                                value: selectAll.value,
                                activeColor: Theme.of(context).primaryColor,
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                title: const Text("Select All"),
                                onChanged: (b) {
                                  selectAll.value = b!;
                                  if (b) {
                                    if (selected.isNotEmpty) {
                                      selected.clear();
                                    }
                                    selected.addAll(snapshot.data!);

                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return Dialog(
                                            insetPadding:
                                                const EdgeInsets.all(16.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Leave Approval for all",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .merge(
                                                                    const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          selectAll.value =
                                                              false;
                                                          selected.clear();
                                                        },
                                                        child: const Icon(
                                                            Icons.close),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                            backgroundColor:
                                                                Colors.green,
                                                            minimumSize: const Size
                                                                .fromHeight(50),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder: (_) {
                                                                return Dialog(
                                                                  child: FutureBuilder<
                                                                          bool>(
                                                                      future: ApproveLeaveApi.instance.approveNow(
                                                                          remark:
                                                                              "Approved All Leaves",
                                                                          status:
                                                                              "Approved",
                                                                          base: baseUrlFromInsCode(
                                                                              "leave",
                                                                              widget
                                                                                  .mskoolController),
                                                                          miId: widget
                                                                              .loginSuccessModel
                                                                              .mIID!,
                                                                          loginId: widget
                                                                              .loginSuccessModel
                                                                              .userId!,
                                                                          getLeaveStatus: selected
                                                                              .expand<Map<String, dynamic>>((element) => [element.toJson()])
                                                                              .toList()),
                                                                      builder: (_, snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          if (snapshot
                                                                              .data!) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.all(12.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  const CircleAvatar(
                                                                                    minRadius: 30.0,
                                                                                    backgroundColor: Colors.green,
                                                                                    child: Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 12.0,
                                                                                  ),
                                                                                  Text(
                                                                                    "All Leaves Approved",
                                                                                    style: Theme.of(context).textTheme.titleSmall!.merge(
                                                                                          const TextStyle(
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 6.0,
                                                                                  ),
                                                                                  const Text("I approved all leaves that you told me to do.. "),
                                                                                  const SizedBox(
                                                                                    height: 6.0,
                                                                                  ),
                                                                                  MSkollBtn(
                                                                                      title: "Ok UnderStood",
                                                                                      onPress: () {
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                        // Navigator.pop(context);
                                                                                      })
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }

                                                                          return const ErrWidget(
                                                                              err: {
                                                                                "errorTitle": "Server Error Occured",
                                                                                "errorMsg": "Currenlty i'm unable to approve leave due to some server issue .. Server not returning 200",
                                                                              });
                                                                        }

                                                                        if (snapshot
                                                                            .hasError) {
                                                                          return ErrWidget(
                                                                              err: snapshot.error as Map<String, dynamic>);
                                                                        }
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: const [
                                                                            AnimatedProgressWidget(
                                                                                title: "Approving All Leaves",
                                                                                desc: "We are in process to approve all the leaves...",
                                                                                animationPath: "assets/json/default.json"),
                                                                          ],
                                                                        );
                                                                      }),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: const Text(
                                                              "Approval"),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                            minimumSize: const Size
                                                                .fromHeight(50),
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) {
                                                                  return Dialog(
                                                                    insetPadding:
                                                                        const EdgeInsets.all(
                                                                            16.0),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                "Reason for Rejection",
                                                                                style: Theme.of(context).textTheme.titleSmall!.merge(
                                                                                      const TextStyle(
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: const Icon(Icons.close),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                32.0,
                                                                          ),
                                                                          CustomContainer(
                                                                            child:
                                                                                TextField(
                                                                              style: Theme.of(context).textTheme.titleSmall,
                                                                              controller: remark,
                                                                              maxLines: 2,
                                                                              decoration: InputDecoration(
                                                                                contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                                                                                border: const OutlineInputBorder(),
                                                                                label: Container(
                                                                                  margin: const EdgeInsets.only(bottom: 5),
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.0), color: const Color(0xFFFFEBEA)),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Image.asset(
                                                                                        "assets/images/reason.png",
                                                                                        height: 24.0,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        width: 6.0,
                                                                                      ),
                                                                                      Text(
                                                                                        " Reason ".tr,
                                                                                        style: Theme.of(context).textTheme.labelMedium!.merge(
                                                                                              const TextStyle(fontSize: 20.0, color: Color(0xFFFF6F67)),
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                hintText: 'Type your reason here.'.tr,
                                                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                enabledBorder: const OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.transparent,
                                                                                  ),
                                                                                ),
                                                                                focusedBorder: const OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.transparent,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                16.0,
                                                                          ),
                                                                          Center(
                                                                            child: MSkollBtn(
                                                                                title: "Done",
                                                                                onPress: () {
                                                                                  if (remark.text.isEmpty) {
                                                                                    Fluttertoast.showToast(msg: "Please provide remark before rejecting the application");
                                                                                    return;
                                                                                  }
                                                                                  acceptOrReject(remark.text, "Rejected", true);
                                                                                }),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: const Text(
                                                              "Reject"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    selected.clear();
                                  }
                                });
                          }),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemBuilder: (_, index) {
                              return Obx(() {
                                return AppliedLeaveAprovalItem(
                                  value: snapshot.data!.elementAt(index),
                                  selectAll: selectAll.value,
                                  onSelect: (b) {
                                    if (b) {
                                      selected
                                          .add(snapshot.data!.elementAt(index));
                                      return;
                                    }
                                    selected.remove(
                                        snapshot.data!.elementAt(index));
                                  },
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                );
                              });
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 16.0,
                              );
                            },
                            itemCount: snapshot.data!.length,
                          ),
                        ],
                      ),
                    );
            }
            if (snapshot.hasError) {
              return ErrWidget(
                err: snapshot.error as Map<String, dynamic>,
              );
            }
            return const Center(
              child: AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading Applied Leaves",
                desc:
                    "We are loading leaves for you... Please wait while we do it for you",
              ),
            );
          }),
      // body: ListView.separated(
      //     padding: const EdgeInsets.all(16.0),
      //     itemBuilder: (_, index) {
      //       return const AppliedLeaveAprovalItem();
      //     },
      //     separatorBuilder: (_, index) {
      //       return const SizedBox(
      //         height: 16.0,
      //       );
      //     },
      //     itemCount: 10),
    );
  }

  void acceptOrReject(
    String remark,
    String status,
    bool isRejecting,
  ) {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          child: FutureBuilder<bool>(
              future: ApproveLeaveApi.instance.approveNow(
                  remark: remark,
                  status: status,
                  base: baseUrlFromInsCode("leave", widget.mskoolController),
                  miId: widget.loginSuccessModel.mIID!,
                  loginId: widget.loginSuccessModel.userId!,
                  getLeaveStatus: selected
                      .expand<Map<String, dynamic>>(
                          (element) => [element.toJson()])
                      .toList()),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            minRadius: 30.0,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            isRejecting ? "Leave Rejected" : "Leave Approved",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(isRejecting
                              ? "You successfully rejected the leave..."
                              : "I approved the leave for you ...."),
                          const SizedBox(
                            height: 6.0,
                          ),
                          MSkollBtn(
                              title: "Ok UnderStood",
                              onPress: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    );
                  }

                  return const ErrWidget(err: {
                    "errorTitle": "Server Error Occured",
                    "errorMsg":
                        "Currenlty i'm unable to approve leave due to some server issue .. Server not returning 200",
                  });
                }

                if (snapshot.hasError) {
                  return ErrWidget(err: snapshot.error as Map<String, dynamic>);
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    AnimatedProgressWidget(
                        title: "Approving All Leaves",
                        desc: "We are in process to approve all the leaves...",
                        animationPath: "assets/json/default.json"),
                  ],
                );
              }),
        );
      },
    );
  }
}
