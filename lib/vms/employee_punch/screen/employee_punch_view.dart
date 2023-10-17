import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/details_api.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class EmployeePunchView extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final EmployeePunchController salaryController;
  final DateTime fromdate;
  final DateTime todate;
  const EmployeePunchView(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.salaryController,
      required this.fromdate,
      required this.todate});

  @override
  State<EmployeePunchView> createState() => _EmployeePunchViewState();
}

class _EmployeePunchViewState extends State<EmployeePunchView> {
  _getData() async {
    widget.salaryController.loading(true);
    await EmployeePunchDetailsApi.instance.getDetails(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("frontoffice", widget.mskoolController),
        hrmeId: widget.salaryController.selectedStaff!.hrmEId!.toInt(),
        fromdate: widget.fromdate,
        todate: widget.todate,
        salaryController: widget.salaryController);
    widget.salaryController.loading(false);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const CustomAppBar(title: "Employee Punch Details").getAppBar(),
        body: widget.salaryController.isDataLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                  animationPath: 'assets/json/default.json',
                  title: 'Loading Punch Details',
                  desc: "We are getting Punch Details, please wait for while",
                ),
              )
            : widget.salaryController.employeePunchDetails.isEmpty
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: 'assets/json/nodata.json',
                      title: 'No Details found',
                      desc: "For this month or employee has no data to show",
                      animatorHeight: 250,
                    ),
                  )
                : RepaintBoundary(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: DataTable(
                                  dataRowHeight: 35,
                                  headingRowHeight: 40,
                                  headingTextStyle:
                                      const TextStyle(color: Colors.white),
                                  border: TableBorder.all(
                                    color: Colors.black,
                                    width: 0.6,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  headingRowColor: MaterialStatePropertyAll(
                                      Theme.of(context).primaryColor),
                                  columns: [
                                    DataColumn(
                                        label: Expanded(
                                      child: Text(
                                        "Date",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Expanded(
                                      child: Text(
                                        "Time\nin",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Expanded(
                                      child: Text(
                                        "Time \nout",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    )),
                                    DataColumn(
                                        label: Expanded(
                                      child: Text(
                                        "Worked \n Hrs",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    )),
                                  ],
                                  rows: List.generate(
                                      widget
                                          .salaryController
                                          .employeePunchDetails
                                          .length, (index) {
                                    var dt = DateTime.parse(widget
                                        .salaryController.employeePunchDetails
                                        .elementAt(index)
                                        .punchdate!);

                                    return DataRow(
                                      cells: [
                                        DataCell(Center(
                                            child: Text(
                                                "${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}"))),
                                        DataCell(Center(
                                            child: Text(
                                                "${widget.salaryController.employeePunchDetails.elementAt(index).intime}"))),
                                        DataCell(Center(
                                            child: Text(
                                                "${widget.salaryController.employeePunchDetails.elementAt(index).outtime}"))),
                                        DataCell(Center(
                                            child: Text(
                                                "${widget.salaryController.employeePunchDetails.elementAt(index).workingtime}"))),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      );
    });
  }
}
