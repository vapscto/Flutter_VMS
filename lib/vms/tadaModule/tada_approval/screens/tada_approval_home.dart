import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/api/tada_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/controller/tada_approval_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_approval/screens/tada_approval_details_scren.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class TadaApproveHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const TadaApproveHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<TadaApproveHomeScreen> createState() => _TadaApproveHomeScreenState();
}

class _TadaApproveHomeScreenState extends State<TadaApproveHomeScreen> {
  TadaApprovalController tadaApprovalController =
      Get.put(TadaApprovalController());
  _getAPIData() async {
    tadaApprovalController.dataLoading(true);
    await TADAApprovalListAPI.instance.showApplyList(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        tadaController: tadaApprovalController);
    tadaApprovalController.dataLoading(false);
  }

  String date = '';

  @override
  void initState() {
    _getAPIData();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar:
            const CustomAppBar(title: 'TADA Details For Approval').getAppBar(),
        body: tadaApprovalController.isDataLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading",
                    desc:
                        "Please wait while we load TADA Details and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : tadaApprovalController.tadaApprovalList.isNotEmpty
                ? ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    children: [
                      Text(
                        "TADA details for approval",
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                              dataRowHeight: 35,
                              headingRowHeight: 45,
                              columnSpacing: 20,
                              headingTextStyle:
                                  const TextStyle(color: Colors.white),
                              border: TableBorder.all(
                                color: Colors.black,
                                width: 0.6,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context).primaryColor),
                              columns: const [
                                DataColumn(label: Text("SL.NO.")),
                                DataColumn(label: Text("Company Name")),
                                DataColumn(label: Text("Staff Name")),
                                DataColumn(label: Text("Clients")),
                                DataColumn(label: Text("City")),
                                DataColumn(label: Text("Applied Date")),
                                DataColumn(label: Text("Applied Amount")),
                                DataColumn(label: Text("Sanctioned Amount")),
                                DataColumn(label: Text("Remarks")),
                                DataColumn(label: Text("Approve/Reject")),
                              ],
                              rows: List.generate(
                                  tadaApprovalController
                                      .tadaApprovalList.length, (index) {
                                var value = index + 1;
                                var v = tadaApprovalController.tadaApprovalList
                                    .elementAt(index);
                                if (v.vTADAAAppliedDate != null) {
                                  DateTime dt =
                                      DateTime.parse(v.vTADAAAppliedDate!);
                                  date = '${dt.day}-${dt.month}-${dt.year}';
                                }

                                return DataRow(cells: [
                                  DataCell(Text(value.toString())),
                                  DataCell(Text(v.mIName ?? "")),
                                  DataCell(Text(v.empName ?? "")),
                                  DataCell(Text(v.clientName ?? "")),
                                  DataCell(Text(v.cityName ?? "")),
                                  DataCell(Text(date)),
                                  DataCell(Text(
                                      v.vTADAATotalAppliedAmount.toString())),
                                  DataCell(Text(
                                      v.vTADAATotalSactionedAmount.toString())),
                                  DataCell(Text(v.vTADAARemarks ?? "")),
                                  DataCell(IconButton(
                                      onPressed: () {
                                        Get.to(() => TADAApprovalDetailsScreen(
                                              tadaController:
                                                  tadaApprovalController,
                                              date: date,
                                              vtadaaId: (tadaApprovalController
                                                          .tadaApprovalList[
                                                              index]
                                                          .vTADAAId !=
                                                      null)
                                                  ? tadaApprovalController
                                                      .tadaApprovalList[index]
                                                      .vTADAAId!
                                                  : 0,
                                              values: tadaApprovalController
                                                  .tadaApprovalList[index],
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController,
                                            ));
                                      },
                                      icon: const Icon(Icons.visibility))),
                                ]);
                              })),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: AnimatedProgressWidget(
                      title:
                          "TADA advance request is not availabla for approval",
                      desc: "",
                      animationPath: "assets/json/nodata.json",
                      animatorHeight: 250,
                    ),
                  ),
      );
    });
  }
}
