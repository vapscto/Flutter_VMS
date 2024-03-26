import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';

class UploadTadaDocument extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final TourLeadController controller;
  const UploadTadaDocument(
      {required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller,
      super.key});

  @override
  State<UploadTadaDocument> createState() => _UploadTadaDocumentState();
}

class _UploadTadaDocumentState extends State<UploadTadaDocument> {
  RxList<int> tableIncrease = <int>[].obs;
  FilePickerResult? result;

  @override
  void initState() {
    init();
    tableIncrease.add(0);
    super.initState();
  }

  init() async {}
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DataTable(
                    dataTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.95),
                        fontWeight: FontWeight.w500),
                    dataRowHeight: 40,
                    headingRowHeight: 40,
                    horizontalMargin: 10,
                    columnSpacing: 20,
                    dividerThickness: 1,
                    headingTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10), width: 0.5),
                    headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    columns: const [
                      DataColumn(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'SL No',
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
                            'Upload',
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
                            'View',
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
                            'Amount',
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
                            'Remark',
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
                            'Action',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(tableIncrease.length, (index) {
                      int num = index + 1;
                      return DataRow(cells: [
                        DataCell(Align(
                            alignment: Alignment.center, child: Text("$num"))),
                        DataCell(Align(
                            alignment: Alignment.center,
                            child: MaterialButton(
                              onPressed: () async {
                                result = await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  PlatformFile file = result!.files.first;
                                   logger.e(file.name);
                                   logger.e(file.bytes);
                                   logger.e(file.size);
                                   logger.e(file.extension);
                                   logger.e(file.path);
                                } else {
                                   
                                }
                              },
                              height: 40,
                              child: SizedBox(
                                width: 100,
                                child: Center(
                                    child: Text(
                                  "Choose File",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontSize: 14, color: Colors.blue)),
                                )),
                              ),
                            ))),
                        const DataCell(Align(
                            alignment: Alignment.center, child: Text(" "))),
                        const DataCell(Align(
                            alignment: Alignment.center, child: Text(" "))),
                        const DataCell(Align(
                            alignment: Alignment.center, child: Text(" "))),
                        DataCell(Align(
                            alignment: Alignment.center,
                            child: index == tableIncrease.length - 1
                                ? Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            tableIncrease.add(index);
                                          },
                                          child: const Icon(Icons.add)),
                                      index >= 1
                                          ? InkWell(
                                              onTap: () {
                                                tableIncrease.remove(index);
                                              },
                                              child: const Icon(Icons.remove))
                                          : const SizedBox()
                                    ],
                                  )
                                : index < tableIncrease.length
                                    ? InkWell(
                                        onTap: () {
                                          tableIncrease.remove(index);
                                        },
                                        child: const Icon(Icons.remove))
                                    : null))
                      ]);
                    }),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tableIncrease.clear();
    super.dispose();
  }
}
