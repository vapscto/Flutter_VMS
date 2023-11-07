import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/health_chequeup/api/get_institute_list.dart';
import 'package:m_skool_flutter/vms/health_chequeup/api/hc_save_api.dart';
import 'package:m_skool_flutter/vms/health_chequeup/controlers/health_controler.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/client_model_list.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/hc_emp_list.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/institute_model.dart';
import 'package:m_skool_flutter/vms/health_chequeup/screens/view_all_data.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:open_filex/open_filex.dart';

class HomeHCheckup extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const HomeHCheckup(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});

  @override
  State<HomeHCheckup> createState() => _HomeHCheckupState();
}

class _HomeHCheckupState extends State<HomeHCheckup> {
  final HealthCheckUpController _controller =
      Get.put(HealthCheckUpController());
  final ImagePicker _imagePicker = ImagePicker();
  DrDetailsCtrlr loadingCntrl = Get.put(DrDetailsCtrlr());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Rx<TextEditingController> dateSelected = TextEditingController().obs;
  TextEditingController etRemarkControllers = TextEditingController();
  int clientId = 0;
  int hrmeId = 0;
  int mIID = 0;
  @override
  void initState() {
    load();
    addItemListBrowse(0, "");
    super.initState();
  }

  load() async {
    await getDetailsHC(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        controller: _controller,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!);
  }

