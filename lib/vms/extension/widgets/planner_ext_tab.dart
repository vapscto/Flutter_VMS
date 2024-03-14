import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/extension/controller/extension_controller.dart';
import 'package:m_skool_flutter/vms/extension/model/planner_extension.dart';

class PlannerExtensionTab extends StatefulWidget {
  final ExtensionController controller;
  const PlannerExtensionTab({super.key, required this.controller});

  @override
  State<PlannerExtensionTab> createState() => _PlannerExtensionTabState();
}

class _PlannerExtensionTabState extends State<PlannerExtensionTab> {
  RxList<ExtensionPlannerModelValues> filterList =
      <ExtensionPlannerModelValues>[].obs;
  final searchController = TextEditingController();
  @override
  void initState() {
    filterList.value = widget.controller.extensionPlannerList;
    super.initState();
  }

  _filterData(String data) {
    if (data.isEmpty) {
      filterList.value = widget.controller.extensionPlannerList;
    } else {
      filterList.value = widget.controller.extensionPlannerList.where((value) {
        return value.employeename!.toLowerCase().contains(data.toLowerCase());
      }).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  style: Get.textTheme.titleSmall,
                  controller: searchController,
                  onChanged: (value) {
                    _filterData(value);
                  },
                  decoration: InputDecoration(
                      hintText: "Search Staff Name....",
                      hintStyle: Get.textTheme.titleSmall!
                          .copyWith(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
                const SizedBox(height: 4),
                (filterList.isEmpty)
                    ? const SizedBox()
                    : Text(
                        filterList.length.toString(),
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Colors.green),
                      ),
              ],
            ),
          ),
          (filterList.isEmpty)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                            headingRowColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor),
                            dataTextStyle: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 0.95),
                                fontWeight: FontWeight.w400),
                            dataRowHeight:
                                MediaQuery.of(context).size.height * 0.1,
                            horizontalMargin: 10,
                            dividerThickness: 1,
                            headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            border: TableBorder.all(
                                borderRadius: BorderRadius.circular(10),
                                width: 0.5),
                            columns: const [
                              DataColumn(
                                label: Text('S.No'),
                              ),
                              DataColumn(
                                label: Text("Employee"),
                              ),
                              DataColumn(
                                label: Text('Emp.Code'),
                              ),
                              DataColumn(
                                label: Text('Valid From'),
                              ),
                              DataColumn(
                                label: Text('To'),
                              ),
                              DataColumn(
                                label: Text('Reason'),
                              ),
                              DataColumn(
                                label: Text('Given By'),
                              ),
                            ],
                            rows: [
                              ...List.generate(filterList.length, (index) {
                                var i = index + 1;
                                var val = filterList.elementAt(index);

                                return DataRow(cells: [
                                  DataCell(Text(i.toString())),
                                  DataCell(Text(
                                    val.employeename!,
                                  )),
                                  DataCell(Text(val.hrmEEmployeeCode!)),
                                  DataCell(Text(getDateFrom(
                                      DateTime.parse(val.ismplEFromDate!)))),
                                  DataCell(Text(getDateFrom(
                                      DateTime.parse(val.ismplEToDate!)))),
                                  DataCell(SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text('${val.ismplEReason}'))),
                                  DataCell(SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Text('${val.bymployeename}'))),
                                ]);
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      );
    });
  }

  String getDateFrom(DateTime? dt) {
    return "${dt!.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
  }
}
