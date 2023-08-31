import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/principal/Fee_collection/controller/fee_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class DetailsFeesCollect extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  DetailsFeesCollect({required this.loginSuccessModel,
  required this.mskoolController});
  @override
  _DetailsFeesCollectState createState() => _DetailsFeesCollectState();
}

class _DetailsFeesCollectState extends State<DetailsFeesCollect> {
  FeeController controller = Get.put(FeeController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(title: "Fee Details").getAppBar(),
          body: Obx(
          () => controller.isLoadingFee.isTrue
              ? Center(
                  child: AnimatedProgressWidget(
                      title: "Loading Marks Entry",
                      desc:
                          "Please wait while we load marks entry detail table and create a view for you.",
                      animationPath: "assets/json/default.json"),
                )
              : SingleChildScrollView(
                  child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                                      'S.No',
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
                                      'Section',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Receipt Count',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Collected',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                  
                              ],
                              rows: List.generate(
                                  controller.SectionList.length,
                                  (index) {
                                var i = index + 1;
                                return DataRow(
                                  cells: [
                                    DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text('$i'))),
                                  DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.SectionList.elementAt(index).sectionname.toString()),
                                        )
                                        ),
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.SectionList.elementAt(index).recptCount.toString()),
                                        )
                                        ),   
                                         DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text( controller.SectionList.elementAt(index).paid.toString()),
                                        )
                                        ), 
                                         
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 128.0,
                      ),
                    ],
                  ),
                )),
        ),
    );
  }
  @override
  void dispose() {
   controller.SectionList.clear();
    super.dispose();
  }
}