import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/staff_leave_approval/model/leave_approval_model.dart';

class ApprovalProxyListPopUp extends StatelessWidget {
  final LeaveApprovalModelValues value;
  ApprovalProxyListPopUp({super.key, required this.value});

  final List<Map<String, dynamic>> newList = [];

  @override
  Widget build(BuildContext context) {
    newList.clear();
    if (value.proxyName != null) {
      newList
          .add({"proxy": value.proxyName, "deg": value.hRMDESDesignationName});
    }
    return AlertDialog(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: const EdgeInsets.all(10),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Proxy Details",
                style: Get.textTheme.titleMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                scrollDirection: Axis.horizontal,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DataTable(
                      dataTextStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(0, 0, 0, 0.95),
                          fontWeight: FontWeight.w400),
                      dataRowHeight: 45,
                      headingRowHeight: 40,
                      horizontalMargin: 10,
                      columnSpacing: 10,
                      dividerThickness: 1,
                      headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(10), width: 0.5),
                      headingRowColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      columns: const [
                        DataColumn(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'S.No',
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Proxy Name',
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Designation',
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(newList.length, (index) {
                        int i = index + 1;
                        var data = newList.elementAt(index);
                        return DataRow(cells: [
                          DataCell(Align(
                              alignment: Alignment.center, child: Text('$i'))),
                          DataCell(Align(
                              alignment: Alignment.center,
                              child: Text(data['proxy']))),
                          DataCell(Align(
                              alignment: Alignment.center,
                              child: Text(data['deg']))),
                        ]);
                      }),
                    ))),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Back",
                    style:
                        Get.textTheme.titleMedium!.copyWith(color: Colors.red),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
