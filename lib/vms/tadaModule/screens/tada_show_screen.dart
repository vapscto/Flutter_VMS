import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/apis/tada_apply_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/controller/tada_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/screens/tada_details_screen.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class TadaListScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const TadaListScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<TadaListScreen> createState() => _TadaListScreenState();
}

class _TadaListScreenState extends State<TadaListScreen> {
  TADAController tadaController = Get.put(TADAController());

  _getAPIData() async {
    tadaController.updateIsLoading(true);
    await TADAApplyListAPI.instance.showApplyList(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        tadaController: tadaController);
    tadaController.updateIsLoading(false);
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
        appBar: const CustomAppBar(title: 'TADA List').getAppBar(),
        body: tadaController.isLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading",
                    desc:
                        "Please wait while we load TADA lists and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )

 

            : tadaController.tadaData.isNotEmpty
                ? ListView(

                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    children: [
                      Text(
                        "TADA advance details for approval",
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
                                  tadaController.tadaData.length, (index) {
                                var value = index + 1;
                                if (tadaController
                                        .tadaData[index].vTADAAAAppliedDate !=
                                    null) {
                                  DateTime dt = DateTime.parse(tadaController
                                      .tadaData[index].vTADAAAAppliedDate!);
                                  date = '${dt.day}-${dt.month}-${dt.year}';
                                }

                                return DataRow(cells: [
                                  DataCell(Text(value.toString())),
                                  DataCell(Text(
                                      tadaController.tadaData[index].mIName ??
                                          "")),
                                  DataCell(Text(
                                      tadaController.tadaData[index].empName ??
                                          "")),
                                  DataCell(Text(tadaController
                                          .tadaData[index].clientName ??
                                      "")),
                                  DataCell(Text(
                                      tadaController.tadaData[index].cityName ??
                                          "")),
                                  DataCell(Text(date)),
                                  DataCell(Text(tadaController
                                      .tadaData[index].vTADAAATotalAppliedAmount
                                      .toString())),
                                  DataCell(Text(tadaController
                                      .tadaData[index].vTADAAAASactionedAmount
                                      .toString())),
                                  DataCell(Text(tadaController
                                          .tadaData[index].vTADAAARemarks ??
                                      "")),
                                  DataCell(IconButton(
                                      onPressed: () {
                                        Get.to(() => TADADetailsScreen(
                                              tadaController: tadaController,
                                              date: date,
                                              vtadaaaId: (tadaController
                                                          .tadaData[index]
                                                          .vTADAAAId !=
                                                      null)
                                                  ? tadaController
                                                      .tadaData[index]
                                                      .vTADAAAId!
                                                  : 0,
                                              values: tadaController
                                                  .tadaData[index],
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
