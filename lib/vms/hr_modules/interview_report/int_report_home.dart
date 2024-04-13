import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_report/api/interview_report_api.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_report/controller/int_report_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class InterviewReportHome extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final String title;
  const InterviewReportHome(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.title});

  @override
  State<InterviewReportHome> createState() => _InterviewReportHomeState();
}

class _InterviewReportHomeState extends State<InterviewReportHome> {
  IntviewGridController controller = Get.put(IntviewGridController());
  List statusList = ["UpComming", "InProgress", "Completed"];
  String selectedValue = 'UpComming';
  _onLoad() async {
    controller.loading(true);
    await InterviewReportAPI.instance.getList(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "fromdate": fromDate!.toIso8601String(),
          "todate": toDate!.toIso8601String(),
          "rdotype": selectedValue
        },
        controller: controller);
    controller.loading(false);
  }

  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 30, 16, 16),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomContainer(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleSmall,
                    readOnly: true,
                    controller: _startDate,
                    onTap: () async {
                      fromDate = await showDatePicker(
                        context: context,
                        helpText: "Select From Data",
                        firstDate: DateTime(2000),
                        initialDate: DateTime.now(),
                        lastDate: DateTime(3050),
                      );
                      if (fromDate != null) {
                        setState(() {
                          _startDate.text =
                              "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                        });
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          fromDate = await showDatePicker(
                            helpText: "Select From Data",
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(3050),
                          );
                          if (fromDate != null) {
                            setState(() {
                              _startDate.text =
                                  "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                            });
                          }
                        },
                        icon: SvgPicture.asset(
                          "assets/svg/calendar_icon.svg",
                          color: const Color(0xFF3E78AA),
                          height: 18,
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 40.0, left: 12),
                      border: const OutlineInputBorder(),
                      label: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFE5F3FF)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/calendar_icon.svg",
                              color: const Color(0xFF3E78AA),
                              height: 18,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              " Start Date ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xFF3E78AA),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Select Date',
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
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: CustomContainer(
                  child: TextField(
                    readOnly: true,
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: _endDate,
                    onTap: () async {
                      if (fromDate != null) {
                        toDate = await showDatePicker(
                          context: context,
                          helpText: "Select To Date",
                          firstDate: fromDate!,
                          initialDate: fromDate!,
                          lastDate: DateTime(3050),
                        );
                        if (toDate != null) {
                          _endDate.text =
                              "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";

                          await _onLoad();
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Please Select Start Date");
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(top: 40.0, left: 12),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (fromDate != null) {
                            toDate = await showDatePicker(
                              context: context,
                              helpText: "Select To Date",
                              firstDate: fromDate!,
                              initialDate: fromDate!,
                              lastDate: DateTime(3050),
                              fieldHintText: 'Date:Month:Year',
                            );
                            if (toDate != null) {
                              _endDate.text =
                                  "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";

                              await _onLoad();
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please Select Start Date");
                          }
                        },
                        icon: SvgPicture.asset(
                          "assets/svg/calendar_icon.svg",
                          color: const Color(0xFF3E78AA),
                          height: 18,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      label: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFE5F3FF)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/calendar_icon.svg",
                              color: const Color(0xFF3E78AA),
                              height: 18,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              " End Date ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xFF3E78AA)),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Select Date',
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
            ],
          ),
          ...List.generate(
              statusList.length,
              (index) => RadioListTile(
                  activeColor: Colors.indigo,
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: 0),
                  value: statusList[index],
                  title: Text(
                    statusList[index],
                    style: Get.textTheme.titleSmall,
                  ),
                  dense: true,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      _onLoad();
                    });
                  })),
          Obx(() {
            return controller.isLoading.value
                ? AnimatedProgressWidget(
                    animationPath: "assets/json/default.json",
                    title: "Loading ${widget.title} ",
                    desc:
                        "We are under process to get your details from server.")
                : Expanded(
                    child: ListView(
                    children: [
                      (selectedValue == "UpComming" &&
                              controller.upComingList.isNotEmpty)
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(6),
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
                                      MediaQuery.of(context).size.height * 0.07,
                                  headingRowHeight: 50,
                                  // horizontalMargin: 10,
                                  dividerThickness: 1,
                                  headingTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                  border: TableBorder.all(
                                      borderRadius: BorderRadius.circular(10),
                                      width: 0.5),
                                  columns: const [
                                    DataColumn(
                                      label: Text('S.No'),
                                    ),
                                    DataColumn(
                                      label: Text("Candidate Name"),
                                    ),
                                    DataColumn(
                                      label: Text('Interview Round'),
                                    ),
                                    DataColumn(
                                      label: Text('Interviewer Name'),
                                    ),
                                    DataColumn(
                                      label: Text('Interview Date'),
                                    ),
                                    DataColumn(
                                      label: Text('Interview Venue'),
                                    ),
                                    DataColumn(
                                      label: Text('Notify By Email'),
                                    ),
                                    DataColumn(
                                      label: Text('Notify By SMS'),
                                    ),
                                  ],
                                  rows: [
                                    ...List.generate(
                                        controller.upComingList.length,
                                        (index) {
                                      var i = index + 1;
                                      var data = controller.upComingList
                                          .elementAt(index);
                                      return DataRow(cells: [
                                        DataCell(Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            i.toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                        DataCell(Text(
                                          data.hrcDFirstName ?? "",
                                        )),
                                        DataCell(Text(
                                            data.hrcisCInterviewRounds ?? "")),
                                        DataCell(Text(
                                            data.hrmEEmployeeFirstName ?? "")),
                                        DataCell(Text(dateFormat1(
                                            DateTime.parse(
                                                data.hrcisCInterviewDateTime ??
                                                    "")))),
                                        DataCell(Text(
                                            data.hrcisCInterviewVenue ?? "")),
                                        DataCell(Text(
                                            data.hrcisCNotifyEmail.toString())),
                                        DataCell(Text(
                                            data.hrcisCNotifySMS.toString())),
                                      ]);
                                    }),
                                  ],
                                ),
                              ),
                            )
                          : (selectedValue == "InProgress" &&
                                  controller.inProgressList.isNotEmpty)
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.all(6),
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
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      headingRowHeight: 50,
                                      // horizontalMargin: 10,
                                      dividerThickness: 1,
                                      headingTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                      border: TableBorder.all(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 0.5),
                                      columns: const [
                                        DataColumn(
                                          label: Text('S.No'),
                                        ),
                                        DataColumn(
                                          label: Text("Candidate Name"),
                                        ),
                                        DataColumn(
                                          label: Text('Interview Round'),
                                        ),
                                        DataColumn(
                                          label: Text('Interviewer Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Interview Date'),
                                        ),
                                        DataColumn(
                                          label: Text('Interview Venue'),
                                        ),
                                      ],
                                      rows: [
                                        ...List.generate(
                                            controller.inProgressList.length,
                                            (index) {
                                          var i = index + 1;
                                          var data = controller.inProgressList
                                              .elementAt(index);
                                          return DataRow(cells: [
                                            DataCell(Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                i.toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                            DataCell(Text(
                                              data.hrcDFirstName ?? "",
                                            )),
                                            DataCell(Text(
                                                data.hrcisCInterviewRounds ??
                                                    "")),
                                            DataCell(Text(
                                                data.hrmEEmployeeFirstName ??
                                                    "")),
                                            DataCell(Text(dateFormat1(
                                                DateTime.parse(
                                                    data.hrcisCInterviewDateTime ??
                                                        "")))),
                                            DataCell(Text(
                                                data.hrcisCInterviewVenue ??
                                                    "")),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.all(6),
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
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      headingRowHeight: 50,
                                      // horizontalMargin: 10,
                                      dividerThickness: 1,
                                      headingTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                      border: TableBorder.all(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 0.5),
                                      columns: const [
                                        DataColumn(
                                          label: Text('S.No'),
                                        ),
                                        DataColumn(
                                          label: Text("Candidate Name"),
                                        ),
                                        DataColumn(
                                          label: Text('Interview Round'),
                                        ),
                                        DataColumn(
                                          label: Text('Interviewer Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Interview Date'),
                                        ),
                                        DataColumn(
                                          label: Text('Interview Venue'),
                                        ),
                                        DataColumn(
                                          label: Text('Interview Feedback'),
                                        ),
                                        DataColumn(
                                          label: Text('Candidate Status'),
                                        ),
                                      ],
                                      rows: [
                                        ...List.generate(
                                            controller.completedList.length,
                                            (index) {
                                          var i = index + 1;
                                          var data = controller.completedList
                                              .elementAt(index);
                                          return DataRow(cells: [
                                            DataCell(Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                i.toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                            DataCell(Text(
                                              data.hrcDFirstName ?? "",
                                            )),
                                            DataCell(Text(
                                                data.hrcisCInterviewRounds ??
                                                    "")),
                                            DataCell(Text(
                                                data.hrmEEmployeeFirstName ??
                                                    "")),
                                            DataCell(Text(dateFormat1(
                                                DateTime.parse(
                                                    data.hrcisCInterviewDateTime ??
                                                        "")))),
                                            DataCell(Text(
                                                data.hrcisCInterviewVenue ??
                                                    "")),
                                            DataCell(Text(data
                                                .hrciSInterviewFeedBack
                                                .toString())),
                                            DataCell(Text(data
                                                .hrciSCandidateStatus
                                                .toString())),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                )
                    ],
                  ));
          }),
        ]),
      ),
    );
  }
}
