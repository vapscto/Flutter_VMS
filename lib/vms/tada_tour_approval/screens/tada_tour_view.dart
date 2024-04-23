import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/api/get_views_tour.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/controller/tada_tour_cntrl.dart';
import 'package:m_skool_flutter/vms/tada_tour_approval/screens/view_planer.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class TadaViewTourView extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  TadaViewTourView(
      {required this.loginSuccessModel, required this.mskoolController});

  @override
  State<TadaViewTourView> createState() => _TadaViewTourViewState();
}

class _TadaViewTourViewState extends State<TadaViewTourView> {
  TadaTourController controller = TadaTourController();
  @override
  void initState() {
    initApi();
    super.initState();
  }

  void initApi() async {
    await getViewList(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        tadaTourController: controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "TADA Tour Approval").getAppBar(),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => controller.getTourViewList.isEmpty
                ? const AnimatedProgressWidget(
                    title: "Please Wait",
                    desc: "We are trying to loging you in.",
                    animationPath: "assets/json/default.json")
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
                                      child: Text("Tour Name"),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.center,
                                      child: Text("View"),
                                    ),
                                  )
                                ],
                                rows: List.generate(
                                    controller.getTourViewList.length, (index) {
                                  int num = index + 1;
                                  return DataRow(cells: [
                                    DataCell(Align(
                                      child: Text("$num"),
                                    )),
                                    DataCell(Align(
                                      child: Text(
                                        controller.getTourViewList
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
                                        controller.getTourViewList
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
                                        controller.planerName
                                            .elementAt(index)
                                            .locationName!,
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
                                            Get.to(()=>
                                              ViewTourPLan(getTourViewValues: controller.getTourViewList.elementAt(index) ,
                                               planerNme: 
                                                controller.planerName
                                            .elementAt(index)
                                            .locationName!,
                                                loginSuccessModel: widget.loginSuccessModel,
                                                mskoolController: widget.mskoolController,
                                                controller: controller,
                                              )
                                            );
                                            
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
}
