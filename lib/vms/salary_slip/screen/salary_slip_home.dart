import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/salary_slip/controller/salary_slip_related_controller.dart';
import 'package:m_skool_flutter/vms/salary_slip/model/yearandmonthdropdown.dart';
import 'package:m_skool_flutter/vms/salary_slip/pdf/generate_pdf.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class SalarySlipHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const SalarySlipHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<SalarySlipHome> createState() => _SalarySlipHomeState();
}

class _SalarySlipHomeState extends State<SalarySlipHome> {
  final SalarySlipController salarySlipController =
      Get.put(SalarySlipController());

  YearDropdownValue? yearDropdownSelectedValue;
  MonthDropdownValue? monthDropdownSelectedValue;

  Future<void> getYear() async {
    salarySlipController.yearLoading(true);
    await salarySlipController
        .getYearAndMonth(
      miId: widget.loginSuccessModel.mIID!,
      userId: widget.loginSuccessModel.userId!,
      base: baseUrlFromInsCode('portal', widget.mskoolController),
    )
        .then((value) {
      if (value) {
        yearDropdownSelectedValue = salarySlipController.yearList.last;
        monthDropdownSelectedValue = salarySlipController.monthList.first;
        salarySlipController.getSalaryDetails(
          miId: widget.loginSuccessModel.mIID!,
          userId: widget.loginSuccessModel.userId!,
          hresYear:
              salarySlipController.yearList.first.hrmlYLeaveYear.toString(),
          hresMonth:
              salarySlipController.monthList.first.ivrMMonthName.toString(),
          base: baseUrlFromInsCode('portal', widget.mskoolController),
        );
      }
    });
    salarySlipController.yearLoading(false);
  }

  @override
  void initState() {
    getYear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 25,
        title: const Text('Salary Slip'),
      ),
      body: Obx(
        () => salarySlipController.isYearLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Salary Slip",
                    desc:
                        "Please wait while we load salary slip and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 40, left: 16, right: 16, bottom: 16),
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
                      child: DropdownButtonFormField<YearDropdownValue>(
                        value: yearDropdownSelectedValue,
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
                          isDense: true,
                          hintText: salarySlipController.yearList.isNotEmpty
                              ? 'select year'
                              : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/bluecalendar.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
                            text: 'Select Year',
                            textColor: Color.fromRGBO(40, 182, 200, 1),
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
                            salarySlipController.yearList.length, (index) {
                          return DropdownMenuItem(
                            value:
                                salarySlipController.yearList.elementAt(index),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                salarySlipController.yearList
                                    .elementAt(index)
                                    .hrmlYLeaveYear!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),
                              ),
                            ),
                          );
                        }),
                        onChanged: (s) async {
                          yearDropdownSelectedValue = s;

                          salarySlipController.showgenerateloading(true);
                          setState(() {});
                          salarySlipController.salarySlipDetail.clear();
                          await salarySlipController.getSalaryDetails(
                            miId: widget.loginSuccessModel.mIID!,
                            userId: widget.loginSuccessModel.userId!,
                            hresYear: s!.hrmlYLeaveYear.toString(),
                            hresMonth: monthDropdownSelectedValue!.ivrMMonthName
                                .toString(),
                            base: baseUrlFromInsCode(
                                'portal', widget.mskoolController),
                          );
                          salarySlipController.showgenerateloading(false);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
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
                      child: DropdownButtonFormField<MonthDropdownValue>(
                        value: monthDropdownSelectedValue,
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
                          isDense: true,
                          hintText: salarySlipController.monthList.isNotEmpty
                              ? 'select month'
                              : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/redcalendar.png',
                            containerColor: Color.fromRGBO(255, 235, 234, 1),
                            text: 'Select Month',
                            textColor: Color.fromRGBO(255, 111, 103, 1),
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
                            salarySlipController.monthList.length, (index) {
                          return DropdownMenuItem(
                            value: salarySlipController.monthList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                salarySlipController
                                    .monthList[index].ivrMMonthName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),
                              ),
                            ),
                          );
                        }),
                        onChanged: (s) async {
                          monthDropdownSelectedValue = s!;
                          salarySlipController.showgenerateloading(true);
                          salarySlipController.salarySlipDetail.clear();
                          await salarySlipController.getSalaryDetails(
                            miId: widget.loginSuccessModel.mIID!,
                            userId: widget.loginSuccessModel.userId!,
                            hresYear: yearDropdownSelectedValue!.hrmlYLeaveYear
                                .toString(),
                            hresMonth: s.ivrMMonthName.toString().toString(),
                            base: baseUrlFromInsCode(
                                'portal', widget.mskoolController),
                          );
                          salarySlipController.showgenerateloading(false);
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    salarySlipController.showGenerate.value
                        ? const CircularProgressIndicator()
                        : MSkollBtn(
                            title: 'Generate PDF',
                            onPress: () {
                              if (salarySlipController
                                      .salarySlipDetail.isEmpty ||
                                  salarySlipController.salarySlipDetail.first
                                          .empsaldetail!.hreSWorkingDays ==
                                      null) {
                                Fluttertoast.showToast(
                                    msg:
                                        'No data available select year and month');
                                return;
                              }
                              GenerateSalarySlip.instance.generateNow(
                                  controller: salarySlipController);
                            },
                            size: const Size.fromWidth(300)),
                    const SizedBox(height: 50),
                    Image.asset('assets/images/salaryslipillustration.png'),
                  ],
                ),
              ),
      ),
    );
  }
}
