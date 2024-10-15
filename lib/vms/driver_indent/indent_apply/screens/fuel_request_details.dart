import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class FuelRequestDetails extends StatefulWidget {
  const FuelRequestDetails({super.key});

  @override
  State<FuelRequestDetails> createState() => _FuelRequestDetailsState();
}

class _FuelRequestDetailsState extends State<FuelRequestDetails> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Fuel Request Details").getAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              style: Get.textTheme.titleSmall,
              onChanged: (value) {},
              decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle:
                      Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
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
                    DataColumn(label: Text("SL.No.")),
                    DataColumn(label: Text("Request Date")),
                    DataColumn(label: Text("Vehicle No")),
                    DataColumn(label: Text("Bill No")),
                    DataColumn(label: Text("Quantity(Ltr)")),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Remarks")),
                    DataColumn(label: Text("Opening KM")),
                    DataColumn(label: Text("Closing KM")),
                    DataColumn(label: Text("Balance Diesel")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows: const [],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
