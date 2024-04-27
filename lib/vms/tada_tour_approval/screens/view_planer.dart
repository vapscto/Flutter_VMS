import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/api/edit_tour_api.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/api/get_view.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_view_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewTourPLan extends StatefulWidget {
  final GetTourViewValues getTourViewValues;
  final String planerNme;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final TadaTourController controller;
  const ViewTourPLan(
      {super.key,
      required this.getTourViewValues,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.planerNme,
      required this.controller});

  @override
  State<ViewTourPLan> createState() => _ViewTourPLanState();
}

class _ViewTourPLanState extends State<ViewTourPLan> {
  var height, width;
  var dayCount;
  RxInt sum = 0.obs;
  RxBool radioBtn = RxBool(true);
  TextEditingController appliedEt = TextEditingController(text: "");
  TextEditingController remarkEt = TextEditingController(text: "");
  RxString totalSanctionAmount = "".obs;

  @override
  void initState() {
    dayCount = dayCounts(widget.getTourViewValues.vTADAAAFromDate!,
        widget.getTourViewValues.vTADAAAToDate!);
    appliedEt.text =
        widget.getTourViewValues.vTADAAATotalAppliedAmount.toString();
    initApi();
    super.initState();
   
    }
  
  initApi() async {
   await getEditTour(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        hrmeId: widget.getTourViewValues.hRMEId!,
        ierId: widget.getTourViewValues.iERID!.toString(),
        miID: widget.getTourViewValues.mIId!,
        tadaTourController: widget.controller,
        userId: widget.getTourViewValues.userId!,
        vtadaaaId: widget.getTourViewValues.vTADAAAId!);
    await getViewTada(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        hrmeId: widget.getTourViewValues.hRMEId!,
        ierId: int.parse(widget.getTourViewValues.iERID!),
        miID: widget.getTourViewValues.mIId!,
        tadaTourController: widget.controller,
        userId: widget.getTourViewValues.userId!,
        vtadaaaId: widget.getTourViewValues.vTADAAAId!);
      setState(() {
        widget.controller.calculateSum();
    widget.controller.sancationAmountTotal.value.text   = widget.controller.totalSamount.value;
      });  
    } 

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.width;
    width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(title: "View TADA TourMap").getAppBar(),
      body: Obx(
        () => widget.controller.timeArrayList.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 1650,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.blue, width: 2)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Companny Name : ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.blue[600]))),
                                            TextSpan(
                                                text: widget
                                                    .getTourViewValues.mIName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(const TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 10, 10, 10))))
                                          ])),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Applied Date :",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.blue[600]))),
                                            TextSpan(
                                                text: getDate(DateTime.parse(
                                                    widget.getTourViewValues
                                                        .vTADAAAAppliedDate!)),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(const TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 10, 10, 10)))),
                                          ])),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Staff Name : ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.blue[600]))),
                                            TextSpan(
                                                text: widget
                                                    .getTourViewValues.empName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(const TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 10, 10, 10))))
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Date :",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.blue[600]))),
                                            TextSpan(
                                                text:
                                                    "${getDate(DateTime.parse(widget.getTourViewValues.vTADAAAFromDate!))} To ${getDate(DateTime.parse(widget.getTourViewValues.vTADAAAToDate!))}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(const TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 10, 10, 10)))),
                                          ])),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Applied Amount : ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.blue[600]))),
                                            TextSpan(
                                                text: widget.getTourViewValues
                                                    .vTADAAATotalAppliedAmount!
                                                    .toDouble()
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(const TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 10, 10, 10))))
                                          ])),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Remarks :",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.blue[600]))),
                                            TextSpan(
                                                text:
                                                    "${widget.getTourViewValues.vTADAAARemarks}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .merge(const TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 10, 10, 10)))),
                                          ])),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  width: 1650,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.blue, width: 2)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "TOUR - ADAVANCE TRAVEL DETAILS",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .merge(TextStyle(
                                                color: Colors.blue[600],
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SingleChildScrollView(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                              scrollDirection: Axis.horizontal,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DataTable(
                                                    dataTextStyle:
                                                        const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.95),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    dataRowHeight: 50,
                                                    headingRowHeight: 40,
                                                    horizontalMargin: 10,
                                                    columnSpacing: 30,
                                                    dividerThickness: 1,
                                                    headingTextStyle:
                                                        const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                    border: TableBorder.all(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        width: 0.5),
                                                    headingRowColor:
                                                        MaterialStateProperty
                                                            .all(Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                    columns: const [
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text("SL.No"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Tour Plan Name"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text("Day"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              Text("FromDate"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Departure Time"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text("Todate"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Arrival Time"),
                                                        ),
                                                      ),
                                                    ],
                                                    rows: List.generate(1,
                                                        (index) {
                                                      return DataRow(cells: [
                                                        DataCell(Align(
                                                          child: Text(
                                                              "${index + 1}"),
                                                        )),
                                                        DataCell(Align(
                                                          child: Text(widget
                                                              .planerNme
                                                              .toUpperCase()),
                                                        )),
                                                        DataCell(Align(
                                                          child: Text(dayCount),
                                                        )),
                                                        //from date
                                                        DataCell(Align(
                                                          child: Text(getDate(
                                                              DateTime.parse(widget
                                                                  .controller
                                                                  .timeArrayList
                                                                  .first
                                                                  .vtadaaAFromDate!))),
                                                        )),
                                                        // departure time
                                                        DataCell(Align(
                                                          child: Text(
                                                              timeFormate(widget
                                                                  .controller
                                                                  .timeArrayList
                                                                  .first
                                                                  .vtadaaADepartureTime!)),
                                                        )),
                                                        //tob date
                                                        DataCell(Align(
                                                          child: Text(getDate(
                                                              DateTime.parse(widget
                                                                  .controller
                                                                  .timeArrayList
                                                                  .first
                                                                  .vtadaaAToDate!))),
                                                        )),
                                                        DataCell(Align(
                                                          child: Text(
                                                              timeFormate(widget
                                                                  .controller
                                                                  .timeArrayList
                                                                  .first
                                                                  .vtadaaAArrivalTime!)),
                                                        )),
                                                      ]);
                                                    }),
                                                  ))),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Obx(
                                            () => widget.controller
                                                    .getTadaCategory.isNotEmpty
                                                ? SingleChildScrollView(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 0),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: DataTable(
                                                          dataTextStyle:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.95),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                          dataRowHeight: 50,
                                                          headingRowHeight: 40,
                                                          horizontalMargin: 10,
                                                          columnSpacing: 30,
                                                          dividerThickness: 1,
                                                          headingTextStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                          border: TableBorder.all(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              width: 0.5),
                                                          headingRowColor:
                                                              MaterialStateProperty
                                                                  .all(Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                          columns: const [
                                                            DataColumn(
                                                              label: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(""),
                                                              ),
                                                            ),
                                                            DataColumn(
                                                              label: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    "Closure"),
                                                              ),
                                                            ),
                                                            DataColumn(
                                                              label: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    Text("HOT"),
                                                              ),
                                                            ),
                                                            DataColumn(
                                                              label: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    "Follow Up"),
                                                              ),
                                                            ),
                                                            DataColumn(
                                                              label: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    "Cold"),
                                                              ),
                                                            ),
                                                          ],
                                                          rows: List.generate(1,
                                                              (index) {
                                                            return DataRow(
                                                                cells: [
                                                                  const DataCell(
                                                                      Align(
                                                                    child: Text(
                                                                        "Percentage"),
                                                                  )),
                                                                  DataCell(
                                                                      Align(
                                                                    child: Text(
                                                                      "${widget.controller.getTadaCategory[0].iMRCPercentage.toString()} %",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                              color: Colors.red),
                                                                    ),
                                                                  )),
                                                                  DataCell(
                                                                      Align(
                                                                    child: Text(
                                                                      "${widget.controller.getTadaCategory[1].iMRCPercentage.toString()} %",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                              color: Colors.red),
                                                                    ),
                                                                  )),
                                                                  //from date
                                                                  DataCell(
                                                                      Align(
                                                                    child: Text(
                                                                      "${widget.controller.getTadaCategory[2].iMRCPercentage!.toInt().toString()} %",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                              color: Colors.red),
                                                                    ),
                                                                  )),
                                                                  // departure time
                                                                  DataCell(
                                                                      Align(
                                                                    child: Text(
                                                                      "${widget.controller.getTadaCategory[3].iMRCPercentage!.toInt().toString()} %",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                              color: Colors.red),
                                                                    ),
                                                                  )),
                                                                ]);
                                                          }),
                                                        )))
                                                : const SizedBox(),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Obx(
                                            () =>
                                                widget
                                                        .controller
                                                        .getTadaCategory
                                                        .isNotEmpty
                                                    ? SingleChildScrollView(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 0),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: DataTable(
                                                              dataTextStyle: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.95),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              dataRowHeight: 50,
                                                              headingRowHeight:
                                                                  40,
                                                              horizontalMargin:
                                                                  10,
                                                              columnSpacing: 30,
                                                              dividerThickness:
                                                                  1,
                                                              headingTextStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                              border: TableBorder.all(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  width: 0.5),
                                                              headingRowColor:
                                                                  MaterialStateProperty
                                                                      .all(Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                              columns: [
                                                                const DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Source Name"),
                                                                  ),
                                                                ),
                                                                const DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Closure"),
                                                                  ),
                                                                ),
                                                                const DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "HOT"),
                                                                  ),
                                                                ),
                                                                const DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Follow Up"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(widget
                                                                            .controller
                                                                            .showTable
                                                                            .isFalse
                                                                        ? "Cold"
                                                                        : "NEGOTATION"),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: List.generate(
                                                                  widget
                                                                      .controller
                                                                      .sourcesList
                                                                      .length,
                                                                  (index) {
                                                                return DataRow(
                                                                    cells: [
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .controller
                                                                              .sourcesList[index]
                                                                              .iSMSMSOSourceName
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .controller
                                                                              .sourcesList[index]
                                                                              .closure
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .controller
                                                                              .sourcesList[index]
                                                                              .hOT
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      //from date
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .controller
                                                                              .sourcesList[index]
                                                                              .followUp
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      // departure time
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget.controller.showTable.isFalse
                                                                              ? widget.controller.sourcesList[index].cold.toString()
                                                                              : widget.controller.sourcesList[index].nEGOTATION.toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                    ]);
                                                              }),
                                                            )))
                                                    : const SizedBox(),
                                          ),
                                        ],
                                      ),
                                      /**
                                   *  Lead adds
                                   */
                                      Obx(() => widget.controller
                                              .getPlanerListData.isNotEmpty
                                          ? SingleChildScrollView(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                              // scrollDirection: Axis.horizontal,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DataTable(
                                                    dataTextStyle:
                                                        const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.95),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    dataRowHeight: 50,
                                                    headingRowHeight: 40,
                                                    horizontalMargin: 10,
                                                    columnSpacing: 30,
                                                    dividerThickness: 1,
                                                    headingTextStyle:
                                                        const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                    border: TableBorder.all(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        width: 0.5),
                                                    headingRowColor:
                                                        MaterialStateProperty
                                                            .all(Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                    columns: const [
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Category Name"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              Text("Lead Name"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Student Strength"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Product Name"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Source Name"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Created By"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Demo given By"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "State Name"),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text("Remove"),
                                                        ),
                                                      ),
                                                    ],
                                                    rows: List.generate(
                                                        widget
                                                            .controller
                                                            .getPlanerListData
                                                            .length, (index) {
                                                      return DataRow(cells: [
                                                        DataCell(Align(
                                                            child: Text(
                                                          widget.controller
                                                              .getPlanerListData
                                                              .elementAt(index)
                                                              .iMRCCategoryName!,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      17,
                                                                      17,
                                                                      17)),
                                                        ))),
                                                        DataCell(Align(
                                                          child: Text(
                                                            widget.controller
                                                                .getPlanerListData
                                                                .elementAt(
                                                                    index)
                                                                .iSMSLELeadName!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )),
                                                        DataCell(Align(
                                                          child: Text(
                                                            widget.controller
                                                                .getPlanerListData
                                                                .elementAt(
                                                                    index)
                                                                .iSMSLEStudentStrength!
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )),
                                                        //from date
                                                        DataCell(Align(
                                                          child: Text(
                                                            widget.controller
                                                                .getPlanerListData
                                                                .elementAt(
                                                                    index)
                                                                .iSMSMPRProductName!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )),
                                                        // departure time
                                                        DataCell(Align(
                                                          child: Text(
                                                            widget.controller
                                                                .getPlanerListData
                                                                .elementAt(
                                                                    index)
                                                                .sourceName!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )),
                                                        DataCell(Align(
                                                          child: Text(
                                                            widget.controller
                                                                .getPlanerListData
                                                                .elementAt(
                                                                    index)
                                                                .hRMEEmployeeFirstName!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )),
                                                        DataCell(Align(
                                                          child: Text(
                                                            widget.controller
                                                                .getPlanerListData
                                                                .elementAt(
                                                                    index)
                                                                .demoEmployeeFirstName!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )),
                                                        DataCell(Align(
                                                          child: Text(
                                                            widget.controller
                                                                .getPlanerListData
                                                                .elementAt(
                                                                    index)
                                                                .iVRMMSName!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )),

                                                        const DataCell(Align(
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                        ))
                                                      ]);
                                                    }),
                                                  )))
                                          : const SizedBox()),
                                      Row(
                                        children: [
                                          Obx(
                                            () =>
                                                widget
                                                        .controller
                                                        .accomdationList
                                                        .isNotEmpty
                                                    ? SingleChildScrollView(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 0),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: DataTable(
                                                              dataTextStyle: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.95),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              dataRowHeight: 50,
                                                              headingRowHeight:
                                                                  40,
                                                              horizontalMargin:
                                                                  10,
                                                              columnSpacing: 30,
                                                              dividerThickness:
                                                                  1,
                                                              headingTextStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                              border: TableBorder.all(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  width: 0.5),
                                                              headingRowColor:
                                                                  MaterialStateProperty
                                                                      .all(Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                              columns: const [
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "SL NO"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Approve"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Reject"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Header"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Amount"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Total Slots"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Slots"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Amount"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Percentage"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Sancation Amouunt"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Approval Remarks"),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: List.generate(
                                                                  widget
                                                                      .controller
                                                                      .accomdationList
                                                                      .length,
                                                                  (index) {
                                                                var num =
                                                                    index + 1;
                                                                return DataRow(
                                                                    color: widget
                                                                            .controller
                                                                            .radioItems[
                                                                                index]
                                                                            .isRejected
                                                                        ? const MaterialStatePropertyAll(Colors
                                                                            .redAccent)
                                                                        : const MaterialStatePropertyAll(
                                                                            Colors.white),
                                                                    cells: [
                                                                      DataCell(
                                                                          Align(
                                                                        child: Text(
                                                                            "$num"),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Radio(
                                                                          value:
                                                                              radioBtn.value,
                                                                          groupValue: widget
                                                                              .controller
                                                                              .radioItems[index]
                                                                              .isApproved,
                                                                          onChanged:
                                                                              (value) {
                                                                            setState(() {
                                                                              widget.controller.radioItems[index].isApproved = value as bool;
                                                                              widget.controller.radioItems[index].isRejected = !value;
                                                                              updateCounts();
                                                                            });
                                                                          },
                                                                        ),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                              child: Radio(
                                                                        value: radioBtn
                                                                            .value,
                                                                        groupValue: widget
                                                                            .controller
                                                                            .radioItems[index]
                                                                            .isRejected,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            widget.controller.radioItems[index].isRejected =
                                                                                value as bool;
                                                                            widget.controller.radioItems[index].isApproved =
                                                                                !value;
                                                                            updateCounts();
                                                                          });
                                                                        },
                                                                      ))),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .controller
                                                                              .accomdationList
                                                                              .elementAt(index)
                                                                              .vTADAAADExpenditureHead!,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          index == 0
                                                                              ? widget.controller.accomdationList.elementAt(index).vTADACMAccommodationAmt!.toInt().toString()
                                                                              : index == 1
                                                                                  ? widget.controller.accomdationList.elementAt(index).vTADACMFoodAmt!.toInt().toString()
                                                                                  : index == 2
                                                                                      ? widget.controller.accomdationList.elementAt(index).vTADACMTransportAmt!.toInt().toString()
                                                                                      : "",
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      //from date
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .controller
                                                                              .accomdationList
                                                                              .elementAt(index)
                                                                              .vTADAAADTotalSlots!
                                                                              .toInt()
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      // departure time
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .controller
                                                                              .accomdationList
                                                                              .elementAt(index)
                                                                              .vTADAAADSlots!
                                                                              .toInt()
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            Text(
                                                                          widget
                                                                              .controller
                                                                              .accomdationList
                                                                              .elementAt(index)
                                                                              .vTADAAADAmount!
                                                                              .toInt()
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            TextField(
                                                                          readOnly: widget.controller.radioItems[index].isRejected
                                                                              ? true
                                                                              : false,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.digitsOnly,
                                                                            LengthLimitingTextInputFormatter(2)
                                                                          ],
                                                                          onChanged:
                                                                              (value) {
                                                                            var percent =
                                                                                int.parse(widget.controller.percentageET[index].text);
                                                                            var amounts =
                                                                                widget.controller.accomdationList.elementAt(index).vTADAAADAmount!;
                                                                            double
                                                                                sancationAmount =
                                                                                amounts * (percent / 100);
                                                                            widget.controller.sancationAmountEt[index].text =
                                                                                sancationAmount.toInt().toString();
                                                                          },
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          decoration:
                                                                              const InputDecoration(border: OutlineInputBorder()),
                                                                          controller: widget
                                                                              .controller
                                                                              .percentageET[index],
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            TextField(
                                                                              keyboardType: TextInputType.number,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                      widget.controller.sancationAmountTotal.value.text   = widget.controller.totalSamount.value;

                                                                                });
                                                                              },
                                                                          readOnly: widget.controller.radioItems[index].isRejected
                                                                              ? true
                                                                              : false,
                                                                          decoration:
                                                                              const InputDecoration(border: OutlineInputBorder()),
                                                                          controller: widget
                                                                              .controller
                                                                              .sancationAmountEt[index],
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child:
                                                                            TextField(
                                                                          readOnly: widget.controller.radioItems[index].isRejected
                                                                              ? true
                                                                              : false,
                                                                          decoration:
                                                                              const InputDecoration(border: OutlineInputBorder()),
                                                                          controller: widget
                                                                              .controller
                                                                              .approvalRemarkEt[index],
                                                                          keyboardType:
                                                                              TextInputType.name,
                                                                          textInputAction:
                                                                              TextInputAction.done,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      )),
                                                                    ]);
                                                              }),
                                                            )))
                                                    : const SizedBox(),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          Obx(
                                            () => widget.controller.chartData
                                                        .length >
                                                    3
                                                ? Container(
                                                    width: 250,
                                                    child: SfCartesianChart(
                                                        enableAxisAnimation:
                                                            true,
                                                        primaryXAxis:
                                                            CategoryAxis(),
                                                        series: <
                                                            CartesianSeries<
                                                                ChartData,
                                                                String>>[
                                                          // Renders column chart
                                                          ColumnSeries<
                                                                  ChartData,
                                                                  String>(
                                                              dataSource: widget
                                                                  .controller
                                                                  .chartData,
                                                              xValueMapper:
                                                                  (ChartData data,
                                                                          _) =>
                                                                      data.x,
                                                              yValueMapper:
                                                                  (ChartData data,
                                                                          _) =>
                                                                      data.y)
                                                        ]))
                                                : const SizedBox(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(
                                            () =>
                                                widget.controller.paymentDetails
                                                        .isNotEmpty
                                                    ? SingleChildScrollView(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 0),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: DataTable(
                                                              dataTextStyle: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.95),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              dataRowHeight: 50,
                                                              headingRowHeight:
                                                                  40,
                                                              horizontalMargin:
                                                                  10,
                                                              columnSpacing: 30,
                                                              dividerThickness:
                                                                  1,
                                                              headingTextStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                              border: TableBorder.all(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  width: 0.5),
                                                              headingRowColor:
                                                                  MaterialStateProperty
                                                                      .all(Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                              columns: const [
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "SL NO"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Total Amount"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Sanction Amount"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Payment Time"),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        "Payment Mode"),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: List.generate(
                                                                  widget
                                                                      .controller
                                                                      .paymentDetails
                                                                      .length,
                                                                  (index) {
                                                                int num =
                                                                    index + 1;
                                                                return DataRow(
                                                                    cells: [
                                                                      DataCell(
                                                                          Align(
                                                                        child: Text(
                                                                            "$num"),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child: Text(widget
                                                                            .controller
                                                                            .paymentDetails
                                                                            .elementAt(index)
                                                                            .totalAppliedAmount!
                                                                            .toInt()
                                                                            .toString()),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child: Text(widget
                                                                            .controller
                                                                            .paymentDetails
                                                                            .elementAt(index)
                                                                            .totalAppliedAmountByPart!
                                                                            .toInt()
                                                                            .toString()),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child: Text(widget
                                                                            .controller
                                                                            .paymentDetails
                                                                            .elementAt(index)
                                                                            .paymentTime!
                                                                            .toInt()
                                                                            .toString()),
                                                                      )),
                                                                      DataCell(
                                                                          Align(
                                                                        child: Text(widget
                                                                            .controller
                                                                            .paymentDetails
                                                                            .elementAt(index)
                                                                            .paymentMode!),
                                                                      )),
                                                                    ]);
                                                              }),
                                                            )))
                                                    : const SizedBox(),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          Container(
                                            height: 250,
                                            width: 250,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                  Obx(
                                                    ()=> Text(
                                                      "Total Applied Amount :${ widget.controller.totalSamount.value}"),
                                                  ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                TextField(
                                                  readOnly: true,
                                                  controller: appliedEt,
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                    "Total Sanction Amount :"),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Obx(
                                                  () => TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: widget
                                                        .controller
                                                        .sancationAmountTotal
                                                        .value,
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          Container(
                                            width: 420,
                                            height: 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Remarks ",
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      hintText: "Enter Remarks",
                                                      helperStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .merge(
                                                              const TextStyle(
                                                                  fontSize:
                                                                      18)),
                                                      border:
                                                          const OutlineInputBorder()),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .merge(const TextStyle(
                                                          fontSize: 18)),
                                                  maxLines: 6,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MSkollBtn(
                                            title: "Approve",
                                            onPress: () {},
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          MSkollBtn(
                                            title: "Reject ",
                                            onPress: () {},
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          MSkollBtn(
                                            title: "Cancel ",
                                            onPress: () {},
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ).marginSymmetric(
                                      horizontal: 20, vertical: 20)),
                            ]),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }
  
  void updateCounts() {
    widget.controller.approvedCount.value =
        widget.controller.radioItems.where((item) => item.isApproved).length;
    widget.controller.rejectedCount.value =
        widget.controller.radioItems.where((item) => item.isRejected).length;
  }

  @override
  void dispose() {
    super.dispose();
   
    widget.controller.timeArrayList.clear();
    widget.controller.sourcesList.clear();
    widget.controller.paymentDetails.clear();
    widget.controller.accomdationList.clear();
    widget.controller.sancationAmountEt.clear();
    widget.controller.percentageET.clear();
    widget.controller.approvalRemarkEt.clear();
    widget.controller.getPlanerListData.clear();
    widget.controller.chartData.clear();
      totalSanctionAmount.close();
 
  }
}

String getDate(DateTime dt) {
  return "${dt.day}-${dt.month}-${dt.year}";
}

String dayCounts(String fromDate, String toDate) {
  final berlinWallFell = DateTime.parse(toDate);
  final dDay = DateTime.parse(fromDate);

  final difference = berlinWallFell.difference(dDay).inDays + 1;
  return "$difference";
}

String timeFormate(String dt) {
  DateTime time = DateFormat("HH:mm").parse(dt);
  String timeFrmt = DateFormat("hh:mm a").format(time);
  return timeFrmt;
}
