import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class TaskDetailsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const TaskDetailsScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _searchController = TextEditingController();
  List newTable = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Task Details").getAppBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: TextFormField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
                hintText: "Search here...",
                hintStyle:
                    Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                )),
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DataTable(
                    showCheckboxColumn: true,
                    headingRowColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor),
                    dataTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.95),
                        fontWeight: FontWeight.w400),
                    dataRowHeight: MediaQuery.of(context).size.height * 0.21,
                    headingRowHeight: MediaQuery.of(context).size.height * 0.08,
                    horizontalMargin: 10,
                    columnSpacing: MediaQuery.of(context).size.width * 0.08,
                    dividerThickness: 1,
                    headingTextStyle: Get.textTheme.titleSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10), width: 0.5),
                    columns: const [
                      DataColumn(
                        numeric: true,
                        label: Text(
                          'S.No',
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Task Details',
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Client-Module-Category',
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Date',
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Description',
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      ...List.generate(newTable.length, (index) {
                        var i = index + 1;

                        return DataRow(cells: [
                          DataCell(Text(i.toString())),
                          DataCell(SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newTable[index].taskNo,
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Text(
                                    newTable[index].taskName,
                                    maxLines: 2,
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Type Task: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: (newTable[index]
                                                            .ismtpltaId ==
                                                        0)
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.red)),
                                    TextSpan(
                                        text: newTable[index].taskType,
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Clint: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text: newTable[index].clint,
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Category: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text: newTable[index].category,
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Periodicity: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text: newTable[index].Periodicity,
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Assigned Date: ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                    TextSpan(
                                        text: newTable[index].assignedDate,
                                        style: Get.textTheme.titleSmall!
                                            .copyWith()),
                                  ])),
                                ],
                              ),
                            ),
                          )),
                          DataCell(Text(newTable[index].assignedBy)),
                          DataCell(Text(newTable[index].date)),
                          DataCell(Text(newTable[index].effort)),
                        ]);
                      })
                    ],
                  ),
                )),
          ],
        ))
      ]),
    );
  }
}
