import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/apis/tada_tour_approval_api.dart';
import 'package:m_skool_flutter/vms/final_tour_approval/controller/final_tada_tour_approval.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class FinalTadaTourApprovalList extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  FinalTadaTourApprovalList(
      {required this.loginSuccessModel, required this.mskoolController});

  @override
  State<FinalTadaTourApprovalList> createState() =>
      _FinalTadaTourApprovalListState();
}

class _FinalTadaTourApprovalListState extends State<FinalTadaTourApprovalList> {
  TadaTourApprovalController controller = TadaTourApprovalController();

  @override
  void initState() {
    initApi();
    super.initState();
  }

  initApi() async {
    await getFinalAdavncedViewList(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        controller: controller,
        userId: widget.loginSuccessModel.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Final TADA Approval").getAppBar(),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => controller.showFinalTadaTourApprovalList.isTrue
                ? const AnimatedProgressWidget(
                    title: "Loading...",
                    desc: "We are trying to loging you in.",
                    animationPath: "assets/json/default.json")
                : controller.finaltadaTourApprovalList.isEmpty
                    ? const AnimatedProgressWidget(
                        title: "No Data",
                        desc: "No data is available",
                        animationPath: "assets/json/nodata.json")
                    : Column(
                        children: [
                          SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                    border: TableBorder.all(
                                        borderRadius: BorderRadius.circular(10),
                                        width: 0.5),
                                    headingRowColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor),
                                    columns: const [
                                      DataColumn(
                                        label: Align(
                                          alignment: Alignment.center,
                                          child: Text("SL.No"),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Align(
                                          alignment: Alignment.center,
                                          child: Text("Company Name"),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Align(
                                          alignment: Alignment.center,
                                          child: Text("Staff Name"),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Align(
                                          alignment: Alignment.center,
                                          child: Text("Applied Date"),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Align(
                                          alignment: Alignment.center,
                                          child: Text("Applied amount"),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Align(
                                          alignment: Alignment.center,
                                          child: Text("Remark"),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Align(
                                          alignment: Alignment.center,
                                          child: Text("view"),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                        controller.finaltadaTourApprovalList
                                            .length, (index) {
                                      int num = index + 1;
                                      return DataRow(cells: [
                                        DataCell(Align(
                                          child: Text("$num"),
                                        )),
                                        DataCell(Align(
                                          child: Text(
                                            controller.finaltadaTourApprovalList
                                                .elementAt(index)
                                                .mIName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ),
                                        )),
                                        DataCell(Align(
                                          child: Text(
                                            controller.finaltadaTourApprovalList
                                                .elementAt(index)
                                                .empName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ),
                                        )),
                                        DataCell(Align(
                                          child: Text(
                                           getDate(controller.finaltadaTourApprovalList
                                                .elementAt(index)
                                                .vTADAAAppliedDate!) ,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ),
                                        )),
                                        DataCell(Align(
                                          child: Text(
                                            controller.finaltadaTourApprovalList
                                                .elementAt(index)
                                                .vTADAATotalAppliedAmount!
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ),
                                        )),
                                        DataCell(Align(
                                          child: Text(
                                            controller.finaltadaTourApprovalList
                                                .elementAt(index)
                                                .vTADAARemarks!
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ),
                                        )),
                                        DataCell(Align(
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                // Get.to(()=>

                                                // );
                                              },
                                              child: Icon(Icons.visibility,
                                                  color: Colors.blue[900]),
                                            ),
                                          ),
                                        )),
                                      ]);
                                    }),
                                  )))
                        ],
                      ),
          )),
    );
  }

  String getDate(String date) {
    DateTime dt = DateTime.parse(date);
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, "0")}";
  }

  @override
  void dispose() {
    controller.finaltadaTourApprovalList.clear();
    super.dispose();
  }
}
