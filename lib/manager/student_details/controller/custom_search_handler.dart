import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/model/search_types.dart';

class CustomSearchHandler extends GetxController {
  RxList<Rx<SearchTypeModel>> fields = RxList();
  RxList<Rx<OperatorConditionModel>> operators = RxList();
  RxList<Rx<OperatorConditionModel>> conditions = RxList();
  RxList<dynamic> values = RxList();

  RxList<Widget> options = RxList();

  RxList<TextEditingController> optionTextEditingController = RxList();

  void addToOptionTextEditingController(TextEditingController controller) {
    optionTextEditingController.add(controller);
  }

  void addOptions(Widget op) {
    options.add(op);
  }

  void updateFields(Rx<SearchTypeModel> val) {
    fields.add(val);
  }

  void updateOperators(Rx<OperatorConditionModel> op) {
    operators.add(op);
  }

  void addConditions(Rx<OperatorConditionModel> condn) {
    conditions.add(condn);
  }

  void addValues(dynamic val) {
    values.add(val);
  }
}
