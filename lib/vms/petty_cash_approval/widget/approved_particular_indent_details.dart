import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ApprovedParticularIndentDetails extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ApprovedParticularIndentDetails({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              title:

                  //"${inventoryController.StockReportSpecific.isNotEmpty ? inventoryController.StockReportSpecific[0].iNVMIItemName : 'No Data'}"
                  "Specific Stock Report")
          .getAppBar(),
      body:  Container(
          margin: EdgeInsets.only(top: 16.0),
          height: Get.height * 0.85,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DataTable(
                      dataTextStyle: const TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(5, 5, 5, 0.945),
                          fontWeight: FontWeight.w500),
                      dataRowHeight: 40,
                      headingRowHeight: 55,
                      horizontalMargin: 10,
                      columnSpacing: 40,
                      dividerThickness: 1,
                      border: TableBorder.all(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      headingRowColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      columns: [
                        DataColumn(
                            label: Text("S No.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Indent No.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Department",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Indent Approved By",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Date",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Indent Requested Amount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                        DataColumn(
                            label: Text("Indent Approved Amount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800))),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Align(
                              alignment: Alignment.center,
                              child: Text('1'),
                            )),
                            DataCell(Text("Hello")),
                            DataCell(Text("Hello")),
                            DataCell(Text("Hello")),
                            DataCell(Text("Hello")),
                            DataCell(Text("Hello")),
                            DataCell(Text("Hello")),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}


/* SingleChildScrollView(
      
      child: DataTable(
        dataTextStyle: const TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(5, 5, 5, 0.945),
            fontWeight: FontWeight.w500),
        dataRowHeight: 40,
        headingRowHeight: 55,
        horizontalMargin: 10,
        columnSpacing: 40,
        dividerThickness: 1,
        border: TableBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        headingRowColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        columns: [
          DataColumn(
              label: Text("S No.",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800))),
          DataColumn(
              label: Text("Indent No.",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800))),
          DataColumn(
              label: Text("Department",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800))),
          DataColumn(
              label: Text("Indent Approved By",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800))),
          DataColumn(
              label: Text("Date",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800))),
          DataColumn(
              label: Text("Indent Requested Amount",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800))),
          DataColumn(
              label: Text("Indent Approved Amount",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800))),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Align(
                alignment: Alignment.center,
                child: Text('1'),
              )),
              DataCell(Text("Hello")),
              DataCell(Text("Hello")),
              DataCell(Text("Hello")),
              DataCell(Text("Hello")),
              DataCell(Text("Hello")),
              DataCell(Text("Hello")),
            ],
          ),
        ],
      ),
    ); 

    */