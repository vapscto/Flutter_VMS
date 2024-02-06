import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class CertificateApprovalList extends StatefulWidget {
  const CertificateApprovalList({super.key});

  @override
  State<CertificateApprovalList> createState() =>
      _CertificateApprovalListState();
}

class _CertificateApprovalListState extends State<CertificateApprovalList> {
  final controller = TextEditingController();
  List<int> dataList = [];

  @override
  void initState() {
    dataList.add(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Certificate Approval/ Reject Details')
          .getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            style: Get.textTheme.titleSmall,
            controller: controller,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                hintText: 'Search Employee name',
                hintStyle:
                    Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
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
                  rows: List.generate(dataList.length, (index) {
                    var v = index + 1;
                    return DataRow(cells: [
                      DataCell(Text(v.toString())),
                      DataCell(SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(v.toString()))),
                      DataCell(Text(v.toString())),
                      DataCell(Text(v.toString())),
                      DataCell(Text(v.toString())),
                      DataCell(IconButton(
                        onPressed: () {
                          createPreview(context, '');
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                      // DataCell(IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.arrow_downward,
                      //     color: Theme.of(context).primaryColor,
                      //   ),
                      // )
                      // ),
                    ]);
                  })),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> createColumn() {
    return const [
      DataColumn(label: Text("SL.NO.")),
      DataColumn(label: Text("Employee Name")),
      DataColumn(label: Text("Requested Date")),
      DataColumn(label: Text("Approved Date")),
      DataColumn(label: Text("Status")),
      DataColumn(label: Text("Document")),
      // DataColumn(label: Text("Action")),
    ];
  }
}
