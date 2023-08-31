import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeFilterByType extends StatelessWidget {
  const NoticeFilterByType({
    Key? key,
    required this.noticeType,
  }) : super(key: key);

  final RxString noticeType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(() {
                return Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Theme.of(context).primaryColor,
                  ),
                  child: Radio(
                      activeColor: Theme.of(context).primaryColor,
                      value: "circular",
                      groupValue: noticeType.value,
                      onChanged: (type) {
                        noticeType.value = type!;
                      }),
                );
              }),
              Text(
                "Circular",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Row(
            children: [
              Obx(() {
                return Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Theme.of(context).primaryColor,
                  ),
                  child: Radio(
                      value: "syllabus",
                      activeColor: Theme.of(context).primaryColor,
                      groupValue: noticeType.value,
                      onChanged: (type) {
                        noticeType.value = type!;
                      }),
                );
              }),
              Text(
                "Syllabus",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Row(
            children: [
              Obx(() {
                return Theme(
                  data: ThemeData(
                      unselectedWidgetColor: Theme.of(context).primaryColor),
                  child: Radio(
                      value: "timetable",
                      activeColor: Theme.of(context).primaryColor,
                      groupValue: noticeType.value,
                      onChanged: (type) {
                        noticeType.value = type!;
                      }),
                );
              }),
              Text(
                "Timetable",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
