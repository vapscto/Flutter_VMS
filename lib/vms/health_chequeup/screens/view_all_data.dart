import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/screens/attachment_viewer.dart';
import 'package:m_skool_flutter/vms/health_chequeup/api/get_hc_docx_api.dart';
import 'package:m_skool_flutter/vms/health_chequeup/controlers/health_controler.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ViewAllHC extends StatefulWidget {
  final int mIID;
  final MskoolController mskoolController;
   const ViewAllHC({
    required this.mIID,
    required this.mskoolController,
    super.key});

  @override
  State<ViewAllHC> createState() => _ViewAllHCState();
}

class _ViewAllHCState extends State<ViewAllHC> {
  final HealthCheckUpController healthCheckUpController =
      Get.put(HealthCheckUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "View All").getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: SingleChildScrollView(
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
                              dataRowHeight: 130,
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
                                // 1
                                DataColumn(
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
                                      'Client Name',
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
                                      'Visited Person',
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
                                      'Date',
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
                                      'Remarks',
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
                                      'Status',
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
                                      'File',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                  healthCheckUpController.getHCData.length,
                                  (index) {
                                int i = index + 1;
                                return DataRow(cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                          width: 140,
                                          child: Text(healthCheckUpController
                                              .getHCData
                                              .elementAt(index)
                                              .ismmclTClientName!)))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(healthCheckUpController
                                          .getHCData
                                          .elementAt(index)
                                          .hrmEEmployeeFirstName!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(healthCheckUpController
                                          .getHCData
                                          .elementAt(index)
                                          .visitedDate!))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 320,
                                        child: Text(
                                          healthCheckUpController.getHCData
                                              .elementAt(index)
                                              .remarks!,
                                          maxLines: 10,
                                        ),
                                      ))),
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(healthCheckUpController
                                          .getHCData
                                          .elementAt(index)
                                          .status!))),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () async{
                                           getDocxApi(
                                            base:  baseUrlFromInsCode('issuemanager', widget.mskoolController ),
                                            miId: widget.mIID,
                                            hcupID: healthCheckUpController
                                          .getHCData
                                          .elementAt(index).hwhchuPId!
                                          ).then(
                                            (value) {
                                              if(value!.values!.isNotEmpty){
                                              Get.to(() => AttachmentViewer(
                                              loadFromRawData: true,
                                              url: value.values!.first.filepath,
                                            )
                                          );  
                                              }
                                            
                                            },
                                          );
                                      
                                        },
                                        child: Icon(Icons.visibility)))),
                                ]);
                              }),
                            ))))),
          ],
        ),
      ),
    );
  }
}
