import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/controller/planner_approval_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class DrNotSubmitWidget extends StatelessWidget {
  final String name;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final PlannerApprovalController plannerApprovalController;
  const DrNotSubmitWidget(
      {super.key,
      required this.name,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.plannerApprovalController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Theme.of(context).primaryColor),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        "Daily report not approved dates of:- $name",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              (plannerApprovalController.notApproveDates.isEmpty)
                  ? const Center(
                      child: AnimatedProgressWidget(
                          title: "Getting Not submited dr List",
                          desc:
                              "We are loading Not submited dr... Please wait ",
                          animationPath: "assets/json/default.json"),
                    )
                  : ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: DataTable(
                                  dataRowHeight: 35,
                                  headingRowHeight: 40,
                                  columnSpacing: 20,
                                  headingTextStyle:
                                      const TextStyle(color: Colors.white),
                                  border: TableBorder.all(
                                    color: Colors.black,
                                    width: 0.6,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  headingRowColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Theme.of(context).primaryColor),
                                  columns: const [
                                    DataColumn(label: Text("SL.NO.")),
                                    DataColumn(
                                        label: Text("Daily Report Date")),
                                    DataColumn(
                                        label: Text(
                                            "Daily Report Generated Date")),
                                    DataColumn(label: Text("Other's Day")),
                                  ],
                                  rows: List.generate(
                                      plannerApprovalController
                                          .notApproveDates.length, (index) {
                                    var i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Text(i.toString())),
                                      DataCell(Text(plannerApprovalController
                                          .notApproveDates
                                          .elementAt(
                                              index)['dailyReportDate'])),
                                      DataCell(Text(plannerApprovalController
                                          .notApproveDates
                                          .elementAt(index)['generatedDate'])),
                                      DataCell(Text(
                                          '${plannerApprovalController.notApproveDates.elementAt(index)['othersDay']}')),
                                    ]);
                                  })),
                            ),
                          ),
                        ),
                      ],
                    ),
            ]),
      ),
    );
  }
}
