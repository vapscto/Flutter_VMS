import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/principal/preadmission_module/apis/pre_admission_apis.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_class_data.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_redg_count.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_year_data.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/student_table_model.dart';

class PreAdmissionController extends GetxController {
  RxList<YearGetDataValues> yearData = <YearGetDataValues>[].obs;
  RxList<GetCountDataValues> countData = <GetCountDataValues>[].obs;
  RxList<ClassGetDataValues> classData = <ClassGetDataValues>[].obs;
  RxList<GetStudentTableDataValues> studentTableData =
      <GetStudentTableDataValues>[].obs;
  RxBool isLoading = RxBool(false);

  void updateIsLoading(bool b) {
    isLoading.value = b;
  }

  Future<bool?> getStudentDataTable({
    required String base,
    required String type,
    required int miId,
    required int asmyId,
    required String fromDate,
    required String toDate,
    required int report,
  }) async {
    if (await checkConnectivity()) {
      GetStudentTableData? response = await PreAdmissionAPIS.getStudentData(
          base: base,
          type: type,
          fromDate: fromDate,
          toDate: toDate,
          miId: miId,
          asmyId: asmyId,
          report: report);

      studentTableData.clear();
      if (response.values!.isNotEmpty) {
        for (int index = 0; index < response.values!.length; index++) {
          studentTableData.addAll(response.values!);
        }
      }

      logger.d(studentTableData);
    } else {
      Fluttertoast.showToast(msg: "No Internet connection");
    }
    return null;
  }
}
