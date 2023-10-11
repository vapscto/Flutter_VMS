import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/api/employee_list_pc_req_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/api/onload_pc_requisition_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/api/save_req_api.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/controller/cash_requisition_controller.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/department_pc_req_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/employee_list_pc_req_model.dart';
import 'package:m_skool_flutter/vms/petty_cash_requisition/model/particulars_pc_req_model.dart';
import 'package:m_skool_flutter/vms/widgets/drop_down_lebel.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class DataTableRowModel {
  int sno;
  ParticularsPcRequestModelValues? selectedParticular;

  TextEditingController amountCountroller;
  TextEditingController remarksController;

  DataTableRowModel({
    required this.sno,
    required this.selectedParticular,
    required this.amountCountroller,
    required this.remarksController,
  });
}

class PcRequisitionScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PcRequisitionScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<PcRequisitionScreen> createState() => _PcRequisitionScreenState();
}

class _PcRequisitionScreenState extends State<PcRequisitionScreen> {
  final CashRequisitionController cashRequisitionController =
      Get.put(CashRequisitionController());

  final TextEditingController selectDate = TextEditingController();
  List<ParticularsPcRequestModelValues> selectedValues = [];
  RxInt changes = RxInt(-1);

  DepartmentPcRequestModelValues? selectedDepartment;
  EmployeeListPcReqModelValues? selectedEmployee;
  ParticularsPcRequestModelValues? selectedParticular;
  loadData() async {
    await getPcRequisitionOnLoad(
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        roleId: widget.loginSuccessModel.roleId!,
        userId: widget.loginSuccessModel.userId!,
        asmaYId: widget.loginSuccessModel.asmaYId!,
        roleFlag: widget.loginSuccessModel.roleforlogin!,
        controller: cashRequisitionController);
  }

  /* DataTableRowModel Model LIST */ List<DataTableRowModel> rows = [];

  @override
  void initState() {
    loadData();

    rows.add(DataTableRowModel(
      sno: rows.length + 1,
      selectedParticular: selectedParticular,
      amountCountroller: TextEditingController(),
      remarksController: TextEditingController(),
    ));

    totalAmountController.text = totalAmount.toStringAsFixed(2);

    selectDate.text = getDateNeed(DateTime.now());
    super.initState();
  }

  ///*** TOTAL AMOUNT FUNCTIONALITIES ***///

  TextEditingController totalAmountController = TextEditingController();

  double totalAmount = 0.0;

