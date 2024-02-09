import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/api/get_planner_details_api.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/utils/save_btn.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class DrnotsentScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final PlannerDetails plannerDetailsController;
  DrnotsentScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.plannerDetailsController});

  @override
  State<DrnotsentScreen> createState() => _DrnotsentScreenState();
}

class _DrnotsentScreenState extends State<DrnotsentScreen> {
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    if (widget.plannerDetailsController.etRemark.isNotEmpty) {
      widget.plannerDetailsController.etRemark.clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Text(
            "DAILY REPORT NOT SENT DATES",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .merge(TextStyle(color: Theme.of(context).primaryColor)),
          ),
          Obx(
            () => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Form(
                    key: _key,
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: DataTable(
                                  dataTextStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(0, 0, 0, 0.95),
                                      fontWeight: FontWeight.w500),
                                  dataRowHeight: 100,
                                  headingRowHeight: 40,
                                  horizontalMargin: 10,
                                  columnSpacing: 30,
                                  dividerThickness: 1,
                                  headingTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  border: TableBorder.all(
                                      borderRadius: BorderRadius.circular(10),
                                      width: 0.5),
                                  headingRowColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  columns: const [
                                    // 1
                                    DataColumn(
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
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'DR Not Sent Date',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Remarks',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                      widget
                                          .plannerDetailsController
                                          .drnotSentdetailsList
                                          .length, (index) {
                                    int i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(getDate(DateTime.parse(
                                              widget.plannerDetailsController
                                                  .drnotSentdetailsList
                                                  .elementAt(index)
                                                  .fromDate!))))),
                                      DataCell(Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter Remarks';
                                              }
                                              return null;
                                            },
                                            maxLines: 3,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                            controller: widget
                                                .plannerDetailsController
                                                .etRemark
                                                .elementAt(index),
                                            decoration: InputDecoration(
                                                hintText: "Enter Remark",
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                                border:
                                                    const OutlineInputBorder(),
                                                errorBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.red))),
                                          ),
                                        ),
                                      )),
                                    ]);
                                  }),
                                )),
                          ],
                        )))),
          ),
          // need to integrate api  holded beacuse of need create sencriao  test
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BtnSave(
                  title: 'Cancel',
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                ),
                MSkollBtn(
                  title: "Save",
                  onPress: () async {
                    if (_key.currentState!.validate()) {
                      for (int i = 0;
                          i <
                              widget.plannerDetailsController
                                  .drnotSentdetailsList.length;
                          i++) {
                        drList.add({
                          "drnotsentdate": widget
                              .plannerDetailsController.drnotSentdetailsList
                              .elementAt(i)
                              .fromDate,
                          "remarks": widget.plannerDetailsController.etRemark
                              .elementAt(i)
                              .text,
                          "Template": "DRNotSentRemarks"
                        });
                      }
                      await drNotSaveDAPI(
                              todayDate: dt.toIso8601String(),
                              base: baseUrlFromInsCode(
                                  'issuemanager', widget.mskoolController),
                              controller: widget.plannerDetailsController,
                              drList: drList,
                              miId: widget.loginSuccessModel.mIID!,
                              userId: widget.loginSuccessModel.userId!)
                          .then((value) {
                        if (value!) {
                          Fluttertoast.showToast(msg: "Remark Captured");
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Map<String, dynamic>> drList = [];

  DateTime dt = DateTime.now();
}
