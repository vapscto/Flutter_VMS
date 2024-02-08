import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/driver_indent/controller/driver_intent_controller.dart';
import 'package:m_skool_flutter/vms/driver_indent/model/indent_approved_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class DriverIndentList extends StatefulWidget {
  final DriverIndentController controller;
  const DriverIndentList({super.key, required this.controller});

  @override
  State<DriverIndentList> createState() => _DriverIndentListState();
}

class _DriverIndentListState extends State<DriverIndentList> {
  final searchController = TextEditingController();
  List<DriverIndentApprovedModelValues> filterList = [];
  filterFun(String query) {
    filterList = widget.controller.indentApprovedListData.where((list) {
      return list.trmVVehicleName!
          .trim()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    filterList = widget.controller.indentApprovedListData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Driver Indent Approval Details')
          .getAppBar(),
      body: filterList.isEmpty
          ? const SizedBox()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  style: Get.textTheme.titleSmall,
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      setState(() {
                        filterFun(searchController.text);
                      });
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      hintText: 'Search Vehicle name',
                      hintStyle: Get.textTheme.titleSmall!
                          .copyWith(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DataTable(
                        dataRowHeight:
                            MediaQuery.of(context).size.height * 0.15,
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
                        columns: createColumn(),
                        rows: List.generate(filterList.length, (index) {
                          var data = filterList.elementAt(index);
                          var i = index + 1;
                          return DataRow(cells: [
                            DataCell(Text(i.toString())),
                            DataCell(Text(
                                dateFormat(DateTime.parse(data.ismdiTDate!)))),
                            DataCell(Text(data.trmVVehicleName!)),
                            DataCell(Text(data.ismdiTQty.toString())),
                            DataCell(Text(data.ismdiTAmount.toString())),
                            DataCell(Text(data.ismdiTOpeningKM.toString())),
                            DataCell(Text(data.ismdiTClosingKM.toString())),
                            DataCell(SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(data.ismdiTRemarks ?? ''))),
                            DataCell(Text(data.ismdiTStatus.toString())),
                          ]);
                        })),
                  ),
                ),
              ],
            ),
    );
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }

  List<DataColumn> createColumn() {
    return const [
      DataColumn(label: Text("SL.NO.")),
      DataColumn(label: Text("Date")),
      DataColumn(label: Text("Vehicle Name")),
      DataColumn(label: Text("Fuel Quantity")),
      DataColumn(label: Text("Amount")),
      DataColumn(label: Text("Opening KM")),
      DataColumn(label: Text("Closing KM")),
      DataColumn(label: Text("Remarks")),
      DataColumn(label: Text("Status")),
    ];
  }
}
