import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:open_filex/open_filex.dart';

class FileUploadWidget extends StatefulWidget {
  final TadaApplyDataController tadaApplyDataController;
  const FileUploadWidget({super.key, required this.tadaApplyDataController});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  // final ImagePicker _imagePicker = ImagePicker();

  addItemListBrowse(int val, String name) {
    widget.tadaApplyDataController.addListBrowser.add(AtachmentFile(
      id: val,
      FileName: name,
    ));
    for (int i = 0;
        i < widget.tadaApplyDataController.addListBrowser.length;
        i++) {
      widget.tadaApplyDataController.newRemarksController
          .add(TextEditingController(text: ''));
    }
    setState(() {});
  }

  void removeRow(int value) {
    widget.tadaApplyDataController.newList.removeAt(value);
    setState(() {});
  }

  @override
  void initState() {
    addItemListBrowse(0, '');
    super.initState();
  }

  @override
  void dispose() {
    widget.tadaApplyDataController.addListBrowser.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: DataTable(
              // dataRowHeight: 35,
              headingRowHeight: 45,
              columnSpacing: 10,
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
                DataColumn(label: Text("Action")),
              ],
              rows: List.generate(
                  widget.tadaApplyDataController.addListBrowser.length,
                  (index) {
                var value = index + 1;
                return DataRow(cells: [
                  DataCell(Text(value.toString())),
                  DataCell(Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                        onPressed: () {
                          pickImage(index);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Theme.of(context).primaryColor),
                        child: Center(
                          child: Text(
                            "Choose File",
                            style: Get.textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        )),
                  )),
                  DataCell(Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            OpenFilex.open(widget.tadaApplyDataController
                                .addListBrowser[index].file!.path);
                          },
                          child: (widget.tadaApplyDataController
                                      .addListBrowser[index].file ==
                                  null)
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ],
                    ),
                  )),
                  DataCell(Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 120,
                      child: TextField(
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.black),
                        controller: widget
                            .tadaApplyDataController.newRemarksController
                            .elementAt(index),
                      ),
                    ),
                  )),
                  DataCell(Align(
                      alignment: Alignment.center,
                      child: index ==
                              widget.tadaApplyDataController.addListBrowser
                                      .length -
                                  1
                          ? InkWell(
                              onTap: () {
                                addItemListBrowse(
                                  index++,
                                  "",
                                );
                                setState(() {});
                              },
                              child: const Icon(Icons.add))
                          : index <
                                  widget.tadaApplyDataController.addListBrowser
                                      .length
                              ? InkWell(
                                  onTap: () {
                                    removeItemListBrowse(index);
                                  },
                                  child: const Icon(Icons.remove))
                              : null)),
                ]);
              })),
        ),
      );
    });
  }

  Future<void> pickImage(int index) async {
    // final pickedImage = await _imagePicker.pickImage(
    //     source: ImageSource.gallery, imageQuality: 25);
    // if (pickedImage != null) {
    //   widget.tadaApplyDataController.addListBrowser[index].file = pickedImage;
    //   widget.tadaApplyDataController.addListBrowser[index].FileName =
    //       pickedImage.name;
    //   setState(() {});
    // } else {
    //   Fluttertoast.showToast(msg: "Image Is not Uploaded Please try Again");
    // }
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      XFile xFile = XFile(file.path);
      widget.tadaApplyDataController.addListBrowser[index].file = xFile;
      widget.tadaApplyDataController.addListBrowser[index].FileName =
          result.names.first;
      setState(() {});
    } else {
      Fluttertoast.showToast(msg: "Image Is not Uploaded Please try Again");
    }
  }

  removeItemListBrowse(int val) {
    widget.tadaApplyDataController.addListBrowser.removeAt(val);
    setState(() {});
  }
}
