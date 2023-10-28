import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/api/marks_entry_related_api.dart';
import 'package:m_skool_flutter/staffs/marks_entry/controller/marks_entry_related_controller.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/save_button.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class MarksEntryDetailScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int asmsId;
  final int asmclId;
  final int asmayId;
  final int emeId;
  final int ismsId;
  final int emssId;

  final int emseId;

  const MarksEntryDetailScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.asmsId,
    required this.asmclId,
    required this.asmayId,
    required this.emeId,
    required this.ismsId,
    required this.emssId,
    required this.emseId,
  });

  @override
  State<MarksEntryDetailScreen> createState() => _MarksEntryDetailScreenState();
}

class _MarksEntryDetailScreenState extends State<MarksEntryDetailScreen> {
  final MarksEntryController marksEntryController =
      Get.find<MarksEntryController>();
  bool restrictChanges = false;
  List<Map<String, dynamic>> detailsList = [];
  bool selectAll = false;
  bool checked = false;
  List<int> checkList = [];
  void getMarksDataTable() async {
    marksEntryController.istableloading(true);
    await marksEntryController.getMarksEntrytabledetail(
      userId: widget.loginSuccessModel.userId!,
      miId: widget.loginSuccessModel.mIID!,
      roleId: widget.loginSuccessModel.roleId!,
      asmsId: widget.asmsId,
      asmclId: widget.asmclId,
      asmayId: widget.asmayId,
      emeId: widget.emeId,
      ismsId: widget.ismsId,
      base: baseUrlFromInsCode(
        'exam',
        widget.mskoolController,
      ),
      emseId: widget.emseId,
      emssId: widget.emssId,
    );

    marksEntryController.istableloading(false);
  }

  void saveDetails() async {
    detailsList.clear();

    if (marksEntryController.subMorGFlag.value.toLowerCase() == 'm') {
      for (var i = 0;
          i < marksEntryController.textEditingControllerList.length;
          i++) {
        // if(marksEntryController.textEditingControllerList.elementAt(i).text.length>4){
        //    Fluttertoast.showToast(
        // msg:
        //     'Please provide a valid entry at ${marksEntryController.marksEntryDataTableList.first.marksEnterFor} for S.NO ${i + 1}');
        // }else{
        // }

        //     if(marksEntryController.textEditingControllerList
        //         .elementAt(i)
        //         .text)

        if (marksEntryController.textEditingControllerList
            .elementAt(i)
            .text
            .isNum) {
          if (double.parse(marksEntryController.textEditingControllerList
                  .elementAt(i)
                  .text) >
              double.parse(marksEntryController
                  .marksEntryDataTableList.first.marksEnterFor!
                  .toString())) {
            Fluttertoast.showToast(
              msg:
                  'Entered Marks is greater than ${marksEntryController.marksEntryDataTableList.first.marksEnterFor} for S.NO ${i + 1}',
            );
            return;
          }
        } else {}
      }
    } else {
      for (var i = 0;
          i < marksEntryController.textEditingControllerList.length;
          i++) {
        if (marksEntryController.textEditingControllerList
                .elementAt(i)
                .text
                .length
                .isGreaterThan(4) ||
            marksEntryController.textEditingControllerList
                .elementAt(i)
                .text
                .isNum) {
          Fluttertoast.showToast(
            msg: 'Entered Grade is not valid for S.NO ${i + 1}',
          );
          return;
        }
      }
    }
    for (var i = 0; i < checkList.length; i++) {
      print("${i}+${checkList.elementAt(i)}");
      detailsList.add({
        "amsT_Id": marksEntryController.marksEntryDataTableList
            .elementAt(checkList[i])
            .amsTId,
        "estM_Id": marksEntryController.marksEntryDataTableList
            .elementAt(checkList[i])
            .estMId,
        "obtainmarks":
            marksEntryController.subMorGFlag.toLowerCase() == 'm' //value.
                ? marksEntryController.textEditingControllerList
                        .elementAt(checkList[i])
                        .text
                        .isNum
                    ? double.parse(
                        marksEntryController.textEditingControllerList
                            .elementAt(checkList[i])
                            .text,
                      )
                    : marksEntryController.textEditingControllerList
                        .elementAt(checkList[i])
                        .text
                : marksEntryController.textEditingControllerList
                    .elementAt(checkList[i])
                    .text,
      });
    }
    marksEntryController.issaveloading(true);
    await saveMarksEntryDetails(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.asmayId,
      asmclId: widget.asmclId,
      asmsId: widget.asmsId,
      amstId: widget.loginSuccessModel.amsTId!,
      emeId: widget.emeId,
      ismsId: widget.ismsId,
      userId: widget.loginSuccessModel.userId!,
      detailsList: detailsList,
      base: baseUrlFromInsCode(
        'exam',
        widget.mskoolController,
      ),
      emseId: widget.emseId,
      emssId: widget.emssId,
    ).then((value) {
      if (value) {
        Fluttertoast.showToast(
          msg: 'Marks Save Successfully',
        );
        if (value) {
          Get.back();
        }
        return;
      }
      Fluttertoast.showToast(
        msg: 'Something went wrong',
      );
    });
    marksEntryController.issaveloading(false);
  }

  @override
  void initState() {
    getMarksDataTable();

    super.initState();
  }

