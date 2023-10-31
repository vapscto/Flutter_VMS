import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/api/get_planner_details_api.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class DailyReportGenration extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const DailyReportGenration(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});

  @override
  State<DailyReportGenration> createState() => _DailyReportGenrationState();
}

class _DailyReportGenrationState extends State<DailyReportGenration> {
  final PlannerDetails _plannerDetailsController = Get.put(PlannerDetails());
  RxBool halfDay = RxBool(false);
  @override
  void initState() {
    init();
    // _plannerDetailsController.plannernameDateController.value.text;
    super.initState();
  }

  init() async {
    await getPlanerdetails(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        controller: _plannerDetailsController,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DR Genration"),
        titleSpacing: 0,
        leading: const CustomGoBackButton(),
      ),
      body: Obx(
        () => _plannerDetailsController.loadPlanerDeatails.isTrue
            ? Container(
                child: const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    title: 'Loading data',
                    desc: "Please wait we are loading data",
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:
                    // ignore: prefer_is_empty
                    _plannerDetailsController
                                .closeTaskCoutnList[0].iSMEDWTCCTaskCount! !=
                            0
                        ? AlertDialog(
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(
                                    color: Colors.black26, width: .5)),
                            content: Container(
                              height: 220,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "You Can Not Generate Daily Report Because Still You Did Not Closed The Completed Task. Kindly Close The Completed Task",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                        color:
                                            Color.fromARGB(255, 37, 113, 228),
                                        fontSize: 18,
                                        wordSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      )),
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 30),
                                child: CustomContainer(
                                  child: Obx(
                                    () => TextField(
                                      controller: _plannerDetailsController
                                          .plannernameEditingController.value,
                                      readOnly: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3)),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        label: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 6.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              color: Color.fromARGB(
                                                  255, 234, 239, 255)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                " Planner Name ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(
                                                      const TextStyle(
                                                          fontSize: 20.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              103,
                                                              118,
                                                              255)),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  child: CustomContainer(
                                    child: Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: RadioListTile(
                                              value: "today",
                                              groupValue:
                                                  _plannerDetailsController
                                                      .day.value,
                                              onChanged: (value) {
                                                _plannerDetailsController
                                                    .updateDayRadio(value!);
                                              },
                                              dense: true,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -4.0),
                                              title: Text(
                                                "Today's",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 0.3)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: RadioListTile(
                                              value: "Others",
                                              groupValue:
                                                  _plannerDetailsController
                                                      .day.value,
                                              dense: true,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -4.0),
                                              title: Text(
                                                "Other's day",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .merge(const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 0.3)),
                                              ),
                                              onChanged: (value) {
                                                _plannerDetailsController
                                                    .updateDayRadio(value!);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 10),
                                child: CustomContainer(
                                  child: Obx(
                                    () => TextField(
                                      onTap: () async {
                                        await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2035),
                                          initialDate: DateTime.now(),
                                        ).then((value) async {
                                          _plannerDetailsController
                                              .plannernameDateController
                                              .value
                                              .text = await getDateNeed(value!);
                                        });
                                      },
                                      controller: _plannerDetailsController
                                          .plannernameDateController.value,
                                      readOnly: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 0.3)),
                                      decoration: InputDecoration(
                                        hintText: "Select Date",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        suffixIcon: const Icon(
                                          Icons.calendar_month,
                                          size: 20,
                                          color:
                                              Color.fromARGB(255, 47, 175, 51),
                                        ),
                                        border: const OutlineInputBorder(),
                                        label: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 6.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              color: Color.fromARGB(
                                                  255, 212, 245, 206)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                " Date ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(
                                                      const TextStyle(
                                                          fontSize: 20.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              20,
                                                              180,
                                                              15)),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: CustomContainer(
                                  child: Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text:
                                                "No.of Daily Report Generated In Other's Date : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .merge(const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 16, 103, 233)))),
                                        TextSpan(
                                            text: _plannerDetailsController
                                                .otherDaysEditingController
                                                .value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .merge(const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 16, 103, 233))))
                                      ])),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: CustomContainer(
                                    child: Obx(
                                  () => Row(
                                    children: [
                                      Checkbox(
                                        value: halfDay.value,
                                        onChanged: (value) {
                                          halfDay.value = value!;
                                        },
                                        activeColor:
                                            Color.fromARGB(255, 33, 54, 243),
                                        shape: ContinuousRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      Text(
                                        "Half Day Daily Report",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromARGB(
                                                      255, 16, 103, 233)),
                                            ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Obx(
                                () => SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                        child: SingleChildScrollView(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            scrollDirection: Axis.horizontal,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: DataTable(
                                                  dataTextStyle:
                                                      const TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.95),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  dataRowHeight: 130,
                                                  headingRowHeight: 40,
                                                  horizontalMargin: 10,
                                                  columnSpacing: 30,
                                                  dividerThickness: 1,
                                                  headingTextStyle:
                                                      const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                  border: TableBorder.all(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      width: 0.5),
                                                  headingRowColor:
                                                      MaterialStateProperty.all(
                                                          Theme.of(context)
                                                              .primaryColor),
                                                  columns: const [
                                                    // 1
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'S.No',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'Task Details',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'Response',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                  rows: List.generate(
                                                      _plannerDetailsController
                                                          .getTaskDrList
                                                          .length, (index) {
                                                    int i = index + 1;
                                                    return DataRow(cells: [
                                                      DataCell(Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text('$i'))),
                                                      DataCell(Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Checkbox(
                                                            value: true,
                                                            onChanged:
                                                                (value) {},
                                                          ))),
                                                      DataCell(Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                _plannerDetailsController
                                                                    .getTaskDrList
                                                                    .elementAt(
                                                                        index)
                                                                    .iSMTCRTaskNo!,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .merge(const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14)),
                                                              ),
                                                              Text(
                                                                "Category : ${_plannerDetailsController.getTaskDrList.elementAt(index).taskcategoryname}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .merge(const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14)),
                                                              ),
                                                              Text(
                                                                "Project : ${_plannerDetailsController.getTaskDrList.elementAt(index).projectName}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .merge(const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14)),
                                                              ),
                                                              Text(
                                                                "Task Start date : ${_plannerDetailsController.getTaskDrList.elementAt(index).iSMTPLStartDate.toString().replaceRange(10, null, '')}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .merge(const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ),
                                                              Text(
                                                                "Task End date : ${_plannerDetailsController.getTaskDrList.elementAt(index).iSMTPLEndDate.toString().replaceRange(10, null, '')}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .merge(const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            14)),
                                                              )
                                                            ],
                                                          ))),
                                                      DataCell(Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              width: 150,
                                                              child:
                                                                  TextFormField(
                                                                maxLines: 6,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall,
                                                                decoration: InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        borderSide: const BorderSide(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: .5))),
                                                              ),
                                                            ),
                                                          ))),
                                                    ]);
                                                  }),
                                                ))))),
                              ),
                            ],
                          ),
              ),
      ),
    );
  }
}

Future<String> getDateNeed(DateTime dt) async {
  return "${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}-${dt.year}";
}
