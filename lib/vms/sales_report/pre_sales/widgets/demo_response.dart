import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/controller/pre_sales_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class DemoResponseScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final PreSalesController preSalesController;
  const DemoResponseScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.preSalesController});

  @override
  State<DemoResponseScreen> createState() => _DemoResponseScreenState();
}

class _DemoResponseScreenState extends State<DemoResponseScreen> {
  bool selectAll = false;
  List<bool> newList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Demo Response").getAppBar(),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DataTable(
                    headingRowHeight: 45,
                    dataRowHeight: 45,
                    headingRowColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor),
                    dataTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.95),
                        fontWeight: FontWeight.w400),
                    horizontalMargin: 10,
                    headingTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10), width: 0.5),
                    columns: [
                      DataColumn(
                          numeric: true,
                          label: Align(
                            alignment: Alignment.center,
                            child: Checkbox(
                                checkColor: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                side: const BorderSide(color: Colors.white),
                                value: selectAll,
                                onChanged: (value) {
                                  setState(() {
                                    selectAll = value!;
                                  });
                                }),
                          )),
                      const DataColumn(
                        label: Text('S.No'),
                      ),
                      const DataColumn(
                        label: Text("Product"),
                      ),
                      const DataColumn(
                        label: Text('Discussion Points'),
                      ),
                      const DataColumn(
                        label: Text('Status'),
                      ),
                      const DataColumn(
                        label: Text('Remark'),
                      ),
                    ],
                    rows: []),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MSkollBtn(title: "Save", onPress: () {}),
    );
  }
}
