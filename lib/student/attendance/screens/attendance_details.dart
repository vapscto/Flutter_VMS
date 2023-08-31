import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/student/attendance/controller/attendance_handler.dart';
import 'package:m_skool_flutter/student/attendance/widgets/attendance_column_chart.dart';

import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class AttendanceDetails extends StatefulWidget {
  final AttendanceHandler handler;
  final Map<String, dynamic> details;
  const AttendanceDetails(
      {super.key, required this.handler, required this.details});

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance".tr),
        leadingWidth: 30,
        leading: const CustomGoBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12.0,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall!.merge(
                      const TextStyle(
                        fontSize: 15.0,
                        //fontWeight: FontWeight.w400,
                        letterSpacing: 0.3,
                      ),
                    ),
                text: "Total Class Held : ".tr,
                children: [
                  TextSpan(
                    text: widget.details['tch'].toString(),
                    style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 0.3,
                          ),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall!.merge(
                      const TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 0.3,
                      ),
                    ),
                text: "Total Class Attended : ".tr,
                children: [
                  TextSpan(
                    text: widget.details['tca'].toString(),
                    style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 0.3,
                          ),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall!.merge(
                      const TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 0.3,
                      ),
                    ),
                text: "Total Class Percentage : ".tr,
                children: [
                  TextSpan(
                    text: "${widget.details['tcp']}%",
                    style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 0.3,
                          ),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomContainer(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.circle,
                            color: Color(0xFFDFEFFD),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("Total Present"),
                        ],
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          const Text("Total Class Held"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.00,
                  ),
                  AttendanceColumnChart(
                    handler: widget.handler,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
