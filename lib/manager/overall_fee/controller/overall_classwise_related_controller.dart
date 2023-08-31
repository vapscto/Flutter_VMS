import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/overall_fee/api/overall_classwise_related_api.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeAcademicYearModel.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeClasswiseStudentDetailModel.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeSectionwiseDataModel.dart';

class OverallClasswiseController extends GetxController {
  RxList<YearlistValue> academicYearList = <YearlistValue>[].obs;
  RxList<AcademicFeesdetailsValue> resultsList =
      <AcademicFeesdetailsValue>[].obs;

  RxList<SectionWiseFeedetailsValue> sectionwiseList =
      <SectionWiseFeedetailsValue>[].obs;

  RxBool isAcademicYear = RxBool(false);
  RxBool isResult = RxBool(false);
  RxBool isSectionwiseData = RxBool(false);

  void isacademicyearloading(bool loading) async {
    isAcademicYear.value = loading;
  }

  void isresultloading(bool loading) async {
    isResult.value = loading;
  }

  void issectionwiseloading(bool loading) async {
    isSectionwiseData.value = loading;
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

  Future<bool> getResultData({
    required String base,
    required int asmayId,
    required int miId,
  }) async {
    ClasswiseFeeResultModel? classwiseFeeResultModel =
        await getClasswiseResultData(
      base: base,
      asmayId: asmayId,
      miId: miId,
    );
    try {
      if (classwiseFeeResultModel!.academicFeesdetails != null ||
          classwiseFeeResultModel.academicFeesdetails!.values != null) {
        resultsList.clear();
        for (var i = 0;
            i < classwiseFeeResultModel.academicFeesdetails!.values!.length;
            i++) {
          resultsList.add(classwiseFeeResultModel.academicFeesdetails!.values!
              .elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getSectionwiseData({
    required String base,
    required int asmayId,
    required int asmclId,
    required int miId,
  }) async {
    ClasswiseSectionDetailModel? classwiseSectionDetailModel =
        await getclasswiseSectionData(
            base: base, asmayId: asmayId, asmclId: asmclId, miId: miId);

    try {
      if (classwiseSectionDetailModel!.academicFeesdetails != null ||
          classwiseSectionDetailModel.academicFeesdetails!.values != null) {
        sectionwiseList.clear();
        for (var i = 0;
            i < classwiseSectionDetailModel.academicFeesdetails!.values!.length;
            i++) {
          sectionwiseList.add(classwiseSectionDetailModel
              .academicFeesdetails!.values!
              .elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }
}
