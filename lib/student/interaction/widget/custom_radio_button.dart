import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T initial;
  final Axis direction;
  final MainAxisAlignment alignment;
  final List<RadioBox<T>> radios;
  final ValueChanged<T>? onChange;
  const CustomRadioButton(
      {required this.initial,
      required this.radios,
      this.alignment = MainAxisAlignment.center,
      this.direction = Axis.horizontal,
      this.onChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<T> radioButtonNotifier = ValueNotifier<T>(initial);
    return ValueListenableBuilder<T>(
        valueListenable: radioButtonNotifier,
        builder: (context, selected, _) {
          List<Widget> widgets = List.generate(
            radios.length,
            (i) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<T>(
                  activeColor: Theme.of(context).primaryColor,
                  focusColor: Theme.of(context).primaryColor,
                  fillColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  value: radios[i].value,
                  groupValue: selected,
                  onChanged: (selected) {
                    if (selected == null) return;
                    radioButtonNotifier.value = selected;
                    if (onChange != null) onChange!(selected);
                  },
                ),
                const SizedBox(width: 3),
                AutoSizeText(radios[i].name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16)),
              ],
            ),
          );
          return direction == Axis.horizontal
              ? Row(
                  mainAxisAlignment: alignment,
                  children: widgets,
                )
              : Column(
                  mainAxisAlignment: alignment,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
                );
        });
  }
}

class RadioBox<T> {
  String name;
  T value;
  RadioBox({required this.name, required this.value});
}
