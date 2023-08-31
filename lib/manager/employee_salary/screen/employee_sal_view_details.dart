import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/employee_salary/api/employee_get_salary_slip.dart';
import 'package:m_skool_flutter/manager/employee_salary/controller/employee_salary_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/screen/salary_overall_det.dart';
import 'package:m_skool_flutter/staffs/salary_details/widget/salary_breakdown_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class EmployeeSalDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final EmployeeSalaryController salaryController;
  const EmployeeSalDetails(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.salaryController});

  @override
  State<EmployeeSalDetails> createState() => _EmployeeSalDetailsState();
}

class _EmployeeSalDetailsState extends State<EmployeeSalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Salary Slip Details").getAppBar(),
      body: FutureBuilder(
          future :  EmployeeSalarySlipApi.instance.getSalary(
              miId: widget.loginSuccessModel.mIID!,
              asmayId: widget.loginSuccessModel.asmaYId!,
              base: baseUrlFromInsCode("portal", widget.mskoolController),
              hrmeId: widget.salaryController.selectedStaff!.hrmEId!.toInt(),
              year: widget.salaryController.selectedYear!.hrmlYLeaveYear!,
              month: widget.salaryController.selectedMonth!.ivrMMonthName!,
              salaryController: widget.salaryController),

 builder: (context, snapshot) {
  
 
            if (snapshot.hasData) {
                          if(snapshot.data!.salaryDeductionModel.values!.isEmpty || snapshot.data!.salaryEarningModel.values!.isEmpty ||
  snapshot.data!.totalDeductionModel.values!.isEmpty || snapshot.data!.totalEarningModel.values!.isEmpty
  
  )
  {
    return const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'No Details found',
                    desc: "For this month or employee has no data to show",
                    animatorHeight: 250,
                  ),
                );

  }
              return SingleChildScrollView(

                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Earning Amount",
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomContainer(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(12.0),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return SalaryBreakDown(
                              amt: snapshot.data!.salaryEarningModel.values!
                                  .elementAt(index)
                                  .hrmedAmount==null? 'n/a' :snapshot.data!.salaryEarningModel.values!.elementAt(index).hrmedAmount.toString(),
                                  
                              title: snapshot.data!.salaryEarningModel.values!
                                      .elementAt(index)
                                      .hrmedName ??
                                  "N/a",
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 12.0,
                            );
                          },
                          itemCount:
                              snapshot.data!.salaryEarningModel.values!.length,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Deduction's",
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 24.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF6F5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Wrap(
                          spacing: Get.width * 0.12,
                          runSpacing: 36.0,
                          children: snapshot.data!.salaryDeductionModel.values!
                              .map((e) => SalaryDeductionItem(
                                    amt: e.hrmedAmount==null ? 'n/a' : e.hrmedAmount.toString(),
                                    title: e.hrmedName ?? "N/a",
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 24.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                color: const Color(0xFFE9F7FF)),
                            child: Column(
                              children: [
                                Text(
                                  "Total Earnings",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  snapshot.data!.totalEarningModel.values!.first
                                      .salary==null ? 'n/a' : snapshot.data!.totalEarningModel.values!.first.salary.toString(),
                                      
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(
                                        const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 24.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                color: const Color(0xFFF9FFEB)),
                            child: Column(
                              children: [
                                Text(
                                  "Total Deductions",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  snapshot.data!.totalDeductionModel.values!
                                      .first.salary==null? 'n/a' :snapshot.data!.totalDeductionModel.values!.first.salary.toString(),
                                    
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(
                                        const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF3FF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text(
                            "Net Salary",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .merge(TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.0)),
                          ),
                          trailing: Text(
                            snapshot.data!.totalEarningModel.values!.first
                                            .salary ==
                                        null ||
                                    snapshot.data!.totalDeductionModel.values!
                                            .first.salary ==
                                        null
                                ? "N/a"
                                : "${snapshot.data!.totalEarningModel.values!.first.salary! - snapshot.data!.totalDeductionModel.values!.first.salary!}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .merge(TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 128,
                    )
                  ],
                ),
              );
            }
 

            if (snapshot.hasError) {
              return Center(
                  child:
                      ErrWidget(err: snapshot.error as Map<String, dynamic>));
            }

            return const Center(
              child: AnimatedProgressWidget(
                  title: "Loading Overall Salary Details",
                  desc:
                      "Please wait while we load the overall salary details for you.",
                  animationPath: "assets/json/default.json"),
            );
          }),



          // builder: (context, snapshot) {
          //   if (snapshot.hasData) {
          //     if (snapshot.data!.isEmpty) {
          //       return const Center(
          //         child: AnimatedProgressWidget(
          //           animationPath: 'assets/json/nodata.json',
          //           title: 'No Details found',
          //           desc: "For this month or employee has no data to show",
          //           animatorHeight: 250,
          //         ),
          //       );
          //     }

          //     double earned = 0.0;
          //     double deduction = 0.0;
          //     double netSal = 0.0;

          //     for (var element in snapshot.data!) {
          //       if (element.hRMEDEarnDedFlag!.toLowerCase() == "earning") {
          //         earned += element.amount!.toDouble();
          //       }
          //       if (element.hRMEDEarnDedFlag!.toLowerCase() == "deduction") {
          //         deduction += element.amount!.toDouble();
          //       }
          //     }

          //     netSal = earned - deduction;
          //     return SingleChildScrollView(
          //       padding: const EdgeInsets.all(16.0),
          //       child: CustomContainer(
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(8.0),
          //           child: DataTable(
          //             border: TableBorder(
          //               horizontalInside: BorderSide(
          //                 color: Colors.grey.shade200,
          //               ),
          //               verticalInside: BorderSide(
          //                 color: Colors.grey.shade200,
          //               ),
          //             ),
          //             headingRowColor: MaterialStatePropertyAll(
          //                 Theme.of(context).primaryColor),
          //             // columnSpacing: 36,
          //             columns: [
          //               DataColumn(
          //                   label: Text(
          //                   "Earning",
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .titleSmall!
          //                       .merge(const TextStyle(color: Colors.white)),
          //                 ),
          //               ),
          //               DataColumn(
          //                   label: Text(
          //                   "Deduction",
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .titleSmall!
          //                       .merge(const TextStyle(color: Colors.white)),
          //                 ),
          //               ),
          //               DataColumn(
          //                   label: Text(
                        
          //                   "Net\nSalary",
          //                   textAlign: TextAlign.center,
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .titleSmall!
          //                       .merge(const TextStyle(color: Colors.white)),
          //                 ),
          //               )
          //             ],

          //             rows: [
          //               DataRow(
          //                 cells: [
          //                     DataCell(Center(child: Text( "$earned"))),
          //                     DataCell(Center(child: Text( "$deduction"))),
          //                     DataCell(Center(child: Text( "$netSal"))),
          //                   // DataCell(Expanded(
          //                   //     child: Center(child: Text("$earned")))),
          //                   // DataCell(Expanded(
          //                   //     child: Center(child: Text("$deduction")))),
          //                   // DataCell(Expanded(
          //                   //     child: Center(child: Text("$netSal")))),
          //                 ],
          //               ),
          //             ],
          //             // rows: snapshot.data!
          //             //     .map(
          //             //       (e) => DataRow(
          //             //         cells: [
          //             //           DataCell(Text("${e.hRMEDEarnDedFlag}")),
          //             //           const DataCell(Text("--")),
          //             //           const DataCell(Text("---s")),
          //             //         ],
          //             //       ),
          //             //     )
          //             //     .toList(),
          //           ),
          //         ),
          //       ),
          //     );
          //   }

          //   if (snapshot.hasError) {
          //     return ErrWidget(
          //       err: snapshot.error as Map<String, dynamic>,
          //     );
          //   }
          //   return const Center(
          //     child: AnimatedProgressWidget(
          //       animationPath: 'assets/json/default.json',
          //       title: 'Loading Salary Slip Details',
          //       desc: "We are getting salary slip, please wait for while",
          //     ),
          //   );
          // }),
    );
  }
}



