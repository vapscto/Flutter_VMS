import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_punch_report_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class StaffPunchReport extends StatelessWidget {
  final DashboardPunchReportModelValues values;
  const StaffPunchReport({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.5 - 28,
      child: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              visualDensity:
                  const VisualDensity(vertical: VisualDensity.minimumDensity),
              title: Text(
                "Punch Report",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
              trailing: Chip(
                backgroundColor: Colors.red.shade100,
                label: Text(
                    values.punchdate == null
                        ? "N/A"
                        : getFormatedDate(DateTime.parse(values.punchdate!))
                            .substring(
                                0,
                                getFormatedDate(
                                            DateTime.parse(values.punchdate!))
                                        .length -
                                    2)
                            .trim(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .merge(const TextStyle(color: Colors.red))),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Punch In: ${values.punchINtime ?? "N/a"}"),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text("Punch Out: ${values.punchOUTtime ?? "N/a"}")
                ],
              ),
              // child: Row(
              //   children: [
              //     Expanded(
              //       child: CustomContainer(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             values.punchOUTtime == null ||
              //                     values.punchINtime == null
              //                 ? "N/A"
              //                 : "${int.parse(values.punchOUTtime!.split(":").first) - int.parse(values.punchINtime!.split(":").first)} H",
              //             textAlign: TextAlign.center,
              //             style: Theme.of(context).textTheme.titleSmall!.merge(
              //                 const TextStyle(
              //                     fontWeight: FontWeight.w600, fontSize: 18.0)),
              //           ),
              //         ),
              //       ),
              //     ),
              //     const Text(" : "),
              //     Expanded(
              //       child: CustomContainer(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             values.punchINtime == null ||
              //                     values.punchOUTtime == null
              //                 ? "N/A"
              //                 : "${int.parse(values.punchOUTtime!.split(":").last) - int.parse(values.punchINtime!.split(":").last)} min",
              //             textAlign: TextAlign.center,
              //             style: Theme.of(context).textTheme.titleSmall!.merge(
              //                 const TextStyle(
              //                     fontWeight: FontWeight.w600, fontSize: 18.0)),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            // const SizedBox(
            //   height: 12.0,
            // ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              // padding:
              //     const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(8.0),
              //   color: const Color.fromRGBO(222, 205, 233, 0.6),
              // ),
              child: Text(values.lateby == null
                  ? "N/A"
                  : "Late in : ${values.lateby!.split(":").first}H ${values.lateby!.split(":").last} min"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              // padding: const EdgeInsets.symmetric(
              //   horizontal: 12.0,
              // ),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8.0),
              //     color: const Color.fromRGBO(234, 222, 185, 0.6)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Early Out : ",
                  ),
                  Text(values.earlyby ?? "N/A"),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
