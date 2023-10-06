import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:open_filex/open_filex.dart';

class FileUploadWidget extends StatefulWidget {
  final TadaApplyDataController tadaApplyDataController;
  const FileUploadWidget({super.key, required this.tadaApplyDataController});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  RxList<int> newList = <int>[].obs;
  RxList<TextEditingController> remarksController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> fileNameController =
      <TextEditingController>[].obs;
  final ImagePicker _imagePicker = ImagePicker();
  void addRow(int value) {
    newList.add(value);
    for (int i = 0; i < newList.length; i++) {
      remarksController.add(TextEditingController(text: ''));
      fileNameController.add(TextEditingController(text: ''));
    }
  }

  void removeRow(int value) {
    newList.removeAt(value);
  }

  @override
  void initState() {
    addRow(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 3),
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
              rows: List.generate(newList.length, (index) {
                var value = index + 1;
                logger.i(value);
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
                    child: InkWell(
                      onTap: () {
                        OpenFilex.open(widget.tadaApplyDataController
                            .addListBrowser[index].file!.path);
                      },
                      child: const Icon(Icons.visibility),
                    ),
                  )),
                  DataCell(Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 120,
                      child: TextField(
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.black),
                        controller: remarksController.elementAt(index),
                      ),
                    ),
                  )),
                  DataCell(IconButton(
                      onPressed: () {
                        setState(() {
                          (index == 0) ? addRow(index + 1) : removeRow(index);
                        });
                      },
                      icon: (index == 0)
                          ? Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                            )
                          : Icon(
                              Icons.remove,
                              color: Theme.of(context).primaryColor,
                            ))),
                ]);
              })),
        ),
      );
    });
  }

  Future<void> pickImage(int index) async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      widget.tadaApplyDataController.addListBrowser[index].file = pickedImage;
      widget.tadaApplyDataController.addListBrowser[index].FileName =
          pickedImage.name;
      setState(() {});
    }
  }
}
