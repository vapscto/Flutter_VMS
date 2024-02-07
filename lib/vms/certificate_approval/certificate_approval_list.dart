import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_approval_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class CertificateApprovalList extends StatefulWidget {
  final List<CertificateApprovalListModelValues> data;
  const CertificateApprovalList({super.key, required this.data});

  @override
  State<CertificateApprovalList> createState() =>
      _CertificateApprovalListState();
}

class _CertificateApprovalListState extends State<CertificateApprovalList> {
  final controller = TextEditingController();
  List<int> dataList = [];
  List<CertificateApprovalListModelValues> filterList = [];
  filterFun(String query) {
    filterList = widget.data.where((list) {
      return list.hRMEEmployeeFirstName!
          .trim()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    dataList.add(1);
    filterList = widget.data;
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
            onChanged: (value) {
              setState(() {
                setState(() {
                  filterFun(controller.text);
                });
              });
            },
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
          (filterList.isEmpty)
              ? const AnimatedProgressWidget(
                  animationPath: 'assets/json/nodata.json',
                  title: 'Data is not available',
                  desc: "",
                  animatorHeight: 250,
                )
              : SingleChildScrollView(
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
                        rows: List.generate(filterList.length, (index) {
                          var v = index + 1;
                          var value = filterList.elementAt(index);
                          return DataRow(cells: [
                            DataCell(Text(v.toString())),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child:
                                    Text(value.hRMEEmployeeFirstName!.trim()))),
                            DataCell(Text(dateFormat(
                                DateTime.parse(value.iSMCERTREQRequestDate!)))),
                            DataCell(Text(dateFormat(DateTime.parse(
                                value.iSMCERTREQAPPApprovedDate!)))),
                            DataCell(Text(value.iSMCERTREQAPPAppRejFlag!)),
                            DataCell((value.iSMCERTREQFilePath!.isNotEmpty)
                                ? IconButton(
                                    onPressed: () {
                                      createPreview(
                                          context, value.iSMCERTREQFilePath!);
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : const SizedBox()),
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

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
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
