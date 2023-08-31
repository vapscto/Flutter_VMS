import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/principal/preadmission_module/controller/pre_admission_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class StudentListTable extends StatefulWidget {
  final PreAdmissionController preAdmissionController;
  const StudentListTable({super.key, required this.preAdmissionController});

  @override
  State<StudentListTable> createState() => _StudentListTableState();
}

class _StudentListTableState extends State<StudentListTable> {
  int _currentSortColumn = 0;
  bool _isAscending = true;

  _isLoading() async {
    widget.preAdmissionController.updateIsLoading(true);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      widget.preAdmissionController.updateIsLoading(false);
      setState(() {
        widget.preAdmissionController.studentTableData;
      });
    });
  }

  @override
  void initState() {
    _isLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Student List').getAppBar(),
      body: Obx(() {
        return widget.preAdmissionController.isLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading...",
                    desc: "Please wait while we load student list for you.",
                    animationPath: "assets/json/default.json"),
              )
            : widget.preAdmissionController.studentTableData.isEmpty
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "No Data Found",
                        desc: "Please wait while we load student list for you.",
                        animationPath: "assets/json/nodata.json",animatorHeight: 250,),
                  )
                : ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _createDataTable(),
                        ),
                      ),
                    ],
                  );
      }),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
      dataRowHeight: 35,
      headingRowHeight: 35,
      columnSpacing: 15,
        sortAscending: _isAscending,
        sortColumnIndex: _currentSortColumn,
        border:
            TableBorder.all(width: 0.6, borderRadius: BorderRadius.circular(10)),
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Theme.of(context).primaryColor),
        columns: _createColumns(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        
          label: Text(
        "SLNO",
        style: Get.textTheme.bodySmall!.copyWith(color: Colors.white),
      )),
      DataColumn(
          label: Text(
            "STUDENT NAME",
            style: Get.textTheme.bodySmall!.copyWith(color: Colors.white),
          ),
          onSort: (columnIndex, _) {
            setState(() {
              _currentSortColumn = columnIndex;
              if (_isAscending == true) {
                _isAscending = false;

                widget.preAdmissionController.studentTableData
                    .sort((b, a) => a.fatherName!.compareTo(b.fatherName!));
              } else {
                _isAscending = true;

                widget.preAdmissionController.studentTableData.sort(
                    (productA, productB) =>
                        productA.fatherName!.compareTo(productB.fatherName!));
              }
            });
          }),
      DataColumn(
          label: Text(
        "EMAIL-ID",
        style: Get.textTheme.bodySmall!.copyWith(color: Colors.white),
      )),
      DataColumn(
          label: Text(
        "MOBILE NUMBER",
        style: Get.textTheme.bodySmall!.copyWith(color: Colors.white),
      )),
      DataColumn(
          label: Text(
        "REG DATE",
        style: Get.textTheme.bodySmall!.copyWith(color: Colors.white),
      ))
    ];
  }

  List<DataRow> _createRows() {
    return List.generate(widget.preAdmissionController.studentTableData.length,
        (index) {
      var value = index + 1;
      return DataRow(cells: [
        DataCell(Text(value.toString())),
        DataCell(Text(
            widget.preAdmissionController.studentTableData[index].fatherName!)),
        DataCell(Text(
            widget.preAdmissionController.studentTableData[index].emailID!)),
        DataCell(Text(
            widget.preAdmissionController.studentTableData[index].mobileno!)),
        DataCell(Text(
            widget.preAdmissionController.studentTableData[index].regDate!)),
      ]);
    });
  }
}
