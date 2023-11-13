import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/api/salary_break_api.dart';
import 'package:m_skool_flutter/staffs/salary_details/models/split_salary_model.dart';
import 'package:m_skool_flutter/staffs/salary_details/widget/salary_breakdown_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class SalaryOverallDetails extends StatelessWidget {
  final String month;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int hresId;

  const SalaryOverallDetails(
      {super.key,
      required this.month,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.hresId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: month).getAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: const Icon(Icons.home),
      ),
      body: FutureBuilder<SplitSalaryModel>(
          future: SalaryBreakApi.instance.getSalaryDivision(
              miId: loginSuccessModel.mIID!,
              userId: loginSuccessModel.userId!,
              hresId: hresId,
              base: baseUrlFromInsCode("portal", mskoolController)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                                  .hrmedAmount
                                  .toString(),
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
                        child: ListView.separated(
                          // padding: const EdgeInsets.all(12.0),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var value = snapshot
                                .data!.salaryDeductionModel.values!
                                .elementAt(index);
                            return SalaryBreakDown(
                              amt: value.hrmedAmount.toString(),
                              title: value.hrmedName ?? "N/a",
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 12.0,
                            );
                          },
                          itemCount: snapshot
                              .data!.salaryDeductionModel.values!.length,
                        ),
                        // Wrap(
                        //   spacing: Get.width * 0.12,
                        //   runSpacing: 36.0,
                        //   children: snapshot.data!.salaryDeductionModel.values!
                        //       .map((e) => SalaryDeductionItem(
                        //             amt: e.hrmedAmount.toString(),
                        //             title: e.hrmedName ?? "N/a",
                        //           ))
                        //       .toList(),
                        // ),
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
                                      .salary
                                      .toString(),
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
                                color: Color.fromARGB(255, 226, 250, 170)),
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
                                      .first.salary
                                      .toString(),
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
    );
  }
}

class SalaryDeductionItem extends StatelessWidget {
  final String title;
  final String amt;
  const SalaryDeductionItem({
    Key? key,
    required this.title,
    required this.amt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          amt,
          style: Theme.of(context).textTheme.titleSmall!.merge(
                const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
        ),
      ],
    );
  }
}
