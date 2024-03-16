import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/api/add_extra_task_api.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/screens/dailyrpt_home.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class SearchPreviousTask extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final PlannerDetails controller;
  const SearchPreviousTask(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<SearchPreviousTask> createState() => _SearchPreviousTaskState();
}

class _SearchPreviousTaskState extends State<SearchPreviousTask> {
  final dateController = TextEditingController();
  String date = '';
  String time = '';
  @override
  dispose() {
    widget.controller.searchTaskList.clear();
    widget.controller.searchpreviousTaskDetailsList.clear();
    dateController.clear();
    super.dispose();
  }

  int appHours = 0;
  int appMinutes = 0;
  int count1 = 0;
  int count2 = 0;
  double count3 = 0;
  double count4 = 0;
  //
  int aCount1 = 0;
  int aCount2 = 0;
  double aCount3 = 0;
  double aCount4 = 0;
  //
  int rCount1 = 0;
  int rCount2 = 0;
  double rCount3 = 0;
  double rCount4 = 0;
  // calculate hour

  _getList(DateTime dt) async {
    widget.controller.searchTaskList.clear();
    widget.controller.searchpreviousTaskDetailsList.clear();
    widget.controller.searchTaskLoading(true);
    await PreviousDrReport.instance.previousDrData(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        mIId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        ismDate: dt.toIso8601String(),
        controller: widget.controller);
    date = await getDateNeed(DateTime.parse(
        widget.controller.searchpreviousTaskDetailsList.first.ismdrptdWDate!));
    widget.controller.searchTaskLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Previous Task List').getAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 14, bottom: 10),
            child: CustomContainer(
              child: TextField(
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate:
                        DateTime.now(), //.subtract(const Duration(days: 1)),
                    initialDate:
                        DateTime.now().subtract(const Duration(days: 1)),
                  ).then((newValue) async {
                    dateController.text = await getDateNeed(newValue!);
                    _getList(newValue);
                  });
                },
                controller: dateController,
                readOnly: true,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.3)),
                decoration: InputDecoration(
                  hintText: "Select Date",
                  hintStyle: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300)),
                  suffixIcon: const Icon(
                    Icons.calendar_month,
                    size: 20,
                    color: Color.fromARGB(255, 47, 175, 51),
                  ),
                  border: const OutlineInputBorder(),
                  label: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: const Color.fromARGB(255, 212, 245, 206)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          " Date ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                    fontSize: 20.0,
                                    color: Color.fromARGB(255, 20, 180, 15)),
                              ),
                        ),
                      ],
                    ),
                  ),
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
          ),
          Obx(() {
            return (widget.controller.searchpreviousTaskDetailsList.isEmpty)
                ? const SizedBox()
                : CustomContainer(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Daily Report Date :- ',
                              style: Get.textTheme.titleSmall!),
                          TextSpan(
                              text: date,
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Daily Report Time Taken :- ',
                              style: Get.textTheme.titleSmall!),
                          TextSpan(
                              text: '${widget.controller.totalDrHrs} ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Daily Report Approved Time :- ',
                              style: Get.textTheme.titleSmall!),
                          TextSpan(
                              text: '${widget.controller.totalDrApproveHrs} ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Daily Report Rejected Time :- ',
                              style: Get.textTheme.titleSmall!),
                          TextSpan(
                              text: '${widget.controller.totalDrRejectedHrs} ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Daily Report Over All Comments :- ',
                              style: Get.textTheme.titleSmall!),
                          TextSpan(
                              text:
                                  '${widget.controller.searchpreviousTaskDetailsList.first.ismdrptdWOverallComments ?? ''} ',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ])),
                      ],
                    ),
                  ));
          }),
          Obx(() {
            return (widget.controller.isSearchLoading.value)
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Getting Previous Dr Task",
                        desc: "We are loading Previous Dr Task... Please wait ",
                        animationPath: "assets/json/default.json"),
                  )
                : (widget.controller.searchTaskList.isNotEmpty)
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6),
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                            headingRowColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor),
                            dataTextStyle: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 0.95),
                                fontWeight: FontWeight.w400),
                            dataRowHeight:
                                MediaQuery.of(context).size.height * 0.21,
                            headingRowHeight:
                                MediaQuery.of(context).size.height * 0.08,
                            horizontalMargin: 15,
                            columnSpacing: 20,
                            dividerThickness: 1,
                            headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            border: TableBorder.all(
                                borderRadius: BorderRadius.circular(10),
                                width: 0.5),
                            columns: const [
                              DataColumn(
                                label: Text('S.No'),
                              ),
                              DataColumn(
                                label: Text("DR Task Details"),
                              ),
                              DataColumn(
                                label: Text('Issue Description'),
                              ),
                              DataColumn(
                                label: Text('Response'),
                              ),
                              DataColumn(
                                label: Text('DR Effort'),
                              ),
                              DataColumn(
                                label: Text('Approved Status'),
                              ),
                              DataColumn(
                                label: Text('Approved Time'),
                              ),
                              // DataColumn(
                              //   label: Text('Approved Remarks'),
                              // ),
                            ],
                            rows: List.generate(
                                widget.controller.searchTaskList.length,
                                (index) {
                              var v = index + 1;
                              var val = widget.controller.searchTaskList
                                  .elementAt(index);
                              int hours = val.efforts!.floor();
                              int minutes =
                                  ((val.efforts! - hours) * 60).round();

                              if (val.iSMDRPTApprovedTime != null) {
                                appHours = val.iSMDRPTApprovedTime!.floor();
                                appMinutes =
                                    ((val.iSMDRPTApprovedTime! - hours) * 60)
                                        .round();
                              }
                              // if (val.iSMDRPTDate != null) {
                              //   DateTime dt = DateTime.parse(val.iSMDRPTDate!);
                              //   var date = '${dt.day}-${dt.month}-${dt.year}';
                              // }
                              return DataRow(cells: [
                                DataCell(Text(v.toString())),
                                DataCell(Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Task No. :- ',
                                        style: TextStyle(
                                            color: (val.iSMDRPTApprovedFlg!
                                                        .toLowerCase() ==
                                                    'approved')
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: val.iSMTCRTaskNo ?? '',
                                        style: TextStyle(
                                            color: (val.iSMDRPTApprovedFlg!
                                                        .toLowerCase() ==
                                                    'approved')
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    ])),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Text('Priority :- '),
                                        Text(val.hRMPName ?? ''),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Text('Client :- '),
                                        Text(val.iSMMCLTClientName ?? ''),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Text('Status :- '),
                                        Text(val.iSMDRPTStatus ?? ''),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Text('Created By :- '),
                                        Text(val.assignedby ?? ''),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Text('DR Date :- '),
                                        Text((val.iSMDRPTDate != null)
                                            ? date
                                            : ''),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: const [
                                        Text('Activity :- '),
                                        Text(''),
                                      ],
                                    ),
                                  ],
                                )),
                                DataCell(SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      val.iSMTCRDesc ?? '',
                                      maxLines: 8,
                                      overflow: TextOverflow.fade,
                                    ))),
                                DataCell(SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      val.iSMDRPTRemarks ?? '',
                                      maxLines: 8,
                                      overflow: TextOverflow.fade,
                                    ))),
                                DataCell(Text('$hours.$minutes Hr')),
                                DataCell(Text(
                                  val.iSMDRPTApprovedFlg ?? '',
                                  style: TextStyle(
                                      color: (val.iSMDRPTApprovedFlg!
                                                  .toLowerCase() ==
                                              'approved')
                                          ? Colors.green
                                          : Colors.red),
                                )),
                                DataCell(Text((val.iSMDRPTApprovedTime != null)
                                    ? convertDoubleToHourMinute(
                                        val.iSMDRPTApprovedTime!)
                                    : '')),
                              ]);
                            }),
                          ),
                        ),
                      )
                    : const Center(
                        child: AnimatedProgressWidget(
                            animatorHeight: 250,
                            title: "Rrecord not Found",
                            desc: " ",
                            animationPath: "assets/json/nodata.json"));
          }),
        ],
      ),
    );
  }

  String convertDoubleToHourMinute(double time) {
    int hours = time.toInt();
    int minutes = ((time - hours) * 60).round();

    String hourStr = hours.toString().padLeft(2, '0');
    String minStr = minutes.toString().padLeft(2, '0');

    return '$hourStr.$minStr Hrs';
  }
}
