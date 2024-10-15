import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/salary_slip/api/salary_slip_related_api.dart';
import 'package:m_skool_flutter/vms/salary_slip/model/salaryslipdetailmodel.dart';
import 'package:m_skool_flutter/vms/salary_slip/model/yearandmonthdropdown.dart';

class SalarySlipController extends GetxController {
  List<YearDropdownValue> yearList = <YearDropdownValue>[].obs;
  List<MonthDropdownValue> monthList = <MonthDropdownValue>[].obs;
  List<MainListValue> salarySlipDetail = <MainListValue>[].obs;
  List<EmployeeSalaryslipDetailsValue> salarySlipDeduction =
      <EmployeeSalaryslipDetailsValue>[].obs;
  List<EmployeeSalaryslipDetailsValue> salarySlipEarning =
      <EmployeeSalaryslipDetailsValue>[].obs;
  RxBool showGenerate = RxBool(false);

  void showgenerateloading(bool loading) {
    showGenerate.value = loading;
  }

  RxBool isYearLoading = RxBool(false);

  void yearLoading(bool loading) {
    isYearLoading.value = loading;
  }

  Future<bool> getYearAndMonth({
    required int miId,
    required int userId,
    required String base,
  }) async {
    YearAndMonthDropdownModel? yearAndMonthDropdownModel =
        await getYearandMonth(miId: miId, userId: userId, base: base);

    try {
      if (yearAndMonthDropdownModel!.leaveyeardropdown != null ||
          yearAndMonthDropdownModel.leaveyeardropdown!.values != null ||
          yearAndMonthDropdownModel.monthdropdown != null ||
          yearAndMonthDropdownModel.monthdropdown!.values != null) {
        yearList.clear();
        monthList.clear();
        for (var i = 0;
            i < yearAndMonthDropdownModel.leaveyeardropdown!.values!.length;
            i++) {
          yearList.add(yearAndMonthDropdownModel.leaveyeardropdown!.values!
              .elementAt(i)!);
        }
        for (var i = 0;
            i < yearAndMonthDropdownModel.monthdropdown!.values!.length;
            i++) {
          monthList.add(
              yearAndMonthDropdownModel.monthdropdown!.values!.elementAt(i)!);
        }
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong..');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getSalaryDetails({
    required int miId,
    required int userId,
    required String hresYear,
    required String hresMonth,
    required String base,
  }) async {
    SalarySlipDetailModel? salarySlipDetailModel = await getSalaryDetail(
        miId: miId,
        userId: userId,
        hresYear: hresYear,
        hresMonth: hresMonth,
        base: base);

    try {
      if (salarySlipDetailModel!.mainList != null ||
          salarySlipDetailModel.mainList!.values != null) {
        salarySlipDetail.clear();
        salarySlipDeduction.clear();
        salarySlipEarning.clear();
        for (var i = 0;
            i < salarySlipDetailModel.mainList!.values!.length;
            i++) {
          salarySlipDetail
              .add(salarySlipDetailModel.mainList!.values!.elementAt(i)!);
        }
        for (int i = 0;
            i <
                salarySlipDetail
                    .first.employeeSalaryslipDetails!.values!.length;
            i++) {
          if (salarySlipDetail.first.employeeSalaryslipDetails!.values![i]!
                  .hrmedEarnDedFlag!
                  .toLowerCase() ==
              "deduction") {
            salarySlipDeduction.add(
                salarySlipDetail.first.employeeSalaryslipDetails!.values![i]!);
          } else {
            salarySlipEarning.add(
                salarySlipDetail.first.employeeSalaryslipDetails!.values![i]!);
          }
        }
        while (salarySlipDeduction.length < salarySlipEarning.length) {
          salarySlipDeduction.insert(
            salarySlipDeduction.length,
            EmployeeSalaryslipDetailsValue(
              hrmedName: "",
              amount: 0.0,
            ),
          );
        }
        // salarySlipDeduction.insert(
        //   salarySlipDeduction.length,
        //   EmployeeSalaryslipDetailsValue(
        //     hrmedName: "",
        //     amount: double.parse(""),
        //   ),
        // );
        // salarySlipDeduction.insert(
        //   salarySlipDeduction.length,
        //   EmployeeSalaryslipDetailsValue(
        //     hrmedName: "",
        //     amount: double.parse(""),
        //   ),
        // );
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong..');
        return false;
      }
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
