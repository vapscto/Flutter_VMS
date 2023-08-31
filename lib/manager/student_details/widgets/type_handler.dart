import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/controller/custom_search_handler.dart';
import 'package:m_skool_flutter/manager/student_details/model/search_types.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class SearchTypeHandler extends StatefulWidget {
  final CustomSearchHandler handler;
  final Function()? onDelete;
  final TextEditingController textEditingController;
  final Rx<SearchTypeModel> searchType;
  final Rx<OperatorConditionModel> operatorType;
  final Rx<OperatorConditionModel> condition;
  const SearchTypeHandler(
      {super.key,
      required this.handler,
      this.onDelete,
      required this.textEditingController,
      required this.searchType,
      required this.operatorType,
      required this.condition});

  @override
  State<SearchTypeHandler> createState() => _SearchTypeHandlerState();
}

class _SearchTypeHandlerState extends State<SearchTypeHandler> {
  // Rx<SearchTypeModel> selectedType = Rx(SearchTypes.instance.getTypes.first);
  // Map<String, dynamic> selectedOperator = SearchTypes.instance.operators.first;

  // Map<String, dynamic> condition = SearchTypes.instance.conditions.first;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.handler.options.length > 1
            ? CustomContainer(
                child: DropdownButtonFormField<OperatorConditionModel>(
                    value: widget.condition.value,
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(fontSize: 16.0),
                        ),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      label: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBE5FC),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/condition.png",
                              height: 24.0,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              " Conditions ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                        backgroundColor: Color(0xFFEBE5FC),
                                        fontSize: 20.0,
                                        color: Color(0xFF7450DC)),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 4.5),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 30,
                      ),
                    ),
                    items: SearchTypes.instance.conditions
                        .map((e) => DropdownMenuItem<OperatorConditionModel>(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, left: 5),
                              child: Text(e.name),
                            )))
                        .toList(),
                    onChanged: (e) async {
                      widget.condition.value = e!;
                    }),
              )
            : const SizedBox(),
        const SizedBox(
          height: 30.0,
        ),
        CustomContainer(
          child: DropdownButtonFormField<SearchTypeModel>(
              value: widget.searchType.value,
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEA),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/sectionnew.png",
                          height: 24.0, color: const Color(0xFFFF6F67)),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Type ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  // backgroundColor: Color(0xFFFFEBEA),
                                  fontSize: 20.0,
                                  color: Color(0xFFFF6F67)),
                            ),
                      ),
                    ],
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
              icon: const Padding(
                padding: EdgeInsets.only(top: 4.5),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
              ),
              items: SearchTypes.instance.getTypes
                  .map((e) => DropdownMenuItem<SearchTypeModel>(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 5),
                        child: Text(e.name),
                      )))
                  .toList(),
              onChanged: (e) async {
                widget.searchType.value = e!;
              }),
        ),
        const SizedBox(
          height: 32.0,
        ),
        CustomContainer(
          child: DropdownButtonFormField<OperatorConditionModel>(
              value: widget.operatorType.value,
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBFDF5),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/operator.png",
                        height: 24.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Operators ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  backgroundColor: Color(0xFFDBFDF5),
                                  fontSize: 20.0,
                                  color: Color(0xFF3BB094)),
                            ),
                      ),
                    ],
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
              icon: const Padding(
                padding: EdgeInsets.only(top: 4.5),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
              ),
              items: SearchTypes.instance.operators
                  .map((e) => DropdownMenuItem<OperatorConditionModel>(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 5),
                        child: Text(e.name),
                      )))
                  .toList(),
              onChanged: (e) async {
                widget.operatorType.value = e!;
              }),
        ),
        const SizedBox(
          height: 32.0,
        ),
        CustomContainer(child: Obx(() {
          return TextField(
            maxLength: widget.searchType.value.name == "AadharNo"
                ? 12
                : widget.searchType.value.name == "MobileNo"
                    ? 10
                    : null,
            controller: widget.textEditingController,
            style: Theme.of(context).textTheme.titleSmall,
            keyboardType: widget.searchType.value.keyboardType,
            decoration: InputDecoration(
              // counter: const SizedBox(),
              hintText: widget.searchType.value.name == "Date"
                  ? "DD-MM-YY"
                  : widget.searchType.value.name == "Sex"
                      ? "Female/Male/Other"
                      : widget.searchType.value.name == "AadharNo"
                          ? "Aadhar No must be 12 digit"
                          : widget.searchType.value.name == "Class"
                              ? "Class must be in Roman Letter"
                              : "Enter the value here",
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F3FF),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/profileiconsa.png",
                      height: 24.0,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      " Value ",
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                            const TextStyle(
                                backgroundColor: Color(0xFFE5F3FF),
                                fontSize: 20.0,
                                color: Color(0xFF3E78AA)),
                          ),
                    ),
                  ],
                ),
              ),
              border: const OutlineInputBorder(),
            ),
          );
        })),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
