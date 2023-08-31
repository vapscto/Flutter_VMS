import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AttendanceShortage extends StatelessWidget {
  final double percentage;
  const AttendanceShortage({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(
            Icons.warning,
            color: Color(0xFFDD2025),
          ),
          minLeadingWidth: 10,
          title: const Text("Alert !"),
          trailing: IconButton(
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
        ),
        Align(
          heightFactor: 0.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfRadialGauge(
                enableLoadingAnimation: true,
                // backgroundColor: Colors.green.shade100,
                axes: [
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    radiusFactor: 0.65,
                    // labelFormat: "",
                    ranges: [
                      GaugeRange(
                        startValue: 0,
                        endValue: percentage,
                        color: Colors.green,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                width: Get.width * 0.26,
                height: Get.width * 0.26,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 8.0,
                        spreadRadius: 8.0,
                        color: Colors.black12,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${percentage.toPrecision(1)}%",
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20.0)),
                    ),
                    Text(
                      "Present",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 36),
          child: Text(
            "Attendance Shortage",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
      ],
    );
  }
}
