import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/widgets/planner_table_widget.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class AllPlanners extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const AllPlanners(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<AllPlanners> createState() => _AllPlannersState();
}

class _AllPlannersState extends State<AllPlanners> {
  List radioList = ['Detailed View', 'Combined View'];
  String groupValue = 'Detailed View';
  bool selectAll = false;
  List<int> checkList = [];
  bool checked = false;
  //
  List<dynamic> headerDropDownList = ['Approve All', 'Reject All'];
  String headerGroupValue = 'Approve All';
  //
  List<dynamic> dataRowDropDownList = ['Approve', 'Reject'];
  String dataRowGroupValue = 'Approve';

  //
  RxList<String> rowStatus = <String>[].obs;
  void getStatus(List<String> status) {
    rowStatus.addAll(status);
  }

  //remarks
  RxList<TextEditingController> remarksController =
      <TextEditingController>[].obs;
  void addRemarks(TextEditingController remarks) {
    remarksController.add(TextEditingController(text: remarks.toString()));
  }

  //effort
  RxList<TextEditingController> effortController =
      <TextEditingController>[].obs;
  void addEffort(TextEditingController effort) {
    effortController.add(TextEditingController(text: effort.toString()));
  }

  //
  List<AllPlannerTable> allPlannerList = <AllPlannerTable>[];
//
  late List<DropdownMenuItem<dynamic>> dropdownMenuItems;
  late List<DropdownMenuItem<dynamic>> dataRowdropdownMenuItems;
  final _remarkController = TextEditingController();
  @override
  void initState() {
    dropdownMenuItems = headerDropDownList.map((dynamic item) {
      return DropdownMenuItem<dynamic>(
        value: item,
        child: Text(item),
      );
    }).toList();
    allPlannerList.add(AllPlannerTable(
        false,
        'TASK/87935/2023-2024',
        'testing',
        'major',
        'Ho',
        'New Module Development - Enhancements',
        'Daily',
        ' 23-10-2023 To 23-10-2023',
        '19-10-2023 - 4:06PM',
        '9:0 Hr',
        '',
        0,
        'MS Adarsh'));
    allPlannerList.add(AllPlannerTable(
        false,
        'TASK/87935/2023-2024',
        'testing',
        'major',
        'Ho',
        'New Module Development - Enhancements',
        'Daily',
        ' 23-10-2023 To 23-10-2023',
        '19-10-2023 - 4:06PM',
        '9:0 Hr',
        '',
        0,
        'MS Adarsh'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Planner Approval', action: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: BtnSave(
              title: 'Save',
              onPress: () {
                if (_remarkController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please Enter Planner Remarks");
                } else {}
              },
            ),
          ),
        )
      ]).getAppBar(),
      body: Obx(() {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: List.generate(radioList.length, (index) {
                    return Expanded(
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor:
                                Theme.of(context).primaryColor),
                        child: RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            activeColor: Theme.of(context).primaryColor,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: 0),
                            title: Text(
                              radioList[index],
                              style: Get.textTheme.titleSmall!
                                  .copyWith(fontSize: 15),
                            ),
                            value: radioList[index],
                            groupValue: groupValue,
                            onChanged: (value) {
                              setState(() {
                                groupValue = value;
                              });
                            }),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: CustomContainer(
                child: TextFormField(
                  controller: _remarkController,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  style: Get.textTheme.titleSmall!.copyWith(fontSize: 15),
                  decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter Planner Remark",
                    label: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFFBFE),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/cap.png",
                            height: 28.0,
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "Planner Remark",
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
                                      const TextStyle(
                                          backgroundColor: Color(0xFFDFFBFE),
                                          fontSize: 20.0,
                                          color: Color(0xFF28B6C8)),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DataTable(
                  showCheckboxColumn: true,
                  headingRowColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  headingTextStyle: Get.textTheme.titleSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  dataTextStyle: Get.textTheme.titleSmall!,
                  dataRowHeight: MediaQuery.of(context).size.height * 0.23,
                  headingRowHeight: MediaQuery.of(context).size.height * 0.08,
                  horizontalMargin: 10,
                  columnSpacing: MediaQuery.of(context).size.width * 0.08,
                  dividerThickness: 1,
                  border: TableBorder.all(
                      borderRadius: BorderRadius.circular(10), width: 0.5),
                  columns: [
                    const DataColumn(
                        label: Text(
                      "Sl No.",
                      textAlign: TextAlign.center,
                    )),
                    DataColumn(
                        numeric: true,
                        label: Align(
                          alignment: Alignment.center,
                          child: Checkbox(
                              checkColor: Colors.indigo,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              value: selectAll,
                              onChanged: (value) {
                                setState(() {
                                  selectAll = value!;
                                  if (selectAll) {
                                    for (var i = 0;
                                        i < allPlannerList.length;
                                        i++) {
                                      checkList.add(i);
                                      setState(() {
                                        allPlannerList.elementAt(i).flag = true;
                                      });
                                    }
                                  } else {
                                    for (var i = 0;
                                        i < allPlannerList.length;
                                        i++) {
                                      checked = allPlannerList[i].flag = false;
                                    }
                                    checkList.clear();
                                    setState(() {});
                                  }
                                });
                              }),
                        )),
                    const DataColumn(
                        numeric: true,
                        label: Text(
                          "Issue/Task Details",
                          textAlign: TextAlign.center,
                        )),
                    DataColumn(
                        numeric: true,
                        label: Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: Center(
                            child: DropdownButton<dynamic>(
                              underline: Container(),
                              elevation: 0,
                              iconSize: 0,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                              dropdownColor: Colors.white,
                              value: headerGroupValue,
                              items: dropdownMenuItems,
                              style: Get.textTheme.titleSmall,
                              onChanged: (dynamic newValue) {
                                setState(() {
                                  headerGroupValue = newValue;
                                  if (headerGroupValue == 'Approve All') {
                                    dataRowGroupValue = 'Approve';
                                    getStatus(['Approve']);
                                  } else if (headerGroupValue == 'Reject All') {
                                    dataRowGroupValue = 'Reject';
                                    getStatus(['Reject']);
                                  }
                                });
                              },
                            ),
                          ),
                        )),
                    const DataColumn(
                        numeric: true,
                        label: Text(
                          "Effort",
                          textAlign: TextAlign.center,
                        )),
                    const DataColumn(
                        numeric: true,
                        label: Text(
                          "Remarks",
                        )),
                  ],
                  rows: List.generate(allPlannerList.length, (index) {
                    var v = index + 1;
                    dataRowdropdownMenuItems =
                        dataRowDropDownList.map((dynamic item) {
                      return DropdownMenuItem<dynamic>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList();
                    addEffort(TextEditingController(
                        text: allPlannerList[index].effort));
                    addRemarks(TextEditingController(
                        text: allPlannerList[index].remarks));
                    return DataRow(cells: [
                      DataCell(
                        Text(v.toString()),
                      ),
                      DataCell(Checkbox(
                          checkColor: Theme.of(context).primaryColor,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          value: allPlannerList.elementAt(index).flag,
                          onChanged: (value) {
                            setState(() {
                              checked =
                                  allPlannerList.elementAt(index).flag = value!;
                              if (checkList.contains(index)) {
                                checkList.remove(index);
                                checked = allPlannerList[index].flag = false;
                                if (allPlannerList.length != checkList.length) {
                                  selectAll = false;
                                }
                              } else {
                                checkList.add(index);
                                if (allPlannerList.length == checkList.length) {
                                  selectAll = true;
                                }
                              }
                            });
                          })),
                      DataCell(SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allPlannerList[index].taskNo,
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              allPlannerList[index].taskName,
                              maxLines: 2,
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Type Task: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color:
                                          (allPlannerList[index].ismtpltaId ==
                                                  0)
                                              ? Theme.of(context).primaryColor
                                              : Colors.red)),
                              TextSpan(
                                  text: allPlannerList[index].taskType,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Clint: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: allPlannerList[index].clint,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Category: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: allPlannerList[index].category,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Periodicity: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: allPlannerList[index].periodicity,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Assigned Date: ',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: allPlannerList[index].plannedDate,
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ])),
                          ],
                        ),
                      )),
                      DataCell((allPlannerList.elementAt(index).flag == true)
                          ? Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                child: DropdownButton<dynamic>(
                                  underline: Container(),
                                  elevation: 0,
                                  iconSize: 0,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  dropdownColor: Colors.white,
                                  value: dataRowGroupValue,
                                  items: dataRowdropdownMenuItems,
                                  style: Get.textTheme.titleSmall,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      dataRowGroupValue = newValue;
                                      getStatus([dataRowGroupValue]);
                                    });
                                  },
                                ),
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                  child: Text(
                                rowStatus.elementAt(index),
                                style: Get.textTheme.titleSmall,
                              )),
                            )),
                      DataCell((allPlannerList.elementAt(index).flag == true)
                          ? SizedBox(
                              height: 40,
                              child: TextFormField(
                                style: Get.textTheme.titleSmall,
                                keyboardType: TextInputType.number,
                                // controller: effortController.elementAt(index),
                                decoration: InputDecoration(
                                    hintText: 'Effort',
                                    hintStyle: Get.textTheme.titleSmall,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black))),
                              ),
                            )
                          : Text(allPlannerList[index].effort)),
                      DataCell(Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          style: Get.textTheme.titleSmall,
                          keyboardType: TextInputType.text,
                          maxLines: 2,
                          // controller: remarksController.elementAt(index),
                          decoration: InputDecoration(
                              hintText: 'Task Remarks',
                              hintStyle: Get.textTheme.titleSmall,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                        ),
                      )),
                    ]);
                  }),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
