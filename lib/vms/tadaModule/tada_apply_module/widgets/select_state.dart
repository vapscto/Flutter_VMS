import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/state_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';

class SelectStateWidget extends StatefulWidget {
  final TadaApplyDataController tadaApplyDataController;
  final Function(StateListModelValues) onPress;
  final StateListModelValues stateListModelValues;
  const SelectStateWidget(
      {super.key,
      required this.tadaApplyDataController,
      required this.onPress,
      required this.stateListModelValues});

  @override
  State<SelectStateWidget> createState() => _SelectStateWidgetState();
}

class _SelectStateWidgetState extends State<SelectStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(top: 30, bottom: 0, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 8,
              color: Colors.black12,
            ),
          ],
        ),
        child: DropdownButtonFormField<StateListModelValues>(
          value: widget.stateListModelValues,
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
            isDense: true,
            hintStyle: Theme.of(context).textTheme.labelSmall!.merge(
                const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                    letterSpacing: 0.3)),
            hintText: widget.tadaApplyDataController.stateList.isNotEmpty
                ? 'Select State'
                : "No data available.",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDFFBFE),
                borderRadius: BorderRadius.circular(24.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/cap.png",
                    height: 28.0,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Text(
                    " State",
                    style: Theme.of(context).textTheme.labelMedium!.merge(
                          const TextStyle(
                              backgroundColor: Color(0xFFDFFBFE),
                              fontSize: 20.0,
                              color: Color(0xFF28B6C8)),
                        ),
                  ),
                ],
              ),
            ),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 30,
            ),
          ),
          iconSize: 30,
          items: List.generate(widget.tadaApplyDataController.stateList.length,
              (index) {
            return DropdownMenuItem(
              value: widget.tadaApplyDataController.stateList[index],
              child: Padding(
                padding: const EdgeInsets.only(top: 13, left: 5),
                child: Text(
                  widget.tadaApplyDataController.stateList[index].ivrmmSName!,
                  style: Theme.of(context).textTheme.labelSmall!.merge(
                      const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          letterSpacing: 0.3)),
                ),
              ),
            );
          }),
          onChanged: (s) {
            widget.onPress(s!);
            // if (_endTime.text.isEmpty) {
            //   Fluttertoast.showToast(
            //       msg: "Select Arrival Time");
            //   return;
            // }
            // stateListModelValues = s!;
            // getCity(
            //     stateListModelValues!.ivrmmCId!, stateListModelValues!.ivrmmSId!);
          },
        ),
      );
    });
  }
}
