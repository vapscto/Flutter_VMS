import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/manager/staff_birthday/model/staff_bday_model.dart';
import 'package:m_skool_flutter/manager/staff_birthday/widget/staff_image_handler.dart';
import 'package:m_skool_flutter/staffs/student_birthday/model/student_bday_model.dart';

class BirthdayItem extends StatelessWidget {
  final Values value;
  const BirthdayItem({
    Key? key,
    required this.color,
    required this.value,
  }) : super(key: key);

  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: noticeBackgroundColor.elementAt(color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // CircleAvatar(
          //   radius: 36.0,
          //   backgroundColor: noticeColor.elementAt(color),
          //   //backgroundImage: NetworkImage(value.amstPhoto!),
          // ),

          StudentImage(value: value, color: color),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.hRMEEmployeeFirstName ?? "N/a",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(value.hRMDESDesignationName!),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                    "${value.hRMDDepartmentName ?? "N/a"} & ${value.hRMEEmployeeCode ?? "N/a"}"),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  value.hRMEDOB == null
                      ? "N/a"
                      : getDate(DateTime.parse(value.hRMEDOB!)),
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
              ),
              const SizedBox(
                height: 46.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
