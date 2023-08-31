import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/staff_home_fab.dart';

class ConsolidatedDateWiseStudentAttendanceDetailScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ConsolidatedDateWiseStudentAttendanceDetailScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<ConsolidatedDateWiseStudentAttendanceDetailScreen> createState() =>
      _ConsolidatedDateWiseStudentAttendanceDetailScreenState();
}

class _ConsolidatedDateWiseStudentAttendanceDetailScreenState
    extends State<ConsolidatedDateWiseStudentAttendanceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 25,
        title: const Text('Student Attendance'),
      ),
      floatingActionButton: StaffHomeFab(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: DataTable(
                      dataTextStyle: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.95),
                          fontWeight: FontWeight.w500),
                      dataRowHeight: 37,
                      headingRowHeight: 40,
                      horizontalMargin: 8,
                      columnSpacing: 26,
                      dividerThickness: 1,
                      headingTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      border: TableBorder.all(
                        borderRadius: BorderRadius.circular(12),
                        width: 0.5,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      // showBottomBorder: true,
                      headingRowColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Name',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Class\nHeld',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Class\nPresent',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Percentage',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],

                      rows: List.generate(20, (index) {
                        var i = index + 1;
                        return DataRow(
                          cells: [
                            const DataCell(
                              Text(
                                'Ankush Verma',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DataCell(
                              Text(
                                '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '15',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '10',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '25%',
                                  overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      ),
    );
  }
}
