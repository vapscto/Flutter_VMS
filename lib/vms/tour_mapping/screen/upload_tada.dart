import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/vms/tour_mapping/api/upload_doc.dart';
import 'package:m_skool_flutter/vms/tour_mapping/controller/tour_lead_cntroller.dart';
import 'package:m_skool_flutter/vms/widgets/attachment_viewer.dart';

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
  RxList<TadaUpload> tableIncrease = <TadaUpload>[].obs;
  FilePickerResult? result;
  RxList<TextEditingController> etController = <TextEditingController>[].obs;
  RxList<TextEditingController> etRemarkController =
      <TextEditingController>[].obs;
  @override
  void initState() {
    tableIncrease.add(TadaUpload(filePath: '', fileName: ''));
    etController.add(TextEditingController(text: ''));
    etRemarkController.add(TextEditingController(text: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  headingRowColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
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
                                UploadHwCwModel model = await uploadTADAAtt(
                                    file: File(file.path!),
                                    miId: widget.loginSuccessModel.mIID!);
                                tableIncrease[index].filePath = model.path;
                                tableIncrease[index].fileName = model.name;
                                setState(() {});
                                // for(int i = 0; i < tableIncrease.length;i++){
                                // print("${i} = ${tableIncrease[i].filePath}");
                                // }
                                // print(file.path);
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
                      DataCell(Align(
                          alignment: Alignment.center,
                          child: InkWell(
                              onTap: () {
                                Get.to(() => AttachmentViewer(
                                      loadFromRawData: true,
                                      url: tableIncrease
                                          .elementAt(index)
                                          .filePath,
                                    ));
                              },
                              child:
                                  tableIncrease.elementAt(index).filePath != ''
                                      ? const Icon(Icons.visibility)
                                      : const SizedBox()))),
                      DataCell(Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 200,
                            child: TextField(
                              controller: etController.elementAt(index),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                          ))),
                      DataCell(Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 200,
                            child: TextField(
                              controller: etRemarkController.elementAt(index),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                          ))),
                      DataCell(Align(
                          alignment: Alignment.center,
                          child: index == tableIncrease.length - 1
                              ? Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          tableIncrease.add(TadaUpload(
                                              filePath: '', fileName: ''));
                                          etController.add(
                                              TextEditingController(text: ''));
                                          etRemarkController.add(
                                              TextEditingController(text: ''));
                                        },
                                        child: const Icon(Icons.add)),
                                    index >= 1
                                        ? InkWell(
                                            onTap: () {
                                              tableIncrease.removeAt(index);
                                              etController.removeAt(index);
                                              etRemarkController
                                                  .removeAt(index);
                                            },
                                            child: const Icon(Icons.remove))
                                        : const SizedBox()
                                  ],
                                )
                              : index < tableIncrease.length
                                  ? InkWell(
                                      onTap: () {
                                        tableIncrease.removeAt(index);
                                        etController.removeAt(index);
                                        etRemarkController.removeAt(index);
                                      },
                                      child: const Icon(Icons.remove))
                                  : null))
                    ]);
                  }),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tableIncrease.clear();
    etController.clear();
    etRemarkController.clear();
    super.dispose();
  }
}

class TadaUpload {
  String? filePath;
  String? fileName;
  TadaUpload({required this.filePath, required this.fileName});
}
