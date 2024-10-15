import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_emp_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_fine_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_v_model.dart';
import 'package:m_skool_flutter/vms/rto/rto_api.dart';
import 'package:m_skool_flutter/vms/rto/rto_controller.dart';
import 'package:m_skool_flutter/vms/rto/violation_list.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/sava_task.dart';
import 'package:m_skool_flutter/vms/utils/save_btn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:open_filex/open_filex.dart';

class RTOViolationScreen extends StatefulWidget {
  final String title;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const RTOViolationScreen(
      {super.key,
      required this.title,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<RTOViolationScreen> createState() => _RTOViolationScreenState();
}

class _RTOViolationScreenState extends State<RTOViolationScreen> {
  RTOController controller = Get.put(RTOController());
  DateTime? dt;
  TimeOfDay? time;
  final desController = TextEditingController();
  final dateConttoller = TextEditingController();
  final timeController = TextEditingController();
  final fineAmount = TextEditingController();
  bool isViolation = false;
  bool isAmountPayed = false;
  final key = GlobalKey<FormState>();
  _onLoad() async {
    controller.isViolationLoading.value = true;
    await RTOAPI.i.getOnLoadData(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        controller: controller);
    controller.isViolationLoading.value = false;
  }

  addItemListBrowse(int val, String name) {
    setState(() {
      controller.addListBrowser.add(AtachmentFile(
        id: val,
        fileName: name,
      ));
      for (int i = 0; i < controller.addListBrowser.length; i++) {
        controller.newRemarksController.add(TextEditingController(text: ''));
      }
    });
  }

  void removeRow(int value) {
    setState(() {
      controller.newList.removeAt(value);
    });
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
        'pdf'
      ],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      XFile xFile = XFile(file.path);
      controller.addListBrowser[index].file = xFile;
      controller.addListBrowser[index].fileName = result.names.first;
      setState(() {});
    } else {
      Fluttertoast.showToast(msg: "Image Is not Uploaded Please try Again");
    }
  }

  removeItemListBrowse(int val) {
    controller.addListBrowser.removeAt(val);
    setState(() {});
  }

  @override
  void initState() {
    controller.isSaving.value = false;
    _onLoad();
    addItemListBrowse(0, '');
    super.initState();
  }

  List<UploadHwCwModel> uploadAttachment = [];
  List<Map<String, dynamic>> uploadArray = [];
  saveData() async {
    String iRemarks = '';
    uploadArray.clear();
    if (controller.addListBrowser.isNotEmpty) {
      for (int i = 0; i < controller.addListBrowser.length; i++) {
        iRemarks = controller.newRemarksController.elementAt(i).text;
      }
    }
    if (controller.addListBrowser.isNotEmpty) {
      for (var element in controller.addListBrowser) {
        try {
          uploadAttachment.add(await uploadAtt(
              miId: widget.loginSuccessModel.mIID!,
              file: File(element.file!.path)));
        } catch (e) {
          logger.e(e);
        }
      }
      for (var element in uploadAttachment) {
        uploadArray.add({
          "RTOVOBFL_FilePath": element.path,
          "RTOVOBFL_FileName": element.name,
          "RTOVOBFL_Remarks": iRemarks
        });
      }
    }
    controller.isSaving.value = true;
    await RTOAPI.i.saveRtoData(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        body: {
          "HRME_Id": controller.selectedEmp!.hRMEId,
          "TRMV_Id": controller.selectedVehicle!.trmVId,
          "RTOVOB_Id": 0,
          "RTOVOB_Date": dt!.toIso8601String(),
          "RTOVOB_AnyViolationFlg": isViolation,
          "VMSFOVOB_DamageDescription": desController.text,
          "RTOVOB_DateTimeOfViolation": timeController.text,
          "RTOMFP_Id": controller.selectedFine!.rtomfPId,
          "RTOVOB_ViolationDescription":
              controller.selectedFine!.rtomfPFineParameterName,
          "RTOVOB_FineAmount": fineAmount.text,
          "ViolationFiles": uploadArray,
          "RTOVOB_FineAmountPaidFlg": isAmountPayed,
        });
    controller.isSaving.value = false;
  }

