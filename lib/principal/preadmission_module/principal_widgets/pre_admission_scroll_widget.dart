import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreAdmissionScrollWidget extends StatelessWidget {
  final Color color;
  final int count;
  final String title;
  final String image;
  const PreAdmissionScrollWidget(
      {super.key,
      required this.color,
      required this.count,
      required this.title,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
          boxShadow: const [
            BoxShadow(
                offset: Offset(2, 3.1),
                blurRadius: 0,
                spreadRadius: -2,
                color: Colors.black12),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              count.toString().toUpperCase(),
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
            Text(
              title,
              style: Get.textTheme.titleLarge!.copyWith(color: Colors.white),
            ),
          ]),
    );
  }
}
