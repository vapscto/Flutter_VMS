import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/vms/sales_report/api/sales_list_api.dart';
import 'package:m_skool_flutter/vms/sales_report/sales_controller/sales_controller.dart';
import 'package:m_skool_flutter/vms/sales_report/screens/lead_details_screen.dart';
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
  final List employeeId;

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
      required this.departmentId,
      required this.employeeId});

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
        hrmdIdList: widget.departmentId,
        hrmeIdList: widget.employeeId,
        designationId: widget.salesController.designationId);
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
      body: Obx(() {
        return (widget.salesController.isList.value)
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
                      animationPath: "assets/json/nodata.json",
                      animatorHeight: 250,
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.only(top: 16),
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                            dataRowHeight:
                                MediaQuery.of(context).size.height * 0.05,
                            headingRowHeight: 45,
                            columnSpacing: 10,
                            headingTextStyle:
                                const TextStyle(color: Colors.white),
                            border: TableBorder.all(
                              color: Colors.black,
                              width: 0.6,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            dataTextStyle: Get.textTheme.titleSmall,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                            columns: const [
                              DataColumn(label: Text("SL.NO.")),
                              DataColumn(label: Text("Employee Name")),
                              DataColumn(label: Text("Total Lead")),
                              DataColumn(label: Text("Demo Given")),
                              DataColumn(label: Text("Not Given Demo")),
                              DataColumn(label: Text("Cold")),
                              DataColumn(label: Text("Hot")),
                              DataColumn(label: Text("Warm")),
                            ],
                            rows: List.generate(
                                widget.salesController.salseListModel.length,
                                (index) {
                              var v = index + 1;
                              var data = widget.salesController.salseListModel
                                  .elementAt(index);
                              return DataRow(cells: [
                                DataCell(Text(v.toString())),
                                DataCell(Text(data.empName.toString())),
                                DataCell(InkWell(
                                    onTap: () {
                                      Get.to(() => LeadDetailsScreen(
                                            mskoolController:
                                                widget.mskoolController,
                                          ));
                                    },
                                    child: Text(data.totalLeads.toString()))),
                                DataCell(InkWell(
                                    onTap: () {
                                      Get.to(() => LeadDetailsScreen(
                                            mskoolController:
                                                widget.mskoolController,
                                          ));
                                    },
                                    child: Text(data.demoGiven.toString()))),
                                DataCell(InkWell(
                                    onTap: () {
                                      Get.to(() => LeadDetailsScreen(
                                            mskoolController:
                                                widget.mskoolController,
                                          ));
                                    },
                                    child: Text(data.notGivenDemo.toString()))),
                                DataCell(SizedBox(
                                  width: 80,
                                  child: InkWell(
                                      onTap: () {
                                        Get.to(() => LeadDetailsScreen(
                                              mskoolController:
                                                  widget.mskoolController,
                                            ));
                                      },
                                      child: Text(data.cOLD.toString())),
                                )),
                                DataCell(SizedBox(
                                  width: 80,
                                  child: InkWell(
                                      onTap: () {
                                        Get.to(() => LeadDetailsScreen(
                                              mskoolController:
                                                  widget.mskoolController,
                                            ));
                                      },
                                      child: Text(data.hOT.toString())),
                                )),
                                DataCell(SizedBox(
                                  width: 80,
                                  child: InkWell(
                                      onTap: () {
                                        Get.to(() => LeadDetailsScreen(
                                              mskoolController:
                                                  widget.mskoolController,
                                            ));
                                      },
                                      child: Text(data.wARM.toString())),
                                )),
                              ]);
                            }),
                            // columns: const [
                            //   DataColumn(label: Text("SL.NO.")),
                            //   DataColumn(label: Text("Employee Name")),
                            //   DataColumn(label: Text("Lead Name")),
                            //   DataColumn(label: Text("Visited Date")),
                            //   DataColumn(label: Text("Demo Date")),
                            //   DataColumn(label: Text("Contact Persion")),
                            //   DataColumn(label: Text("Status Name")),
                            // ],
                            // rows: List.generate(
                            //     widget.salesController.leadListModelValue
                            //         .length, (index) {
                            //   var date;
                            //   var demoDate;
                            //   var value = index + 1;
                            //   if (widget
                            //           .salesController
                            //           .leadListModelValue[index]
                            //           .iSMSLEVisitedDate !=
                            //       null) {
                            //     DateTime dt = DateTime.parse(widget
                            //         .salesController
                            //         .leadListModelValue[index]
                            //         .iSMSLEVisitedDate!);
                            //     date = '${dt.day}-${dt.month}-${dt.year}';
                            //   }
                            //   if (widget
                            //           .salesController
                            //           .leadListModelValue[index]
                            //           .iSMSLEDMDemoDate !=
                            //       null) {
                            //     DateTime dt2 = DateTime.parse(widget
                            //         .salesController
                            //         .leadListModelValue[index]
                            //         .iSMSLEDMDemoDate!);
                            //     demoDate =
                            //         '${dt2.day}-${dt2.month}-${dt2.year}';
                            //   }

                            //   return DataRow(cells: [
                            //     DataCell(Text(value.toString())),
                            //     DataCell(Text(widget
                            //             .salesController
                            //             .leadListModelValue[index]
                            //             .hRMEEmployeeFirstName ??
                            //         "")),
                            //     DataCell(Text(widget
                            //             .salesController
                            //             .leadListModelValue[index]
                            //             .iSMSLELeadName ??
                            //         "")),
                            //     DataCell(Text(
                            //       date ?? '',
                            //       textAlign: TextAlign.center,
                            //     )),
                            //     DataCell(Text(demoDate ?? '')),
                            //     DataCell(Text(widget
                            //             .salesController
                            //             .leadListModelValue[index]
                            //             .iSMSLEContactPerson ??
                            //         '')),
                            //     DataCell(Text(widget
                            //             .salesController
                            //             .leadListModelValue[index]
                            //             .iSMSMSTStatusName ??
                            //         '')),
                            //   ]);
                            // }),
                          ),
                        ),
                      ),
                    ],
                  );
      }),
    );
  }
}
