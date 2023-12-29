import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/visitor_approval/api/visitor_api.dart';
import 'package:m_skool_flutter/vms/visitor_approval/controller/visitor_approval_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class VisitorApprovalHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const VisitorApprovalHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  VisitorApprovalHomeState createState() => VisitorApprovalHomeState();
}

class VisitorApprovalHomeState extends State<VisitorApprovalHome> {
  VisitorApprovalController controller = Get.put(VisitorApprovalController());
  _loadData() async {
    controller.updateIsLoadingVisitor(true);
    await VisitorApprovalApi.instance.getVisitorApprovalApi(
        base: baseUrlFromInsCode(
            'visitorsManagementServiceHub', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        controller: controller,
        miId: widget.loginSuccessModel.mIID!);
    controller.updateIsLoadingVisitor(false);
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Visitor Approval").getAppBar(),
        floatingActionButton: const HomeFab(),
        body: Obx(
          () => controller.isLoadingVisitor.value
              ? const Center(
                  child: AnimatedProgressWidget(
                    animationPath: "assets/json/default.json",
                    animatorHeight: 300,
                    title: "Loading Visitor Approval",
                    desc:
                        "Please wait while we laod detail table and create a view for you",
                  ),
                )
              : controller.getvisitorList.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 300,
                        title: "Data is not Available For Visitor Approval",
                        desc: " ",
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: DataTable(
                                  dataTextStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(0, 0, 0, 0.95),
                                      fontWeight: FontWeight.w500),
                                  dataRowHeight: 45,
                                  headingRowHeight: 40,
                                  horizontalMargin: 10,
                                  columnSpacing: 40,
                                  dividerThickness: 1,
                                  headingTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  border: TableBorder.all(
                                      borderRadius: BorderRadius.circular(10),
                                      width: 0.5),
                                  headingRowColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                  columns: const [
                                    DataColumn(
                                      numeric: true,
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'SL.No.',
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
                                          'Company Name',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Visitor Name',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'To Meet',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Appointment Date',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Requested By',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Status',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Action',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                      controller.getvisitorList.length,
                                      (index) {
                                    var i = index + 1;
                                    return DataRow(
                                      cells: [
                                        DataCell(Align(
                                            alignment: Alignment.center,
                                            child: Text('$i'))),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getvisitorList
                                              .elementAt(index)
                                              .mIName
                                              .toString()),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getvisitorList
                                              .elementAt(index)
                                              .vMAPVisitorName
                                              .toString()),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getvisitorList
                                              .elementAt(index)
                                              .hrmEEmployeeFirstName
                                              .toString()),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getvisitorList
                                              .elementAt(index)
                                              .vMAPEntryDateTime
                                              .toString()),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getvisitorList
                                              .elementAt(index)
                                              .createdby
                                              .toString()),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(controller.getvisitorList
                                              .elementAt(index)
                                              .vMAPStatus
                                              .toString()),
                                        )),
                                        DataCell(IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.visibility),
                                        )),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
        ));
  }
}
