import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';

class SalesLeadDemo extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final TourLeadController controller;
  const SalesLeadDemo({
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<SalesLeadDemo> createState() => _SalesLeadDemoState();
}

class _SalesLeadDemoState extends State<SalesLeadDemo> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SALES LEAD DEMO",
                style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildLeadRow(
                  "Lead Title",
                  "${widget.controller.viewDemoResopnseList.first.ismslELeadName}",
                  "Lead Contact No",
                  "${widget.controller.viewDemoResopnseList.first.ismslEContactNo}"),
              const SizedBox(height: 10),
              _buildLeadRow(
                  "Contact Person",
                  "${widget.controller.viewDemoResopnseList.first.ismsledMContactPerson}",
                  "Address",
                  "${widget.controller.viewDemoResopnseList.first.ismsledMDemoAddress}"),
              const SizedBox(
                height: 40,
              ),
              Text(
                "PRODUCT DETAILS",
                style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DataTable(
                    dataTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.95),
                        fontWeight: FontWeight.w500),
                    dataRowHeight: 40,
                    headingRowHeight: 40,
                    horizontalMargin: 10,
                    columnSpacing: 20,
                    dividerThickness: 1,
                    headingTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10), width: 0.5),
                    headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    columns: const [
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'SL NO',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Product Name',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Discussion Points',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                    rows: List.generate(
                        widget.controller.viewDemoPRoductList.length, (index) {
                      int num = index + 1;
                      return DataRow(cells: [
                        DataCell(Align(
                            alignment: Alignment.center, child: Text("$num"))),
                        DataCell(Align(
                            alignment: Alignment.center,
                            child: Text(
                                "${widget.controller.viewDemoPRoductList.elementAt(index).ismsmpRProductName}"))),
                        DataCell(Align(
                            alignment: Alignment.center,
                            child: Text(
                                "${widget.controller.viewDemoPRoductList.elementAt(index).ismsledmpRDiscussionPoints}"))),
                      ]);
                    }),
                  )),
              const SizedBox(
                height: 40,
              ),
              Text(
                "RESPONSE DETAILS",
                style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DataTable(
                    dataTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.95),
                        fontWeight: FontWeight.w500),
                    dataRowHeight: 40,
                    headingRowHeight: 40,
                    horizontalMargin: 10,
                    columnSpacing: 20,
                    dividerThickness: 1,
                    headingTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10), width: 0.5),
                    headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    columns: const [
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'SL NO',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Product Name',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Discussion Points',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Staus Name',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Reamrks',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                    rows: List.generate(
                        widget.controller.viewDemoResponseDetailsList.length,
                        (index) {
                      int num = index + 1;
                      return DataRow(cells: [
                        DataCell(Align(
                            alignment: Alignment.center, child: Text("$num"))),
                        DataCell(Align(
                            alignment: Alignment.center,
                            child: Text(
                                "${widget.controller.viewDemoResponseDetailsList.elementAt(index).ismsmpRProductName}"))),
                        DataCell(Align(
                            alignment: Alignment.center,
                            child: Text(
                                "${widget.controller.viewDemoResponseDetailsList.elementAt(index).ismsledmpRDiscussionPoints}"))),
                        DataCell(Align(
                            alignment: Alignment.center,
                            child: Text(
                                "${widget.controller.viewDemoResponseDetailsList.elementAt(index).ismsmsTStatusName}"))),
                        DataCell(Align(
                            alignment: Alignment.center,
                            child: Text(
                                "${widget.controller.viewDemoResponseDetailsList.elementAt(index).ismsledmpRRemarks}"))),
                      ]);
                    }),
                  )),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeadRow(
      String title, String content, String title1, String content1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 250,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title : ",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                ),
                TextSpan(
                  text: content,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 250,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title1: ",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                ),
                TextSpan(
                  text: content1,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
