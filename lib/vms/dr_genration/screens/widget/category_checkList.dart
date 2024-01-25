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
import 'package:m_skool_flutter/vms/dr_genration/model/planner_file_upload_model.dart';
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
  bool? newBool;
  CategoryCheckList(
      {required this.value,
      super.key,
      required this.plannerDetailsController,
      required this.loginSuccessModel,
      required this.index,
      this.newBool});

  @override
  State<CategoryCheckList> createState() => _CategoryCheckListState();
}

class _CategoryCheckListState extends State<CategoryCheckList> {
  @override
  void initState() {
    widget.plannerDetailsController.addListBrowser.clear();
    addItemListBrowse(0, "");
    logger.e(widget.index);
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
        'pdf'
      ],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      widget.plannerDetailsController.addListBrowser[index].file = file;
      widget.plannerDetailsController.addListBrowser[index].FileName =
          result.names.first;
      setState(() {});
    }
  }

  removeItemListBrowse(int val) {
    widget.plannerDetailsController.addListBrowser.removeAt(val);
    setState(() {});
  }

  int id = 0;
  String drName = '';
  String refNo = '';
  CategoryCheckListModelValues? category;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.newBool = false;
        return true;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(10),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 20, left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: DropdownButtonFormField<CategoryCheckListModelValues>(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    hintStyle: Theme.of(context).textTheme.labelSmall!.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            letterSpacing: 0.3)),
                    hintText: "Select",
                    isDense: true,
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    ),
                  ),
                  iconSize: 30,
                  items: List.generate(widget.value.values!.length, (index) {
                    return DropdownMenuItem(
                      value: widget.value.values![index],
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          overflow: TextOverflow.clip,
                          widget.value.values![index].ismmtcatcLCheckListName!,
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    );
                  }),
                  onChanged: (s) async {
                    category = s!;
                    id = s.ismmtcatcLId!;
                    drName = s.ismmtcatcLCheckListName!;
                  },
                ),
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
                                      widget.plannerDetailsController
                                          .addListBrowser.length, (index) {
                                    int i = index + 1;
                                    return DataRow(cells: [
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text('$i'))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 27, 59, 238),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 14,
                                                        vertical: 2.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
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
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.3)),
                                              )))),
                                      DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(widget
                                              .plannerDetailsController
                                              .addListBrowser[index]
                                              .FileName!))),
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
                                                        child: const Icon(
                                                            Icons.add)),
                                                    index >= 1
                                                        ? InkWell(
                                                            onTap: () {
                                                              removeItemListBrowse(
                                                                  index);
                                                            },
                                                            child: const Icon(
                                                                Icons.remove))
                                                        : const SizedBox()
                                                  ],
                                                )
                                              : index <
                                                      widget
                                                          .plannerDetailsController
                                                          .addListBrowser
                                                          .length
                                                  ? InkWell(
                                                      onTap: () {
                                                        removeItemListBrowse(
                                                            index);
                                                      },
                                                      child: const Icon(
                                                          Icons.remove))
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
                        if (drName.isEmpty) {
                          Fluttertoast.showToast(msg: "Select Checklist");
                        } else if (widget.plannerDetailsController
                                .addListBrowser.last.file ==
                            null) {
                          Fluttertoast.showToast(msg: " Upload File");
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          for (var element in widget
                              .plannerDetailsController.addListBrowser) {
                            await uploadDrImage(
                                    miId: widget.loginSuccessModel.mIID!,
                                    file: element.file!)
                                .then((value) {
                              if (value.name.isNotEmpty) {
                                if (!uploadAttachment.any(
                                    (element) => element.name == value.name)) {
                                  uploadAttachment.add(UploadDrImage(
                                      name: value.name, path: value.path));
                                }
                              }
                            });
                          }

                          widget.plannerDetailsController
                              .uploadImages[widget.index].index = widget.index;
                          widget
                              .plannerDetailsController
                              .uploadImages[widget.index]
                              .name = uploadAttachment.first.name;
                          widget
                              .plannerDetailsController
                              .uploadImages[widget.index]
                              .path = uploadAttachment.first.path;
                          widget.plannerDetailsController
                              .uploadImages[widget.index].id = id;
                          widget.plannerDetailsController
                              .uploadImages[widget.index].imageType = drName;

                          if (uploadAttachment.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                          } else {
                            widget.newBool = false;
                          }
                          Get.back(result: widget.index);
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   // widget.plannerDetailsController.addListBrowser.clear();
  //   widget.value.values!.clear();
  //   super.dispose();
  // }

  List<UploadDrImage> uploadAttachment = [];
  bool isLoading = false;
}
