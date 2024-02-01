import 'package:flutter/material.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/salary_details/models/salary_det_graph_model.dart';
import 'package:m_skool_flutter/vms/salary_details/models/salary_details_graph_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalaryLineChart extends StatefulWidget {
  final List<SalaryDetailsGraphValues> graphValues;
  const SalaryLineChart({super.key, required this.graphValues});

  @override
  State<SalaryLineChart> createState() => _SalaryLineChartState();
}

class _SalaryLineChartState extends State<SalaryLineChart> {
  List<SalaryGraphDetModel> salary = [];

  List<SalaryGraphDetModel> deduction = [];

  late TooltipBehavior _tooltipBehavior;

  List<SalaryGraphDetModel> lop = [];
  int parsedValue = 0;
  @override
  void initState() {
    for (var e in widget.graphValues) {
      if (e.lOP == null) {
        parsedValue = int.parse(e.lOP!);
        logger.i(parsedValue);
      }
      salary.add(SalaryGraphDetModel(
          salary: e.earning == null ? 0 : e.earning! / 1000,
          month: e.hRESMonth ?? "N/a",
          type: "Salary"));

      deduction.add(SalaryGraphDetModel(
          salary: e.deduction == null ? 0 : e.deduction! / 1000,
          month: e.hRESMonth ?? "N/a",
          type: "Deduction"));

      lop.add(SalaryGraphDetModel(
          salary: e.lOP == null ? 0 : parsedValue / 1000,
          month: e.hRESMonth ?? "N/a",
          type: "LOP"));
    }
    widget.graphValues.map((e) {
      setState(() {});
    });

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            'Month: ${data.month}\n${series.name}: ${data.salary}k',
            style: const TextStyle(fontSize: 12),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 4.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                child: SfCartesianChart(
                  primaryYAxis: NumericAxis(labelFormat: "{value}K"),
                  primaryXAxis: CategoryAxis(
                      name: "Months", labelStyle: const TextStyle(fontSize: 9)),
                  tooltipBehavior: _tooltipBehavior,
                  series: <LineSeries>[
                    LineSeries<SalaryGraphDetModel, String>(
                        name: "Salary",
                        isVisible: true,
                        markerSettings: const MarkerSettings(isVisible: true),
                        enableTooltip: true,
                        color: const Color.fromARGB(255, 74, 173, 212),
                        dataSource: salary,
                        xValueMapper: ((datum, index) => datum.month),
                        yValueMapper: (datum, index) => datum.salary),
                    LineSeries<SalaryGraphDetModel, String>(
                        name: "Deduction",
                        enableTooltip: true,
                        isVisible: true,
                        markerSettings: const MarkerSettings(isVisible: true),
                        color: const Color(0xFFD0F801),
                        dataSource: deduction,
                        xValueMapper: ((datum, index) => datum.month),
                        yValueMapper: (datum, index) => datum.salary),
                    LineSeries<SalaryGraphDetModel, String>(
                        dataSource: lop,
                        enableTooltip: true,
                        color: const Color(0xFFFF828A),
                        name: "LOP",
                        isVisible: true,
                        markerSettings: const MarkerSettings(isVisible: true),
                        xValueMapper: ((datum, index) => datum.month),
                        yValueMapper: (datum, index) => datum.salary)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 74, 173, 212),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text("Salary"),
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Color(0xFFD0F801),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text("Deduction"),
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.circle,
                      color: Color(0xFFFF828A),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text("LOP"),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
