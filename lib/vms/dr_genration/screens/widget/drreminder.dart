import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';

class RemainderDue extends StatelessWidget {
  RemainderDue({super.key});
  final PlannerDetails _plannerDetailsController = Get.put(PlannerDetails());
 TextEditingController   remarkEt = TextEditingController();
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
                                  "REMINDER DUE PLANNER DETAILS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .merge(TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                )
                              ],
                            ),
                           const SizedBox(height: 20,),
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
                                          'Planner Name',
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
                                          'Due Date',
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
                                          'Reminder Flag',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                     ],
                                  rows: List.generate(
                                      _plannerDetailsController
                                          .hrplannerDetailsList.length, (index) {
                                    int i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                           DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            _plannerDetailsController
                                          .hrplannerDetailsList.elementAt(index).hRPDSDPlannerName!
                                          ))),
                                          DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            _plannerDetailsController
                                          .hrplannerDetailsList.elementAt(index).hRPDSDDueDate!
                                          ))),
                                          DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            _plannerDetailsController
                                          .hrplannerDetailsList.elementAt(index).hRPLMGReminderFlag!
                                          ))),
                                       
                                    ]);
                                  }),
                                )),

                          ],
                        )))),
          ),
          SizedBox(
            height: 150, 
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: TextField(
              controller: remarkEt,      
              decoration:const InputDecoration(
               border:OutlineInputBorder(
               
               ) 
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
