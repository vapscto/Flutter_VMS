import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/model/tada_balance_table.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/widgets/applied_list_widget.dart';

class TadaBalanceWidget extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const TadaBalanceWidget(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<TadaBalanceWidget> createState() => _TadaBalanceWidgetState();
}

class _TadaBalanceWidgetState extends State<TadaBalanceWidget> {
  List<TadaBalanceTable> newWidget = [];
  @override
  void initState() {
    newWidget.add(TadaBalanceTable(
        "Kolkata", "15000", "15000", "14000", "10-10-2023", '15-10-2023'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Note:",
                style: Get.textTheme.titleMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "* TA-DA Should Applied Only Below 30 Days",
                style: Get.textTheme.titleSmall!
                    .copyWith(color: Colors.red, fontSize: 10),
              ),
              Text(
                "*  When Daily Report Not Generate Ta Da Not Avalible For apply",
                style: Get.textTheme.titleSmall!
                    .copyWith(color: Colors.red, fontSize: 10),
              ),
              Text(
                "* Old Balance Not Clear Ta Da Not Avalible For apply",
                style: Get.textTheme.titleSmall!
                    .copyWith(color: Colors.red, fontSize: 10),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: DataTable(
                dataRowHeight: 35,
                headingRowHeight: 45,
                columnSpacing: 20,
                headingTextStyle: const TextStyle(color: Colors.white),
                border: TableBorder.all(
                  color: Colors.black,
                  width: 0.6,
                  borderRadius: BorderRadius.circular(5),
                ),
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).primaryColor),
                columns: const [
                  DataColumn(label: Text("SL.NO.")),
                  DataColumn(label: Text("City")),
                  DataColumn(label: Text("Total Applied Amount")),
                  DataColumn(label: Text("Total Sactioned Amount")),
                  DataColumn(label: Text("Total Paid Amount")),
                  DataColumn(label: Text("From Date")),
                  DataColumn(label: Text("To Date")),
                  DataColumn(label: Text("Action")),
                  DataColumn(label: Text("View")),
                ],
                rows: List.generate(newWidget.length, (index) {
                  var value = index + 1;
                  // if (tadaController.tadaData[index].vTADAAAAppliedDate !=
                  //     null) {
                  //   DateTime dt = DateTime.parse(
                  //       tadaController.tadaData[index].vTADAAAAppliedDate!);
                  //   date = '${dt.day}-${dt.month}-${dt.year}';
                  // }

                  return DataRow(cells: [
                    DataCell(Text(value.toString())),
                    DataCell(Text(newWidget[index].city)),
                    DataCell(Text(newWidget[index].appliedAmount)),
                    DataCell(Text(newWidget[index].sanctionedAmount)),
                    DataCell(Text(newWidget[index].paidAmount)),
                    DataCell(Text(newWidget[index].fromDate)),
                    DataCell(Text(newWidget[index].toDate)),
                    DataCell(IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_upward,
                          color: Theme.of(context).primaryColor,
                        ))),
                    DataCell(IconButton(
                        onPressed: () {
                          Get.dialog(const AppliedListWidget());
                        },
                        icon: const Icon(Icons.visibility))),
                  ]);
                })),
          ),
        ),
      ],
    );
  }
}
