import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/vms/online_leave/api/leave_approval_status.dart';
import 'package:m_skool_flutter/vms/online_leave/controller/ol_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:open_filex/open_filex.dart';

class ApprovalWidget extends StatefulWidget {
  final int hrmeId;
  final MskoolController mskoolController;
  const ApprovalWidget(
      {super.key, required this.hrmeId, required this.mskoolController});

  @override
  State<ApprovalWidget> createState() => _ApprovalWidgetState();
}

class _ApprovalWidgetState extends State<ApprovalWidget> {
  OpetionLeaveController controller = Get.find();
  String approvedDate = '';
  String fromDate = '';
  String toDate = "";
  String fTopdate = '';
  String toTopDate = '';
  _getData() async {
    controller.leaveCommentDataLoading(true);
    await LeaveApprovalStatusAPI.instance.getLeavesComment(
        miId: widget.hrmeId,
        base: baseUrlFromInsCode("leave", widget.mskoolController),
        opetionLeaveController: controller);
    var formatter = DateFormat('dd-MM-yyyy');
    for (int index = 0; index < controller.leaveCommentList.length; index++) {
      DateTime fDt = DateTime.parse(controller.leaveCommentList
          .elementAt(index)
          .hRELAPFromDate
          .toString());
      fTopdate = formatter.format(fDt);

      DateTime fDt1 = DateTime.parse(
          controller.leaveCommentList.elementAt(index).hRELAPToDate.toString());
      toTopDate = formatter.format(fDt1);
      if (controller.leaveCommentList.elementAt(index).hRELAPAFromDate !=
          null) {
        DateTime fDt = DateTime.parse(controller.leaveCommentList
            .elementAt(index)
            .hRELAPAFromDate
            .toString());
        fromDate = formatter.format(fDt);
      }
      if (controller.leaveCommentList.elementAt(index).hRELAPAToDate != null) {
        DateTime tDt = DateTime.parse(
            controller.leaveCommentList.elementAt(index).hRELAPAToDate ?? '');
        toDate = formatter.format(tDt);
      }

      if (controller.leaveCommentList.elementAt(index).updatedDate != null) {
        DateTime tDt = DateTime.parse(
            controller.leaveCommentList.elementAt(index).updatedDate!);
        approvedDate = formatter.format(tDt);
      }
    }
    controller.leaveCommentDataLoading(false);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AlertDialog(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        contentPadding: const EdgeInsets.all(10),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.leaveCommentLoading.value
                  ? const AnimatedProgressWidget(
                      title: "Loading applied leaves",
                      desc:
                          "Please wait we are loading the leave status you applied for",
                      animationPath: "assets/json/default.json")
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Leave Status",
                            style: Get.textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        const SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: 'Applied Start Date ',
                                style: Get.textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              TextSpan(
                                text: fTopdate,
                                style: Get.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: 'Applied End Date ',
                                style: Get.textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              TextSpan(
                                text: toTopDate,
                                style: Get.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 0),
                            scrollDirection: Axis.horizontal,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: DataTable(
                                  dataTextStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(0, 0, 0, 0.95),
                                      fontWeight: FontWeight.w400),
                                  dataRowHeight: 45,
                                  headingRowHeight: 40,
                                  horizontalMargin: 10,
                                  columnSpacing: 10,
                                  dividerThickness: 1,
                                  headingTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                  border: TableBorder.all(
                                      borderRadius: BorderRadius.circular(10),
                                      width: 0.5),
                                  headingRowColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  columns: const [
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'S.No',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Approved By',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Approved Date',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Approved Days',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Approved From Date',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Approved To Date',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Status',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Comment',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Document',
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                      controller.leaveCommentList.length,
                                      (index) {
                                    int i = index + 1;
                                    var data = controller.leaveCommentList
                                        .elementAt(index);
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              data.iVRMSTAULUserName ?? ''))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data.updatedDate != null
                                              ? approvedDate
                                              : ''))),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(data.hRELAPATotalDays !=
                                                null
                                            ? data.hRELAPATotalDays.toString()
                                            : ''),
                                      )),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              data.hRELAPAFromDate != null
                                                  ? fromDate
                                                  : " "))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data.hRELAPAToDate != null
                                              ? toDate
                                              : ''))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              data.hRELAPALeaveStatus ?? ''))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child:
                                              Text(data.hRELAPARemarks ?? ''))),
                                      DataCell(IconButton(
                                          onPressed: () {
                                            // OpenFilex.open(
                                            //     data.hRELAPSupportingDocument ??
                                            //         '');
                                          },
                                          icon: const Icon(Icons.visibility))),
                                    ]);
                                  }),
                                )))
                      ],
                    ),
            ],
          ),
        ),
      );
    });
  }
}