  submitData() async {
    loadingCntrl.updateTabLoading(true);
    await saveHealthCheckUp(
            base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
            clientId: clientId,
            date: dateSelected.value.text,
            hrmEId: hrmeId,
            miId: widget.loginSuccessModel.mIID!,
            remark: etRemarkControllers.value.text,
            userId: widget.loginSuccessModel.userId!,
            loadingCntrl: loadingCntrl,
            controller: _controller)
        .then(
      (value) {
        Fluttertoast.showToast(msg: " Save successfully ");
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Health CheckUp", action: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
          child: Obx(
            () => loadingCntrl.drIsLoading.value
                ? const SizedBox()
                : BtnSave(
                    title: 'Submit',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        if (dateSelected.value.text.isNotEmpty ||
                            etRemarkControllers.text.isNotEmpty) {
                          await submitData();
                        } else {
                          Fluttertoast.showToast(msg: " Fill mandatory ");
                        }
                      } else {
                        Fluttertoast.showToast(msg: " Select mandatory ");
                      }
                    },
                  ),
          ),
        )
      ]).getAppBar(),
      body: Obx(
        () => _controller.getInstituteList.isEmpty
            ? const AnimatedProgressWidget(
                animationPath: 'assets/json/default.json',
                title: 'Loading data',
                desc: "Please wait we are loading data",
              )
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 40, left: 16, right: 16, bottom: 16),
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
                      
                      child: DropdownButtonFormField<InstituteListModelValues>(
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
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .merge(const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.3)),
                          hintText: _controller.getInstituteList.isNotEmpty
                              ? 'Select Institute'
                              : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/hat.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
                            text: 'Institute',
                            textColor: Color.fromRGBO(40, 182, 200, 1),
                          ),
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
                            _controller.getInstituteList.length, (index) {
                          return DropdownMenuItem(
                            value: _controller.getInstituteList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                overflow: TextOverflow.clip,
                                _controller.getInstituteList[index].mIName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0,
                                        letterSpacing: 0.3)),
                              ),
                            ),
                          );
                        }),
                        onChanged: (s) async {
                          mIID = s!.mIId!;
                        },
                      ),
                    ),
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
                      child: DropdownButtonFormField<ClientListModelValues>(
                        validator: (value) {
                          if (value == null) {
                            return "";
                          }
                          return null;
                        },
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
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .merge(const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.3)),
                          hintText: _controller.getClientList.isNotEmpty
                              ? 'Select Client'
                              : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/hat.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
                            text: 'Client',
                            textColor: Color.fromRGBO(40, 182, 200, 1),
                          ),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 30,
                          ),
                        ),
                        iconSize: 30,
                        items: List.generate(_controller.getClientList.length,
                            (index) {
                          return DropdownMenuItem(
                            value: _controller.getClientList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.35,
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  _controller
                                      .getClientList[index].ismmclTClientName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            ),
                          );
                        }),
                        onChanged: (s) async {
                          clientId = s!.ismmclTId!;
                        },
                      ),
                    ),
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
                      child: DropdownButtonFormField<GetHCEmpListModelValues>(
                        validator: (value) {
                          if (value == null) {
                            return "";
                          }
                          return null;
                        },
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
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .merge(const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.3)),
                          hintText: _controller.getEmpList.isNotEmpty
                              ? 'Select Employee'
                              : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/hat.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
                            text: 'Employee',
                            textColor: Color.fromRGBO(40, 182, 200, 1),
                          ),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 30,
                          ),
                        ),
                        iconSize: 30,
                        items: List.generate(_controller.getEmpList.length,
                            (index) {
                          return DropdownMenuItem(
                            value: _controller.getEmpList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.35,
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  _controller
                                      .getEmpList[index].hrmEEmployeeFirstName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            ),
                          );
                        }),
                        onChanged: (s) async {
                          hrmeId = s!.hrmEId!;
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      margin: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
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
                      child: Obx(
                        () => TextFormField(
                          onTap: () {
                            dateCall();
                          },
                          controller: dateSelected.value,
                          readOnly: true,
                          style: Theme.of(context).textTheme.titleSmall,
                          decoration: InputDecoration(
                              hintText: "Select Date",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(const TextStyle(fontSize: 14)),
                              suffixIcon: InkWell(
                                onTap: () async {
                                  dateCall();
                                },
                                child: const Icon(
                                  Icons.calendar_month,
                                  size: 30,
                                  color: Colors.black38,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 0.5),
                                      headingRowColor:
                                          MaterialStateProperty.all(
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
                                          _controller.addListBrowser.length,
                                          (index) {
                                        int i = index + 1;
                                        return DataRow(cells: [
                                          DataCell(Align(
                                              alignment: Alignment.center,
                                              child: Text('$i'))),
                                          DataCell(Align(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 27, 59, 238),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 14,
                                                        vertical: 2.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    pickImage(index);
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
                                                            letterSpacing:
                                                                0.3)),
                                                  )))),
                                          DataCell(Align(
                                              alignment: Alignment.center,
                                              child: Text(_controller
                                                  .addListBrowser[index]
                                                  .FileName!))),
                                          DataCell(Align(
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                onTap: () {
                                                  OpenFilex.open(_controller
                                                      .addListBrowser[index]
                                                      .file!
                                                      .path);
                                                },
                                                child: const Icon(
                                                    Icons.visibility),
                                              ))),
                                          DataCell(Align(
                                              alignment: Alignment.center,
                                              child: index ==
                                                      _controller.addListBrowser
                                                              .length -
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
                                                        InkWell(
                                                            onTap: () {
                                                              removeItemListBrowse(
                                                                  index);
                                                            },
                                                            child: const Icon(
                                                                Icons.remove))
                                                      ],
                                                    )
                                                  : index <
                                                          _controller
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "";
                          }
                          return null;
                        },
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(const TextStyle(fontSize: 14)),
                        controller: etRemarkControllers,
                        decoration: InputDecoration(
                            hintText: "Write Remark",
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        maxLines: 4,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MSkollBtn(
                      title: "View All",
                      onPress: () {
                        Get.to(() => ViewAllHC(
                              mIID: mIID,
                              mskoolController: widget.mskoolController,
                            ));
                      },
                    )
                  ]),
                ),
              ),
      ),
    );
  }

  addItemListBrowse(int val, String name) {
    _controller.addListBrowser.add(AtachmentFile(
      id: val,
      FileName: name,
    ));

    setState(() {});
  }

  Future<void> pickImage(int index) async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _controller.addListBrowser[index].file = pickedImage;
      _controller.addListBrowser[index].FileName = pickedImage.name;
      setState(() {});
    }
  }

  removeItemListBrowse(int val) {
    _controller.addListBrowser.removeAt(val);
    setState(() {});
  }

  dateCall() async {
    await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((value) {
      dateSelected.value.text =
          "${value!.year}-${value.month}-${value.day.toInt().toString().padLeft(2, "0")}";
    });
  }
}
