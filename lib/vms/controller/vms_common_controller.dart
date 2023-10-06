import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/model/transation_config_model.dart';

class VmsTransationController extends GetxController {
  RxList<TransationConfigModelValues> transationConfigmodel =
      <TransationConfigModelValues>[].obs;
  getUserTransation(List<TransationConfigModelValues> model) {
    if (transationConfigmodel.isNotEmpty) {
      transationConfigmodel.clear();
    }
    for (int index = 0; index < model.length; index++) {
      if (model.elementAt(index).imNFlag == 'ISMTASK') {
        transationConfigmodel.add(model.elementAt(index));
      }
    }
  }
}
