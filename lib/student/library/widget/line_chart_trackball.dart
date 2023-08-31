import 'package:flutter/material.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/student/library/model/library_graph.dart';
import 'package:m_skool_flutter/student/library/model/library_graph_data.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartLib extends StatefulWidget {
  final LibraryGraph libraryGraph;
  const LineChartLib({super.key, required this.libraryGraph});

  @override
  State<LineChartLib> createState() => _LineChartLibState();
}

class _LineChartLibState extends State<LineChartLib> {
  List<FullLibGraphData> source = [
    // FullLibGraphData(
    //     issuedData: LibraryGraphDataIssued(month: "May", issued: 5),
    //     returnedData: LibraryGraphDataRetured(month: "May", returned: 3)),
    // FullLibGraphData(
    //     issuedData: LibraryGraphDataIssued(month: "June", issued: 6),
    //     returnedData: LibraryGraphDataRetured(month: "June", returned: 4)),
    // FullLibGraphData(
    //     issuedData: LibraryGraphDataIssued(month: "July", issued: 1),
    //     returnedData: LibraryGraphDataRetured(month: "July", returned: 6)),
    // FullLibGraphData(
    //     issuedData: LibraryGraphDataIssued(month: "August", issued: 2),
    //     returnedData: LibraryGraphDataRetured(month: "August", returned: 0)),
    // FullLibGraphData(
    //     issuedData: LibraryGraphDataIssued(month: "September", issued: 5),
    //     returnedData: LibraryGraphDataRetured(month: "September", returned: 6)),
  ];

  final TrackballBehavior trackballBehavior = TrackballBehavior(
    enable: true,
    tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
  );

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.libraryGraph.values!.length; i++) {
      final LibraryGraphValues graphValues =
          widget.libraryGraph.values!.elementAt(i);
      source.add(
        FullLibGraphData(
          issuedData: LibraryGraphDataIssued(
              month: graphValues.mONTHNAME!, issued: graphValues.iSSUEDCOUNT!),
          returnedData: LibraryGraphDataRetured(
            month: graphValues.mONTHNAME!,
            returned: graphValues.rETURNCOUNT!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: CustomThemeData.getShadow(),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "Monthly",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .merge(const TextStyle(letterSpacing: 0.2)),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 14.0,
                          color: Color(0xFFAD80E3),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text("Issued"),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 14.0,
                          color: Color(0xFF0165A3),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text("Returned"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          SfCartesianChart(
            trackballBehavior: trackballBehavior,
            primaryXAxis: CategoryAxis(
              name: 'Month',
              labelStyle: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .merge(const TextStyle(letterSpacing: 0.2)),
              majorGridLines: const MajorGridLines(width: 0.0),
            ),
            primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 12,
                interval: 2,
                labelStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .merge(const TextStyle(letterSpacing: 0.2)),
                majorGridLines: const MajorGridLines(width: 0.0)),
            series: <ChartSeries<FullLibGraphData, String>>[
              LineSeries(
                  color: const Color(0xFFAD80E3),
                  dataSource: source,
                  xValueMapper: (datum, index) => datum.issuedData.month,
                  yValueMapper: ((datum, index) => datum.issuedData.issued),
                  markerSettings: const MarkerSettings(isVisible: true)),
              LineSeries(
                  dataSource: source,
                  color: const Color(0xFF0165A3),
                  xValueMapper: (datum, index) => datum.returnedData.month,
                  yValueMapper: ((datum, index) => datum.returnedData.returned),
                  markerSettings: const MarkerSettings(isVisible: true))
            ],
          ),
        ],
      ),
    );
  }
}
