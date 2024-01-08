import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class TADAUpdateImage extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final TadaApplyDataController tadaApplyDataController;
  const TADAUpdateImage(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.tadaApplyDataController});

  @override
  State<TADAUpdateImage> createState() => _TADAUpdateImageState();
}

class _TADAUpdateImageState extends State<TADAUpdateImage> {
  bool isFinalSubmition = true;
  List<int> newList = [];
  void addRow(int v) {
    newList.add(v);
    for (int i = 0; i < newList.length; i++) {
      widget.tadaApplyDataController
          .getRemarks(TextEditingController(text: ''));
    }
  }

  @override
  void initState() {
    addRow(0);
    super.initState();
  }

  void addUpdatedimageIndex(int v) {
    widget.tadaApplyDataController.addUpdatedImageList.removeAt(v);
  }

  addItemListBrowse(int val, String name) {
    setState(() {
      widget.tadaApplyDataController.addUpdatedImageList.add('');
      for (int i = 0;
          i < widget.tadaApplyDataController.addUpdatedImageList.length;
          i++) {
        widget.tadaApplyDataController
            .getRemarks(TextEditingController(text: ''));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: "TADA Advance File Details").getAppBar(),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          children: [
            CheckboxListTile(
                visualDensity: const VisualDensity(vertical: 0, horizontal: 0),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                checkColor: Colors.indigo,
                value: isFinalSubmition,
                title: Text(
                  "Final Submission",
                  style: Get.textTheme.titleMedium,
                ),
                onChanged: (value) {
                  setState(() {
                    isFinalSubmition = value!;
                  });
                }),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DataTable(
                  dataRowHeight: 70,
                  headingRowHeight: 45,
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
                    DataColumn(label: Text("Upload")),
                    DataColumn(label: Text("View")),
                    DataColumn(label: Text("Remarks")),
                    DataColumn(label: Text("Approval Remark")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: List.generate(newList.length, (index) {
                    var value = index + 1;
                    //
                    return DataRow(cells: [
                      DataCell(Text(value.toString())),
                      DataCell(InkWell(
                        onTap: () {
                          pickImage(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Choose File",
                                style: Get.textTheme.titleMedium!
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                      )),
                      DataCell(IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility))),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 200,
                          child: TextFormField(
                            style: Get.textTheme.titleSmall,
                            controller: widget.tadaApplyDataController
                                .uploadedImageRemarkController
                                .elementAt(index),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 3),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey))),
                          ),
                        ),
                      )),
                      DataCell(Container()),
                      DataCell(Align(
                          alignment: Alignment.center,
                          child: index == newList.length - 1
                              ? Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          newList.add(index + 1);
                                        },
                                        child: const Icon(Icons.add)),
                                    index >= 1
                                        ? InkWell(
                                            onTap: () {
                                              newList.add(index - 1);
                                              ;
                                            },
                                            child: const Icon(Icons.remove))
                                        : const SizedBox()
                                  ],
                                )
                              : index < newList.length
                                  ? InkWell(
                                      onTap: () {
                                        newList.add(index + 1);
                                      },
                                      child: const Icon(Icons.remove))
                                  : null)),
                    ]);
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomCenter,
              child: MSkollBtn(
                onPress: () {},
                title: 'Save',
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<void> pickImage(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'pdf',
        'mp4'
      ],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      XFile xFile = XFile(file.path);
      // tadaApplyDataController.addListBrowser[index].file = xFile;
      // tadaApplyDataController.addListBrowser[index].FileName =
      // result.names.first;
      setState(() {});
    } else {
      Fluttertoast.showToast(msg: "Image Is not Uploaded Please try Again");
    }
  }
}
