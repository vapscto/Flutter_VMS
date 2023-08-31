import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final int? initial;
  final List<String> items;
  final ValueChanged<int?> onChange;
  const CustomDropdown(
      {this.initial,
      required this.label,
      required this.items,
      required this.onChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    final indexNotifier = ValueNotifier<int?>(initial);
    return Stack(
      children: [
        ValueListenableBuilder<int?>(
            valueListenable: indexNotifier,
            builder: (context, value, _) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    boxShadow: CustomThemeData.getShadow(),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButtonFormField2<int?>(
                  value: value,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.3, horizontal: 10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                  ),
                  iconSize: 30,
                  items: List.generate(
                    items.length,
                    (index) => DropdownMenuItem(
                      value: index,
                      child: Text(
                        items[index],
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                letterSpacing: 0.3)),
                      ),
                    ),
                  ),
                  onChanged: onChange,
                ),
              );
            }),
        Positioned(
            top: 0,
            left: 13,
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  backgroundColor: Colors.white,
                  color: Color(0xff898989)),
            ))
      ],
    );
  }
}
