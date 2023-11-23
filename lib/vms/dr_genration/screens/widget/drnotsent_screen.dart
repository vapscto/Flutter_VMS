import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class DrnotApprovedScreen extends StatelessWidget {
  DrnotApprovedScreen({super.key});
  final PlannerDetails _plannerDetailsController = Get.put(PlannerDetails());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Obx(
            () => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "DAILY REPORT NOT SENT DATES",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .merge(TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            ClipRRect(
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
                                          'DR Not Sent Date',
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
                                  
                                  ],
                                  rows: List.generate(
                                      _plannerDetailsController
                                          .drnotSentdetailsList.length, (index) {
                                    int i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text( 
                                            DateTime.parse( _plannerDetailsController
                                              .drnotSentdetailsList
                                              .elementAt(index)
                                              .fromDate!).toString()
                                          ))),
                                     
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child:TextField(
                                            maxLines: 3,
                                           style: Theme.of(context).textTheme.titleSmall,
                                            controller: _plannerDetailsController.etRemark.elementAt(index),
                                            decoration: InputDecoration(
                                              hintText: "Enter Remark",
                                              hintStyle: Theme.of(context).textTheme.titleSmall,
                                              border: OutlineInputBorder()
                                            ),
                                          )
                                            )),
                                    ]);
                                  }),
                                )),
                                MSkollBtn(title: "Save", onPress: 
                                () {
                                  
                                },)
                          ],
                        )))),
          ),
        ],
      ),
    );
  }
}
