import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/api/job_posting_api.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/controller/job_posting_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/client_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/depart_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/job_gender_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/job_post_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/position_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/priority_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/model/ql_list_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

import '../../../health_chequeup/api/hc_save_api.dart';

class NewJobPost extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final JobPostingController controller;
  const NewJobPost(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<NewJobPost> createState() => _NewJobPostState();
}

class _NewJobPostState extends State<NewJobPost> {
  _onLoad() async {
    widget.controller.loading(true);
    await JobPostingAPI.i.onLoad(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        controller: widget.controller);
    widget.controller.loading(false);
  }

  _saveAPI(Map<String, dynamic> body) async {
    widget.controller.saving(true);
    await JobPostingAPI.i.saveData(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        body: body);
    widget.controller.saving(false);
  }

  @override
  void initState() {
    _onLoad();
    super.initState();
  }

  final positionController = TextEditingController();
  int hrmpId = 0;
  //
  final priorityController = TextEditingController();
  int hrmprId = 0;
  //
  final qualifacationController = TextEditingController();
  int hrmcId = 0;
  //
  final SuggestionsBoxController _suggestionsBoxController =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController1 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController2 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController3 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController4 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController5 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController6 =
      SuggestionsBoxController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final positionCountController = TextEditingController();
  final descriptionController = TextEditingController();
  final ageController = TextEditingController();
  final reasonController = TextEditingController();
  final mrfNoController = TextEditingController();
  final skillController = TextEditingController();
  final expFromController = TextEditingController();
  final expToController = TextEditingController();
  final remarksController = TextEditingController();
  final locationController = TextEditingController();
  List locationList = ['HO', 'Client', 'Location'];
  String selectedRadio = 'HO';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return widget.controller.isLoading.value
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading ",
                desc: "We are under process to get your details from server.")
            : widget.controller.positionList.isEmpty
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "",
                    animatorHeight: 250,
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Form(
                        key: _key,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TypeAheadFormField<PositionListModelValues>(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.isEmpty) {
                                  return " ";
                                }
                                return null;
                              },
                              suggestionsBoxController:
                                  _suggestionsBoxController,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: positionController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText: widget
                                            .controller.positionList.isNotEmpty
                                        ? 'Position'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Position',
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(fontSize: 18),
                                    suffixIcon:
                                        (positionController.text.isEmpty)
                                            ? const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                                size: 30,
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  positionController.clear();
                                                  hrmpId = 0;
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                    Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return widget.controller.positionList.where(
                                    (d) => d.hrmPPosition!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    positionController.text =
                                        suggestion.hrmPPosition!;
                                    hrmpId = suggestion.hrmPId!;
                                    logger.v(hrmpId);
                                    _suggestionsBoxController.close();
                                    setState(() {});
                                  },
                                  title: Text(
                                    suggestion.hrmPPosition!,
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
                            TypeAheadFormField<PriorityListModelValues>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              suggestionsBoxController:
                                  _suggestionsBoxController1,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: priorityController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText: widget
                                            .controller.priorityList.isNotEmpty
                                        ? 'Priority '
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Priority ',
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(fontSize: 18),
                                    suffixIcon:
                                        (priorityController.text.isEmpty)
                                            ? const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                                size: 30,
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  priorityController.clear();
                                                  hrmpId = 0;
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                    Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return widget.controller.priorityList.where(
                                    (d) => d.hrmPName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    priorityController.text =
                                        suggestion.hrmPName!;
                                    hrmprId = suggestion.hrmpRId!;
                                    logger.v(hrmprId);
                                    _suggestionsBoxController1.close();
                                    setState(() {});
                                  },
                                  title: Text(
                                    suggestion.hrmPName!,
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
                            TypeAheadFormField<QualificationListModelValues>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              suggestionsBoxController:
                                  _suggestionsBoxController2,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: qualifacationController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText: widget.controller
                                            .qualificationList.isNotEmpty
                                        ? 'Qualification'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Qualification',
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(fontSize: 18),
                                    suffixIcon: (qualifacationController
                                            .text.isEmpty)
                                        ? const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              qualifacationController.clear();
                                              hrmpId = 0;
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return widget.controller.qualificationList
                                    .where((d) => d.hrmCQulaificationName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    qualifacationController.text =
                                        suggestion.hrmCQulaificationName!;
                                    hrmcId = suggestion.hrmCId!;
                                    logger.v(hrmcId);
                                    _suggestionsBoxController2.close();
                                    setState(() {});
                                  },
                                  title: Text(
                                    suggestion.hrmCQulaificationName!,
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
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              controller: positionCountController,
                              style: Get.textTheme.titleSmall,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                hintText: "No. of Postion",
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                labelText: 'No. of Postion',
                                labelStyle: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              controller: descriptionController,
                              style: Get.textTheme.titleSmall,
                              decoration: InputDecoration(
                                hintText: "Job Description",
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                labelText: 'Job Description',
                                labelStyle: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              controller: ageController,
                              style: Get.textTheme.titleSmall,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                hintText: "Age",
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                labelText: 'Age',
                                labelStyle: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              controller: reasonController,
                              style: Get.textTheme.titleSmall,
                              decoration: InputDecoration(
                                hintText: "Reason",
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                labelText: 'Reason',
                                labelStyle: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Location:",
                              style: Get.textTheme.titleSmall,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: locationList.map<Widget>((location) {
                                return Row(
                                  children: [
                                    Radio<String>(
                                      activeColor: Colors.green,
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        return Theme.of(context).primaryColor;
                                      }),
                                      value: location,
                                      groupValue: selectedRadio,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedRadio = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      location,
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                            (selectedRadio == "Location")
                                ? TextFormField(
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return '';
                                    //   }
                                    //   return null;
                                    // },
                                    controller: locationController,
                                    style: Get.textTheme.titleSmall,
                                    decoration: InputDecoration(
                                      hintText: "Location",
                                      hintStyle: Get.textTheme.titleSmall!
                                          .copyWith(color: Colors.grey),
                                      labelText: 'Location',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
                                    ),
                                  )
                                : (selectedRadio == "Client")
                                    ? TypeAheadFormField<ClientListModelValues>(
                                        // validator: (value) {
                                        //   if (value == null || value.isEmpty) {
                                        //     return "";
                                        //   }
                                        //   return null;
                                        // },
                                        direction: AxisDirection.up,
                                        suggestionsBoxController:
                                            _suggestionsBoxController3,
                                        getImmediateSuggestions: true,
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          style: Get.textTheme.titleSmall,
                                          controller: clientController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey)),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                              hintText: widget.controller
                                                      .clientList.isNotEmpty
                                                  ? 'Client'
                                                  : 'No data available',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              labelText: 'Client',
                                              labelStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(fontSize: 18),
                                              suffixIcon: (clientController
                                                      .text.isEmpty)
                                                  ? const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.black,
                                                      size: 30,
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        clientController
                                                            .clear();
                                                        hrmpId = 0;
                                                        setState(() {});
                                                      },
                                                      icon: const Icon(
                                                          Icons.clear_outlined))),
                                        ),
                                        suggestionsCallback: (v) {
                                          return widget.controller.clientList
                                              .where((d) => d.ismmclTClientName!
                                                  .toLowerCase()
                                                  .contains(v.toLowerCase()));
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            onTap: () async {
                                              clientController.text =
                                                  suggestion.ismmclTClientName!;
                                              immcltId = suggestion.ismmclTId!;
                                              logger.v(immcltId);
                                              _suggestionsBoxController3
                                                  .close();
                                              setState(() {});
                                            },
                                            title: Text(
                                              suggestion.ismmclTClientName!,
                                              style: Get.textTheme.titleSmall,
                                            ),
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {},
                                        noItemsFoundBuilder: (context) {
                                          return const SizedBox();
                                        },
                                      )
                                    : const SizedBox(),
                            const SizedBox(height: 15),
                            TypeAheadFormField<JobDepartmentListModelValues>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              direction: AxisDirection.up,
                              suggestionsBoxController:
                                  _suggestionsBoxController4,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: departmentController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText: widget.controller
                                            .jobDepartmentList.isNotEmpty
                                        ? 'Department'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Department',
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(fontSize: 18),
                                    suffixIcon:
                                        (departmentController.text.isEmpty)
                                            ? const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                                size: 30,
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  departmentController.clear();
                                                  hrmdId = 0;
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                    Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return widget.controller.jobDepartmentList
                                    .where((d) => d.hrmDDepartmentName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    departmentController.text =
                                        suggestion.hrmDDepartmentName!;
                                    hrmdId = suggestion.hrmDId!;
                                    logger.v(hrmdId);
                                    _suggestionsBoxController4.close();
                                    setState(() {});
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
                            TypeAheadFormField<JobPostListModelValues>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              direction: AxisDirection.up,
                              suggestionsBoxController:
                                  _suggestionsBoxController6,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: positionTypeController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText:
                                        widget.controller.jobPostList.isNotEmpty
                                            ? 'Position Type'
                                            : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Position Type',
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(fontSize: 18),
                                    suffixIcon: (positionTypeController
                                            .text.isEmpty)
                                        ? const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              positionTypeController.clear();
                                              hrmdId = 0;
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return widget.controller.jobPostList.where(
                                    (d) => d.hrmpTName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    positionTypeController.text =
                                        suggestion.hrmpTName!;
                                    hrmptId = suggestion.hrmpTId!;
                                    logger.v(hrmptId);
                                    _suggestionsBoxController6.close();
                                    setState(() {});
                                  },
                                  title: Text(
                                    suggestion.hrmpTName!,
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
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              controller: mrfNoController,
                              style: Get.textTheme.titleSmall,
                              decoration: InputDecoration(
                                hintText: "MRF No.",
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                labelText: 'MRF No.',
                                labelStyle: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              controller: skillController,
                              style: Get.textTheme.titleSmall,
                              decoration: InputDecoration(
                                hintText: "Skill",
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                labelText: 'Skill',
                                labelStyle: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Experience(Year)",
                              style: Get.textTheme.titleSmall,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    controller: expFromController,
                                    style: Get.textTheme.titleSmall,
                                    decoration: InputDecoration(
                                      hintText: "From",
                                      hintStyle: Get.textTheme.titleSmall!
                                          .copyWith(color: Colors.grey),
                                      labelText: 'From',
                                      labelStyle: Get.textTheme.titleSmall,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    controller: expToController,
                                    style: Get.textTheme.titleSmall,
                                    decoration: InputDecoration(
                                      hintText: "To",
                                      hintStyle: Get.textTheme.titleSmall!
                                          .copyWith(color: Colors.grey),
                                      labelText: 'To',
                                      labelStyle: Get.textTheme.titleSmall,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            TypeAheadFormField<JobGenderListModelValues>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              direction: AxisDirection.up,
                              suggestionsBoxController:
                                  _suggestionsBoxController5,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: genderController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    hintText: widget
                                            .controller.jobGenderList.isNotEmpty
                                        ? 'Gender'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Gender',
                                    labelStyle: Get.textTheme.titleSmall!
                                        .copyWith(fontSize: 18),
                                    suffixIcon: (genderController.text.isEmpty)
                                        ? const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              genderController.clear();
                                              ivrmmgId = 0;
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.clear_outlined))),
                              ),
                              suggestionsCallback: (v) {
                                return widget.controller.jobGenderList.where(
                                    (d) => d.ivrmmGGenderName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  onTap: () async {
                                    genderController.text =
                                        suggestion.ivrmmGGenderName!;
                                    ivrmmgId = suggestion.ivrmmGId!;
                                    logger.v(ivrmmgId);
                                    _suggestionsBoxController5.close();
                                    setState(() {});
                                  },
                                  title: Text(
                                    suggestion.ivrmmGGenderName!,
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
                              controller: remarksController,
                              style: Get.textTheme.titleSmall,
                              decoration: InputDecoration(
                                hintText: "Remark",
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                labelText: 'Remark',
                                labelStyle: Get.textTheme.titleSmall!
                                    .copyWith(fontSize: 18),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 30,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      visualDensity: const VisualDensity(
                                          vertical: 0, horizontal: 0),
                                      checkColor: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      value: isWritten,
                                      onChanged: (v) {
                                        setState(() {
                                          isWritten = v!;
                                        });
                                      }),
                                  Text(
                                    testList[0],
                                    style: Get.textTheme.titleSmall,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      visualDensity: const VisualDensity(
                                          vertical: 0, horizontal: 0),
                                      checkColor: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      value: isOnline,
                                      onChanged: (v) {
                                        setState(() {
                                          isOnline = v!;
                                        });
                                      }),
                                  Text(
                                    testList[1],
                                    style: Get.textTheme.titleSmall,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      visualDensity: const VisualDensity(
                                          vertical: 0, horizontal: 0),
                                      checkColor: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      value: isTechnical,
                                      onChanged: (v) {
                                        setState(() {
                                          isTechnical = v!;
                                        });
                                      }),
                                  Text(
                                    testList[2],
                                    style: Get.textTheme.titleSmall,
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.54,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor,
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(1, 2.1),
                                            blurRadius: 0,
                                            spreadRadius: 0,
                                            color: Colors.black12)
                                      ]),
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            uploadFile();
                                          });
                                        },
                                        child: Text(
                                          "Upload Document",
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                      (fileName.isEmpty)
                                          ? const SizedBox()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    createPreview(
                                                        context, filePath);
                                                  },
                                                  child: const Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: widget.controller.isSaving.value == true
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : MSkollBtn(
                                        title: "Save & Publish",
                                        onPress: () {
                                          if (_key.currentState!.validate()) {
                                            _saveAPI({
                                              "MI_Id":
                                                  widget.loginSuccessModel.mIID,
                                              "HRMP_Id": hrmpId,
                                              "HRMLO_Id": 0,
                                              "HRMD_Id": hrmdId,
                                              "HRMPR_Id": hrmprId,
                                              "HRMPT_Id": hrmptId,
                                              "HRMRFR_MRFNO":
                                                  mrfNoController.text,
                                              "HRMC_Id": hrmcId,
                                              "HRMRFR_NoofPosition":
                                                  positionCountController.text,
                                              "HRMRFR_Skills":
                                                  skillController.text,
                                              "HRMRFR_JobDesc":
                                                  positionController.text,
                                              "HRMRFR_ExpFrom":
                                                  expFromController.text,
                                              "HRMRFR_ExpTo":
                                                  expToController.text,
                                              "HRMRFR_Age": ageController.text,
                                              "IVRMMG_Id": ivrmmgId,
                                              "HRMRFR_Reason":
                                                  reasonController.text,
                                              "HRMRFR_WrittenTestFlg":
                                                  isWritten,
                                              "HRMRFR_OnlineTestFlg": isOnline,
                                              "HRMRFR_TechnicalInterviewFlg":
                                                  isTechnical,
                                              "HRMRFR_Gender":
                                                  genderController.text,
                                              "HRMRFR_Attachment": filePath,
                                              "HRMRFR_ActiveFlag": false,
                                              "HRMRFR_Status": "Pending",
                                              "HRMRFR_CreatedBy": 0,
                                              "HRMRFR_UpdatedBy": widget
                                                  .loginSuccessModel.userId,
                                              "HRMRFR_ManagerFlag": true,
                                              "HRMRFR_JobLocation":
                                                  (selectedRadio == "HO")
                                                      ? "HO"
                                                      : (selectedRadio ==
                                                              "Client")
                                                          ? clientController
                                                              .text
                                                          : locationController
                                                              .text
                                            });
                                          }
                                        }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
      }),
    );
  }

  final clientController = TextEditingController();
  int immcltId = 0;
  final departmentController = TextEditingController();
  int hrmdId = 0;
  final positionTypeController = TextEditingController();
  int hrmptId = 0;
  final genderController = TextEditingController();
  int ivrmmgId = 0;
  bool isWritten = false;
  bool isOnline = false;
  bool isTechnical = false;
  List testList = ['Written Test', 'Online Test', 'Technical Interview'];
  int maxFileSize = 5 * 1024 * 1024;
  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp'],
    );

    if (result != null) {
      int fileSize = result.files.single.size;
      if (fileSize > maxFileSize) {
        Fluttertoast.showToast(
            msg: 'File size exceeds the maximum allowed size.');
      } else {
        setState(() {
          File file = File(result.files.single.path!);
          _getImageUrl(file);
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Image Is not Uploaded Please try Again");
    }
  }

  _getImageUrl(
    File path,
  ) async {
    try {
      uploadAttachment.add(
          await uploadAtt(miId: widget.loginSuccessModel.mIID!, file: path));
    } catch (e) {
      Fluttertoast.showToast(msg: "Please Upload Image");
      return Future.error({
        "errorTitle": "An Error Occured",
        "errorMsg": "While trying to upload attchement, we encountered an error"
      });
    }
    setState(() {
      Fluttertoast.showToast(msg: "Uploaded");
      for (var i in uploadAttachment) {
        filePath = i.path;
        fileName = i.name;
      }
    });
  }

  List<UploadHwCwModel> uploadAttachment = [];
  String filePath = '';
  String fileName = '';
}
