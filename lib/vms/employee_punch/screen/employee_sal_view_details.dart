import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_get_salary_slip.dart';
import 'package:m_skool_flutter/vms/employee_punch/api/employee_slip_model.dart';
import 'package:m_skool_flutter/vms/employee_punch/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class EmployeeSalDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final EmployeePunchController salaryController;
  final DateTime fromdate;
  final DateTime todate;
  const EmployeeSalDetails(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.fromdate,
      required this.todate,
      required this.salaryController});

  @override
  State<EmployeeSalDetails> createState() => _EmployeeSalDetailsState();
}

class _EmployeeSalDetailsState extends State<EmployeeSalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Employee Punch Details").getAppBar(),
      body: FutureBuilder(
          future: EmployeeSalarySlipApi.instance.getSalary(
              miId: widget.loginSuccessModel.mIID!,
              asmayId: widget.loginSuccessModel.asmaYId!,
              base: baseUrlFromInsCode("frontoffice", widget.mskoolController),
              hrmeId: widget.salaryController.selectedStaff!.hrmEId!.toInt(),
              fromdate: widget.fromdate,
              todate: widget.todate,
              salaryController: widget.salaryController),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'No Details found',
                    desc: "For this month or employee has no data to show",
                    animatorHeight: 250,
                  ),
                );
              }
              return RepaintBoundary(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: DataTable(
                              border: TableBorder(
                                horizontalInside: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                                verticalInside: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              headingRowColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColor),
                              // columnSpacing: 36,
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

                              rows:
                                  List.generate(snapshot.data!.length, (index) {
                                var dt = DateTime.parse(
                                    snapshot.data!.elementAt(index).punchdate!);

                                return DataRow(
                                  cells: [
                                    DataCell(Center(
                                        child: Text(
                                            "${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}"))),
                                    DataCell(Center(
                                        child: Text(
                                            "${snapshot.data!.elementAt(index).intime}"))),
                                    DataCell(Center(
                                        child: Text(
                                            "${snapshot.data!.elementAt(index).outtime}"))),
                                    DataCell(Center(
                                        child: Text(
                                            "${snapshot.data!.elementAt(index).workingtime}"))),
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
              );
            }

            if (snapshot.hasError) {
              return ErrWidget(
                err: snapshot.error as Map<String, dynamic>,
              );
            }
            return const Center(
              child: AnimatedProgressWidget(
                animationPath: 'assets/json/default.json',
                title: 'Loading Punch Details',
                desc: "We are getting Punch Details, please wait for while",
              ),
            );
          }),
    );
  }
}
