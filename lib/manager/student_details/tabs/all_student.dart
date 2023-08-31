import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/controller/custom_search_handler.dart';
import 'package:m_skool_flutter/manager/student_details/model/search_types.dart';
import 'package:m_skool_flutter/manager/student_details/screen/search_result_screen.dart';
import 'package:m_skool_flutter/manager/student_details/widgets/type_handler.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class AllStudent extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final CustomSearchHandler handler;

  const AllStudent({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    if (handler.options.isEmpty) {
      // handler.options.clear();
      handler.optionTextEditingController.add(TextEditingController());
      handler.fields.add(Rx(SearchTypes.instance.getTypes.first));
      handler.operators.add(Rx(SearchTypes.instance.operators.first));
      handler.conditions.add(Rx(SearchTypes.instance.conditions.first));
      handler.addOptions(
        SearchTypeHandler(
          handler: handler,
          textEditingController: handler.optionTextEditingController.first,
          condition: handler.conditions.first,
          operatorType: handler.operators.first,
          searchType: handler.fields.first,
        ),
      );
    }

    logger.d(handler.options.length);
    RxString status = RxString("All");
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(() {
                    return Radio(
                        value: "All",
                        groupValue: status.value,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (sts) {
                          status.value = sts!;
                        });
                  }),
                  const Text("All"),
                ],
              ),
              Row(
                children: [
                  Obx(() {
                    return Radio(
                        value: "S",
                        groupValue: status.value,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (sts) {
                          status.value = sts!;
                        });
                  }),
                  const Text("Studying"),
                ],
              ),
              Row(
                children: [
                  Obx(() {
                    return Radio(
                        value: "L",
                        groupValue: status.value,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (sts) {
                          status.value = sts!;
                        });
                  }),
                  const Text("Left"),
                ],
              ),
            ],
          ),
          Obx(() {
            return Column(children: [
              ...List.generate(
                  handler.options.length,
                  (index) => Column(
                        children: [
                          index == 0
                              ? const SizedBox()
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      handler.options.removeAt(index);
                                      handler.fields.removeAt(index);
                                      handler.operators.removeAt(index);
                                      handler.conditions.removeAt(index);
                                      handler.optionTextEditingController
                                          .removeAt(index);
                                    },
                                    icon: Image.asset(
                                      "assets/images/delete.png",
                                      width: 24.0,
                                    ),
                                  ),
                                ),
                          handler.options.elementAt(index),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      )),
            ]);
          }),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                minimumSize: const Size(120, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              onPressed: () {
                handler
                    .addToOptionTextEditingController(TextEditingController());
                handler.fields.add(Rx(SearchTypes.instance.getTypes.first));
                handler.operators.add(Rx(SearchTypes.instance.operators.first));
                handler.conditions
                    .add(Rx(SearchTypes.instance.conditions.first));
                handler.addOptions(
                  SearchTypeHandler(
                    handler: handler,
                    textEditingController:
                        handler.optionTextEditingController.last,
                    condition: handler.conditions.last,
                    operatorType: handler.operators.last,
                    searchType: handler.fields.last,
                  ),
                );
              },
              child: Text(
                "+ Add New",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .merge(TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          MSkollBtn(
            size: Size(Get.width * 0.4, 50),
            onPress: () {
              List<String> fields = [];
              List<String> operators = [];
              List<String> condition = [];
              List<String> value = [];

              for (int i = 0; i < handler.fields.length; i++) {
                if (handler.fields.elementAt(i).value.name == "AadharNo") {
                  if (handler.optionTextEditingController
                          .elementAt(i)
                          .text
                          .length !=
                      12) {
                    Fluttertoast.showToast(msg: "Aadhar no must be 12 digit");
                    return;
                  }
                }

                if (handler.fields.elementAt(i).value.name == "MobileNo") {
                  if (!RegExp("/^[6-9]{1,1}[0-9]{9,9}?\$/").hasMatch(
                      handler.optionTextEditingController.elementAt(i).text)) {
                    Fluttertoast.showToast(
                        msg: "Please provide a valid phone number");
                    return;
                  }
                }
                if (handler.optionTextEditingController
                    .elementAt(i)
                    .text
                    .isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Somewhere you forgot to provide value");
                  return;
                }
              }
              for (var element in handler.fields) {
                fields.add(element.value.value);
              }
              for (var element in handler.operators) {
                operators.add(element.value.value);
              }

              for (var element in handler.optionTextEditingController) {
                value.add(element.text);
              }

              for (int i = 1; i < handler.conditions.length; i++) {
                condition.add(handler.conditions.elementAt(i).value.value);
              }
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SearchResultScreen(
                  condition: condition,
                  field: fields,
                  loginSuccessModel: loginSuccessModel,
                  mskoolController: mskoolController,
                  operators: operators,
                  status: status.value,
                  values: value,
                );
              }));

              // logger.d(fields);
              // logger.d(operators);

              // logger.d(condition);

              // logger.d(value);
            },
            title: 'Search',
          ),
        ],
      ),
    );
  }
}
