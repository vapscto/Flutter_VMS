import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/controller/add_to_hrms_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrmd_deg.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_candidate_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_dep_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_emp_type.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/candidates_details_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/cast_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/company_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/grade_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/marital_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/religion_model.dart';

import '../model/group_type_list.dart';

class AddToHRMSAPI {
  AddToHRMSAPI.init();
  static final AddToHRMSAPI i = AddToHRMSAPI.init();
  var dio = Dio();
  onLoad(
      {required String base,
      required int miId,
      required AddToHRMSConttroller controller}) async {
    controller.loading(true);
    var api = base + URLS.addToHrmsOnLoad;
    logger.i(api);
    logger.e({"MI_Id": miId});
    try {
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: {"MI_Id": miId});
      if (response.statusCode == 200) {
        AddToHrmsCandidateListModel addToHrmsCandidateListModel =
            AddToHrmsCandidateListModel.fromJson(
                response.data['candidatelist']);
        controller.candidateList.clear();
        controller.candidateList.addAll(addToHrmsCandidateListModel.values!);

        AddToHrmsEmpTypeModel addToHrmsEmpTypeModel =
            AddToHrmsEmpTypeModel.fromJson(response.data['masterEmployeetype']);
        controller.empTypeList.clear();
        controller.empTypeList.addAll(addToHrmsEmpTypeModel.values!);
        ReligionListModel religionListModel =
            ReligionListModel.fromJson(response.data['masterreligionlist']);
        controller.religionlist.clear();
        controller.religionlist.addAll(religionListModel.values!);

        CastListModel castListModel =
            CastListModel.fromJson(response.data['castelist']);
        controller.castList.clear();
        controller.castList.addAll(castListModel.values!);
        MaritalListModel maritalListModel =
            MaritalListModel.fromJson(response.data['maritalstatuslist']);
        controller.maritalList.clear();
        controller.maritalList.addAll(maritalListModel.values!);
        AddToHrmsDepListModel addToHrmsDepListModel =
            AddToHrmsDepListModel.fromJson(
                response.data['employeedepartmentlist']);
        controller.depList.clear();
        controller.depList.addAll(addToHrmsDepListModel.values!);
        AddToHrmsDegModel addToHrmsDegModel = AddToHrmsDegModel.fromJson(
            response.data['employeedesignationlist']);
        controller.degList.clear();
        controller.degList.addAll(addToHrmsDegModel.values!);
        GradeListModel gradeListModel =
            GradeListModel.fromJson(response.data['gradeList']);
        controller.gradeList.clear();
        controller.gradeList.addAll(gradeListModel.values!);
        GroupTypeListModel groupTypeListModel =
            GroupTypeListModel.fromJson(response.data['groupTypeList']);
        controller.groupTypeList.clear();
        controller.groupTypeList.addAll(groupTypeListModel.values!);
        CompanyListModel companyListModel =
            CompanyListModel.fromJson(response.data['companylist']);
        controller.companyList.clear();
        controller.companyList.addAll(companyListModel.values!);
        controller.loading(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  addHrms({required String base, required Map<String, dynamic> body}) async {
    var api = 'base' + URLS.addToHrmsSave;
    logger.i(body);
    logger.e(api);
    var response = await dio.post(api,
        options: Options(headers: getSession()), data: body);
    if (response.statusCode == 200) {
      if (response.data['retrunMsg'].isNotEmpty) {
        if (response.data['retrunMsg'] == "Duplicate") {
          Fluttertoast.showToast(
            msg: "Record already exists..!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        } else if (response.data['retrunMsg'] == "false") {
          Fluttertoast.showToast(
            msg: "Record Not saved / Updated.. Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        } else if (response.data['retrunMsg'] == "Add") {
          Fluttertoast.showToast(
            msg: "Record Saved Successfully..",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else if (response.data['retrunMsg'] == "Update") {
          Fluttertoast.showToast(
            msg: "Record Updated Successfully..",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Something went wrong..! Kindly contact Administrator",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      }
    }
  }
}

Future<int?> candidateList(
    {required String base,
    required int hrcdId,
    required AddToHRMSConttroller controller}) async {
  // controller.loading(true);
  var api = base + URLS.candidateDetails;
  var dio = Dio();
  logger.i(api);
  logger.e({"HRCD_Id": hrcdId});
  try {
    var response = await dio.post(api,
        options: Options(headers: getSession()), data: {"HRCD_Id": hrcdId});
    if (response.statusCode == 200) {
      logger.i(response.data['candidateDetails']);
      CandidateDetailsModel addToHrmsCandidateListModel =
          CandidateDetailsModel.fromJson(response.data['candidateDetails']);
      controller.candidateDetailsList.clear();
      controller.candidateDetailsList
          .addAll(addToHrmsCandidateListModel.values!);

      // controller.loading(false);
    }
    return response.statusCode;
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
  return 0;
}
