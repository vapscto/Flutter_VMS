import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/save_button.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/create_planner_table_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class PlannerCreationScreen extends StatefulWidget {
  const PlannerCreationScreen({super.key});

  @override
  State<PlannerCreationScreen> createState() => _PlannerCreationScreenState();
}

class _PlannerCreationScreenState extends State<PlannerCreationScreen> {
  final _plannerName = TextEditingController();
  final _plannerGoal = TextEditingController();
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool selectAll = false;
  bool checked = false;
  List<int> checkList = [];
  bool isPlan = false;

  DateTime? fromDate;
  DateTime? toDate;
  List<CreatePlannerTable> newTable = [];
  @override
  void initState() {
    setState(() {
      newTable.add(CreatePlannerTable(
          false,
          'TASK/70466/2022-2023',
          'Tenant module live implement and remaining should be completed',
          'Major',
          'HO',
          'Softwate Development',
          'Daily',
          '18-12-2023',
          'Name',
          '22-12-2023 To 28-12-2023',
          '4:30 HR',
          ''));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Planner Creation').getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Form(
            key: _key,
            child: CustomContainer(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      child: TextField(
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: _plannerName,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 6.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: const Color(0xFFFFEBEA)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/images/subjectfielicon.png",
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  " Planner Name ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(
                                        const TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xFFFF6F67)),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter here.',
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
                    const SizedBox(height: 25),
                    CustomContainer(
                      child: TextField(
                        style: Theme.of(context).textTheme.titleSmall,
                        controller: _plannerGoal,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 6.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: const Color(0xFFFFEBEA)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/images/subjectfielicon.png",
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  " Planner Goal ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(
                                        const TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xFFFF6F67)),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Enter here.',
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
                    const SizedBox(height: 25),
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
                                  helpText: "Select Data",
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(3050),
                                  selectableDayPredicate: (day) =>
                                      day.weekday == 7 || day.weekday == 7
                                          ? false
                                          : true,
                                );

                                if (fromDate != null) {
                                  setState(() {
                                    _startDate.text =
                                        "${numberList[fromDate!.day]}-${numberList[fromDate!.month]}-${fromDate!.year}";
                                    DateTime dt =
                                        fromDate!.add(const Duration(days: 5));
                                    _endDate.text =
                                        "${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}";
                                    isPlan = true;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    fromDate = await showDatePicker(
                                      helpText: "Select Data",
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(3050),
                                      selectableDayPredicate: (day) =>
                                          day.weekday == 7 || day.weekday == 7
                                              ? false
                                              : true,
                                    );

                                    if (fromDate != null) {
                                      setState(() {
                                        _startDate.text =
                                            "${numberList[fromDate!.day]}-${numberList[fromDate!.month]}-${fromDate!.year}";
                                        DateTime dt = fromDate!
                                            .add(const Duration(days: 5));
                                        _endDate.text =
                                            "${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}";
                                        isPlan = true;
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
                                    helpText: "Select Date",
                                    initialDate:
                                        DateTime(int.parse(_endDate.text)),
                                    firstDate:
                                        DateTime(int.parse(_endDate.text)),
                                    lastDate: DateTime(3050),
                                    selectableDayPredicate: (day) =>
                                        day.weekday == 7 || day.weekday == 7
                                            ? false
                                            : true,
                                  );
                                  if (toDate != null) {
                                    setState(() {
                                      _endDate.text =
                                          "${numberList[toDate!.day]}-${numberList[toDate!.month]}-${toDate!.year}";
                                      isPlan = true;
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please Select Start Date");
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
                                        helpText: "Select Date",
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(3050),
                                        selectableDayPredicate: (day) =>
                                            day.weekday == 7 || day.weekday == 7
                                                ? false
                                                : true,
                                      );
                                      if (toDate != null) {
                                        setState(() {
                                          _endDate.text =
                                              "${numberList[toDate!.day]}-${numberList[toDate!.month]}-${toDate!.year}";
                                          isPlan = true;
                                        });
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
                      ],
                    ),
                  ],
                ),
              ),
            )),
          ),
          const SizedBox(height: 16),
          Text(
            "Planner Details",
            style: Get.textTheme.titleSmall!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          (isPlan != true)
              ? const SizedBox()
              : CustomContainer(
                  child: Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Total Task: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: '25 ',
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      const SizedBox(height: 6),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Total Working Days: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: '7 ',
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      const SizedBox(height: 6),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Minimum Effort Required: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: '25 ',
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      const SizedBox(height: 6),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'planned Effort: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: '25 Hrs ',
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      const SizedBox(height: 6),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Total Effort: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: '25 ',
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                    ],
                  ),
                )),
          (isPlan != true) ? const SizedBox() : const SizedBox(height: 16),
          (isPlan != true) ? const SizedBox() : _createTable(),
          (isPlan != true)
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MSkollBtn(
                      title: "Save",
                      onPress: () {},
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  _createTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DataTable(
          showCheckboxColumn: true,
          headingRowColor:
              MaterialStatePropertyAll(Theme.of(context).primaryColor),
          dataTextStyle: const TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(0, 0, 0, 0.95),
              fontWeight: FontWeight.w500),
          dataRowHeight: MediaQuery.of(context).size.height * 0.23,
          headingRowHeight: MediaQuery.of(context).size.height * 0.08,
          horizontalMargin: 10,
          columnSpacing: MediaQuery.of(context).size.width * 0.08,
          dividerThickness: 1,
          headingTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          border: TableBorder.all(
              borderRadius: BorderRadius.circular(10), width: 0.5),
          columns: [
            const DataColumn(
              numeric: true,
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'S.No',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            DataColumn(
              numeric: true,
              label: Align(
                alignment: Alignment.center,
                child: Checkbox(
                  checkColor: Colors.indigo,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  value: selectAll,
                  onChanged: (newValue) {
                    setState(() {
                      selectAll = newValue!;
                      if (selectAll) {
                        for (var i = 0; i < newTable.length; i++) {
                          checkList.add(i);
                          setState(() {
                            newTable.elementAt(i).flag = true;
                          });
                        }
                      } else {
                        for (var i = 0; i < newTable.length; i++) {
                          checked = newTable[i].flag = false;
                        }
                        checkList.clear();
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Issue/Task',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Assigned By',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Date',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Effort(Hrs)',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const DataColumn(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Remarks',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
          rows: [
            ...List.generate(newTable.length, (index) {
              var i = index + 1;
              return DataRow(cells: [
                DataCell(Text(i.toString())),
                DataCell(
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Checkbox(
                        checkColor: Colors.indigo,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: newTable.elementAt(index).flag,
                        onChanged: (val) {
                          setState(() {
                            checked = newTable[index].flag = val!;
                            if (checkList.contains(index)) {
                              checkList.remove(index);
                              checked = newTable[index].flag = false;
                              if (newTable.length != checkList.length) {
                                selectAll = false;
                              }
                              setState(() {});
                            } else {
                              checkList.add(index);
                              if (newTable.length == checkList.length) {
                                selectAll = true;
                              }
                            }
                            setState(() {});
                          });
                        },
                      )),
                ),
                DataCell(Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newTable[index].taskNo,
                        style: Get.textTheme.bodySmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        newTable[index].taskName,
                        style: Get.textTheme.bodySmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Type Task: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: newTable[index].taskType,
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Clint: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: newTable[index].clint,
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Category: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: newTable[index].category,
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Periodicity: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: newTable[index].Periodicity,
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Assigned Date: ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text: newTable[index].assignedDate,
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                    ],
                  ),
                )),
                DataCell(Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(newTable[index].assignedBy),
                )),
                DataCell(Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(newTable[index].date),
                )),
                DataCell(Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(newTable[index].effort),
                )),
                DataCell(TextFormField(
                  onTap: () {
                    var checkTxt = checkList.contains(
                            newTable.indexOf(newTable.elementAt(index)))
                        ? false
                        : true;
                    if (checkTxt) {
                      Fluttertoast.showToast(msg: "Please select checkbox");
                    }
                  },
                  readOnly: checkList
                          .contains(newTable.indexOf(newTable.elementAt(index)))
                      ? false
                      : true,
                  style: Get.textTheme.titleSmall,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 4, right: 4),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  // controller: widget.remarkEntryController
                )),
              ]);
            })
          ],
        ),
      ),
    );
  }
}
