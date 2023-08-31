import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_lop_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class StaffHomeLop extends StatelessWidget {
  final DashboardLopModelValues value;
  const StaffHomeLop({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.5 - 28,
      child: CustomContainer(
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              visualDensity:
                  const VisualDensity(vertical: VisualDensity.minimumDensity),
              title: Text(
                "LOP",
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
              trailing: Chip(
                  backgroundColor: const Color(0xFFFBCFCF),
                  label: Text(
                    value.monthname ?? "N/A",
                    style: const TextStyle(color: Color(0xFFA83232)),
                  )),
            ),
            Image.asset(
              "assets/images/money.png",
              height: Get.height * 0.05,
            ),
            // const SizedBox(
            //   height: 12.0,
            // ),
            Text(
              "₹ ${value.lOPAmount ?? "N/A"}",
              style: Theme.of(context).textTheme.titleMedium!.merge(
                    TextStyle(
                      fontSize: Get.width * 0.06,
                      color: const Color(0xFFFF385C),
                    ),
                  ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              value.lOPCOUNT == null ? "N/A" : "${value.lOPCOUNT} day leave",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).textTheme.labelMedium!.color,
                        fontWeight: FontWeight.normal),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
