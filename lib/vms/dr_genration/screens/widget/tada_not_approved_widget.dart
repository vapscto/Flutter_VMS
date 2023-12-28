import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/tada_not_approve_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/screens/tada_approval_home.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class TADANotApproveScreen extends StatelessWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final RxList<TADAApplyListModelValues> data;
  const TADANotApproveScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "TA-DA  List",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              )
            ],
          ),
          Obx(
            () => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: SingleChildScrollView(
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
                                DateTime dt = DateTime.parse(
                                    data.elementAt(index).vTADAAAppliedDate!);
                                var appliedDate =
                                    '${dt.day}-${dt.month}-${dt.year}';
                                DateTime dt1 = DateTime.parse(
                                    data.elementAt(index).vTADAAFromDate!);
                                var fromDate =
                                    '${dt1.day}-${dt1.month}-${dt1.year}';
                                DateTime dt2 = DateTime.parse(
                                    data.elementAt(index).vTADAAToDate!);
                                var toDate =
                                    '${dt2.day}-${dt2.month}-${dt2.year}';
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
                                      child: Text(appliedDate))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(fromDate))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(data
                                          .elementAt(index)
                                          .vTADAADepartureTime!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(toDate))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(data
                                          .elementAt(index)
                                          .vTADAAArrivalTime!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(data
                                          .elementAt(index)
                                          .vTADAATotalAppliedAmount
                                          .toString()))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          data.elementAt(index).iVRMMSName!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          data.elementAt(index).iVRMMCTName!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(data
                                          .elementAt(index)
                                          .vTADAAToAddress!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          data.elementAt(index).vTADAARemarks ??
                                              ''))),
                                ]);
                              }),
                            ))))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: MSkollBtn(
                title: "TA-DA Approval",
                onPress: () {
                  Get.back();
                  Get.to(() => TadaApproveHomeScreen(
                        mskoolController: mskoolController,
                        loginSuccessModel: loginSuccessModel,
                      ));
                }),
          )
        ],
      ),
    );
  }
}
