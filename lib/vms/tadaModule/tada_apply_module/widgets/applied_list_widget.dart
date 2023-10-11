import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/model/tada_approved_list_table.dart';

class AppliedListWidget extends StatefulWidget {
  const AppliedListWidget({super.key});

  @override
  State<AppliedListWidget> createState() => _AppliedListWidgetState();
}

class _AppliedListWidgetState extends State<AppliedListWidget> {
  List<TadaApprovedModel> newWidget = [];
  @override
  void initState() {
    newWidget.add(TadaApprovedModel(
        "Food", "10-10-2023", 15000, 15000, '10-10-2023', '', 'Approved'));
    newWidget.add(TadaApprovedModel("Accommodation", "10-10-2023", 15000, 15000,
        '10-10-2023', '', 'Approved'));
    newWidget.add(TadaApprovedModel(
        "Other", "10-10-2023", 15000, 15000, '10-10-2023', '', 'Approved'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        "TADA Advance Authurization details",
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Close",
                            style: Get.textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Text(
                  "Leavel  Approved by - VAPSACCOUNTANT",
                  style: Get.textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DataTable(
                        dataRowHeight: 35,
                        headingRowHeight: 45,
                        columnSpacing: 20,
                        headingTextStyle: const TextStyle(color: Colors.white),
                        border: TableBorder.all(
                          color: Colors.black,
                          width: 0.6,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColor),
                        columns: const [
                          DataColumn(label: Text("SL.NO.")),
                          DataColumn(label: Text("Expenditure Head")),
                          DataColumn(label: Text("Applied Date")),
                          DataColumn(label: Text("Applied Amount")),
                          DataColumn(label: Text("Approved Amount")),
                          DataColumn(label: Text("Approve Date")),
                          DataColumn(label: Text("Remark")),
                          DataColumn(label: Text("ExpenditureHead Status")),
                        ],
                        rows: List.generate(newWidget.length, (index) {
                          var value = index + 1;
                          // if (tadaController
                          //         .tadaData[index].vTADAAAAppliedDate !=
                          //     null) {
                          //   DateTime dt = DateTime.parse(tadaController
                          //       .tadaData[index].vTADAAAAppliedDate!);
                          //   date = '${dt.day}-${dt.month}-${dt.year}';
                          // }

                          return DataRow(cells: [
                            DataCell(Text(value.toString())),
                            DataCell(Text(newWidget[index].expenditureHead)),
                            DataCell(Text(newWidget[index].appliedDate)),
                            DataCell(Text(
                                newWidget[index].appliedAmount.toString())),
                            DataCell(Text(
                                newWidget[index].approvedAmount.toString())),
                            DataCell(Text(newWidget[index].approvedDate)),
                            DataCell(Text(newWidget[index].remarks.toString())),
                            DataCell(Text(newWidget[index].status)),
                          ]);
                        })),
                  ),
                ),
                Text(
                  "Leavel Approved by - SIDDESH",
                  style: Get.textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DataTable(
                        dataRowHeight: 35,
                        headingRowHeight: 45,
                        columnSpacing: 20,
                        headingTextStyle: const TextStyle(color: Colors.white),
                        border: TableBorder.all(
                          color: Colors.black,
                          width: 0.6,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColor),
                        columns: const [
                          DataColumn(label: Text("SL.NO.")),
                          DataColumn(label: Text("Expenditure Head")),
                          DataColumn(label: Text("Applied Date")),
                          DataColumn(label: Text("Applied Amount")),
                          DataColumn(label: Text("Approved Amount")),
                          DataColumn(label: Text("Approve Date")),
                          DataColumn(label: Text("Remark")),
                          DataColumn(label: Text("ExpenditureHead Status")),
                        ],
                        rows: List.generate(newWidget.length, (index) {
                          var value = index + 1;
                          // if (tadaController
                          //         .tadaData[index].vTADAAAAppliedDate !=
                          //     null) {
                          //   DateTime dt = DateTime.parse(tadaController
                          //       .tadaData[index].vTADAAAAppliedDate!);
                          //   date = '${dt.day}-${dt.month}-${dt.year}';
                          // }

                          return DataRow(cells: [
                            DataCell(Text(value.toString())),
                            DataCell(Text(newWidget[index].expenditureHead)),
                            DataCell(Text(newWidget[index].appliedDate)),
                            DataCell(Text(
                                newWidget[index].appliedAmount.toString())),
                            DataCell(Text(
                                newWidget[index].approvedAmount.toString())),
                            DataCell(Text(newWidget[index].approvedDate)),
                            DataCell(Text(newWidget[index].remarks.toString())),
                            DataCell(Text(newWidget[index].status)),
                          ]);
                        })),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
