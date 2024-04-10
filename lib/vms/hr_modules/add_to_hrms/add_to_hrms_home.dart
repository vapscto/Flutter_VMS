import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/api/add_to_hrms_api.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/controller/add_to_hrms_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_candidate_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_emp_type.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class AddToHrmsHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  const AddToHrmsHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<AddToHrmsHome> createState() => _AddToHrmsHomeState();
}

class _AddToHrmsHomeState extends State<AddToHrmsHome> {
  final AddToHRMSConttroller controller = Get.put(AddToHRMSConttroller());

  _loading() async {
    controller.loading(true);
    await AddToHRMSAPI.i.onLoad(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        controller: controller);
    controller.loading(false);
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  //
  final candidatenameController = TextEditingController();
  final companynameController = TextEditingController();
  final empTypeController = TextEditingController();
  final religionController = TextEditingController();
  final casteController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final departmentController = TextEditingController();
  final designationController = TextEditingController();
  final empGradeController = TextEditingController();
  final groupTypeController = TextEditingController();
  final empCodeController = TextEditingController();
  final cardNoController = TextEditingController();
  //
  AddToHrmsCandidateListModelValues? candidateselected;
  AddToHrmsEmpTypeModelValues? empSelectedType;
  //
  @override
  void initState() {
    _loading();
    super.initState();
  }

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
  final SuggestionsBoxController _suggestionsBoxController7 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController8 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController9 =
      SuggestionsBoxController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Obx(() {
        return controller.isLoading.value
            ? AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading ${widget.title} ",
                desc: "We are under process to get your details from server.")
            : controller.candidateList.isEmpty
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "",
                    animatorHeight: 250,
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    children: [
                      Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TypeAheadFormField<
                                  AddToHrmsCandidateListModelValues>(
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
                                  controller: candidatenameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                          controller.candidateList.isNotEmpty
                                              ? 'Candidate Name'
                                              : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Candidate Name',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon: (candidatenameController
                                              .text.isEmpty)
                                          ? const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                candidatenameController.clear();
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                  Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.candidateList.where((d) => d
                                      .hrcDFullName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      candidatenameController.text =
                                          suggestion.hrcDFullName!;

                                      _suggestionsBoxController.close();
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.hrcDFullName!,
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  candidateselected = suggestion;
                                },
                                noItemsFoundBuilder: (context) {
                                  return const SizedBox();
                                },
                              ),
                              const SizedBox(height: 15),
                              TypeAheadFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                suggestionsBoxController:
                                    _suggestionsBoxController1,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: companynameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                      hintText: companyName.isNotEmpty
                                          ? 'Company Name'
                                          : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Company Name',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon: (companynameController
                                              .text.isEmpty)
                                          ? const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                companynameController.clear();
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                  Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return companyName.where((d) => d['name']!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      companynameController.text =
                                          suggestion['name'];

                                      _suggestionsBoxController1.close();
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion['name'],
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
                              TypeAheadFormField<AddToHrmsEmpTypeModelValues>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                suggestionsBoxController:
                                    _suggestionsBoxController2,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: empTypeController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                          controller.empTypeList.isNotEmpty
                                              ? 'Employee Type'
                                              : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Employee Type',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon:
                                          (empTypeController.text.isEmpty)
                                              ? const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                  size: 30,
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    empTypeController.clear();
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                      Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.empTypeList.where((d) => d
                                      .hrmeTEmployeeType!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      empTypeController.text =
                                          suggestion.hrmeTEmployeeType!;

                                      _suggestionsBoxController2.close();
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.hrmeTEmployeeType!,
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  empSelectedType = suggestion;
                                },
                                noItemsFoundBuilder: (context) {
                                  return const SizedBox();
                                },
                              ),
                              const SizedBox(height: 15),
                            ],
                          )),
                    ],
                  );
      }),
    );
  }
}
