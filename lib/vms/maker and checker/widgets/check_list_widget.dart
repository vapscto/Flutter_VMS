import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/dr_check_list_model.dart';

class CheckListWidget extends StatelessWidget {
  final List<DrCheckListModelValues> checkList;
  final String taskNo;
  final String eName;
  const CheckListWidget(
      {super.key,
      required this.checkList,
      required this.taskNo,
      required this.eName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(10),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Employee Name:- ',
                    style: Get.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w500)),
                TextSpan(
                    text: eName,
                    style: Get.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor)),
              ])),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Task No.:- ',
                    style: Get.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w500)),
                TextSpan(
                    text: taskNo,
                    style: Get.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor)),
              ])),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DataTable(
                        dataTextStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 0.95),
                            fontWeight: FontWeight.w500),
                        dataRowHeight: 50,
                        headingRowHeight: 40,
                        horizontalMargin: 10,
                        columnSpacing: 30,
                        dividerThickness: 1,
                        headingTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        border: TableBorder.all(
                            borderRadius: BorderRadius.circular(10),
                            width: 0.5),
                        headingRowColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        columns: const [
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text('S.No'),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Checklist Name',
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'File Name',
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'File Details',
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Ref.No',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Remarks',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(checkList.length, (index) {
                          int i = index + 1;
                          var data = checkList.elementAt(index);
                          return DataRow(cells: [
                            DataCell(Text('$i')),
                            DataCell(Text(data.ismmtcatcLCheckListName ?? '')),
                            DataCell(Text(data.ismdrptfLFileName ?? '')),
                            DataCell(Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    createPreview(
                                        context, data.ismdrptfLFilePath!);
                                  },
                                  child: const Icon(Icons.visibility),
                                ))),
                            DataCell(Text(data.ismdrptfLRefNo ?? '')),
                            DataCell(Text(data.ismdrptfLRemarks ?? '')),
                          ]);
                        }),
                      ))),
              const SizedBox(
                height: 4,
              )
            ],
          )),
    );
  }
}
