import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_api/gate_pass_api.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_controller/gate_pass_controller.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/gate_pass_dep_list.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/gate_pass_staff_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/pass_deg_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/pass_inst_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class GatePassScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final GatePassController controller;
  const GatePassScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.controller});

  @override
  State<GatePassScreen> createState() => _GatePassScreenState();
}

class _GatePassScreenState extends State<GatePassScreen> {
  RxBool isLoading = RxBool(false);
  final _suggestionsBoxController1 = SuggestionsBoxController();
  final _suggestionsBoxController2 = SuggestionsBoxController();
  final _suggestionsBoxController3 = SuggestionsBoxController();
  final _suggestionsBoxController4 = SuggestionsBoxController();
  final miName = TextEditingController();
  int miId = 0;
  final departmentName = TextEditingController();
  int depId = 0;
  final degController = TextEditingController();
  int degId = 0;
  final staffController = TextEditingController();
  int staffId = 0;
  final cardNo = TextEditingController();
  final dateController = TextEditingController();
  final remarks = TextEditingController();
  DateTime? dt;
  _onLoad(int id) async {
    isLoading.value = true;
    await GatePassAPI.instance.onLoad(
        base: baseUrlFromInsCode(
            'visitorsmanagementservicehub', widget.mskoolController),
        miId: id,
        userId: widget.loginSuccessModel.userId!,
        controller: widget.controller);
    isLoading.value = false;
    miName.text = widget.controller.institutionList.first.mIName ?? "";
    miId = widget.controller.institutionList.first.mIId ?? 0;
  }

  @override
  void initState() {
    _onLoad(miId);
    super.initState();
  }

