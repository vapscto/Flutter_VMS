import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/vms/rto/rto_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class VioLationList extends StatefulWidget {
  final RTOController controller;
  const VioLationList({super.key, required this.controller});

  @override
  State<VioLationList> createState() => _VioLationListState();
}

class _VioLationListState extends State<VioLationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: "RTO Violation Observation").getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              scrollDirection: Axis.horizontal,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DataTable(
                    dataTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.95),
                        fontWeight: FontWeight.w500),
                    dataRowHeight: 300,
                    headingRowHeight: 40,
                    horizontalMargin: 10,
                    columnSpacing: 30,
                    dividerThickness: 1,
                    headingTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10), width: 0.5),
                    headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    columns: const [
                      // 1
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'S.No',
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
                            'Vehical Name',
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
                            'Action',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(widget.controller.violationList.length,
                        (index) {
                      int i = index + 1;
                      var v = widget.controller.violationList.elementAt(index);
                      return DataRow(cells: [
                        DataCell(Text(i.toString())),
                        DataCell(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Vehical Name:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text:
                                      "${v.tRMVVehicleName}/${v.tRMVVehicleNo}",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: noticeColor.elementAt(bgColor)
                                  )),
                            ])),
                            const SizedBox(height: 3),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Driver Name:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: "${v.eMPNAME}",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: noticeColor.elementAt(bgColor)
                                  )),
                            ])),
                            const SizedBox(height: 3),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Enter By:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: "${v.applicationuser}",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: noticeColor.elementAt(bgColor)
                                  )),
                            ])),
                            const SizedBox(height: 3),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Date:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: getDate(DateTime.parse(v.rTOVOBDate!)),
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: noticeColor.elementAt(bgColor)
                                  )),
                            ])),
                            const SizedBox(height: 3),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Time:- ",
                                  style: Get.textTheme.titleSmall),
                              TextSpan(
                                  text: '${v.rTOVOBDateTimeOfViolation}',
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: noticeColor.elementAt(bgColor)
                                  )),
                            ])),
                            const SizedBox(height: 3),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: "Description:- ",
                                    style: Get.textTheme.titleSmall),
                                TextSpan(
                                    text: '${v.rTOVOBViolationDescription}',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.fade,
                                      // color: noticeColor.elementAt(bgColor)
                                    )),
                              ])),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  "Amount Paid:-",
                                  style: Get.textTheme.titleSmall,
                                ),
                                const SizedBox(width: 20),
                                (v.rTOVOBFineAmountPaidFlg == false)
                                    ? const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  "Any Violation:-",
                                  style: Get.textTheme.titleSmall,
                                ),
                                const SizedBox(width: 20),
                                (v.rTOVOBAnyViolationFlg == false)
                                    ? const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "View:-",
                                  style: Get.textTheme.titleSmall,
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Theme.of(context).primaryColor,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 3),
                          ],
                        )),
                        const DataCell(Align(
                            alignment: Alignment.center, child: Text(""))),
                      ]);
                    }),
                  )))
        ],
      ),
    );
  }
}
