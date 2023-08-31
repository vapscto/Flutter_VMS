import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/Principal/toperWise/api/toper_result_api.dart';
import 'package:m_skool_flutter/Principal/toperWise/controller/toper_wise_result.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ToperResultShow extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int sub_checkType;
  const ToperResultShow(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.sub_checkType});

  @override
  State<ToperResultShow> createState() => _ToperResultShowState();
}

class _ToperResultShowState extends State<ToperResultShow> {
  ToperWiseController marksEntryController = Get.put(ToperWiseController());
  @override
  void initState() {
    loadResult();
    super.initState();
  }

  loadResult() async {
    // await featchResult(
    //     miId: widget.loginSuccessModel.mIID!,
    //     asmayId: "academic code",
    //     asmclId: "",
    //     asmsId: 0,
    //     emeId: "",
    //     ismsId: '',
    //     examCheckType: "",
    //     reportType: '',
    //     subCheckType: '',
    //     topper: '',
    //     base: baseUrlFromInsCode("exam", widget.mskoolController),
    //     controller: marksEntryController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Toper wise list").getAppBar(),
      body: Obx(
        () => marksEntryController.isLoadingCategory.isTrue
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
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                                    'Rank',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Adm.No',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Name',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Class",
                                    style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.clip),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Section",
                                    style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.clip),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Total Marks",
                                    style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.clip),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Obtained Marks",
                                    style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.clip),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Pecentage",
                                    style: TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.clip),
                                  ),
                                ),
                              ),
                            ],
                            rows: List.generate(
                                marksEntryController.marksDataTableList.length,
                                (index) {
                              var i = index + 1;
                              return DataRow(
                                cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.sub_checkType == 1
                                            ? marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .rNO
                                                .toString()
                                            : marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .estmPSectionRank
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        marksEntryController.marksDataTableList
                                            .elementAt(index)
                                            .amsTAdmNo
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        marksEntryController.marksDataTableList
                                            .elementAt(index)
                                            .amsTFirstName
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.sub_checkType == 1
                                            ? marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .ASMCLClassName
                                                .toString()
                                            : marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .asmcLClassName
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.sub_checkType == 1
                                            ? marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .ASMCSectionName
                                                .toString()
                                            : marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .asmCSectionName
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.sub_checkType == 1
                                            ? marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .estmpSMaxMarks
                                                .toString()
                                            : marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .estmPTotalMaxMarks
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.sub_checkType == 1
                                            ? marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .estmpSObtainedMarks
                                                .toString()
                                            : marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .estmPTotalObtMarks
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.sub_checkType == 1
                                            ? marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .estmpSSectionHighest
                                                .toString()
                                            : marksEntryController
                                                .marksDataTableList
                                                .elementAt(index)
                                                .estmPPercentage
                                                .toString(),
                                      ),
                                    ),
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
    if (marksEntryController.marksDataTableList.isNotEmpty) {
      marksEntryController.marksDataTableList.clear();
    }

    super.dispose();
  }
}
