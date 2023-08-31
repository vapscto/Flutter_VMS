import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/dynamic_analytics_controller.dart';
import 'package:m_skool_flutter/manager/student_details/model/preadmission_data_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPreAdmissionWidget extends StatefulWidget {
  final DynamicAnalyticsController dashboardController;
  const DashboardPreAdmissionWidget(
      {super.key, required this.dashboardController});

  @override
  State<DashboardPreAdmissionWidget> createState() =>
      _DashboardPreAdmissionWidgetState();
}

class _DashboardPreAdmissionWidgetState
    extends State<DashboardPreAdmissionWidget> {
  final List<PreAdmissionData> data = [];

  @override
  void initState() {
    data.add(PreAdmissionData(
        count:
            widget.dashboardController.preAdmission.first.totalConfirmed ?? 0,
        name: "Confirmed",
        color: const Color(0xFFC58940)));
    data.add(PreAdmissionData(
        count: widget.dashboardController.preAdmission.first.totalPaid ?? 0,
        name: "Paid",
        color: const Color(0xFFE5BA73)));
    data.add(PreAdmissionData(
        count:
            widget.dashboardController.preAdmission.first.totalRegistred ?? 0,
        name: "Registered",
        color: const Color(0xFFFAEAB1)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12.0,
        ),
        CustomContainer(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    color: Color(0xFFE2FCFF)),
                child: ListTile(
                  visualDensity: const VisualDensity(
                      vertical: VisualDensity.minimumDensity),
                  title: Text(
                    "Pre Admission",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            color: Color(0xFF46A869),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  ),
                  trailing: Chip(
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity),
                      backgroundColor: const Color(0xFFFFFFFF),
                      label: Text(widget.dashboardController.preAdmission.first
                              .currentyear ??
                          "N/a")),
                  // trailing: Chip(label: Text("${widget.dashboardController.preAdmission.first.}")),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      width: Get.width * 0.36,
                      height: Get.width * 0.36,
                      child: SfCircularChart(
                        enableMultiSelection: true,
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CircularSeries>[
                          PieSeries<PreAdmissionData, String>(
                              enableTooltip: true,
                              name: "Preadmission Count",
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              dataSource: data,
                              pointColorMapper: ((datum, index) => datum.color),
                              xValueMapper: ((datum, index) => datum.name),
                              yValueMapper: ((datum, index) => datum.count)),
                          // PieSeries<PieDataModel, String>(
                          //     dataSource: pieChartVal,
                          //     name: "Marks Obtained",
                          //     enableTooltip: true,
                          //     dataLabelSettings: const DataLabelSettings(isVisible: true),
                          //     pointColorMapper: ((datum, index) => datum.color),
                          //     xValueMapper: ((datum, index) => datum.name),
                          //     yValueMapper: ((datum, index) => datum.marks)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: Color(0xFFFAEAB1),
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text("Registered"),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    "${widget.dashboardController.preAdmission.first.totalRegistred ?? "N/a"}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: Color(0xFFE5BA73),
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "Paid",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    "${widget.dashboardController.preAdmission.first.totalPaid ?? "N/a"}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.circle,
                                  size: 15,
                                  color: Color(0xFFC58940),
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  "Confirmed",
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              " ${widget.dashboardController.preAdmission.first.totalConfirmed ?? "N/a"}",
                              style:
                                  Theme.of(context).textTheme.titleSmall!.merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
