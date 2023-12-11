import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/get_depart_api.dart';
import 'package:m_skool_flutter/vms/task%20creation/controller/task_department_cntrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/created_task_list_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class TaskDetailsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final TaskDepartController taskDepartController;
  const TaskDetailsScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.taskDepartController});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _searchController = TextEditingController();
  _loadData() async {
    widget.taskDepartController.createdTask(true);
    await CreatedTaskList.instance.getTskCompaniesList(
      base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
      controller: widget.taskDepartController,
      userId: widget.loginSuccessModel.userId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      miId: widget.loginSuccessModel.mIID!,
    );
    widget.taskDepartController.createdTask(false);
  }

  List<CreatedTaskListModelValues> filterData = [];
  filterFun(String query) {
    filterData = widget.taskDepartController.createdTaskList.where((list) {
      return list.iSMTCRTaskNo!.toLowerCase().contains(query.toLowerCase()) ||
          list.iSMTCRTitle!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    filterData = widget.taskDepartController.createdTaskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const CustomAppBar(title: "Task Details").getAppBar(),
        body: (widget.taskDepartController.isCreatedTaskLoading.value)
            ? const AnimatedProgressWidget(
                animationPath: 'assets/json/default.json',
                title: 'Loading data',
                desc: "Please wait we are loading data",
              )
            : (widget.taskDepartController.createdTaskList.isEmpty)
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Tasks not Found",
                        desc: " ",
                        animationPath: "assets/json/nodata.json"))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                filterFun(_searchController.text);
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "Search Task by Name and Task Number",
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                )),
                          ),
                        ),
                        Expanded(
                            child: ListView(
                          children: [
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: DataTable(
                                    showCheckboxColumn: true,
                                    headingRowColor: MaterialStatePropertyAll(
                                        Theme.of(context).primaryColor),
                                    dataTextStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(0, 0, 0, 0.95),
                                        fontWeight: FontWeight.w400),
                                    dataRowHeight:
                                        MediaQuery.of(context).size.height *
                                            0.2,
                                    headingRowHeight: 50,
                                    horizontalMargin: 10,
                                    columnSpacing: 10,
                                    dividerThickness: 1,
                                    headingTextStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                    border: TableBorder.all(
                                        borderRadius: BorderRadius.circular(10),
                                        width: 0.5),
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
                                      ...List.generate(filterData.length,
                                          (index) {
                                        var i = index + 1;
                                        var value = filterData.elementAt(index);

                                        return DataRow(cells: [
                                          DataCell(Text(i.toString())),
                                          DataCell(SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Clipboard.setData(
                                                              ClipboardData(
                                                                  text: value
                                                                      .iSMTCRTaskNo!))
                                                          .then((_) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Copied to your clipboard !')));
                                                      });
                                                    },
                                                    child: Text(
                                                        value.iSMTCRTaskNo!)),
                                                Text(value.iSMTCRTitle!),
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: value
                                                          .iSMTCRBugOREnhancementFlg,
                                                      style: Get.textTheme
                                                          .titleSmall!),
                                                  TextSpan(
                                                      text:
                                                          '-${value.hRMPName}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color:
                                                                  Colors.red)),
                                                  TextSpan(
                                                      text:
                                                          '-${value.iSMTCRStatus}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: (value
                                                                          .iSMTCRStatus ==
                                                                      "Close")
                                                                  ? Theme.of(
                                                                          context)
                                                                      .primaryColor
                                                                  : Colors
                                                                      .red)),
                                                ])),
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Dept: ",
                                                      style: Get.textTheme
                                                          .titleSmall!),
                                                  TextSpan(
                                                      text:
                                                          '-${value.hRMDDepartmentName}',
                                                      style: Get.textTheme
                                                          .titleSmall!),
                                                ])),
                                              ],
                                            ),
                                          )),
                                          DataCell(SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Client: ",
                                                      style: Get.textTheme
                                                          .titleSmall!),
                                                  TextSpan(
                                                      text:
                                                          '${value.iSMMCLTClientName}',
                                                      style: Get.textTheme
                                                          .titleSmall!),
                                                ])),
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Module: ",
                                                      style: Get.textTheme
                                                          .titleSmall!),
                                                  TextSpan(
                                                      text:
                                                          '${value.iVRMMModuleName}',
                                                      style: Get.textTheme
                                                          .titleSmall!),
                                                ])),
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Category: ",
                                                      style: Get.textTheme
                                                          .titleSmall!),
                                                  TextSpan(
                                                      text:
                                                          '${value.iSMMTCATTaskCategoryName}',
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                ])),
                                              ],
                                            ),
                                          )),
                                          DataCell(
                                              Text(value.iSMTCRCreationDate!)),
                                          DataCell(Text(value.iSMTCRDesc!)),
                                        ]);
                                      })
                                    ],
                                  ),
                                )),
                          ],
                        ))
                      ]),
      );
    });
  }
}
