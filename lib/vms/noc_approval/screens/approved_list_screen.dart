import 'package:flutter/material.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/approved_list_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ApprovedListScreen extends StatelessWidget {
  final List<NocApprovedListModelValues> data;
  const ApprovedListScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Approved Details').getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                dataRowHeight: 45,
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
                rows: List.generate(data.length, (index) {
                  var i = index + 1;
                  var v = data.elementAt(index);
                  return DataRow(cells: [
                    DataCell(Text(i.toString())),
                    DataCell(Text(v.hrmEEmployeeFirstName.toString())),
                    DataCell(Text(
                      v.ismcertreqapPAppRejFlag.toString(),
                      style: TextStyle(
                          color: (v.ismcertreqapPAppRejFlag == "Approved")
                              ? Colors.green
                              : Colors.red),
                    )),
                    DataCell(Text(dateFormat(
                            DateTime.parse(v.ismcertreqapPApprovedDate ?? ''))
                        .toString())),
                    DataCell(Text(v.ismcertreqapPRemarks.toString())),
                  ]);
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DataColumn> createColumn() {
    return const [
      DataColumn(label: Text("Sl.No")),
      DataColumn(label: Text("Approved By")),
      DataColumn(label: Text("Approved Status")),
      DataColumn(label: Text("Approved Date")),
      DataColumn(label: Text("Approved Remark")),
    ];
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }
}