  void updateTotalAmount() {
    double total = 0.0;
    for (var row in rows) {
      if (row.amountCountroller.text.isNotEmpty) {
        total += double.tryParse(row.amountCountroller.text) ?? 0.0;
      }
    }
    totalAmountController.text = total.toStringAsFixed(2);
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var row in rows) {
      if (row.amountCountroller.text.isNotEmpty) {
        total += double.parse(row.amountCountroller.text);
      }
    }
    setState(() {
      totalAmount = total;
    });
  }

  TextEditingController purposeController = TextEditingController();

  ///*** SAVE REQUISITION FUNCTIONALITY ***///

  List<Map<String, dynamic>> reqDetailsDTOList = [];

  void requisitionSaveRecord() {
    reqDetailsDTOList.clear();
    for (int index = 0; index < rows.length; index++) {
      var selectedParticular = rows[index].selectedParticular;
      var amount = rows[index].amountCountroller.text;
      var remarks = rows[index].remarksController.text;

      if (selectedParticular != null) {
        reqDetailsDTOList.add({
          "PCMPART_Id": selectedParticular.pcmparTId,
          "PCMPART_ParticularName": selectedParticular.pcmparTParticularName,
          "PCREQTNDET_Amount": double.parse(amount),
          "PCREQTNDET_Id": cashRequisitionController.employeeList
              .elementAt(index)
              .pcreqtndeTId,
          "PCREQTNDET_Remarks": remarks,
        });
      }
    }

    print(reqDetailsDTOList.toString());
  }

  ////*** SAVE VALIDATION ***////

  bool isLoading = false;

  bool validateFields() {
    if (selectedDepartment == null) {
      Fluttertoast.showToast(msg: "Select department.");
      return false;
    }
    if (selectedEmployee == null) {
      Fluttertoast.showToast(msg: "Select an Employee.");
      return false;
    }
    if (purposeController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter a Purpose.");
      return false;
    }
    if (rows.any((row) => row.selectedParticular == null)) {
      Fluttertoast.showToast(msg: "Select Particular.");
      return false;
    }

    if (rows.any((row) => row.amountCountroller.text.isEmpty)) {
      Fluttertoast.showToast(msg: "Enter Amount.");
      return false;
    }

    if (rows.any((row) => row.remarksController.text.isEmpty)) {
      Fluttertoast.showToast(msg: "Enter remarks.");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, left: 0, right: 0, bottom: 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: DropdownButtonFormField<DepartmentPcRequestModelValues>(
                  value: selectedDepartment,
                  decoration: InputDecoration(
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
                    hintStyle: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            letterSpacing: 0.3)),
                    hintText:
                        cashRequisitionController.departmentList.isNotEmpty
                            ? 'Select Department'
                            : 'No data available',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    isDense: true,
                    label: const CustomDropDownLabel(
                      icon: 'assets/images/Library.png',
                      containerColor: Color.fromRGBO(250, 241, 247, 1),
                      text: 'Select Department',
                      textColor: Color.fromRGBO(252, 77, 173, 1),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    ),
                  ),
                  iconSize: 30,
                  items: List.generate(
                      cashRequisitionController.departmentList.length, (index) {
                    return DropdownMenuItem(
                      value: cashRequisitionController.departmentList[index],
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, left: 5),
                        child: Text(
                          cashRequisitionController
                              .departmentList[index].hrmDDepartmentName!,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    );
                  }),
                  onChanged: (selected) async {
                    setState(() {
                      selectedDepartment = selected;

                      selectedEmployee = null;
                      cashRequisitionController.employeeList.clear();
                    });

                    await getEmployeeListPcReq(
                        miId: widget.loginSuccessModel.mIID!,
                        base: baseUrlFromInsCode(
                            "issuemanager", widget.mskoolController),
                        roleId: widget.loginSuccessModel.roleId!,
                        userId: widget.loginSuccessModel.userId!,
                        asmaYId: widget.loginSuccessModel.asmaYId!,
                        roleFlag: widget.loginSuccessModel.roleforlogin!,
                        hrmdId: selected!.hrmDId!,
                        controller: cashRequisitionController);
                  },
                ),
              ),
              const SizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(
                    top: 30, left: 0, right: 0, bottom: 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: DropdownButtonFormField<EmployeeListPcReqModelValues>(
                  value: selectedEmployee,
                  decoration: InputDecoration(
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
                    hintStyle: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            letterSpacing: 0.3)),
                    hintText: cashRequisitionController.employeeList.isNotEmpty
                        ? 'Select Employee'
                        : 'No data available',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    isDense: true,
                    label: const CustomDropDownLabel(
                      icon: 'assets/images/ClassTeacher.png',
                      containerColor: Color.fromRGBO(250, 238, 253, 1),
                      text: 'Select Employee',
                      textColor: Color.fromRGBO(146, 79, 190, 1),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    ),
                  ),
                  iconSize: 30,
                  items: List.generate(
                      cashRequisitionController.employeeList.length, (index) {
                    final employee =
                        cashRequisitionController.employeeList[index];
                    return DropdownMenuItem(
                      value: employee,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, left: 5),
                        child: Text(
                          cashRequisitionController
                              .employeeList[index].empname!,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    );
                  }),
                  onChanged: (s) {
                    setState(() {
                      selectedEmployee = s;
                    });

                    selectedEmployee = s;
                  },
                ),
              ),
              const SizedBox(height: 35),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: const Color.fromARGB(255, 211, 211, 211)),
                ),
                child: TextField(
                  controller: purposeController,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall,
                  decoration: InputDecoration(
                    hintText: "Enter Purpose",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(136, 189, 187, 187),
                        fontWeight: FontWeight.w700),
                    border: const OutlineInputBorder(),
                    label: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: const Color.fromARGB(255, 230, 255, 235),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/abouticon.png",
                            height: 24.0,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            "Purpose",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .merge(const TextStyle(
                                    fontSize: 20.0,
                                    color: Color.fromARGB(255, 15, 87, 42))),
                          ),
                        ],
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              CustomContainer(
                child: TextField(
                  readOnly: true,
                  controller: selectDate,
                  style: Theme.of(context).textTheme.titleSmall,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                    border: const OutlineInputBorder(),
                    label: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: const Color(0xFFDFFBFE),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/calendar.png",
                            height: 24.0,
                            color: const Color(0xFF28B6C8),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "Select Date",
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
                                      const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF28B6C8),
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Select Date',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () async {
                        DateTime? selectedDT = await showDatePicker(
                          context: context,
                          initialDate: selectDate.text.isNotEmpty
                              ? DateTime.parse(selectDate.text)
                              : DateTime.now(),
                          firstDate: DateTime(1000),
                          lastDate: DateTime(DateTime.now().year, 12, 31),
                        );

                        if (selectedDT == null) {
                          Fluttertoast.showToast(
                              msg: "You didn't select the date");
                          return;
                        }
                        changes.value += 1;

                        selectDate.text = getDate(selectedDT);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          "assets/images/calendar.png",
                          height: 16.0,
                          width: 16.0,
                          color: const Color(0xFF28B6C8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16.0, bottom: 30),
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
                                  fontWeight: FontWeight.w500,
                                ),
                                dataRowHeight: 120,
                                headingRowHeight: 55,
                                horizontalMargin: 10,
                                columnSpacing: 40,
                                dividerThickness: 1,
                                border: TableBorder.all(
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                headingRowColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor,
                                ),
                                columns: const [
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "SLNO",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Particular",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Amount",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Remarks",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Action",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: [
                                  for (var index = 0;
                                      index < rows.length;
                                      index++)
                                    DataRow(
                                      cells: [
                                        DataCell(Text((index + 1).toString())),
                                        DataCell(
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    offset: Offset(0, 1),
                                                    blurRadius: 8,
                                                    color: Colors.black12,
                                                  ),
                                                ],
                                              ),
                                              child: DropdownButtonFormField<
                                                      ParticularsPcRequestModelValues>(
                                                  value: rows[index]
                                                      .selectedParticular,
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15.0,
                                                          color: Color.fromARGB(
                                                              255,
                                                              133,
                                                              132,
                                                              132),
                                                          letterSpacing: 0.5,
                                                        )),
                                                    hintText: cashRequisitionController
                                                            .itemsParticularList
                                                            .isNotEmpty
                                                        ? 'Select Particular'
                                                        : 'No data available',
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    isDense: true,
                                                  ),
                                                  icon: const Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 3),
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  iconSize: 30,
                                                  items: List.generate(
                                                    cashRequisitionController
                                                        .itemsParticularList
                                                        .length,
                                                    (index) {
                                                      return DropdownMenuItem(
                                                        value: cashRequisitionController
                                                                .itemsParticularList[
                                                            index],
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 13,
                                                                  left: 5),
                                                          child: SizedBox(
                                                            width: 180,
                                                            child: Text(
                                                              cashRequisitionController
                                                                  .itemsParticularList[
                                                                      index]
                                                                  .pcmparTParticularName!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .merge(
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.3,
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  onChanged: (selected) async {
                                                    if (selected != null) {
                                                      if (selectedValues
                                                          .contains(selected)) {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Particular already selected",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0,
                                                        );
                                                      } else {
                                                        rows[index]
                                                                .selectedParticular =
                                                            selected;
                                                        selectedValues
                                                            .add(selected);
                                                        print(selected
                                                            .pcmparTParticularName!);
                                                      }
                                                    }
                                                  }),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: 250,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                controller: rows[index]
                                                    .amountCountroller,
                                                onChanged: (value) {
                                                  updateTotalAmount();
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.black12,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          233, 232, 232, 1),
                                                    ),
                                                  ),
                                                  hintText: "Enter Amount",
                                                  hintStyle:
                                                      TextStyle(fontSize: 14),
                                                  fillColor: Color.fromARGB(
                                                      31, 233, 231, 231),
                                                  filled: true,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      7)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: 200,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  controller: rows[index]
                                                      .remarksController,
                                                  decoration:
                                                      const InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black12,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            233, 232, 232, 1),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    hintText: "Write Remarks",
                                                    fillColor: Color.fromARGB(
                                                        31, 233, 231, 231),
                                                  ),
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              if (index == rows.length - 1)
                                                IconButton(
                                                  icon: const Icon(Icons.add),
                                                  onPressed: () {
                                                    setState(() {
                                                      rows.add(
                                                          DataTableRowModel(
                                                        sno: rows.length + 1,
                                                        selectedParticular:
                                                            selectedParticular,
                                                        amountCountroller:
                                                            TextEditingController(),
                                                        remarksController:
                                                            TextEditingController(),
                                                      ));
                                                    });
                                                  },
                                                )
                                              else
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.remove),
                                                  onPressed: () {
                                                    setState(() {
                                                      rows.removeAt(index);
                                                    });
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
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
                ],
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: const Color.fromARGB(255, 211, 211, 211)),
                    ),
                    child: TextField(
                      controller: totalAmountController,
                      style: Theme.of(context).textTheme.titleSmall,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFFFEBEA),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/subjectfielicon.png",
                                height: 24.0,
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                " Total Approved Amount ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFFFF6F67))),
                              ),
                            ],
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: const Color.fromARGB(235, 56, 23, 243),
                  ),
                  onPressed: () async {
                    if (!validateFields()) {
                      return;
                    }

                    setState(() {
                      calculateTotalAmount();
                    });

                    setState(() {
                      isLoading = true;
                    });

                    requisitionSaveRecord();
                    int status = await saveRequisitionApi(
                      base: baseUrlFromInsCode(
                          "issuemanager", widget.mskoolController),
                      userId: widget.loginSuccessModel.userId!,
                      roleId: widget.loginSuccessModel.roleId!,
                      miId: widget.loginSuccessModel.mIID!,
                      asmayId: widget.loginSuccessModel.asmaYId!,
                      roleFlag: widget.loginSuccessModel.roleforlogin!,
                      hrmDId: selectedDepartment!.hrmDId!,
                      pcReqId: selectedEmployee!.pcreqtNId!,
                      hrmEId: selectedEmployee!.hrmEId!,
                      reqPurpose: purposeController.text,
                      reqTotalAmount: double.parse(totalAmountController.text),
                      reqDate: getDateNeed(
                          cashRequisitionController.selectDate.value),
                      reqDetailsDTOList: reqDetailsDTOList,
                    );

                    if (status == 200) {
                      setState(() {
                        isLoading = false;

                        selectedDepartment = null;
                        selectedEmployee = null;
                        selectDate.clear();
                        purposeController.clear();
                        reqDetailsDTOList.clear();

                        totalAmountController.clear();
                      });

                      setState(() {
                        rows.clear();
                        rows.add(
                          DataTableRowModel(
                            sno: 1,
                            selectedParticular: null,
                            amountCountroller: TextEditingController(),
                            remarksController: TextEditingController(),
                          ),
                        );
                      });

                      Fluttertoast.showToast(msg: "Saved Successfully");
                    }
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(
                            top: 13.0,
                            bottom: 13,
                            left: 14,
                            right: 14,
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    for (var row in rows) {
      row.remarksController.dispose();
    }
    cashRequisitionController.departmentList.clear();
    cashRequisitionController.employeeList.clear();
    cashRequisitionController.particularsList.clear();

    super.dispose();
  }

  String getDateNeed(DateTime dt) {
    return "${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}-${dt.year}";
  }
}
