import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/api/get_task_check_list.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/category_check_list_model.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/upload_dr_image.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/sava_task.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:open_filex/open_filex.dart';

class CategoryCheckList extends StatefulWidget {
  final CategoryCheckListModel value;
  final PlannerDetails plannerDetailsController;
  final LoginSuccessModel loginSuccessModel;
  final int index;
  const CategoryCheckList(
      {required this.value,
      super.key,
      required this.plannerDetailsController,
      required this.loginSuccessModel,
      required this.index});

  @override
  State<CategoryCheckList> createState() => _CategoryCheckListState();
}

class _CategoryCheckListState extends State<CategoryCheckList> {
  // final PlannerDetails _plannerDetailsController = Get.put(PlannerDetails());
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    addItemListBrowse(0, "");
    super.initState();
  }

  addItemListBrowse(int val, String name) {
    widget.plannerDetailsController.addListBrowser.add(AtachmenDrtFile(
      id: val,
      FileName: name,
    ));

    setState(() {});
  }

  String newFile = "";
  Future<void> pickImage(int index) async {
    // final pickedImage =
    //     await _imagePicker.pickImage(source: ImageSource.gallery);
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
      // XFile xFile = XFile(file.path);
      widget.plannerDetailsController.addListBrowser[index].file = file;
      widget.plannerDetailsController.addListBrowser[index].FileName =
          result.names.first;
      // widget.plannerDetailsController.addListBrowser[index].id = widget.index;
      setState(() {});
    }
  }

  removeItemListBrowse(int val) {
    widget.plannerDetailsController.addListBrowser.removeAt(val);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownMenu<CategoryCheckListModelValues>(
          initialSelection: widget.value.values!.first,
          width: MediaQuery.of(context).size.width / 2,
          onSelected: (CategoryCheckListModelValues? value) {
            setState(() {});
          },
          dropdownMenuEntries: widget.value.values!
              .map<DropdownMenuEntry<CategoryCheckListModelValues>>(
                  (CategoryCheckListModelValues value) {
            return DropdownMenuEntry<CategoryCheckListModelValues>(
                value: value, label: value.ismmtcatcLCheckListName!);
          }).toList(),
        ),
        Obx(
          () => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                            dataTextStyle: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 0.95),
                                fontWeight: FontWeight.w500),
                            dataRowHeight: 50,
                            headingRowHeight: 40,
                            horizontalMargin: 10,
                            columnSpacing: 30,
                            dividerThickness: 1,
                            headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            border: TableBorder.all(
                                borderRadius: BorderRadius.circular(10),
                                width: 0.5),
                            headingRowColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            columns: const [
                              // 1
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'S.No',
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
                                    'UploadFile',
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
                                    'File Name',
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
                                    'Add',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            rows: List.generate(
                                widget.plannerDetailsController.addListBrowser
                                    .length, (index) {
                              int i = index + 1;
                              return DataRow(cells: [
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text('$i'))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 27, 59, 238),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 2.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          pickImage(index);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Browse",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .merge(const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.3)),
                                        )))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(widget.plannerDetailsController
                                        .addListBrowser[index].FileName!))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        OpenFilex.open(widget
                                            .plannerDetailsController
                                            .addListBrowser[index]
                                            .file!
                                            .path);
                                      },
                                      child: const Icon(Icons.visibility),
                                    ))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: index ==
                                            widget.plannerDetailsController
                                                    .addListBrowser.length -
                                                1
                                        ? Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    addItemListBrowse(
                                                      index + 1,
                                                      "",
                                                    );
                                                  },
                                                  child: const Icon(Icons.add)),
                                            ],
                                          )
                                        : index <
                                                widget.plannerDetailsController
                                                    .addListBrowser.length
                                            ? InkWell(
                                                onTap: () {
                                                  removeItemListBrowse(index);
                                                },
                                                child: const Icon(Icons.remove))
                                            : null)),
                              ]);
                            }),
                          ))))),
        ),
        (isLoading == true)
            ? SizedBox(
                height: 30,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : MSkollBtn(
                title: "Save",
                onPress: () async {
                  if (widget
                          .plannerDetailsController.addListBrowser.first.file ==
                      null) {
                    Fluttertoast.showToast(msg: "Please Upload File");
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    for (var element
                        in widget.plannerDetailsController.addListBrowser) {
                      var path = element.file!.path;
                      logger.i(path);
                      try {
                        uploadAttachment.add(await uploadDrImage(
                            miId: widget.loginSuccessModel.mIID!,
                            file: element.file!));
                      } catch (e) {
                        return Future.error({
                          "errorTitle": "An Error Occured",
                          "errorMsg":
                              "While trying to upload attchement, we encountered an error"
                        });
                      }
                    }
                    widget.plannerDetailsController.uploadImages.clear();
                    for (var i in uploadAttachment) {
                      widget.plannerDetailsController.uploadImages.add({
                        "name": i.name,
                        "path": i.path,
                        // "index": widget.index
                      });
                    }
                    setState(() {
                      isLoading = false;
                    });
                    Get.back(result: uploadAttachment);
                  }
                },
              )
      ],
    );
  }

  @override
  void dispose() {
    widget.plannerDetailsController.addListBrowser.clear();
    super.dispose();
  }

  List<UploadDrImage> uploadAttachment = [];
  bool isLoading = false;
}
