import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/extension/controller/extension_controller.dart';

class DrExtensionTab extends StatefulWidget {
  final ExtensionController controller;
  const DrExtensionTab({super.key, required this.controller});

  @override
  State<DrExtensionTab> createState() => _DrExtensionTabState();
}

class _DrExtensionTabState extends State<DrExtensionTab> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (widget.controller.extensionDrList.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              children: [
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                      dataRowHeight: MediaQuery.of(context).size.height * 0.1,
                      // horizontalMargin: 10,
                      dividerThickness: 1,
                      headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(10), width: 0.5),
                      columns: const [
                        DataColumn(
                          label: Text('S.No'),
                        ),
                        DataColumn(
                          label: Text("Employee"),
                        ),
                        DataColumn(
                          label: Text('Emp.Code'),
                        ),
                        DataColumn(
                          label: Text('month'),
                        ),
                        DataColumn(
                          label: Text('No of Days'),
                        ),
                        DataColumn(label: Text('Extension Date')),
                        DataColumn(
                          label: Text('Reason'),
                        ),
                        DataColumn(
                          label: Text('Given By'),
                        ),
                      ],
                      rows: [
                        ...List.generate(
                            widget.controller.extensionDrList.length, (index) {
                          var i = index + 1;
                          var val = widget.controller.extensionDrList
                              .elementAt(index);

                          return DataRow(cells: [
                            DataCell(Text(i.toString())),
                            DataCell(Text(
                              val.employeename!,
                            )),
                            DataCell(Text(val.hrmEEmployeeCode!)),
                            DataCell(Text(val.ivrMMonthName!)),
                            DataCell(Text(val.ismodENoofdays.toString())),
                            DataCell(Text(
                                getDateFrom(DateTime.parse(val.ismodEDate!)))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text('${val.ismodEReason}'))),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text('${val.bymployeename}'))),
                          ]);
                        }),
                      ],
                    ),
                  ),
                )
              ],
            );
    });
  }

  String getDateFrom(DateTime? dt) {
    return "${dt!.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
  }
}
