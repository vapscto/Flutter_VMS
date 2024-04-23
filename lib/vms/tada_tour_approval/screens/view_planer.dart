import 'package:flutter/material.dart';
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

class ViewTourPLan extends StatefulWidget {
  final GetTourViewValues getTourViewValues;
  final String planerNme;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final TadaTourController controller;
  const ViewTourPLan(
      {required this.getTourViewValues,
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

  @override
  void initState() {
    dayCount = dayCounts(widget.getTourViewValues.vTADAAAFromDate!,
        widget.getTourViewValues.vTADAAAToDate!);
    initApi();

    super.initState();
  }

  initApi() async {
    // logger.w("hrme${widget.getTourViewValues.hRMEId!}");
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
                        child: Column(children: [
                          Container(
                            width: width,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.blue, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
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
                                                    color: Colors.blue[600]))),
                                        TextSpan(
                                            text:
                                                widget.getTourViewValues.mIName,
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
                                                    color: Colors.blue[600]))),
                                        TextSpan(
                                            text: getDate(DateTime.parse(widget
                                                .getTourViewValues
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
                                                    color: Colors.blue[600]))),
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
                                                    color: Colors.blue[600]))),
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
                                                    color: Colors.blue[600]))),
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
                                                    color: Colors.blue[600]))),
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
                              width: width,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.blue, width: 2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      scrollDirection: Axis.horizontal,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: DataTable(
                                            dataTextStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.95),
                                                fontWeight: FontWeight.w500),
                                            dataRowHeight: 50,
                                            headingRowHeight: 40,
                                            horizontalMargin: 10,
                                            columnSpacing: 30,
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
                                                    Theme.of(context)
                                                        .primaryColor),
                                            columns: const [
                                              DataColumn(
                                                label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("SL.No"),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Tour Plan Name"),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Day"),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("FromDate"),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Departure Time"),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Todate"),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Arrival Time"),
                                                ),
                                              ),
                                            ],
                                            rows: List.generate(1, (index) {
                                              return DataRow(cells: [
                                                DataCell(Align(
                                                  child: Text("${index + 1}"),
                                                )),
                                                DataCell(Align(
                                                  child: Text(widget.planerNme
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
                                                  child: Text(timeFormate(widget
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
                                                  child: Text(timeFormate(widget
                                                      .controller
                                                      .timeArrayList
                                                      .first
                                                      .vtadaaAArrivalTime!)),
                                                )),
                                              ]);
                                            }),
                                          ))),
                                  Obx(
                                    () => widget.controller.getTadaCategory
                                            .isNotEmpty
                                        ? SingleChildScrollView(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 0),
                                            scrollDirection: Axis.horizontal,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: DataTable(
                                                  dataTextStyle:
                                                      const TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.95),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  dataRowHeight: 50,
                                                  headingRowHeight: 40,
                                                  horizontalMargin: 10,
                                                  columnSpacing: 30,
                                                  dividerThickness: 1,
                                                  headingTextStyle:
                                                      const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                  border: TableBorder.all(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      width: 0.5),
                                                  headingRowColor:
                                                      MaterialStateProperty.all(
                                                          Theme.of(context)
                                                              .primaryColor),
                                                  columns: const [
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(""),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text("Closure"),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text("HOT"),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            Text("Follow Up"),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text("Cold"),
                                                      ),
                                                    ),
                                                  ],
                                                  rows:
                                                      List.generate(1, (index) {
                                                    return DataRow(cells: [
                                                      const DataCell(Align(
                                                        child:
                                                            Text("Percentage"),
                                                      )),
                                                      DataCell(Align(
                                                        child: Text(
                                                          "${widget.controller.getTadaCategory[0].iMRCPercentage.toString()} %",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      )),
                                                      DataCell(Align(
                                                        child: Text(
                                                          "${widget.controller.getTadaCategory[1].iMRCPercentage.toString()} %",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      )),
                                                      //from date
                                                      DataCell(Align(
                                                        child: Text(
                                                          "${widget.controller.getTadaCategory[2].iMRCPercentage!.toInt().toString()} %",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      )),
                                                      // departure time
                                                      DataCell(Align(
                                                        child: Text(
                                                          "${widget.controller.getTadaCategory[3].iMRCPercentage!.toInt().toString()} %",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      )),
                                                    ]);
                                                  }),
                                                )))
                                        : SizedBox(),
                                  )
                                ],
                              ).marginSymmetric(horizontal: 20, vertical: 20))
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
