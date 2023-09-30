import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/planner_status_model.dart';

class PlannerStatusWidget extends StatefulWidget {
  const PlannerStatusWidget({super.key});

  @override
  State<PlannerStatusWidget> createState() => _PlannerStatusWidgetState();
}

class _PlannerStatusWidgetState extends State<PlannerStatusWidget> {
  List<PlannerStatusModel> statusList = [];
  @override
  void initState() {
    setState(() {
      statusList.add(PlannerStatusModel('Sept 4th Week', '25-09-2023',
          '30-09-2023', '58:00 Hr', 'Approved', 'Name'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        scrollDirection: Axis.horizontal,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: DataTable(
            headingRowColor:
                MaterialStatePropertyAll(Theme.of(context).primaryColor),
            dataTextStyle: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 0.95),
                fontWeight: FontWeight.w400),
            // dataRowHeight: MediaQuery.of(context).size.height * 0.08,
            // headingRowHeight: MediaQuery.of(context).size.height * 0.08,
            horizontalMargin: 10,
            columnSpacing: MediaQuery.of(context).size.width * 0.08,
            dividerThickness: 1,
            headingTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
            border: TableBorder.all(
                borderRadius: BorderRadius.circular(10), width: 0.5),
            columns: const [
              DataColumn(
                label: Text('S.No'),
              ),
              DataColumn(
                label: Text("Planner"),
              ),
              DataColumn(
                label: Text('Start Date'),
              ),
              DataColumn(
                label: Text('End Date'),
              ),
              DataColumn(
                label: Text('Total Effort'),
              ),
              DataColumn(
                label: Text('Status'),
              ),
            ],
            rows: [
              ...List.generate(statusList.length, (index) {
                var i = index + 1;
                return DataRow(cells: [
                  DataCell(Text(i.toString())),
                  DataCell(Text(statusList[index].planner,
                      style: Get.textTheme.titleMedium!
                          .copyWith(color: Theme.of(context).primaryColor))),
                  DataCell(Text(statusList[index].startDate)),
                  DataCell(Text(statusList[index].endDate)),
                  DataCell(Text(statusList[index].totalEffort)),
                  DataCell(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: statusList[index].status,
                            style: Get.textTheme.titleMedium!
                                .copyWith(color: Colors.green)),
                        TextSpan(
                            text: ' By- ${statusList[index].assignedBy}',
                            style: Get.textTheme.titleSmall!.copyWith()),
                      ])),
                      Text('Remarks: ${statusList[index].status}'),
                    ],
                  )),
                ]);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
