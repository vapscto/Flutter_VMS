// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/controller/view_student_details_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FeeTab extends StatefulWidget {
  final ViewStudentDetailsController controller;
  const FeeTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<FeeTab> createState() => _FeeTabState();
}

class _FeeTabState extends State<FeeTab> {
  double amount = 0;
  List<FeeGraphData> fee = [];
  List<Color> color = [
    const Color(0xFFD0F801),
    const Color(0xFF31E1F7),
    const Color(0xFFEBA9FF),
    const Color(0xFFFF79CD),
    const Color.fromARGB(15, 147, 255, 105),
    const Color.fromARGB(15, 188, 221, 39),
    const Color.fromARGB(15, 41, 24, 185),
    const Color.fromARGB(15, 161, 27, 45),
    const Color.fromARGB(15, 184, 14, 133),
    const Color.fromARGB(15, 14, 121, 148),
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      amount = 0;
      int index = -1;
      for (var element in widget.controller.getTermFee) {
        index += 1;
        if (index % 9 == 0) {
          index = 0;
        }
        if (element.balanceAmount != null) {
          amount += element.balanceAmount!.toDouble();
        }
        fee.add(FeeGraphData(
            name: element.fMTName == null
                ? "N/a"
                : "${element.fMTName!.split(" ").first} Inst",
            amt: element.balanceAmount == null
                ? 0
                : element.balanceAmount!.toDouble(),
            color: color.elementAt(index)));
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.controller.isErrorOccured.value
          ? Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg": widget.controller.status.value,
                },
              ),
            )
          : widget.controller.isLoading.value
              ? Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    desc: widget.controller.status.value,
                    title: "Please wait we are loading.",
                  ),
                )
              : widget.controller.feeDetails.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Fee Details Found",
                        desc:
                            "No Fee details present for this student.. Please ask your technical team to add some",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomContainer(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Academic Year",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  ),
                                  subtitle: Text(
                                    widget.controller.feeDetails.first.acdYear ?? "N/a",
                                  ),
                                  trailing: Chip(
                                    backgroundColor: const Color(0xFF93FF93),
                                    label: Text(
                                        "Balance: ₹${widget.controller.feeDetails.first.balance ?? "N/a"}"),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  height: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "${widget.controller.feeDetails.first.receivable ?? "N/a"}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(
                                                  const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          Text(
                                            "Payable",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(
                                                  TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .color,
                                                  ),
                                                ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${widget.controller.feeDetails.first.concession ?? "N/a"}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(
                                                  const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          Text(
                                            "Concession",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(
                                                  TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .color,
                                                  ),
                                                ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${widget.controller.feeDetails.first.collectionamount ?? "N/a"}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(
                                                  const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          Text(
                                            "Paid",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(
                                                  TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .color,
                                                  ),
                                                ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Term Wise Details",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomContainer(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Chip(
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 237, 237),
                                      label: Text(
                                        "Total ₹$amount ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                color: Color(0xFFD05954))),
                                      )),
                                  SfCartesianChart(
                                    primaryXAxis: CategoryAxis(
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                    ),
                                    primaryYAxis: NumericAxis(
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                    ),
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    series: [
                                      ColumnSeries(
                                          dataSource: fee,
                                          name: "Fees",
                                          enableTooltip: true,
                                          pointColorMapper: (datum, index) =>
                                              datum.color,
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(12.0),
                                          ),
                                          xValueMapper: (dta, index) =>
                                              dta.name,
                                          yValueMapper: (dta, index) => dta.amt,
                                          dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                            builder: (d, d2, d3, i, i2) => Text(
                                                "₹${fee.elementAt(i).amt}"),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
    });
  }
}

class FeeGraphData {
  final String name;
  final double amt;
  final Color color;
  FeeGraphData({
    required this.name,
    required this.amt,
    required this.color,
  });

  FeeGraphData copyWith({
    String? name,
    double? amt,
    Color? color,
  }) {
    return FeeGraphData(
      name: name ?? this.name,
      amt: amt ?? this.amt,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'amt': amt,
      'color': color.value,
    };
  }

  factory FeeGraphData.fromMap(Map<String, dynamic> map) {
    return FeeGraphData(
      name: map['name'] as String,
      amt: map['amt'] as double,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeeGraphData.fromJson(String source) =>
      FeeGraphData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FeeGraphData(name: $name, amt: $amt, color: $color)';

  @override
  bool operator ==(covariant FeeGraphData other) {
    if (identical(this, other)) return true;

    return other.name == name && other.amt == amt && other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ amt.hashCode ^ color.hashCode;
}
