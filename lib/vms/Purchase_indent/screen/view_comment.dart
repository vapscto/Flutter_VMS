import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/Purchase_indent/controller/purchase_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class ViewComment extends StatefulWidget {
  final int invmpiId;
  const ViewComment({
    super.key,
    required PurchaseController purchaseController,
    required this.invmpiId,
  });
  @override
  // ignore: library_private_types_in_public_api
  _ViewCommentState createState() => _ViewCommentState();
}

class _ViewCommentState extends State<ViewComment> {
  PurchaseController controller = Get.put(PurchaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "View Comment").getAppBar(),
        floatingActionButton: const HomeFab(),
        body: Obx(
          () => controller.getrequestList.isEmpty
              ? const Center(
                  child: AnimatedProgressWidget(
                    animationPath: "assets/json/nodata.json",
                    animatorHeight: 300,
                    title: "Loading View Comment",
                    desc:
                        "Please wait while we laod detail table and create a view for you",
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                              dataTextStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.95),
                                  fontWeight: FontWeight.w500),
                              dataRowHeight: 45,
                              headingRowHeight: 40,
                              horizontalMargin: 10,
                              columnSpacing: 40,
                              dividerThickness: 1,
                              headingTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.5),
                              headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(
                                  numeric: true,
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'SL.No.',
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
                                      'Requisition No.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Applied By',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Applied Date',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Remarks',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                  controller.getrequestList.length, (index) {
                                var i = index + 1;
                                return DataRow(
                                  cells: [
                                    DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text('$i'))),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(controller.getrequestList
                                          .elementAt(index)
                                          .invmpRPRNo
                                          .toString()),
                                    )),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(controller.getrequestList
                                          .elementAt(index)
                                          .employeename
                                          .toString()),
                                    )),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(controller.getrequestList
                                          .elementAt(index)
                                          .invmpRPRDate
                                          .toString()),
                                    )),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(controller.getrequestList
                                          .elementAt(index)
                                          .invmpRRemarks
                                          .toString()),
                                    )),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      controller.getcommentList.isNotEmpty
                          ? Obx(
                              () => SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: DataTable(
                                      dataTextStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(0, 0, 0, 0.95),
                                          fontWeight: FontWeight.w500),
                                      dataRowHeight: 45,
                                      headingRowHeight: 40,
                                      horizontalMargin: 10,
                                      columnSpacing: 40,
                                      dividerThickness: 1,
                                      headingTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      border: TableBorder.all(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 0.5),
                                      headingRowColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor),
                                      columns: const [
                                        DataColumn(
                                          numeric: true,
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'SL.No.',
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
                                              'Approval Given BY',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Date',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Remarks',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                          controller.getrequestList.length,
                                          (index) {
                                        var i = index + 1;
                                        return DataRow(
                                          cells: [
                                            DataCell(Align(
                                                alignment: Alignment.center,
                                                child: Text('$i'))),
                                            DataCell(Align(
                                              alignment: Alignment.center,
                                              child: Text(controller
                                                  .getcommentList
                                                  .elementAt(index)
                                                  .userName
                                                  .toString()),
                                            )),
                                            DataCell(Align(
                                              alignment: Alignment.center,
                                              child: Text(controller
                                                  .getcommentList
                                                  .elementAt(index)
                                                  .invmpiapPPIDate
                                                  .toString()),
                                            )),
                                            DataCell(Align(
                                              alignment: Alignment.center,
                                              child: Text(controller
                                                  .getcommentList
                                                  .elementAt(index)
                                                  .invmpiapPRemarks
                                                  .toString()),
                                            )),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )),
        ));
  }
}
