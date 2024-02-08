import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/api/certificate_api.dart';
import 'package:m_skool_flutter/vms/certificate_approval/controller/certificate_controller.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certi_emp_list.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:m_skool_flutter/widget/reject_btn.dart';

class CertificateApprovalSheet extends StatefulWidget {
  final CertificateController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String iSMCERTREQId;
  final String hrmeId;
  const CertificateApprovalSheet(
      {super.key,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.iSMCERTREQId,
      required this.hrmeId});

  @override
  State<CertificateApprovalSheet> createState() =>
      _CertificateApprovalSheetState();
}

class _CertificateApprovalSheetState extends State<CertificateApprovalSheet> {
  List<int> newImage = [];
  final remarkController = TextEditingController();
  final employeeController = TextEditingController();
  int hrmeId = 0;
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  CerEmployListModelValues? selectedEmployee;
  _loadData() async {
    widget.controller.certificatDocList.clear();
    widget.controller.previousApprovedList.clear();
    widget.controller.viewList.clear();
    widget.controller.employeeList.clear();
    widget.controller.approvedloading(true);
    await CertificateLoadAPI.instance.documentLoad(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: widget.controller,
        iSMCERTREQId: widget.iSMCERTREQId,
        userId: widget.loginSuccessModel.userId!,
        hrmeId: widget.hrmeId);
    widget.controller.approvedloading(false);
    if (widget.controller.certificatDocList.isEmpty) {
      Fluttertoast.showToast(
          msg: "Certificate Is Not Uploaded In Employee Registration");
      Get.back();
      return;
    }
    setState(() {});
  }

  _saveData(
    Map<String, dynamic> data,
  ) async {
    widget.controller.aprove(true);
    await CertificateLoadAPI.instance.approveCertificate(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: widget.controller,
        body: data);
    widget.controller.aprove(false);
    widget.controller.certificatelist.clear();
    widget.controller.certificateApprovalList.clear();
    widget.controller.loading(true);
    await CertificateLoadAPI.instance.certificateLoad(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: widget.controller,
        userId: widget.loginSuccessModel.userId!);
    widget.controller.loading(false);
    Get.back();
  }

  DateTime dt = DateTime.now();

