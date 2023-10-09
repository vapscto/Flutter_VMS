import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/vms/sales_report/api/sales_list_api.dart';
import 'package:m_skool_flutter/vms/sales_report/sales_controller/sales_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class SaleReportList extends StatefulWidget {
  final SalesController salesController;
  final MskoolController mskoolController;
  final String flag;
  final String fromDate;
  final String toDate;
  final int miId;
  final int userId;
  final List leadId;
  final List departmentId;

  const SaleReportList(
      {super.key,
      required this.salesController,
      required this.mskoolController,
      required this.flag,
      required this.fromDate,
      required this.toDate,
      required this.miId,
      required this.userId,
      required this.leadId,
      required this.departmentId});

  @override
  State<SaleReportList> createState() => _SaleReportListState();
}

class _SaleReportListState extends State<SaleReportList> {
  List<Map<String, dynamic>> newId = [];
  _getList() async {
    widget.salesController.listLoading(true);
    await SalesListAPI.instance.salesListApi(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        salesController: widget.salesController,
        flag: widget.flag,
        fromDate: widget.fromDate,
        toDate: widget.toDate,
        miId: widget.miId,
        userId: widget.userId,
        leadIdList: newId,
        hrmdIdList: widget.departmentId,
        hrmeIdList: []);
    widget.salesController.listLoading(false);
  }

  _getId() {
    for (int index = 0; index < widget.leadId.length; index++) {
      newId.add({"ISMSLE_Id": widget.leadId.elementAt(index)});
    }
  }

  @override
  void initState() {
    _getId();
    _getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: "Sales Lead Comments Report").getAppBar(),
      body: (widget.salesController.isList.value)
          ? const Center(
              child: AnimatedProgressWidget(
                  title: "Loading Sales report",
                  desc:
                      "Please wait while we load Sales report entry and create a view for you.",
                  animationPath: "assets/json/default.json"),
            )
          : (widget.salesController.leadListModelValue.isEmpty)
              ? const Center(
                  child: AnimatedProgressWidget(
                      title: "Sales repor is not available",
                      desc: " ",
                      animationPath: "assets/json/nodata.json"),
                )
              : ListView(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: DataTable(
                          dataRowHeight:
                              MediaQuery.of(context).size.height * 0.4,
                          headingRowHeight: 45,
                          columnSpacing: 10,
                          headingTextStyle:
                              const TextStyle(color: Colors.white),
                          border: TableBorder.all(
                            color: Colors.black,
                            width: 0.6,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context).primaryColor),
                          columns: const [
                            DataColumn(label: Text("SL.NO.")),
                            DataColumn(label: Text("Lead Name")),
                            DataColumn(label: Text("Comments")),
                            DataColumn(label: Text("Comments Date")),
                            DataColumn(label: Text("Comments By")),
                            DataColumn(label: Text("View")),
                          ],
                          rows: List.generate(
                              widget.salesController.leadListModelValue.length,
                              (index) {
                            var date;
                            var value = index + 1;
                            if (widget.salesController.leadListModelValue[index]
                                    .iSMSLECOMCreatedDate !=
                                null) {
                              DateTime dt = DateTime.parse(widget
                                  .salesController
                                  .leadListModelValue[index]
                                  .iSMSLECOMCreatedDate!);
                              date = '${dt.day}-${dt.month}-${dt.year}';
                            }
                            return DataRow(cells: [
                              DataCell(Text(value.toString())),
                              DataCell(Text(widget
                                      .salesController
                                      .leadListModelValue[index]
                                      .iSMSLELeadName ??
                                  "")),
                              DataCell(Text(widget
                                  .salesController
                                  .leadListModelValue[index]
                                  .iSMSLECOMComments!)),
                              DataCell(Text(date)),
                              DataCell(Text(widget.salesController
                                  .leadListModelValue[index].employeename!)),
                              const DataCell(Text('')),
                            ]);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
