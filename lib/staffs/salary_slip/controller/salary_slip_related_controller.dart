import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/salary_slip/api/salary_slip_related_api.dart';
import 'package:m_skool_flutter/staffs/salary_slip/model/salaryslipdetailmodel.dart';
import 'package:m_skool_flutter/staffs/salary_slip/model/yearandmonthdropdown.dart';

class SalarySlipController extends GetxController {
  List<YearDropdownValue> yearList = <YearDropdownValue>[].obs;
  List<MonthDropdownValue> monthList = <MonthDropdownValue>[].obs;
  List<MainListValue> salarySlipDetail = <MainListValue>[].obs;

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
        for (var i = 0;
            i < salarySlipDetailModel.mainList!.values!.length;
            i++) {
          salarySlipDetail
              .add(salarySlipDetailModel.mainList!.values!.elementAt(i)!);
        }
        logger.d(salarySlipDetail.first.toString());
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