  @override
  void dispose() {
    if (marksEntryController.marksEntryDataTableList.isNotEmpty) {
      marksEntryController.marksEntryDataTableList.clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 25,
        title: const Text('Marks Entry'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Obx(
              () => marksEntryController.isTable.value
                  ? const SizedBox()
                  : SaveBtn(
                      title: marksEntryController.updateButton.value > 0
                          ? 'Update'
                          : 'Save',
                      onPress: () {
                        logger.d(detailsList);
                        if (checked || selectAll) {
                          saveDetails();
                        } else {
                          //  Fluttertoast.showToast(msg: "Please select checkbox");
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: const HomeFab(),
      //  StaffHomeFab(
      //   loginSuccessModel: widget.loginSuccessModel,
      //   mskoolController: widget.mskoolController,
      // ),
      body: Obx(
        () => marksEntryController.isTable.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Marks Entry",
                    desc:
                        "Please wait while we load marks entry detail table and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : (marksEntryController.marksEntryDataTableList.isEmpty)
                ? const Center(
                    child: AnimatedProgressWidget(
                      title: "No Data Found",
                      desc: "This Subject is not Mapped with Students.",
                      animationPath: "assets/json/nodata.json",
                      animatorHeight: 250,
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: marksEntryController
                                      .subMorGFlag.value
                                      .toLowerCase() ==
                                  "g"
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            marksEntryController.subMorGFlag.value
                                        .toLowerCase() ==
                                    "m"
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFDFD6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 160,
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Maximum Marks : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(
                                                const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Color(0xffF24E1E),
                                                ),
                                              ),
                                        ),
                                        Text(
                                          marksEntryController
                                              .marksEntryDataTableList
                                              .first
                                              .marksEnterFor
                                              .toString()
                                              .split(".")
                                              .first,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(
                                                const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Color(0xffE13C3C),
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFDFD6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 160,
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    marksEntryController.subMorGFlag.value
                                                .toLowerCase() ==
                                            "g"
                                        ? 'Grading Sytem'
                                        : 'Number System',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(
                                          const TextStyle(
                                            fontSize: 14.0,
                                            color: Color(0xffF24E1E),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: DataTable(
                                dataTextStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(0, 0, 0, 0.95),
                                    fontWeight: FontWeight.w500),
                                dataRowHeight: 45,
                                headingRowHeight: 40,
                                horizontalMargin: 10,
                                columnSpacing: 40,
                                dividerThickness: 1,
                                headingTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                                border: TableBorder.all(
                                    borderRadius: BorderRadius.circular(10),
                                    width: 0.5),
                                headingRowColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                                columns: [
                                  DataColumn(
                                    numeric: true,
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Checkbox(
                                        checkColor: Colors.indigo,
                                        shape: ContinuousRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        value: selectAll,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectAll = newValue!;
                                            if (selectAll) {
                                              for (var i = 0;
                                                  i <
                                                      marksEntryController
                                                          .marksEntryDataTableList
                                                          .length;
                                                  i++) {
                                                checkList.add(i);
                                              }
                                              // print(detailsList.toString());
                                            } else {
                                              checkList.clear();
                                              //print(detailsList.toString());
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
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
                                  const DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Name',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Adm.No',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        marksEntryController.subMorGFlag.value
                                                    .toLowerCase() ==
                                                "m"
                                            ? 'Enter Marks'
                                            : 'Enter Grade',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            overflow: TextOverflow.clip),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                    marksEntryController.marksEntryDataTableList
                                        .length, (index) {
                                  var i = index + 1;
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Checkbox(
                                              checkColor: Colors.indigo,
                                              shape: ContinuousRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              value: selectAll ||
                                                  marksEntryController
                                                      .marksEntryDataTableList
                                                      .elementAt(index)
                                                      .estMActiveFlg!,
                                              onChanged: (val) {
                                                setState(() {
                                                  checked = marksEntryController
                                                      .marksEntryDataTableList[
                                                          index]
                                                      .estMActiveFlg = val!;
                                                  if (checkList
                                                      .contains(index)) {
                                                    checkList.remove(index);
                                                    // print(checkList);
                                                  } else {
                                                    checkList.add(index);
                                                    //print(checkList);
                                                  }

                                                  //print(detailsList.toList().toString());
                                                });
                                              },
                                            )),
                                      ),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(marksEntryController
                                              .marksEntryDataTableList
                                              .elementAt(index)
                                              .studentname
                                              .toString()),
                                        ),
                                      ),
                                      DataCell(
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            marksEntryController
                                                .marksEntryDataTableList
                                                .elementAt(index)
                                                .amsTAdmNo
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: TextField(
                                              onTap: () {
                                                var checkTxt = checkList.contains(
                                                        marksEntryController
                                                            .marksEntryDataTableList
                                                            .indexOf(
                                                                marksEntryController
                                                                    .marksEntryDataTableList
                                                                    .elementAt(
                                                                        index)))
                                                    ? false
                                                    : true;
                                                if (checkTxt) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please select checkbox");
                                                }
                                              },
                                              readOnly: checkList.contains(
                                                      marksEntryController
                                                          .marksEntryDataTableList
                                                          .indexOf(
                                                              marksEntryController
                                                                  .marksEntryDataTableList
                                                                  .elementAt(
                                                                      index)))
                                                  ? false
                                                  : true,
                                              controller: marksEntryController
                                                  .textEditingControllerList
                                                  .elementAt(index),
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 128.0,
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
