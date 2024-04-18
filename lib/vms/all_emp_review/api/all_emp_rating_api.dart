import 'package:dio/dio.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/all_emp_review/controller/all_emp_rating_controller.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/all_rating_emp_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/all_rating_month.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/rating_data_list_model.dart';
import 'package:m_skool_flutter/vms/all_emp_review/model/rating_year_model.dart';

class AllEmpRatingAPI {
  AllEmpRatingAPI.init();
  static final AllEmpRatingAPI i = AllEmpRatingAPI.init();
  var dio = Dio();
  yearAPI(
      {required String base,
      required Map<String, dynamic> body,
      required EmpRatingController controller}) async {
    var api = base + URLS.allEmpRating;
    logger.i(api);
    logger.i(body);
    try {
      controller.empLoad(true);
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        RatingEmpModel ratingEmpModel =
            RatingEmpModel.fromJson(response.data['get_userEmplist']);
        controller.employeeList.clear();
        controller.employeeList.addAll(ratingEmpModel.values!);
        //****//
        RatingMonthModel ratingMonthModel =
            RatingMonthModel.fromJson(response.data['month_array']);
        controller.monthList.clear();
        controller.monthList.addAll(ratingMonthModel.values!);
        //****//
        RatingYearModel ratingYearModel =
            RatingYearModel.fromJson(response.data['yearlist']);
        controller.yearList.clear();
        controller.yearList.addAll(ratingYearModel.values!);
        controller.empLoad(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.w(e.toString());
    }
  }

  ratingList(
      {required String base,
      required Map<String, dynamic> body,
      required EmpRatingController controller}) async {
    var api = base + URLS.ratingList;
    logger.e(api);
    logger.d(body);
    try {
      controller.rating(true);
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        logger.v(response.data['consolidateData']);
        if (response.data['consolidateData'] != null) {
          RatingDataListModel ratingDataListModel =
              RatingDataListModel.fromJson(response.data['consolidateData']);
          controller.ratingDataList.clear();
          controller.getRating(ratingDataListModel.values!);
        }
        controller.rating(false);
      }
    } on DioError catch (e) {
      logger.e(e.message);
    } on Exception catch (e) {
      logger.w(e.toString());
    }
  }
}
