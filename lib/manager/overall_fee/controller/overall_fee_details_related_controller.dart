import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/overall_fee/api/overall_classwise_related_api.dart';
import 'package:m_skool_flutter/manager/overall_fee/api/overall_fee_detail_related_api.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeAcademicYearModel.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeDetailModel.dart';

class OverallFeeDetailsController extends GetxController {
  RxList<YearlistValue> academicYearList = <YearlistValue>[].obs;
  RxList<OverallFeeDetailValue> overallFeeDetail =
      <OverallFeeDetailValue>[].obs;

  RxBool isFeeDetail = RxBool(false);
  RxBool isAcademicYear = RxBool(false);

  void isacademicyearloading(bool loading) async {
    isAcademicYear.value = loading;
  }

  void isfeedetailloading(bool loading) {
    isFeeDetail.value = loading;
  }

  Future<bool> getAcademicList({
    required int miId,
    required String base,
  }) async {
    OverallFeeAcademicYearModel? overallFeeAcademicYearModel =
        await getClasswiseAcademicYearData(miId: miId, base: base);

    try {
      if (overallFeeAcademicYearModel!.yearlist != null ||
          overallFeeAcademicYearModel.yearlist!.values != null) {
        academicYearList.clear();
        for (var i = 0;
            i < overallFeeAcademicYearModel.yearlist!.values!.length;
            i++) {
          academicYearList
              .add(overallFeeAcademicYearModel.yearlist!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getFeeDetail({
    required String base,
    required int miId,
    required int asmayId,
  }) async {
    OverallFeeDetailModel? overallFeeDetailModel =
        await getOverallFeeDetailsData(
            base: base, miId: miId, asmayId: asmayId);

    try {
      if (overallFeeDetailModel!.managerdashFeetotal != null ||
          overallFeeDetailModel.managerdashFeetotal!.values != null) {
        overallFeeDetail.clear();
        for (var i = 0;
            i < overallFeeDetailModel.managerdashFeetotal!.values!.length;
            i++) {
          overallFeeDetail.add(
              overallFeeDetailModel.managerdashFeetotal!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
