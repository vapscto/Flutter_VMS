import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class DashboardFeeMode extends StatelessWidget {
  final DynamicAnalyticsController dashboardController;
  const DashboardFeeMode({super.key, required this.dashboardController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.55,
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  visualDensity: const VisualDensity(
                      vertical: VisualDensity.minimumDensity),
                  title: Text(
                    "Fee Collection",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w600,
                            // fontSize: 12.0,
                          ),
                        ),
                  ),
                  trailing: Chip(
                    backgroundColor: const Color(0xFFFFEDD8),
                    label: Text(
                        getFormatedDate(DateTime.now().toLocal()).substring(
                            0,
                            getFormatedDate(DateTime.now().toLocal()).length -
                                4),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(const TextStyle(color: Color(0xFFFF8700)))),
                  ),
                ),
                Image.asset(
                  "assets/images/money.png",
                  width: 50,
                ),
                Text(
                  "₹${dashboardController.feeDetails.first.totalAmount ?? "N/a"}",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(0xFFE5FFF3)),
              child: Text(
                "Today's fee collection amount",
                maxLines: 2,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(color: Color(0xFF269962), fontSize: 13.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