  @override
  void dispose() {
    controller.isSaving.value = false;
    controller.addListBrowser.clear();
    controller.checkBox.clear();
    controller.vehicleList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: widget.title, action: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Obx(() {
              return controller.isSaving.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : BtnSave(
                      title: 'Save',
                      onPress: () {
                        if (key.currentState!.validate()) {
                          saveData();
                        }
                      },
                    );
            }),
          ),
        ]).getAppBar(),
        body: Obx(() {
          return controller.isViolationLoading.value
              ? const AnimatedProgressWidget(
                  title: "Loading RTO Violation",
                  desc:
                      "Please wait while we load RTO Violation and create a view for you.",
                  animationPath: "assets/json/default.json")
              : controller.vehicleList.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                        title: "No RTO Violation",
                        desc:
                            "We don't have any RTO Violation corresponding to the session",
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Form(
                            key: key,
                            child: Column(
                              children: [
                                DropdownButtonFormField<RtoVehicleModelValues>(
                                  validator: (value) {
                                    if (value == null) {
                                      return "";
                                    }
                                    return null;
                                  },
                                  style: Get.textTheme.titleSmall,
                                  // value: controller.companiesList.first,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey)),
                                    hintText: controller.vehicleList.isNotEmpty
                                        ? 'Select Vehicle Name'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    isDense: true,
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                    labelText: "Vehicle Name",
                                  ),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 30,
                                    ),
                                  ),
                                  iconSize: 30,
                                  items: List.generate(
                                      controller.vehicleList.length, (index) {
                                    return DropdownMenuItem(
                                      value: controller.vehicleList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 13, left: 5),
                                        child: Text(
                                          overflow: TextOverflow.clip,
                                          "${controller.vehicleList[index].trmVVehicleName}/ ${controller.vehicleList[index].trmVVehicleNo}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                              )),
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (s) async {
                                    setState(() {
                                      controller.selectedVehicle = s!;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<RtoEmpModelValues>(
                                  validator: (value) {
                                    if (value == null) {
                                      return "";
                                    }
                                    return null;
                                  },
                                  style: Get.textTheme.titleSmall,
                                  // value: controller.companiesList.first,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey)),
                                    hintText: controller.empList.isNotEmpty
                                        ? 'Select Driver Name'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    isDense: true,
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                    labelText: "Driver Name",
                                  ),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 30,
                                    ),
                                  ),
                                  iconSize: 30,
                                  items: List.generate(
                                      controller.empList.length, (index) {
                                    return DropdownMenuItem(
                                      value: controller.empList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 13, left: 5),
                                        child: Text(
                                          overflow: TextOverflow.clip,
                                          "${controller.empList[index].eMPNAME}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                              )),
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (s) async {
                                    setState(() {
                                      controller.selectedEmp = s!;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<RtoFineModelValues>(
                                  validator: (value) {
                                    if (value == null) {
                                      return "";
                                    }
                                    return null;
                                  },
                                  style: Get.textTheme.titleSmall,
                                  // value: controller.companiesList.first,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey)),
                                    hintText: controller.fineList.isNotEmpty
                                        ? 'Select Parameter Name'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    isDense: true,
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                    labelText: "Parameter Name",
                                  ),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 30,
                                    ),
                                  ),
                                  iconSize: 30,
                                  items: List.generate(
                                      controller.fineList.length, (index) {
                                    return DropdownMenuItem(
                                      value: controller.fineList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 13, left: 5),
                                        child: Text(
                                          overflow: TextOverflow.clip,
                                          "${controller.fineList[index].rtomfPFineParameterName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                              )),
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (s) async {
                                    setState(() {
                                      controller.selectedFine = s!;
                                      fineAmount.text =
                                          s.rtomfPFineAmount.toString();
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "";
                                    }
                                    return null;
                                  },
                                  controller: fineAmount,
                                  style: Get.textTheme.titleSmall,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*'))
                                  ],
                                  decoration: InputDecoration(
                                      hintText: "Fine Amount",
                                      hintStyle: Get.textTheme.titleSmall,
                                      labelText: "Fine Amount",
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey))),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "";
                                            }
                                            return null;
                                          },
                                          style: Get.textTheme.titleSmall,
                                          controller: dateConttoller,
                                          decoration: InputDecoration(
                                              hintText: "Date",
                                              hintStyle:
                                                  Get.textTheme.titleSmall,
                                              labelText: "Date",
                                              labelStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              suffixIcon: Icon(
                                                Icons.calendar_month,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey))),
                                          readOnly: true,
                                          onTap: () async {
                                            dt = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1000),
                                                lastDate: DateTime(3000));
                                            if (dt != null) {
                                              dateConttoller.text =
                                                  getDate(dt!);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Select Date");
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "";
                                            }
                                            return null;
                                          },
                                          style: Get.textTheme.titleSmall,
                                          controller: timeController,
                                          decoration: InputDecoration(
                                              hintText: "Time",
                                              hintStyle:
                                                  Get.textTheme.titleSmall,
                                              labelText: "Time",
                                              labelStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              suffixIcon: Icon(
                                                Icons.watch_later_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey))),
                                          readOnly: true,
                                          onTap: () async {
                                            time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (time != null) {
                                              timeController.text =
                                                  "${time!.hour}:${time!.minute} ${time!.period.name.toUpperCase()}";
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Select Time");
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                              visualDensity:
                                                  const VisualDensity(
                                                      vertical: 0,
                                                      horizontal: -4),
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              side: const BorderSide(
                                                  color: Colors.grey, width: 2),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              value: isViolation,
                                              onChanged: (value) {
                                                setState(() {
                                                  isViolation = value!;
                                                });
                                              }),
                                          Text(
                                            "Any Violation?",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                              visualDensity:
                                                  const VisualDensity(
                                                      vertical: 0,
                                                      horizontal: -4),
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              side: const BorderSide(
                                                  color: Colors.grey, width: 2),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              value: isAmountPayed,
                                              onChanged: (value) {
                                                setState(() {
                                                  isAmountPayed = value!;
                                                });
                                              }),
                                          Text(
                                            "Any Amount Paid?",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  controller: desController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      hintText: "Description",
                                      hintStyle: Get.textTheme.titleSmall,
                                      labelText: "Description",
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey))),
                                ),
                              ],
                            )),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: DataTable(
                                // dataRowHeight: 35,
                                headingRowHeight: 45,
                                columnSpacing: 10,
                                headingTextStyle:
                                    const TextStyle(color: Colors.white),
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
                                  DataColumn(label: Text("Description")),
                                  DataColumn(label: Text("Action")),
                                ],
                                rows: List.generate(
                                    controller.addListBrowser.length, (index) {
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor),
                                          child: Center(
                                            child: Text(
                                              "Choose File",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          )),
                                    )),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              OpenFilex.open(controller
                                                  .addListBrowser[index]
                                                  .file!
                                                  .path);
                                            },
                                            child: (controller
                                                        .addListBrowser[index]
                                                        .file ==
                                                    null)
                                                ? const Icon(
                                                    Icons.visibility_off)
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
                                          controller: controller
                                              .newRemarksController
                                              .elementAt(index),
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(3)),
                                        ),
                                      ),
                                    )),
                                    DataCell(Align(
                                        alignment: Alignment.center,
                                        child: index ==
                                                controller
                                                        .addListBrowser.length -
                                                    1
                                            ? Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        addItemListBrowse(
                                                          index++,
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
                                                    controller
                                                        .addListBrowser.length
                                                ? InkWell(
                                                    onTap: () {
                                                      removeItemListBrowse(
                                                          index);
                                                    },
                                                    child: const Icon(
                                                        Icons.remove))
                                                : null)),
                                  ]);
                                })),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() {
          return (controller.violationList.isNotEmpty)
              ? MSkollBtn(
                  title: "RTO Violation Observation List",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => VioLationList(
                                  controller: controller,
                                )));
                  })
              : const SizedBox();
        }));
  }
}
