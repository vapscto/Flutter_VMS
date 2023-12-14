import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/category_check_list_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:open_filex/open_filex.dart';

class CategoryCheckList extends StatefulWidget {
  final CategoryCheckListModel value;
  const CategoryCheckList({required this.value, super.key});

  @override
  State<CategoryCheckList> createState() => _CategoryCheckListState();
}

class _CategoryCheckListState extends State<CategoryCheckList> {
  final PlannerDetails _plannerDetailsController = Get.put(PlannerDetails());
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    addItemListBrowse(0, "");
    super.initState();
  }

  addItemListBrowse(int val, String name) {
    _plannerDetailsController.addListBrowser.add(AtachmentFile(
      id: val,
      FileName: name,
    ));

    setState(() {});
  }

  Future<void> pickImage(int index) async {
    // final pickedImage =
    //     await _imagePicker.pickImage(source: ImageSource.gallery);
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      XFile xFile = XFile(file.path);
      _plannerDetailsController.addListBrowser[index].file = xFile;
      _plannerDetailsController.addListBrowser[index].FileName =
          result.names.first;
      // if (pickedImage != null) {
      //   _plannerDetailsController.addListBrowser[index].file = pickedImage;
      //   _plannerDetailsController.addListBrowser[index].FileName =
      //       pickedImage.name;
      setState(() {});
    }
  }

  removeItemListBrowse(int val) {
    _plannerDetailsController.addListBrowser.removeAt(val);
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
                                _plannerDetailsController.addListBrowser.length,
                                (index) {
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
                                    child: Text(_plannerDetailsController
                                        .addListBrowser[index].FileName!))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        OpenFilex.open(_plannerDetailsController
                                            .addListBrowser[index].file!.path);
                                      },
                                      child: Icon(Icons.visibility),
                                    ))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: index ==
                                            _plannerDetailsController
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
                                                  child: Icon(Icons.add)),
                                              // InkWell(
                                              //     onTap: () {
                                              //       removeItemListBrowse(
                                              //           index);
                                              //     },
                                              //     child: Icon(Icons.remove))
                                            ],
                                          )
                                        : index <
                                                _plannerDetailsController
                                                    .addListBrowser.length
                                            ? InkWell(
                                                onTap: () {
                                                  removeItemListBrowse(index);
                                                },
                                                child: Icon(Icons.remove))
                                            : null)),
                              ]);
                            }),
                          ))))),
        ),
        MSkollBtn(
          title: "Save",
          onPress: () {
            // if (_plannerDetailsController.addListBrowser.isNotEmpty) {
            Get.back();
            // }
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _plannerDetailsController.addListBrowser.clear();
    super.dispose();
  }
}
