import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/get_planerdata.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/models/tada_getcategory.dart';

Future<void> getViewTada(
    {required String base,
    required int userId,
    required int hrmeId,
    required int ierId,
    required int vtadaaaId,
    required int miID,
    required TadaTourController tadaTourController}) async {
  final Dio ins = getGlobalDio();
  final String apiUrl = base + URLS.getViewTada;
  logger.w(apiUrl);

  try {
    final Response response =
        await ins.post(apiUrl, options: Options(headers: getSession()), data: {
      "HRME_Id": hrmeId,
      "IER_ID": ierId,
      "MI_Id": miID,
      "VTADAAA_Id": vtadaaaId,
      "userId": userId
    });
    logger.e({
      "HRME_Id": hrmeId,
      "IER_ID": ierId,
      "MI_Id": miID,
      "VTADAAA_Id": vtadaaaId,
      "userId": userId
    });
    if (tadaTourController.getTadaCategory.isNotEmpty || tadaTourController.getPlanerListData.isNotEmpty) {
      tadaTourController.getTadaCategory.clear();
      tadaTourController.getPlanerListData.clear();
       tadaTourController.rows.clear();
       tadaTourController.columns.clear();
    }
    TadaGetCategoryModel categoryModel =
        TadaGetCategoryModel.fromJson(response.data['getCategoryArray']);
    tadaTourController.getTadaCategory.addAll(categoryModel.values!);
     tadaTourController.columns.add(const DataColumn(label: Text('')));
     tadaTourController.rows.add(const DataCell(Text('Percentage', )),  );
   tadaTourController.getTadaCategory.forEach((element) { 
      tadaTourController.columns.add(DataColumn(label: Text(element.iMRCCategoryName!)),);
      tadaTourController.rows.add( DataCell(Text('${element.iMRCPercentage!.toInt()} %', )),  );
    });
    TadaPlanerData getPalnerList =
     TadaPlanerData.fromJson(response.data['getPlanerdata']);
    tadaTourController.getPlanerListData.addAll(getPalnerList.values!);
    tadaTourController.adminTotal.value = tadaTourController.getTadaCategory.length;
  } on DioError catch (e) {
    logger.e(e.message);
  } on Exception catch (e) {
    logger.e(e.toString());
  }
}
