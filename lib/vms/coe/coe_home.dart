import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';

class CoeHomeScreen extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const CoeHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "COE",
          style: Get.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 10),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                  dataRowHeight: 35,
                  headingRowHeight: 40,
                  columnSpacing: 20,
                  headingTextStyle: const TextStyle(color: Colors.white),
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 0.6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).primaryColor),
                  columns: const [
                    DataColumn(label: Text("SL.NO.")),
                    DataColumn(label: Text("Holiday")),
                    DataColumn(label: Text("Date")),
                  ],
                  rows: []),
            ),
          )
        ],
      ),
    );
  }
}
