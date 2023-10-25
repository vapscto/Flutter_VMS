// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/model/student_dashboard_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardFeeGraph extends StatefulWidget {
  final List<FeesListValues> feeDet;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const DashboardFeeGraph(
      {super.key,
      required this.feeDet,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<DashboardFeeGraph> createState() => _DashboardFeeGraphState();
}

class _DashboardFeeGraphState extends State<DashboardFeeGraph> {
  final List<FeeDetModel> feeDetails = [];

  @override
  void initState() {
    for (int i = 0; i < widget.feeDet.length; i++) {
      feeDetails.add(FeeDetModel(
          amt: widget.feeDet.elementAt(i).fSSPaidAmount == null
              ? 0
              : widget.feeDet.elementAt(i).fSSPaidAmount!.toDouble() / 1000,
          instName: widget.feeDet.elementAt(i).fTIName ?? "N/a",
          amtInK: widget.feeDet.elementAt(i).fSSPaidAmount == null
              ? "N/a"
              : '${(widget.feeDet.elementAt(i).fSSPaidAmount!.toDouble() / 1000).toPrecision(1)}K'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          SizedBox(
            height: 36,
            child: InkWell(
              onTap: () {
                // Get.to(() => FeeAnalysisScreen(
                //       loginSuccessModel: widget.loginSuccessModel,
                //       mskoolController: widget.mskoolController,
                //       title: 'Fee Analysis',
                //     ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fee",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(Icons.chevron_right_rounded),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: ((Get.width * 0.4329)),
          //   child: SfCartesianChart(
          //     primaryXAxis: CategoryAxis(
          //       majorGridLines: const MajorGridLines(width: 0.0),
          //       name: "Installment Name",
          //     ),
          //     primaryYAxis: NumericAxis(
          //         majorGridLines: const MajorGridLines(width: 0.0),
          //         name: "Amount",
          //         labelFormat: "{value}K",
          //         rangePadding: ChartRangePadding.round),
          //     tooltipBehavior: TooltipBehavior(enable: true),
          //     series: <ChartSeries>[
          //       LineSeries<FeeDetModel, String>(
          //           name: "Fee's Paid",
          //           dataSource: feeDetails,
          //           dataLabelSettings: const DataLabelSettings(isVisible: true),
          //           xValueMapper: ((datum, index) =>
          //               datum.instName.split(" ").first),
          //           yValueMapper: (((datum, index) => datum.amt))),
          //     ],
          //   ),
          // ),

          SizedBox(
              height: ((Get.width * 0.4329)),
              child: SfCircularChart(
                // title: ChartTitle(text: 'Fee Details'),

                margin: EdgeInsets.zero,
                palette: const [
                  Color(0xFFD09CFA),
                  Color(0xFF72FFFF),
                  Color(0xFFF2FA5A),
                  Color(0xFF93FFD8),
                  Color(0xFFFB7AFC),
                  Color(0xFFA9F1DF),
                  Color(0xFF52734D),
                  Color(0xFF91C788),
                  Color(0xFFDDFFBC),
                  Color(0xFFFEFFDE),
                  // Color.fromARGB(255, 135, 234, 245),
                  // Color.fromARGB(255, 125, 241, 187),
                  // Color.fromARGB(255, 240, 228, 119),
                  // Color.fromARGB(255, 238, 180, 118),
                  // Color.fromARGB(255, 204, 121, 235),
                  // Color.fromARGB(255, 114, 192, 238),
                  // Color.fromARGB(255, 238, 118, 170),
                  // Color.fromARGB(255, 109, 231, 203)
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  PieSeries<FeeDetModel, String>(
                    enableTooltip: true,
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside,
                        textStyle: TextStyle(fontSize: 12.0)),
                    dataSource: feeDetails,
                    xValueMapper: (datum, index) => datum.instName,
                    yValueMapper: (datum, index) => datum.amt,
                    dataLabelMapper: (datum, index) => datum.amtInK,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class FeeDetModel {
  final double amt;
  final String instName;
  final String amtInK;
  FeeDetModel({
    required this.amt,
    required this.instName,
    required this.amtInK,
  });

  FeeDetModel copyWith({
    double? amt,
    String? instName,
    String? amtInK,
  }) {
    return FeeDetModel(
      amt: amt ?? this.amt,
      instName: instName ?? this.instName,
      amtInK: amtInK ?? this.amtInK,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amt': amt,
      'instName': instName,
      'amtInK': amtInK,
    };
  }

  factory FeeDetModel.fromMap(Map<String, dynamic> map) {
    return FeeDetModel(
      amt: map['amt'] as double,
      instName: map['instName'] as String,
      amtInK: map['amtInK'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeeDetModel.fromJson(String source) =>
      FeeDetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FeeDetModel(amt: $amt, instName: $instName, amtInK: $amtInK)';

  @override
  bool operator ==(covariant FeeDetModel other) {
    if (identical(this, other)) return true;

    return other.amt == amt &&
        other.instName == instName &&
        other.amtInK == amtInK;
  }

  @override
  int get hashCode => amt.hashCode ^ instName.hashCode ^ amtInK.hashCode;
}
