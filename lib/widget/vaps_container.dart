import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VapsContainer extends StatelessWidget {
  final Widget child;
  const VapsContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 4,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/vpslogo.png',
                  height: 36,
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  "VAPS International School".tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .merge(const TextStyle(color: Color(0xFF35658F))),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
