import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/overall_fee/screen/classwise_class_detail_screen.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ManagerFeeBarChart extends StatefulWidget {
  final String chipText;
  bool navigationIcon;
  final double totalCharges;
  final double totalPaid;
  final double payable;
  final double totalConcession;
  int? asmayId;
  int? asmclId;
  LoginSuccessModel? loginSuccessModel;
  MskoolController? mskoolController;

  ManagerFeeBarChart({
    super.key,
    required this.chipText,
    this.navigationIcon = false,
    required this.payable,
    required this.totalCharges,
    required this.totalConcession,
    required this.totalPaid,
    this.asmayId,
    this.asmclId,
    this.loginSuccessModel,
    this.mskoolController,
  });

  @override
  State<ManagerFeeBarChart> createState() => _ManagerFeeBarChartState();
}

class _ManagerFeeBarChartState extends State<ManagerFeeBarChart> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  backgroundColor: const Color.fromARGB(255, 255, 228, 224),
                  label: Text(
                    widget.chipText,
                    style: const TextStyle(color: Color(0xFFD05954)),
                  ),
                ),
                if (widget.navigationIcon)
                  InkWell(
                    onTap: () {
                      Get.to(() => ClasswiseClassDetailScreen(
                            heading: widget.chipText,
                            loginSuccessModel: widget.loginSuccessModel!,
                            mskoolController: widget.mskoolController!,
                            asmayId: widget.asmayId!,
                            asmclId: widget.asmclId!,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xFF1E38FC),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 380,
              child: SfCartesianChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                primaryYAxis: NumericAxis(
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryXAxis: CategoryAxis(
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                series: <CartesianSeries>[
                  ColumnSeries<ChartData, String>(
                    name: 'Fees Details',
                    enableTooltip: true,
                    width: 0.6,
                    spacing: 0.2,
                    animationDuration: 2500,
                    dataSource: [
                      ChartData(
                        'Total\nCharges',
                        widget.totalCharges,
                        const Color(0xffd0f801),
                      ),
                      ChartData(
                        'Total Paid',
                        widget.totalPaid,
                        const Color(0xff31E1F7),
                      ),
                      ChartData(
                        'Now\nPayable',
                        widget.payable,
                        const Color(0xffEBA9FF),
                      ),
                      ChartData(
                        'Total\nConcession',
                        widget.totalConcession,
                        const Color(0xffFF79CD),
                      ),
                    ],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double? y;
  final Color? color;
}
