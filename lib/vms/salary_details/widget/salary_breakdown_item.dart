import 'package:flutter/material.dart';

class SalaryBreakDown extends StatelessWidget {
  final String title;
  final String amt;
  const SalaryBreakDown({super.key, required this.title, required this.amt});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          amt,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .merge(const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