  @override
  void dispose() {
    miId = 0;
    depId = 0;
    degId = 0;
    super.dispose();
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return isLoading.value
          ? const Center(
              child: AnimatedProgressWidget(
              animationPath: 'assets/json/default.json',
              title: 'Loading data',
              desc: "Please wait we are loading data",
            ))
          : (widget.controller.institutionList.isEmpty)
              ? const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'No data',
                    desc: "",
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Form(
                        key: key,
                        child: Column(
                          children: [
                            TypeAheadFormField<GatePassInstModelValues>(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              suggestionsBoxController:
                                  _suggestionsBoxController1,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: miName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText: widget.controller.institutionList
                                            .isNotEmpty
                                        ? 'Company Name'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Company Name',
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(fontSize: 18),
                                    suffixIcon: (miName.text.isEmpty)
                                        ? const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              miName.clear();
                                              miId = 0;
                                              departmentName.clear();
                                              degController.clear();
                                              depId = 0;
                                              degId = 0;
                                              staffController.clear();
                                              staffId = 0;
                                              await GatePassAPI.instance.onLoad(
                                                  base: baseUrlFromInsCode(
                                                      'visitorsmanagementservicehub',
                                                      widget.mskoolController),
                                                  miId: miId,
                                                  userId: widget
                                                      .loginSuccessModel
                                                      .userId!,
                                                  controller:
                                                      widget.controller);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return widget.controller.institutionList.where(
                                    (d) => d.mIName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    miName.text = suggestion.mIName!;
                                    miId = suggestion.mIId!;
                                    _suggestionsBoxController1.close();
                                    await GatePassAPI.instance.onLoad(
                                        base: baseUrlFromInsCode(
                                            'visitorsmanagementservicehub',
                                            widget.mskoolController),
                                        miId: miId,
                                        userId:
                                            widget.loginSuccessModel.userId!,
                                        controller: widget.controller);
                                    setState(() {});
                                  },
                                  title: Text(
                                    suggestion.mIName!,
                                    style: Get.textTheme.titleSmall,
                                  ),
                                );
                              },
                              onSuggestionSelected: (suggestion) {},
                              noItemsFoundBuilder: (context) {
                                return const SizedBox();
                              },
                            ),
                            const SizedBox(height: 15),
                            TypeAheadFormField<GatePassDepartmentModelValues>(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              suggestionsBoxController:
                                  _suggestionsBoxController2,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: departmentName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText: widget.controller.departmentList
                                            .isNotEmpty
                                        ? 'Department Name'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Department Name',
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(fontSize: 18),
                                    suffixIcon: (departmentName.text.isEmpty)
                                        ? const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              departmentName.clear();
                                              depId = 0;
                                              widget.controller.degList.clear();
                                              widget.controller.staffList
                                                  .clear();
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return widget.controller.departmentList.where(
                                    (d) => d.hrmDDepartmentName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    departmentName.text =
                                        suggestion.hrmDDepartmentName!;
                                    depId = suggestion.hrmDId!;
                                    _suggestionsBoxController2.close();
                                    setState(() {
                                      isDegLoading.value = true;
                                    });
                                    await GatePassAPI.instance.designation(
                                        base: baseUrlFromInsCode(
                                            'visitorsmanagementservicehub',
                                            widget.mskoolController),
                                        miId: miId,
                                        depId: depId,
                                        controller: widget.controller);

                                    setState(() {
                                      isDegLoading.value = false;
                                    });
                                  },
                                  title: Text(
                                    suggestion.hrmDDepartmentName!,
                                    style: Get.textTheme.titleSmall,
                                  ),
                                );
                              },
                              onSuggestionSelected: (suggestion) {},
                              noItemsFoundBuilder: (context) {
                                return const SizedBox();
                              },
                            ),
                            const SizedBox(height: 15),
                            (isDegLoading.value)
                                ? const SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                        color: Colors.green,
                                        strokeWidth: 8,
                                      ),
                                    ),
                                  )
                                : (widget.controller.degList.isEmpty)
                                    ? const SizedBox()
                                    : TypeAheadFormField<
                                        GatePassDesignationModelValues>(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        suggestionsBoxController:
                                            _suggestionsBoxController3,
                                        getImmediateSuggestions: true,
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          style: Get.textTheme.titleSmall,
                                          controller: degController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey)),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                              hintText: widget.controller
                                                      .degList.isNotEmpty
                                                  ? 'Designation Name'
                                                  : 'No data available',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              labelText: 'Designation Name',
                                              labelStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(fontSize: 18),
                                              suffixIcon: (degController
                                                      .text.isEmpty)
                                                  ? const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.black,
                                                      size: 30,
                                                    )
                                                  : IconButton(
                                                      onPressed: () async {
                                                        degController.clear();
                                                        degId = 0;
                                                        widget.controller
                                                            .staffList
                                                            .clear();
                                                        setState(() {});
                                                      },
                                                      icon: const Icon(
                                                          Icons.clear_outlined))),
                                        ),
                                        suggestionsCallback: (v) {
                                          return widget.controller.degList
                                              .where((d) => d
                                                  .hrmdeSDesignationName!
                                                  .toLowerCase()
                                                  .contains(v.toLowerCase()));
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            onTap: () async {
                                              setState(() {
                                                degController.text = suggestion
                                                    .hrmdeSDesignationName!;
                                                degId = suggestion.hrmdeSId!;
                                                _suggestionsBoxController3
                                                    .close();
                                                isStaffLoading.value = true;
                                              });
                                              await GatePassAPI.instance.staffData(
                                                  base: baseUrlFromInsCode(
                                                      'visitorsmanagementservicehub',
                                                      widget.mskoolController),
                                                  miId: miId,
                                                  controller: widget.controller,
                                                  degId: degId,
                                                  depId: depId);
                                              setState(() {
                                                isStaffLoading.value = false;
                                              });
                                            },
                                            title: Text(
                                              suggestion.hrmdeSDesignationName!,
                                              style: Get.textTheme.titleSmall,
                                            ),
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {},
                                        noItemsFoundBuilder: (context) {
                                          return const SizedBox();
                                        },
                                      ),
                            const SizedBox(height: 15),
                            (isStaffLoading.value)
                                ? const SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                        color: Colors.green,
                                        strokeWidth: 8,
                                      ),
                                    ),
                                  )
                                : (widget.controller.staffList.isEmpty)
                                    ? const SizedBox()
                                    : TypeAheadFormField<
                                        GatePassStaffModelValues>(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        suggestionsBoxController:
                                            _suggestionsBoxController4,
                                        getImmediateSuggestions: true,
                                        direction: AxisDirection.up,
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          style: Get.textTheme.titleSmall,
                                          controller: staffController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey)),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                              hintText: widget.controller
                                                      .staffList.isNotEmpty
                                                  ? 'Staff Name'
                                                  : 'No data available',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              labelText: 'Staff Name',
                                              labelStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(fontSize: 18),
                                              suffixIcon: (staffController
                                                      .text.isEmpty)
                                                  ? const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.black,
                                                      size: 30,
                                                    )
                                                  : IconButton(
                                                      onPressed: () async {
                                                        staffController.clear();
                                                        staffId = 0;

                                                        setState(() {});
                                                      },
                                                      icon: const Icon(
                                                          Icons.clear_outlined))),
                                        ),
                                        suggestionsCallback: (v) {
                                          return widget.controller.staffList
                                              .where((d) => d.empname!
                                                  .toLowerCase()
                                                  .contains(v.toLowerCase()));
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            onTap: () async {
                                              staffController.text =
                                                  suggestion.empname!;
                                              staffId = suggestion.hrmEId!;
                                              _suggestionsBoxController4
                                                  .close();

                                              setState(() {});
                                            },
                                            title: Text(
                                              suggestion.empname!,
                                              style: Get.textTheme.titleSmall,
                                            ),
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {},
                                        noItemsFoundBuilder: (context) {
                                          return const SizedBox();
                                        },
                                      ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              controller: cardNo,
                              style: Get.textTheme.titleSmall,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Card No',
                                labelStyle: Get.textTheme.titleMedium,
                                hintText: 'Card No',
                                hintStyle: Get.textTheme.titleSmall,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              controller: dateController,
                              style: Get.textTheme.titleSmall,
                              keyboardType: TextInputType.emailAddress,
                              readOnly: true,
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Date',
                                  labelStyle: Get.textTheme.titleMedium,
                                  hintText: 'Date',
                                  hintStyle: Get.textTheme.titleSmall,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                  )),
                              onTap: () async {
                                dt = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(3000));
                                if (dt != null) {
                                  dateController.text = dateFormat1(dt!);
                                } else {
                                  Fluttertoast.showToast(msg: "Select Date");
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              controller: remarks,
                              style: Get.textTheme.titleSmall,
                              keyboardType: TextInputType.text,
                              maxLines: 3,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(6),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Remarks',
                                labelStyle: Get.textTheme.titleMedium,
                                hintText: 'Remarks',
                                hintStyle: Get.textTheme.titleSmall,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: (isSaving.value)
                          ? const SizedBox(
                              height: 40,
                              width: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                  color: Colors.green,
                                  strokeWidth: 8,
                                ),
                              ),
                            )
                          : MSkollBtn(
                              title: "Save",
                              onPress: () async {
                                if (key.currentState!.validate() == false) {
                                  Fluttertoast.showToast(
                                      msg: "Select All Fields");
                                  return;
                                } else {
                                  setState(() {
                                    isSaving.value = true;
                                  });
                                  await GatePassAPI.instance.saveData(
                                    base: baseUrlFromInsCode(
                                        'visitorsmanagementservicehub',
                                        widget.mskoolController),
                                    body: {
                                      "GPHST_Id": 0,
                                      "HRMD_Id": depId,
                                      "HRMDES_Id": degId,
                                      "HRME_Id": staffId,
                                      "GPHST_Remarks": remarks.text,
                                      "GPHST_DateTime": dt!.toIso8601String(),
                                      "GPHST_IDCardNo": cardNo.text,
                                      "MI_Id": miId,
                                    },
                                  ).then((value) {
                                    if (value == 200) {
                                      Get.back();
                                    }
                                  });
                                  setState(() {
                                    isSaving.value = false;
                                  });
                                }
                              }),
                    ),
                  ],
                );
    });
  }

  RxBool isDegLoading = RxBool(false);
  RxBool isStaffLoading = RxBool(false);
  RxBool isSaving = RxBool(false);
}
