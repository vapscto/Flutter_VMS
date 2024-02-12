import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
// import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/advance_tada_applied.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/screens/tada_show_screen.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class TADAAdvancenotApproveScreen extends StatelessWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final RxList<AdvanceApplyModelValues> data;
  const TADAAdvancenotApproveScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Obx(
            () => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "TA-DA ADAVANCE LIST",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                )
                              ],
                            ),
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
                                  dataRowHeight: 50,
                                  headingRowHeight: 40,
                                  horizontalMargin: 10,
                                  columnSpacing: 30,
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
                                    // 1
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
                                          'Employee Name',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Applied Date',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'From Date',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Departure Time',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'To Date',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Arrival Time',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Applied Amount',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'State',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'City',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Address',
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Remarks',
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(data.length, (index) {
                                    int i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              data.elementAt(index).empName!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .vTADAAAAppliedDate!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .vTADAAAFromDate!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .vTADAAADepartureTime!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .vTADAAAToDate!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .vTADAAAArrivalTime!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .vTADAAATotalAppliedAmount
                                              .toString()))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .iVRMMSName!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .iVRMMCTName!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                              .elementAt(index)
                                              .vTADAAAToAddress!))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(data
                                                  .elementAt(index)
                                                  .vTADAAARemarks ??
                                              ''))),
                                    ]);
                                  }),
                                )),
                            const SizedBox(height: 16),
                            MSkollBtn(
                                title: "Advance Approval",
                                onPress: () {
                                  Get.back();
                                  Get.to(() => TadaAdvanceApproveScreen(
                                        mskoolController: mskoolController,
                                        loginSuccessModel: loginSuccessModel,
                                      ));
                                })
                          ],
                        )))),
          ),
        ],
      ),
    );
  }
}
