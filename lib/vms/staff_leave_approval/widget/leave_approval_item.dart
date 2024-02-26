import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/api/approve_leave.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/model/leave_approval_model.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/widget/approval_leave_date.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/widget/approval_proxy_list.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/widget/date_picker_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:open_filex/open_filex.dart';

import '../../../constants/constants.dart';

class AppliedLeaveAprovalItem extends StatefulWidget {
  final LeaveApprovalModelValues value;
  final bool selectAll;
  final Function(bool) onSelect;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const AppliedLeaveAprovalItem({
    Key? key,
    required this.value,
    required this.selectAll,
    required this.onSelect,
    required this.loginSuccessModel,
    required this.mskoolController,
  }) : super(key: key);

  @override
  State<AppliedLeaveAprovalItem> createState() =>
      _AppliedLeaveAprovalItemState();
}

class _AppliedLeaveAprovalItemState extends State<AppliedLeaveAprovalItem> {
  List<String> leaveDates = [];

  List<Map<String, dynamic>> newList = [];
  DateTime dt = DateTime.now();
  @override
  Widget build(BuildContext context) {
    newList.add({
      "HRME_Id": widget.value.hRMEId,
      "HRELAP_ApplicationID": widget.value.hRELAPApplicationID,
      "HRELAP_LeaveReason": widget.value.hRELAPLeaveReason,
      "HRELAPA_Remarks": widget.value.hRELAPARemarks,
      "HRELAP_FromDateapprv": dt.toIso8601String(),
      "HRELAP_ToDateapprv": dt.toIso8601String(),
      "HRELAP_FromDate": widget.value.hRELAPFromDate,
      "HRELAP_ToDate": widget.value.hRELAPToDate,
      "HRELAP_TotalDays": widget.value.hRELAPTotalDays,
      "HRELAP_TotalDaysapprv": widget.value.hRELAPTotalDays,
      "HRML_Id": widget.value.hRMLId
    });
    final RxBool select = RxBool(widget.selectAll);
    final RxBool showCheckBox = RxBool(widget.selectAll);
    final TextEditingController remark = TextEditingController();
    String fromDate = '';
    String toDate = '';
    if (widget.value.hRELAPFromDate != null) {
      var dt = DateTime.parse(widget.value.hRELAPFromDate!);
      fromDate = '${numberList[dt.day]} ${shortMonth[dt.month - 1]} ${dt.year}';
    }
    if (widget.value.hRELAPToDate != null) {
      var dt2 = DateTime.parse(widget.value.hRELAPToDate!);
      toDate =
          '${numberList[dt2.day]} ${shortMonth[dt2.month - 1]} ${dt2.year}';
    }
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.value.hRELAPLeaveReason ?? "N/a",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.0),
                            ),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Text(widget.value.hRMLLeaveName ?? "N/a"),
                    ],
                  ),
                ),
                Obx(() {
                  return showCheckBox.value == false
                      ? const SizedBox()
                      : Checkbox(
                          value: select.value,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (b) {
                            select.value = b!;
                          });
                })
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: noticeBackgroundColor.last),
                  child: widget.value.hRMLLeaveName == null
                      ? const Icon(Icons.broken_image)
                      : Image.asset(
                          height: 24.0,
                          widget.value.hRMLLeaveName!
                                  .toLowerCase()
                                  .contains("casual")
                              ? "assets/images/cl.png"
                              : widget.value.hRMLLeaveName!
                                      .toLowerCase()
                                      .contains("sick")
                                  ? 'assets/images/sl.png'
                                  : widget.value.hRMLLeaveName!
                                          .toLowerCase()
                                          .contains("emergency")
                                      ? "assets/images/el.png"
                                      : "assets/images/el.png",
                          color: noticeColor.last,
                        ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      Text(
                        "Leave From : ",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color,
                              ),
                            ),
                      ),
                      Text(
                        widget.value.hRELAPFromDate == null ||
                                widget.value.hRELAPToDate == null
                            ? "N/a"
                            : "$fromDate TO $toDate",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            Text("Applied Days: ${widget.value.hRELAPTotalDays}"),
            const SizedBox(
              height: 6.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name : ",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          color: Theme.of(context).textTheme.labelMedium!.color,
                        ),
                      ),
                ),
                Text(
                  "${widget.value.hRMEEmployeeFirstName ?? "N/a"} ",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                )
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Designation : ",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          color: Theme.of(context).textTheme.labelMedium!.color,
                        ),
                      ),
                ),
                Text(
                  "${widget.value.hRMDESDesignationName ?? "N/a"}",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                )
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            (widget.value.hRELAPTotalDays! <= 1.0)
                ? const SizedBox()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Do you want reduce leave?",
                        style: Get.textTheme.titleSmall,
                      ),
                      InkWell(
                        onTap: () {
                          Get.dialog(
                                  DatePickerWidget(
                                    endDate: widget.value.hRELAPToDate!,
                                    startDate: widget.value.hRELAPFromDate!,
                                  ),
                                  barrierDismissible: false)
                              .then((dateList) {
                            setState(() {
                              if (leaveDates.isNotEmpty) {
                                leaveDates.clear();
                              }
                              leaveDates.addAll(dateList);
                              if (leaveDates.isNotEmpty) {
                                widget.value.hRELAPToDate = leaveDates.first;
                                widget.value.hRELAPFromDate = leaveDates.last;
                                widget.value.hRELAPTotalDays = DateTime.parse(
                                            leaveDates.last)
                                        .difference(
                                            DateTime.parse(leaveDates.first))
                                        .inDays +
                                    1;
                                widget.value.hRELAPReportingDate =
                                    getFormatedDate(DateTime.parse(
                                        DateTime.parse(leaveDates.last)
                                            .add(const Duration(days: 1))
                                            .toString()));
                              }
                            });
                          });
                        },
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                                'assets/svg/calendar_icon.svg')),
                      )
                    ],
                  ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (widget.value.hRMLLeaveName == 'Privilege Leave')
                    ? InkWell(
                        onTap: () {
                          if (widget.value.proxyName != null) {
                            Get.dialog(
                                ApprovalProxyListPopUp(value: widget.value));
                          } else {
                            Fluttertoast.showToast(msg: "No Proxy Added");
                          }
                        },
                        child: Chip(
                          label: Text(
                            "Proxy",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      )
                    : const SizedBox(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: InkWell(
                          onTap: () {
                            Get.dialog(ApprovalLeaveDatePopUp(
                              hrelapId: widget.value.hRELAPId.toString(),
                              mskoolController: widget.mskoolController,
                              loginSuccessModel: widget.loginSuccessModel,
                              hrmeId: widget.value.hRMEId!,
                            ));
                          },
                          child: const Icon(
                            Icons.visibility_outlined,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (widget.value.hRELAPSupportingDocument == 0)
                    ? const SizedBox()
                    : (widget.value.hRELAPSupportingDocument != 'undefined')
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                              onTap: () {
                                if (widget.value.hRELAPSupportingDocument
                                    .toString()
                                    .contains('https:')) {
                                  createPreview(
                                      context,
                                      widget.value.hRELAPSupportingDocument
                                          .toString());
                                } else {
                                  OpenFilex.open(
                                      widget.value.hRELAPSupportingDocument);
                                }
                                logger.i(widget.value.hRELAPSupportingDocument);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green[100]),
                                child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.visibility,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Dialog(
                              insetPadding: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Leave Approval for ${widget.value.hRMEEmployeeFirstName ?? "N/a"}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .merge(
                                                    const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("From Date"),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 12.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade500,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child:
                                                      (leaveDates.length >= 2)
                                                          ? Text(
                                                              getFormatedDate(
                                                                DateTime.parse(
                                                                    leaveDates
                                                                        .first),
                                                              ),
                                                            )
                                                          : Text(
                                                              widget.value.hRELAPFromDate ==
                                                                      null
                                                                  ? "N/a"
                                                                  : getFormatedDate(
                                                                      DateTime.parse(widget
                                                                          .value
                                                                          .hRELAPFromDate!),
                                                                    ),
                                                            ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Center(
                                            child: Text(
                                              "  \u2212  ",
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("End Date"),
                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 12.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade500,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: (leaveDates.isNotEmpty)
                                                      ? Text(
                                                          getFormatedDate(
                                                            DateTime.parse(
                                                                leaveDates
                                                                    .last),
                                                          ),
                                                        )
                                                      : Text(widget.value
                                                                  .hRELAPToDate ==
                                                              null
                                                          ? "N/a"
                                                          : getFormatedDate(
                                                              DateTime.parse(widget
                                                                  .value
                                                                  .hRELAPToDate!))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            backgroundColor: Colors.green,
                                            minimumSize:
                                                Size(Get.width * 0.5, 40),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (_) {
                                                return Dialog(
                                                  child: FutureBuilder<bool>(
                                                      future: ApproveLeaveApi
                                                          .instance
                                                          .approveNow(
                                                        remark:
                                                            "Leave Approved",
                                                        status: "Approved",
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
                                                        getLeaveStatus: newList,
                                                      ),
                                                      builder: (_, snapshot) {
                                                        if (snapshot.hasData) {
                                                          if (snapshot.data!) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  const CircleAvatar(
                                                                    minRadius:
                                                                        30.0,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height:
                                                                        12.0,
                                                                  ),
                                                                  Text(
                                                                    "Leave Approved",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .merge(
                                                                          const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6.0,
                                                                  ),
                                                                  const Text(
                                                                      "Leave Approved"),
                                                                  const SizedBox(
                                                                    height: 6.0,
                                                                  ),
                                                                  MSkollBtn(
                                                                      title:
                                                                          "Ok",
                                                                      onPress:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        Navigator.pop(
                                                                            context);
                                                                        Navigator.pop(
                                                                            context);
                                                                      })
                                                                ],
                                                              ),
                                                            );
                                                          }

                                                          return const ErrWidget(
                                                              err: {
                                                                "errorTitle":
                                                                    "Server Error Occured",
                                                                "errorMsg":
                                                                    "Currenlty i'm unable to approve leave due to some server issue .. Server not returning 200",
                                                              });
                                                        }

                                                        if (snapshot.hasError) {
                                                          return ErrWidget(
                                                              err: snapshot
                                                                      .error
                                                                  as Map<String,
                                                                      dynamic>);
                                                        }
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: const [
                                                            AnimatedProgressWidget(
                                                                title:
                                                                    "Approving Leave",
                                                                desc:
                                                                    "We are in process to approve the leaves...",
                                                                animationPath:
                                                                    "assets/json/default.json"),
                                                          ],
                                                        );
                                                      }),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text("Approval"),
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          });
                    },
                    child: const Text("Approval"),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      backgroundColor: Colors.red,
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Dialog(
                              insetPadding: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Reason for Rejection",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(
                                                const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            remark.clear();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(Icons.close),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 32.0,
                                    ),
                                    CustomContainer(
                                      child: TextField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                        controller: remark,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 48.0, left: 12),
                                          border: const OutlineInputBorder(),
                                          label: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                color: const Color(0xFFFFEBEA)),
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
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .merge(
                                                        const TextStyle(
                                                            fontSize: 20.0,
                                                            color: Color(
                                                                0xFFFF6F67)),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          hintText: 'Type your reason here.'.tr,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Center(
                                      child: MSkollBtn(
                                        title: "Done",
                                        onPress: () {
                                          if (remark.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please provide remark before rejecting");
                                            return;
                                          }

                                          acceptOrReject(context, remark.text,
                                              "Rejected", true, widget.value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text("Reject"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void acceptOrReject(BuildContext context, String remark, String status,
      bool isRejecting, LeaveApprovalModelValues value) {
    Navigator.pop(context);
    // remark != '' ? remark = '' :
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          child: FutureBuilder<bool>(
              future: ApproveLeaveApi.instance.rejectNow(
                remark: remark,
                status: status,
                base: baseUrlFromInsCode("leave", widget.mskoolController),
                miId: widget.loginSuccessModel.mIID!,
                loginId: widget.loginSuccessModel.userId!,
                getLeaveStatus: newList,
              ),
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
                              title: "Ok",
                              onPress: () {
                                Navigator.pop(context);
                                remark = '';
                                // Navigator.pop(context);
                              })
                        ],
                      ),
                    );
                  }

                  return const ErrWidget(err: {
                    "errorTitle": "Server Error Occured",
                    "errorMsg":
                        "Currenlty i'm unable to reject  leave due to some server issue .. Server not returning 200",
                  });
                }

                if (snapshot.hasError) {
                  return ErrWidget(err: snapshot.error as Map<String, dynamic>);
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    AnimatedProgressWidget(
                        title: "Rejecting  Leave",
                        desc: "We are in process to reject  the leave...",
                        animationPath: "assets/json/default.json"),
                  ],
                );
              }),
        );
      },
    );
  }
}
