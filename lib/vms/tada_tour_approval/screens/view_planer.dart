import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/api/edit_tour_api.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/api/get_view.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/api/save_tada_tour.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_tour_view_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/screens/add_lead_screen.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

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
  List<Map<String, dynamic>> mapAccomdationList = [];
  List<Map<String, dynamic>> emplyeList = [];
  String tp = "AR";

  var totalApproveCount;
  @override
  void initState() {
    initApi();
    dayCount = dayCounts(widget.getTourViewValues.vTADAAAFromDate!,
        widget.getTourViewValues.vTADAAAToDate!);
    appliedEt.text =
        widget.getTourViewValues.vTADAAATotalAppliedAmount.toString();

    // totalApproveCount = widget.controller.approvedCount.value;
    // logger.e("count1$totalApproveCount");
    super.initState();
  }

  Future<void> addAccomdation(bool tap) async {
    if (mapAccomdationList.isNotEmpty || emplyeList.isNotEmpty) {
      mapAccomdationList.clear();
      emplyeList.clear();
    }
    totalApproveCount = widget.controller.approvedCount.value;
    logger.e("count2$totalApproveCount");
    String planneEndDate = getDate(
        DateTime.parse(widget.getTourViewValues.vTADAAAToDate.toString()));
    String planneStartDate = getDate(
        DateTime.parse(widget.getTourViewValues.vTADAAAFromDate.toString()));
    for (int i = 0; i < widget.controller.accomdationList1.length; i++) {
      if (i != 2) {
        mapAccomdationList.add({
          "VTADAAAAH_SactionedAmount": widget
                  .controller.radioItems[i].isApproved
              ? "${int.parse(widget.controller.sancationAmountEt[i].text)}.00"
              : 0,
          "VTADAAAD_Amount":
              widget.controller.accomdationList1[i].vTADAAADAmount!.toInt(),
          "VTADAAAD_ExpenditureHead":
              widget.controller.accomdationList1[i].vTADAAADExpenditureHead,
          "VTADAAAD_Id": widget.controller.accomdationList1[i].vTADAAADId,
          "VTADAAAD_Slots":
              widget.controller.accomdationList1[i].vTADAAADSlots!.toInt(),
          "VTADAAAD_TotalSlots":
              widget.controller.accomdationList1[i].vTADAAADTotalSlots!.toInt(),
          "VTADAAA_Id": widget.controller.accomdationList1[i].vTADAAAId,
          "VTADACM_AccommodationAmt": widget
              .controller.accomdationList1[i].vTADACMAccommodationAmt!
              .toInt(),
          "VTADACM_FoodAmt":
              widget.controller.accomdationList1[i].vTADACMFoodAmt!.toInt(),
          "VTADACM_TransportAmt": widget
              .controller.accomdationList1[i].vTADACMTransportAmt!
              .toInt(),
          "classname":
              widget.controller.radioItems[i].isApproved ? "neww" : "oldd",
          "flag": tap
              ? widget.controller.radioItems[i].isApproved
                  ? "A"
                  : "R"
              : "R",
          "vtdaA_Percentage": int.parse(widget.controller.percentageET[i].text)
        });
      } else {
        mapAccomdationList.add({
          "VTADAAAAH_SactionedAmount": widget
                  .controller.radioItems[i].isApproved
              ? "${int.parse(widget.controller.sancationAmountEt[i].text)}.00"
              : 0,
          "VTADAAAD_Amount":
              widget.controller.accomdationList1[i].vTADAAADAmount!.toInt(),
          "VTADAAAD_ExpenditureHead":
              widget.controller.accomdationList1[i].vTADAAADExpenditureHead,
          "VTADAAAD_Id": widget.controller.accomdationList1[i].vTADAAADId,
          "VTADACM_AccommodationAmt": widget
              .controller.accomdationList1[i].vTADACMAccommodationAmt!
              .toInt(),
          "VTADACM_FoodAmt":
              widget.controller.accomdationList1[i].vTADACMFoodAmt!.toInt(),
          "VTADACM_TransportAmt": widget
              .controller.accomdationList1[i].vTADACMTransportAmt!
              .toInt(),
          "classname":
              widget.controller.radioItems[i].isApproved ? "neww" : "oldd",
          "flag": tap
              ? widget.controller.radioItems[i].isApproved
                  ? "A"
                  : "R"
              : "R",
          "vtdaA_Percentage": int.parse(widget.controller.percentageET[i].text)
        });
      }
    }
    if (widget.controller.adminFlag.value) {
      for (int i = 0; i < widget.controller.getPlanerListData.length; i++) {
        emplyeList.add({
          "CategoryId": widget.controller.getPlanerListData[i].iMRCCategoryId,
          "ClientId": widget.controller.getPlanerListData[i].iSMSLEId,
          "ISMSMPR_Id": widget.controller.getPlanerListData[i].iSMSMPRId
        });
      }
    }
    // if (widget.controller.approvedCount.value == 3) {
    //   tp = "AR";
    // } else if (widget.controller.approvedCount.value < 3 &&
    //     widget.controller.approvedCount.value >= 1) {
    //   tp = "AR";
    // } else
    if (widget.controller.rejectedCount.value == 3) {
      tp = "R";
      totalApproveCount = 0;
    }
    if (tap == false) {
      tp = "R";
      totalApproveCount = 0;
    }
    await saveTadaTour(
            context: context,
            userID: widget.loginSuccessModel.userId!,
            base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
            adminFlag: widget.controller.adminFlag.value,
            approvecount: totalApproveCount,
            hrmeId: widget.getTourViewValues.hRMEId!,
            ierId: widget.getTourViewValues.iERID!,
            leavel: widget.getTourViewValues.sanctionLevelNo!,
            miID: widget.getTourViewValues.mIId!,
            planerEndDate: planneEndDate,
            planerName: widget.planerNme,
            plannerStarDate: planneStartDate,
            tadaRemark: remarkEt.text,
            totalSanctionAmount: tap
                ? int.parse(widget.controller.sancationAmountTotal.value.text)
                : 0,
            tourRemark: "",
            tp: tp,
            vTADAAADId: widget.getTourViewValues.vTADAAAId!,
            empList: widget.controller.adminFlag.value ? emplyeList : [],
            headArray: mapAccomdationList)
        .then(
      (value) {
        Fluttertoast.showToast(msg: "Saved Successfully");
        Get.back();
        Get.back();
      },
    );
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
      widget.controller.sancationAmountTotal.value.text =
          widget.controller.totalSamount.value;
    });
    updateCounts();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.width;
    width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: "View TADA TourMap", action: [
        MSkollBtn(
          title: "Add To Lead",
          onPress: () {
            Get.to(() => AddLeadScreen(
                  hrmeId: widget.getTourViewValues.hRMEId!,
                  miID: widget.loginSuccessModel.mIID!,
                  tadaTourController: widget.controller,
                  userId: widget.loginSuccessModel.userId!,
                  mskoolController: widget.mskoolController,
                ));
          },
        )
      ]).getAppBar(),
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 1650,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.blue, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "Company Name : ",
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
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SingleChildScrollView(
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
                                                        child: Text("FromDate"),
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
                                                  rows:
                                                      List.generate(1, (index) {
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
                                                        child: Text(timeFormate(
                                                            widget
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
                                                        child: Text(timeFormate(
                                                            widget
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
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: DataTable(
                                                          dataTextStyle:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color.fromRGBO(
                                                                      0, 0, 0, 0.95),
                                                                  fontWeight: FontWeight.w500),
                                                          dataRowHeight: 50,
                                                          headingRowHeight: 40,
                                                          horizontalMargin: 10,
                                                          columnSpacing: 30,
                                                          dividerThickness: 1,
                                                          headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                                          border: TableBorder.all(borderRadius: BorderRadius.circular(10), width: 0.5),
                                                          headingRowColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                                          columns: widget.controller.columns,
                                                          rows: [
                                                            DataRow(
                                                                cells: widget
                                                                    .controller
                                                                    .rows)
                                                          ])))
                                              : const SizedBox(),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Obx(
                                          () =>
                                              widget.controller.getTadaCategory
                                                      .isNotEmpty
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
                                                                    fontSize:
                                                                        14,
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 0),
                                            // scrollDirection: Axis.horizontal,
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
                                                        child:
                                                            Text("Source Name"),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            Text("Created By"),
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
                                                        child:
                                                            Text("State Name"),
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
                                                        style: Theme.of(context)
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
                                                              .elementAt(index)
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
                                                              .elementAt(index)
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
                                                              .elementAt(index)
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
                                                              .elementAt(index)
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
                                                              .elementAt(index)
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
                                                              .elementAt(index)
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
                                                              .elementAt(index)
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

                                                      DataCell(Align(
                                                        child: InkWell(
                                                          onTap: () {
                                                            widget.controller
                                                                .getPlanerListData
                                                                .remove(widget
                                                                    .controller
                                                                    .getPlanerListData
                                                                    .elementAt(
                                                                        index));
                                                            setState(() {
                                                              widget
                                                                  .controller
                                                                  .adminFlag
                                                                  .value = true;
                                                            });
                                                            for (var element
                                                                in widget
                                                                    .controller
                                                                    .getPlanerListData) {
                                                              logger.w(element
                                                                  .iSMSLELeadName);
                                                            }
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            size: 30,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                        ),
                                                      ))
                                                    ]);
                                                  }),
                                                )))
                                        : const SizedBox()),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () =>
                                              widget.controller.accomdationList1
                                                      .isNotEmpty
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
                                                                    fontSize:
                                                                        14,
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
                                                                    .accomdationList1
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
                                                                      ? const MaterialStatePropertyAll(
                                                                          Colors
                                                                              .redAccent)
                                                                      : const MaterialStatePropertyAll(
                                                                          Colors
                                                                              .white),
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
                                                                        value: radioBtn
                                                                            .value,
                                                                        groupValue: widget
                                                                            .controller
                                                                            .radioItems[index]
                                                                            .isApproved,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            widget.controller.radioItems[index].isApproved =
                                                                                value as bool;
                                                                            widget.controller.radioItems[index].isRejected =
                                                                                !value;
                                                                            widget.controller.sancationAmountEt[index].text = widget.controller.radioItems[index].isApproved
                                                                                ? widget.controller.accomdationList1[index].vTADAAADAmount!.toInt().toString()
                                                                                : "0";
                                                                            //

                                                                            updateCounts();
                                                                          });
                                                                          setState(
                                                                              () {
                                                                            calPercnt(index);
                                                                          });
                                                                        },
                                                                      ),
                                                                    )),
                                                                    DataCell(Align(
                                                                        child: Radio(
                                                                      value: radioBtn
                                                                          .value,
                                                                      groupValue: widget
                                                                          .controller
                                                                          .radioItems[
                                                                              index]
                                                                          .isRejected,
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          widget
                                                                              .controller
                                                                              .radioItems[index]
                                                                              .isRejected = value as bool;
                                                                          widget
                                                                              .controller
                                                                              .radioItems[index]
                                                                              .isApproved = !value;
                                                                          widget
                                                                              .controller
                                                                              .sancationAmountEt[
                                                                                  index]
                                                                              .text = widget
                                                                                  .controller.radioItems[index].isRejected
                                                                              ? "0"
                                                                              : "0";
                                                                          setState(
                                                                              () {
                                                                            calPercnt(index);
                                                                          });
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
                                                                            .accomdationList1
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
                                                                        index ==
                                                                                0
                                                                            ? widget.controller.accomdationList1.elementAt(index).vTADACMAccommodationAmt!.toInt().toString()
                                                                            : index == 1
                                                                                ? widget.controller.accomdationList1.elementAt(index).vTADACMFoodAmt!.toInt().toString()
                                                                                : index == 2
                                                                                    ? widget.controller.accomdationList1.elementAt(index).vTADACMTransportAmt!.toInt().toString()
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
                                                                            .accomdationList1
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
                                                                            .accomdationList1
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
                                                                            .accomdationList1
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
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly,
                                                                          LengthLimitingTextInputFormatter(
                                                                              2)
                                                                        ],
                                                                        onChanged:
                                                                            (value) {
                                                                          calPercnt(
                                                                              index);
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
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            widget.controller.sancationAmountTotal.value.text =
                                                                                widget.controller.totalSamount.value;
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
                                          width: 20,
                                        ),
                                        Obx(
                                          () => widget.controller.paymentDetails
                                                  .isNotEmpty
                                              ? SingleChildScrollView(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                        columnSpacing: 10,
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
                                                              child:
                                                                  Text("SL NO"),
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
                                                          int num = index + 1;
                                                          return DataRow(
                                                              cells: [
                                                                DataCell(Align(
                                                                  child: Text(
                                                                      "$num"),
                                                                )),
                                                                DataCell(Align(
                                                                  child: Text(widget
                                                                      .controller
                                                                      .paymentDetails
                                                                      .elementAt(
                                                                          index)
                                                                      .totalAppliedAmount!
                                                                      .toInt()
                                                                      .toString()),
                                                                )),
                                                                DataCell(Align(
                                                                  child: Text(widget
                                                                      .controller
                                                                      .paymentDetails
                                                                      .elementAt(
                                                                          index)
                                                                      .totalAppliedAmountByPart!
                                                                      .toInt()
                                                                      .toString()),
                                                                )),
                                                                DataCell(Align(
                                                                  child: Text(widget
                                                                      .controller
                                                                      .paymentDetails
                                                                      .elementAt(
                                                                          index)
                                                                      .paymentTime!
                                                                      .toInt()
                                                                      .toString()),
                                                                )),
                                                                DataCell(Align(
                                                                  child: Text(widget
                                                                      .controller
                                                                      .paymentDetails
                                                                      .elementAt(
                                                                          index)
                                                                      .paymentMode!),
                                                                )),
                                                              ]);
                                                        }),
                                                      )))
                                              : const SizedBox(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /**    Obx(
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
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        */
                                        SizedBox(
                                          height: 250,
                                          width: 250,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                  "Total Applied Amount :"),
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
                                                  decoration: const InputDecoration(
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
                                        SizedBox(
                                          width: 420,
                                          height: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Remarks",
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextField(
                                                controller: remarkEt,
                                                decoration: InputDecoration(
                                                    hintText: "Enter Remarks",
                                                    helperStyle: Theme.of(
                                                            context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .merge(const TextStyle(
                                                            fontSize: 18)),
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
                                          MainAxisAlignment.start,
                                      children: [
                                        MSkollBtn(
                                          title: "Approve",
                                          onPress: () async {
                                            Get.dialog(AlertDialog(
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              contentPadding:
                                                  const EdgeInsets.all(8),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              content: SizedBox(
                                                  width: Get.width,
                                                  child: SizedBox(
                                                    height: 240,
                                                    child: Center(
                                                      child: Text(
                                                        "Please Wait...",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .merge(const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        39,
                                                                        4,
                                                                        196))),
                                                      ),
                                                    ),
                                                  )),
                                            ));

                                            await addAccomdation(true);
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        MSkollBtn(
                                          title: "Reject ",
                                          onPress: () async {
                                            await addAccomdation(false);
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        MSkollBtn(
                                          title: "Cancel ",
                                          onPress: () {
                                            clearAll();

                                            Get.back();
                                          },
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
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  calPercnt(int index) {
    var percent = int.parse(widget.controller.percentageET[index].text);
    var amounts = widget.controller.radioItems[index].isApproved
        ? widget.controller.accomdationList1.elementAt(index).vTADAAADAmount!
        : double.parse("00");
    double sancationAmount = amounts * (percent / 100);
    widget.controller.sancationAmountEt[index].text =
        sancationAmount.toInt().toString();
    setState(() {
      widget.controller.calculateSum();
      widget.controller.sancationAmountTotal.value.text =
          widget.controller.totalSamount.value;
    });
  }

  void updateCounts() {
    widget.controller.approvedCount.value =
        widget.controller.radioItems.where((item) => item.isApproved).length;
    widget.controller.rejectedCount.value =
        widget.controller.radioItems.where((item) => item.isRejected).length;
  }

  @override
  void dispose() {
    clearAll();
    super.dispose();
  }

  clearAll() {
    widget.controller.timeArrayList.clear();
    widget.controller.sourcesList.clear();
    widget.controller.paymentDetails.clear();
    widget.controller.accomdationList1.clear();
    widget.controller.sancationAmountEt.clear();
    widget.controller.percentageET.clear();
    widget.controller.approvalRemarkEt.clear();
    widget.controller.getPlanerListData.clear();
    //widget.controller.chartData.clear();
    totalSanctionAmount.close();
    widget.controller.columns.clear();
    widget.controller.rows.clear();
    widget.controller.radioItems.clear();
    emplyeList.clear();
    widget.controller.adminFlag.value = false;
    mapAccomdationList.clear();
  }
}

String getDate(DateTime dt) {
  return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, "0")}";
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
