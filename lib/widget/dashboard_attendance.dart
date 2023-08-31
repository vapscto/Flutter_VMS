import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashBoardAttendance extends StatefulWidget {
  final num? attendanceValue;
  const DashBoardAttendance({super.key, required this.attendanceValue});

  @override
  State<DashBoardAttendance> createState() => _DashBoardAttendanceState();
}

class _DashBoardAttendanceState extends State<DashBoardAttendance> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          showLabels: false,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          radiusFactor: 0.8,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.2,
            color: Color.fromARGB(30, 0, 169, 181),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
                value: widget.attendanceValue == null
                    ? 0
                    : widget.attendanceValue!.toDouble(),
                width: 0.2,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationDuration: 75,
                animationType: AnimationType.linear,
                gradient: const SweepGradient(
                    colors: <Color>[Color(0xFF31E1F7), Color(0xFF31E1F7)],
                    stops: <double>[0.25, 0.75])),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              positionFactor: 0.1,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.attendanceValue ?? "N/a"}%',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .merge(const TextStyle(fontSize: 25.0)),
                  ),
                  Text(
                    "Present",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            )
          ]),
    ]);
  }
}
