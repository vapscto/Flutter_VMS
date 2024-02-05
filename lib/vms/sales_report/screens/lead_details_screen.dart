import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class LeadDetailsScreen extends StatelessWidget {
  final MskoolController mskoolController;
  const LeadDetailsScreen({super.key, required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Lead Details').getAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                dataRowHeight: MediaQuery.of(context).size.height * 0.05,
                headingRowHeight: 45,
                columnSpacing: 10,
                headingTextStyle: const TextStyle(color: Colors.white),
                border: TableBorder.all(
                  color: Colors.black,
                  width: 0.6,
                  borderRadius: BorderRadius.circular(10),
                ),
                dataTextStyle: Get.textTheme.titleSmall,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).primaryColor),
                columns: const [
                  DataColumn(label: Text("Lead Name")),
                  DataColumn(label: Text("Contact Person")),
                  DataColumn(label: Text("ContactNo")),
                  DataColumn(label: Text("Email Id")),
                  DataColumn(label: Text("Demo Type")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Remarks")),
                ],
                rows: const [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
