import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/apis/tada_details_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/controller/tada_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/model/tada_apply_list.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_a._approval/widgets/update_tada_table.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class TADADetailsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final TADAController tadaController;
  final int vtadaaaId;
  final GetadvancetadaValues values;

  final String date;
  const TADADetailsScreen(
      {super.key,
      required this.tadaController,
      required this.date,
      required this.vtadaaaId,
      required this.values,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<TADADetailsScreen> createState() => _TADADetailsScreenState();
}

class _TADADetailsScreenState extends State<TADADetailsScreen> {
  final remarkController = TextEditingController();
  final sanctionController = TextEditingController();
  String fromDate = '';
  String toDate = '';
  String fromTime = '';
  String toTime = '';
  Map<String, dynamic> headArray = {};
  // ignore: prefer_typing_uninitialized_variables
  var day;
  _getData() async {
    widget.tadaController.updateIsLoading(true);
    await TADADetailsAPI.instance.tadaDetails(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        userId: widget.values.userId!,
        tadaController: widget.tadaController,
        vtaDaaaId: widget.vtadaaaId);
    setState(() {
      DateTime dt = DateTime.parse(widget.values.vTADAAAFromDate!);
      fromDate = '${dt.day}-${dt.month}-${dt.year}';
      DateTime toDt = DateTime.parse(widget.values.vTADAAAToDate!);
      toDate = '${toDt.day}-${toDt.month}-${toDt.year}';
      DateTime dt1 = DateTime.parse(widget.values.vTADAAAFromDate!);
      DateTime dt2 = DateTime.parse(widget.values.vTADAAAToDate!);
      int diff = dt2.difference(dt1).inDays;
      day = diff + 1;
    });
    widget.tadaController.updateIsLoading(false);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const CustomAppBar(title: "TADA Advance Details").getAppBar(),
        body: widget.tadaController.isLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading",
                    desc:
                        "Please wait while we load TADA lists and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomContainer(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Company Name: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.mIName ?? "N/a",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Staff Name: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.empName ?? "N/a",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "City: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.cityName ?? "N/a",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Applied Date: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.date,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Date: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: fromDate,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: " To ",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: toDate,
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Applied Amount: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.vTADAAATotalAppliedAmount
                                      .toString(),
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Remarks: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.vTADAAARemarks ?? "N/a",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Client Name: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.clientName ?? "N/a",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Address: ",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor)),
                              TextSpan(
                                  text: widget.values.vTADAAAToAddress ?? "N/a",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          const SizedBox(height: 10),
                          widget.tadaController.newTimeArray.isNotEmpty
                              ? Obx(() {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "TADA Advance Travel Details",
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: _createTable()),
                                      ),
                                    ],
                                  );
                                })
                              : const Center(
                                  child: AnimatedProgressWidget(
                                    title: "No Data Found",
                                    desc: "",
                                    animationPath: "assets/json/nodata.json",
                                    animatorHeight: 200,
                                  ),
                                ),
                        ],
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  (widget.tadaController.tadaEditValues.isEmpty)
                      ? const SizedBox()
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                UpdateTADATable(
                                  tadaController: widget.tadaController,
                                  amount:
                                      widget.values.vTADAAATotalAppliedAmount!,
                                  values: widget.values,
                                  mskoolController: widget.mskoolController,
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
      );
    });
  }

  DataTable _createTable() {
    return DataTable(
        dataRowHeight: 35,
        headingRowHeight: 40,
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
        rows: createRow());
  }

  List<DataColumn> createColumn() {
    return const [
      DataColumn(label: Text("SL.NO.")),
      DataColumn(label: Text("City")),
      DataColumn(label: Text("Days")),
      DataColumn(label: Text("Form Date")),
      DataColumn(label: Text("Departure Time")),
      DataColumn(label: Text("To Date")),
      DataColumn(label: Text("Arrival Time")),
    ];
  }

  List<DataRow> createRow() {
    return List.generate(widget.tadaController.newTimeArray.length, (index) {
      var value = index + 1;
      var v = widget.tadaController.newTimeArray.elementAt(index);

      return DataRow(cells: [
        DataCell(Text(value.toString())),
        DataCell(Text(widget.values.cityName ?? "")),
        DataCell(Text(day.toString())),
        DataCell(Text(fromDate)),
        DataCell(Text(v.vtadaaADepartureTime!)),
        DataCell(Text(toDate)),
        DataCell(Text(v.vtadaaAArrivalTime!)),
      ]);
    });
  }
}