  @override
  void initState() {
    newImage.add(1);
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.controller.isApprovedloading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AnimatedContainer(
              duration: const Duration(milliseconds: 10),
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color.fromARGB(255, 247, 140, 140),
                  //     Color.fromARGB(255, 155, 248, 158)
                  //   ],
                  //   begin: Alignment.bottomLeft,
                  //   end: Alignment.topRight,
                  // ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 2.1),
                        blurRadius: 3,
                        spreadRadius: 1,
                        color: Colors.black12)
                  ]),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        (widget.controller.employeeData.isNotEmpty)
                            ? Column(
                                children: [
                                  Text(
                                    'Employee Details',
                                    style: Get.textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: const Border(
                                                left: BorderSide(
                                                    color: Colors.grey),
                                                right: BorderSide(
                                                    color: Colors.grey),
                                                top: BorderSide(
                                                    color: Colors.grey),
                                                bottom: BorderSide(
                                                    color: Colors.grey))),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            widget.controller.employeeData.last
                                                .hRMEPhoto!,
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Image.network(
                                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Employee Name:',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  TextSpan(
                                                      text:
                                                          ' ${widget.controller.employeeData.last.employeename}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Date of joining:',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  TextSpan(
                                                      text: dateFormat(
                                                          DateTime.parse(widget
                                                              .controller
                                                              .employeeData
                                                              .last
                                                              .hRMEDOJ!)),
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Department:',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  TextSpan(
                                                      text:
                                                          ' ${widget.controller.employeeData.last.hRMDDepartmentName}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Designation:',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  TextSpan(
                                                      text:
                                                          ' ${widget.controller.employeeData.last.hRMDESDesignationName}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Company Name:',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  TextSpan(
                                                      text:
                                                          ' ${widget.controller.employeeData.last.mIName}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        // const SizedBox(height: 10),
                        // ignore: unrelated_type_equality_checks
                        ((widget.controller.maxLevel - 1) ==
                                widget.controller.viewList.first
                                    .hrpaoNSanctionLevelNo)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey)),
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Certificate Receive Date",
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(color: Colors.red),
                                      ),
                                      const SizedBox(height: 25),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomContainer(
                                              child: TextField(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                                readOnly: true,
                                                controller: _startDate,
                                                onTap: () async {
                                                  fromDate =
                                                      await showDatePicker(
                                                    context: context,
                                                    helpText:
                                                        "Select From Data",
                                                    firstDate: DateTime(2000),
                                                    initialDate: DateTime.now(),
                                                    lastDate: DateTime(3050),
                                                  );
                                                  if (fromDate != null) {
                                                    setState(() {
                                                      _startDate.text =
                                                          "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                                                    });
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                    onPressed: () async {
                                                      fromDate =
                                                          await showDatePicker(
                                                        helpText:
                                                            "Select From Data",
                                                        context: context,
                                                        firstDate:
                                                            DateTime(2000),
                                                        initialDate:
                                                            DateTime.now(),
                                                        lastDate:
                                                            DateTime(3050),
                                                      );
                                                      if (fromDate != null) {
                                                        setState(() {
                                                          _startDate.text =
                                                              "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                                                        });
                                                      }
                                                    },
                                                    icon: SvgPicture.asset(
                                                      "assets/svg/calendar_icon.svg",
                                                      color: const Color(
                                                          0xFF3E78AA),
                                                      height: 18,
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          top: 40.0, left: 12),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  label: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 8.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        color: const Color(
                                                            0xFFE5F3FF)),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/svg/calendar_icon.svg",
                                                          color: const Color(
                                                              0xFF3E78AA),
                                                          height: 18,
                                                        ),
                                                        const SizedBox(
                                                          width: 6.0,
                                                        ),
                                                        Text(
                                                          " Start Date ",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium!
                                                                  .merge(
                                                                    const TextStyle(
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Color(
                                                                          0xFF3E78AA),
                                                                    ),
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  hintText: 'Select Date',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          Expanded(
                                            child: CustomContainer(
                                              child: TextField(
                                                readOnly: true,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                                controller: _endDate,
                                                onTap: () async {
                                                  if (fromDate != null) {
                                                    toDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      helpText:
                                                          "Select To Date",
                                                      firstDate: fromDate!,
                                                      initialDate: fromDate!,
                                                      lastDate: DateTime(3050),
                                                    );
                                                    if (toDate != null) {
                                                      _endDate.text =
                                                          "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please Select Start Date");
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          top: 40.0, left: 12),
                                                  suffixIcon: IconButton(
                                                    onPressed: () async {
                                                      if (fromDate != null) {
                                                        toDate =
                                                            await showDatePicker(
                                                          context: context,
                                                          helpText:
                                                              "Select To Date",
                                                          firstDate: fromDate!,
                                                          initialDate:
                                                              fromDate!,
                                                          lastDate:
                                                              DateTime(3050),
                                                          fieldHintText:
                                                              'Date:Month:Year',
                                                        );
                                                        if (toDate != null) {
                                                          _endDate.text =
                                                              "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                                        }
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Select Start Date");
                                                      }
                                                    },
                                                    icon: SvgPicture.asset(
                                                      "assets/svg/calendar_icon.svg",
                                                      color: const Color(
                                                          0xFF3E78AA),
                                                      height: 18,
                                                    ),
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  label: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 8.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        color: const Color(
                                                            0xFFE5F3FF)),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/svg/calendar_icon.svg",
                                                          color: const Color(
                                                              0xFF3E78AA),
                                                          height: 18,
                                                        ),
                                                        const SizedBox(
                                                          width: 6.0,
                                                        ),
                                                        Text(
                                                          " End Date ",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium!
                                                                  .merge(
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            18.0,
                                                                        color: Color(
                                                                            0xFF3E78AA)),
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  hintText: 'Select Date',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      (widget.controller.employeeList.isEmpty)
                                          ? const SizedBox()
                                          : Container(
                                              height: 60,
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    offset: Offset(0, 1),
                                                    blurRadius: 8,
                                                    color: Colors.black12,
                                                  ),
                                                ],
                                              ),
                                              child: TypeAheadFormField<
                                                  CerEmployListModelValues>(
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                  style:
                                                      Get.textTheme.titleSmall,
                                                  controller:
                                                      employeeController,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14),
                                                      hintText: widget
                                                              .controller
                                                              .employeeList
                                                              .isNotEmpty
                                                          ? 'Search Employee'
                                                          : 'No data available',
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      label:
                                                          const CustomDropDownLabel(
                                                        icon:
                                                            'assets/images/prof4.png',
                                                        containerColor:
                                                            Color.fromRGBO(212,
                                                                194, 247, 1),
                                                        text: 'Hand OverTo',
                                                        textColor:
                                                            Color.fromRGBO(107,
                                                                51, 196, 1),
                                                      ),
                                                      suffixIcon: const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.black,
                                                        size: 30,
                                                      )),
                                                ),
                                                suggestionsCallback: (pattern) {
                                                  return widget
                                                      .controller.employeeList
                                                      .where((fruit) => fruit
                                                          .hrmEEmployeeFirstName!
                                                          .toLowerCase()
                                                          .contains(pattern
                                                              .toLowerCase()));
                                                },
                                                itemBuilder:
                                                    (context, suggestion) {
                                                  return ListTile(
                                                    onTap: () {
                                                      employeeController.text =
                                                          suggestion
                                                              .hrmEEmployeeFirstName!;
                                                      hrmeId =
                                                          suggestion.hrmEId!;
                                                      logger.d(hrmeId);
                                                    },
                                                    title: Text(
                                                      suggestion
                                                          .hrmEEmployeeFirstName!,
                                                      style: Get
                                                          .textTheme.titleSmall,
                                                    ),
                                                  );
                                                },
                                                onSuggestionSelected:
                                                    (suggestion) {},
                                                noItemsFoundBuilder: (context) {
                                                  return const SizedBox();
                                                },
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 10),
                        Text(
                          'Employee Certificates',
                          style: Get.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        (widget.controller.certificatDocList.isEmpty)
                            ? const SizedBox()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: DataTable(
                                      dataRowHeight: 35,
                                      headingRowHeight: 40,
                                      columnSpacing: 20,
                                      headingTextStyle:
                                          const TextStyle(color: Colors.white),
                                      border: TableBorder.all(
                                        color: Colors.black,
                                        width: 0.6,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Theme.of(context)
                                                  .primaryColor),
                                      columns: const [
                                        DataColumn(label: Text("SL.NO.")),
                                        DataColumn(
                                            label: Text("Document Name")),
                                        DataColumn(label: Text("View")),
                                      ],
                                      rows: List.generate(
                                          widget.controller.certificatDocList
                                              .length, (index) {
                                        var v = index + 1;
                                        var value = widget
                                            .controller.certificatDocList
                                            .elementAt(index);
                                        return DataRow(cells: [
                                          DataCell(Text(v.toString())),
                                          DataCell(Text(value.hrmedSDocumentName
                                              .toString())),
                                          DataCell(IconButton(
                                            onPressed: () {
                                              createPreview(
                                                  context,
                                                  value
                                                      .hrmedSDocumentImageName!);
                                            },
                                            icon: Icon(
                                              Icons.visibility,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )),
                                        ]);
                                      })),
                                ),
                              ),
                        const SizedBox(height: 16),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Employee Remarks:',
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text:
                                      ' ${widget.controller.employeeRemarks.value}',
                                  style: Get.textTheme.titleSmall!.copyWith()),
                            ],
                          ),
                        ),
                        (widget.controller.previousApprovedList.isNotEmpty)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: InkWell(
                                  onTap: () {
                                    Get.dialog(_getDialog());
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Previous Approver Remark ",
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      Icon(
                                        Icons.visibility,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 25),
                        CustomContainer(
                            child: TextFormField(
                          style: Get.textTheme.titleSmall,
                          maxLines: 2,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          controller: remarkController,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 12),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            hintText: "Approve Remark",
                            label: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFFBFE),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/noteicon.svg',
                                    color:
                                        const Color.fromRGBO(40, 182, 200, 1),
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    "Approve Remark",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(
                                          const TextStyle(
                                            fontSize: 20.0,
                                            color:
                                                Color.fromRGBO(40, 182, 200, 1),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              (widget.controller.isApprove.value == false)
                                  ? MSkollBtn(
                                      title: 'Approve',
                                      onPress: () {
                                        // ignore: unrelated_type_equality_checks
                                        if ((widget.controller.maxLevel - 1) ==
                                            widget.controller.viewList.first
                                                .hrpaoNSanctionLevelNo) {
                                          if (_endDate.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: "Enter To date");
                                            return;
                                          } else if (hrmeId == 0) {
                                            Fluttertoast.showToast(
                                                msg: "Select Hand OverTo");
                                            return;
                                          } else if (remarkController
                                              .text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: "Add Remarks");
                                            return;
                                          } else {
                                            _saveData({
                                              "UserId": widget
                                                  .loginSuccessModel.userId,
                                              "MI_Id":
                                                  widget.loginSuccessModel.mIID,
                                              "Fromdate":
                                                  fromDate!.toIso8601String(),
                                              "HRME_Id": hrmeId,
                                              "ISMCERTREQAPP_AppRejFlag":
                                                  "Approved",
                                              "ISMCERTREQAPP_Remarks":
                                                  remarkController.text,
                                              "ISMCERTREQ_FilePath":
                                                  "undefined",
                                              "ISMCERTREQ_Id":
                                                  widget.iSMCERTREQId,
                                              "Todate":
                                                  toDate!.toIso8601String(),
                                              "maxmumlevel": widget
                                                  .controller
                                                  .viewList
                                                  .first
                                                  .hrpaoNSanctionLevelNo
                                            });
                                            return;
                                          }
                                        } else {
                                          if (remarkController.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: "Add Remarks");
                                            return;
                                          } else {
                                            _saveData({
                                              "UserId": widget
                                                  .loginSuccessModel.userId,
                                              "MI_Id":
                                                  widget.loginSuccessModel.mIID,
                                              "Fromdate": dt.toIso8601String(),
                                              "HRME_Id": 0,
                                              "ISMCERTREQAPP_AppRejFlag":
                                                  "Approved",
                                              "ISMCERTREQAPP_Remarks":
                                                  remarkController.text,
                                              "ISMCERTREQ_FilePath":
                                                  "undefined",
                                              "ISMCERTREQ_Id":
                                                  widget.iSMCERTREQId,
                                              "Todate": dt.toIso8601String(),
                                              "maxmumlevel": widget
                                                  .controller
                                                  .viewList
                                                  .first
                                                  .hrpaoNSanctionLevelNo
                                            });
                                          }
                                        }
                                      })
                                  : const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                              (widget.controller.isApprove.value == false)
                                  ? RejectBtn(
                                      title: 'Reject',
                                      onPress: () {
                                        if (remarkController.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: "Add Remarks");
                                          return;
                                        } else {
                                          _saveData({
                                            "UserId":
                                                widget.loginSuccessModel.userId,
                                            "MI_Id":
                                                widget.loginSuccessModel.mIID,
                                            "Fromdate": dt.toIso8601String(),
                                            "HRME_Id": 0,
                                            "ISMCERTREQAPP_AppRejFlag":
                                                "Rejected",
                                            "ISMCERTREQAPP_Remarks":
                                                remarkController.text,
                                            "ISMCERTREQ_FilePath": "undefined",
                                            "ISMCERTREQ_Id":
                                                widget.iSMCERTREQId,
                                            "Todate": dt.toIso8601String(),
                                            "maxmumlevel": widget
                                                .controller
                                                .viewList
                                                .first
                                                .hrpaoNSanctionLevelNo
                                          });
                                        }
                                      },
                                    )
                                  : const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
    });
  }

  _getDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DataTable(
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
                    columns: const [
                      DataColumn(label: Text("SL.NO.")),
                      DataColumn(label: Text("Approver Name")),
                      DataColumn(label: Text("Approved Date")),
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("Remarks")),
                    ],
                    rows: List.generate(
                        widget.controller.previousApprovedList.length, (index) {
                      var v = index + 1;
                      var value = widget.controller.previousApprovedList
                          .elementAt(index);
                      return DataRow(cells: [
                        DataCell(Text(v.toString())),
                        DataCell(Text(value.hrmEEmployeeFirstName.toString())),
                        DataCell(Text(dateFormat(
                            DateTime.parse(value.ismcertreqapPApprovedDate!)))),
                        DataCell(Text(value.ismcertreqapPAppRejFlag!)),
                        DataCell(Text(value.ismcertreqapPRemarks!))
                      ]);
                    })),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Close",
                  style: Get.textTheme.titleMedium,
                )),
          )
        ]),
      ),
    );
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }
}
