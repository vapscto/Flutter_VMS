import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';

class DrnotApprovedScreen extends StatelessWidget {
  DrnotApprovedScreen({super.key});
  final PlannerDetails _plannerDetailsController = Get.put(PlannerDetails());

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
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "DAILY REPORT NOT APPROVED DETAILS",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
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
                                      'Employee Name',
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
                                      'Employee Code',
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
                                      'DR Date',
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
                                      'DR Generated Date Time',
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
                                      'Others Date Flag',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                  _plannerDetailsController
                                      .drnotapprovedList.length, (index) {
                                int i = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(_plannerDetailsController
                                          .drnotapprovedList
                                          .elementAt(index)
                                          .employeeName!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(_plannerDetailsController
                                          .drnotapprovedList
                                          .elementAt(index)
                                          .hRMEEmployeeCode!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(_plannerDetailsController
                                          .drnotapprovedList
                                          .elementAt(index)
                                          .drDate!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(_plannerDetailsController
                                          .drnotapprovedList
                                          .elementAt(index)
                                          .dRGDate!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: _plannerDetailsController
                                              .drnotapprovedList
                                              .elementAt(index)
                                              .iSMDRPTOrdersDateFlg!
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ))),
                                ]);
                              }),
                            ))),
                  ],
                ))),
          ),
        ],
      ),
    );
  }
}
