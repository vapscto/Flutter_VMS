import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphicalAnalysisFeeWidget extends StatefulWidget {
  final double receivable;
  final double collection;
  final double balance;
  final double adjustment;
  final double concession;
  const GraphicalAnalysisFeeWidget({
    super.key,
    required this.receivable,
    required this.collection,
    required this.balance,
    required this.adjustment,
    required this.concession,
  });

  @override
  State<GraphicalAnalysisFeeWidget> createState() =>
      _GraphicalAnalysisFeeWidgetState();
}

class _GraphicalAnalysisFeeWidgetState
    extends State<GraphicalAnalysisFeeWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(75, 231, 241, 247),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Academic Year Fee Analysis',
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
              child: SfCartesianChart(
                primaryYAxis: NumericAxis(
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
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
                    width: 0.6,
                    spacing: 0.2,
                    animationDuration: 2500,
                    enableTooltip: true,
                    dataSource: [
                      ChartData(
                        'Total\nCharges',
                        widget.receivable,
                        const Color(0xff59cdff),
                      ),
                      ChartData(
                        'Total Paid',
                        widget.collection,
                        const Color(0xff8e5aff),
                      ),
                      ChartData(
                        'Total\nConcession',
                        widget.concession,
                        const Color(0xff6ecfbd),
                      ),
                      ChartData(
                        'Now\nPayable',
                        widget.balance,
                        const Color(0xfff9623e),
                      ),
                      // ChartData(
                      //   'Con',
                      //   widget.concession,
                      //   const Color(0xffff8728),
                      // ),
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
            const SizedBox(height: 20),
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
