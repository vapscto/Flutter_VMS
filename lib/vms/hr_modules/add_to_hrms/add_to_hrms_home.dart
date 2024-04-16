import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/api/add_to_hrms_api.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/controller/add_to_hrms_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrmd_deg.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_candidate_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_dep_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/add_to_hrms_emp_type.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/cast_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/company_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/grade_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/group_type_list.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/marital_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/add_to_hrms/model/religion_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

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
  ReligionListModelValues? religionSelected;
  CastListModelValues? selectedCast;
  MaritalListModelValues? selectedMarital;
  AddToHrmsDepListModelValues? selectedDep;
  AddToHrmsDegModelValues? selectedDeg;
  GradeListModelValues? selectedGrade;
  GroupTypeListModelValues? selectGroupType;
  CompanyListModelValues? selectedCompany;
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
                                      companynameController.clear();
                                      empTypeController.clear();
                                      religionController.clear();
                                      casteController.clear();
                                      maritalStatusController.clear();
                                      departmentController.clear();
                                      designationController.clear();
                                      empGradeController.clear();
                                      groupTypeController.clear();
                                      empCodeController.clear();
                                      cardNoController.clear();
                                      empSelectedType = null;
                                      religionSelected = null;
                                      selectedCast = null;
                                      selectedMarital = null;
                                      selectedDep = null;
                                      selectedDeg = null;
                                      selectedGrade = null;
                                      selectGroupType = null;
                                      selectedCompany = null;
                                      candidatenameController.text =
                                          suggestion.hrcDFullName!;

                                      _suggestionsBoxController.close();
                                      candidateselected = suggestion;
                                      await candidateList(
                                              base: baseUrlFromInsCode(
                                                  "recruitement",
                                                  widget.mskoolController),
                                              controller: controller,
                                              hrcdId: suggestion.hrcDId)
                                          .then((value) {
                                        setState(() {
                                          for (var i
                                              in controller.companyList) {
                                            if (i.mIId ==
                                                controller.candidateDetailsList
                                                    .last.mIId) {
                                              companynameController.text =
                                                  i.mIName!;
                                              selectedCompany = i;
                                            }
                                          }
                                          for (var i
                                              in controller.religionlist) {
                                            if (i.ivrmmRId ==
                                                controller.candidateDetailsList
                                                    .last.hrcDReligion) {
                                              religionController.text =
                                                  i.ivrmmRName.toString();
                                              religionSelected = i;
                                            }
                                          }
                                          for (var i in controller.castList) {
                                            if (i.imCId ==
                                                controller.candidateDetailsList
                                                    .last.hrcDCasteId) {
                                              casteController.text =
                                                  i.imCCasteName.toString();
                                              selectedCast = i;
                                            }
                                            for (var i
                                                in controller.maritalList) {
                                              if (i.ivrmmmSId ==
                                                  controller
                                                      .candidateDetailsList
                                                      .last
                                                      .hrcDMaritalStatus) {
                                                maritalStatusController.text = i
                                                    .ivrmmmSMaritalStatus
                                                    .toString();
                                                selectedMarital = i;
                                              }
                                            }
                                            if (controller.candidateDetailsList
                                                        .last.department !=
                                                    null &&
                                                controller.candidateDetailsList
                                                        .last.department !=
                                                    "") {
                                              for (var i
                                                  in controller.depList) {
                                                if (i.hrmDDepartmentName ==
                                                    controller
                                                        .candidateDetailsList
                                                        .last
                                                        .department!) {
                                                  departmentController.text =
                                                      i.hrmDDepartmentName!;
                                                  selectedDep = i;
                                                }
                                              }
                                            }
                                            if (controller.candidateDetailsList
                                                        .last.designation !=
                                                    null &&
                                                controller.candidateDetailsList
                                                        .last.designation !=
                                                    "") {
                                              for (var i
                                                  in controller.degList) {
                                                if (i.hrmdeSDesignationName ==
                                                    controller
                                                        .candidateDetailsList
                                                        .last
                                                        .designation!) {
                                                  designationController.text =
                                                      i.hrmdeSDesignationName!;
                                                  selectedDeg = i;
                                                }
                                              }
                                            }
                                          }
                                        });
                                      });
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.hrcDFullName!,
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
                              TypeAheadFormField<CompanyListModelValues>(
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
                                      hintText:
                                          controller.companyList.isNotEmpty
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
                                  return controller.companyList.where((d) => d
                                      .mIName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      companynameController.text =
                                          suggestion.mIName!;
                                      selectedCompany = suggestion;
                                      _suggestionsBoxController1.close();
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
                                      empSelectedType = suggestion;
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.hrmeTEmployeeType!,
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
                              TypeAheadFormField<ReligionListModelValues>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                suggestionsBoxController:
                                    _suggestionsBoxController3,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: religionController,
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
                                          controller.religionlist.isNotEmpty
                                              ? 'Religion'
                                              : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Religion',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon:
                                          (religionController.text.isEmpty)
                                              ? const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                  size: 30,
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    religionController.clear();
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                      Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.religionlist.where((d) => d
                                      .ivrmmRName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      religionController.text =
                                          suggestion.ivrmmRName!;

                                      _suggestionsBoxController3.close();
                                      religionSelected = suggestion;
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.ivrmmRName!,
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
                              TypeAheadFormField<CastListModelValues>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                direction: AxisDirection.up,
                                suggestionsBoxController:
                                    _suggestionsBoxController4,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: casteController,
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
                                      hintText: controller.castList.isNotEmpty
                                          ? 'Caste'
                                          : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Caste',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon: (casteController.text.isEmpty)
                                          ? const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                casteController.clear();
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                  Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.castList.where((d) => d
                                      .imCCasteName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      casteController.text =
                                          suggestion.imCCasteName!;

                                      _suggestionsBoxController4.close();
                                      selectedCast = suggestion;
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.imCCasteName!,
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
                              TypeAheadFormField<MaritalListModelValues>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                direction: AxisDirection.up,
                                suggestionsBoxController:
                                    _suggestionsBoxController5,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: maritalStatusController,
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
                                          controller.maritalList.isNotEmpty
                                              ? 'Marital Status'
                                              : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Marital Status',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon: (maritalStatusController
                                              .text.isEmpty)
                                          ? const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                maritalStatusController.clear();
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                  Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.maritalList.where((d) => d
                                      .ivrmmmSMaritalStatus!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      maritalStatusController.text =
                                          suggestion.ivrmmmSMaritalStatus!;
                                      _suggestionsBoxController5.close();
                                      selectedMarital = suggestion;
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.ivrmmmSMaritalStatus!,
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
                              TypeAheadFormField<AddToHrmsDepListModelValues>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                direction: AxisDirection.up,
                                suggestionsBoxController:
                                    _suggestionsBoxController6,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: departmentController,
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
                                      hintText: controller.depList.isNotEmpty
                                          ? 'Employee Department'
                                          : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Employee Department',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon: (departmentController
                                              .text.isEmpty)
                                          ? const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                departmentController.clear();
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                  Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.depList.where((d) => d
                                      .hrmDDepartmentName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      departmentController.text =
                                          suggestion.hrmDDepartmentName!;
                                      _suggestionsBoxController6.close();
                                      selectedDep = suggestion;
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
                              TypeAheadFormField<AddToHrmsDegModelValues>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                direction: AxisDirection.up,
                                suggestionsBoxController:
                                    _suggestionsBoxController7,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: designationController,
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
                                      hintText: controller.degList.isNotEmpty
                                          ? 'Employee Designation'
                                          : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Employee Designation',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon: (designationController
                                              .text.isEmpty)
                                          ? const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                designationController.clear();
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                  Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.degList.where((d) => d
                                      .hrmdeSDesignationName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      designationController.text =
                                          suggestion.hrmdeSDesignationName!;
                                      _suggestionsBoxController7.close();
                                      selectedDeg = suggestion;
                                      setState(() {});
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
                              TypeAheadFormField<GradeListModelValues>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                direction: AxisDirection.up,
                                suggestionsBoxController:
                                    _suggestionsBoxController8,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: empGradeController,
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
                                      hintText: controller.degList.isNotEmpty
                                          ? 'Employee Grade'
                                          : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Employee Grade',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon:
                                          (empGradeController.text.isEmpty)
                                              ? const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                  size: 30,
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    empGradeController.clear();
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                      Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.gradeList.where((d) => d
                                      .hrmGGradeName!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      empGradeController.text =
                                          suggestion.hrmGGradeName!;
                                      _suggestionsBoxController8.close();
                                      selectedGrade = suggestion;
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.hrmGGradeName!,
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
                              TypeAheadFormField<GroupTypeListModelValues>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                direction: AxisDirection.up,
                                suggestionsBoxController:
                                    _suggestionsBoxController9,
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: Get.textTheme.titleSmall,
                                  controller: groupTypeController,
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
                                      hintText: controller.degList.isNotEmpty
                                          ? 'Group Type'
                                          : 'No data available',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Group Type',
                                      labelStyle: Get.textTheme.titleSmall!
                                          .copyWith(fontSize: 18),
                                      suffixIcon:
                                          (groupTypeController.text.isEmpty)
                                              ? const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                  size: 30,
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    groupTypeController.clear();
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                      Icons.clear_outlined))),
                                ),
                                suggestionsCallback: (v) {
                                  return controller.groupTypeList.where((d) => d
                                      .hrmgTEmployeeGroupType!
                                      .toLowerCase()
                                      .contains(v.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    onTap: () async {
                                      groupTypeController.text =
                                          suggestion.hrmgTEmployeeGroupType!;
                                      _suggestionsBoxController9.close();
                                      selectGroupType = suggestion;
                                      setState(() {});
                                    },
                                    title: Text(
                                      suggestion.hrmgTEmployeeGroupType!,
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
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                controller: empCodeController,
                                style: Get.textTheme.titleSmall,
                                // keyboardType: TextInputType.number,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.allow(
                                //       RegExp(r'[0-9]')),
                                // ],
                                decoration: InputDecoration(
                                  hintText: "Employee Code",
                                  hintStyle: Get.textTheme.titleSmall!
                                      .copyWith(color: Colors.grey),
                                  labelText: 'Employee Code',
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
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.isEmpty) {
                                    return " ";
                                  }
                                  return null;
                                },
                                controller: cardNoController,
                                style: Get.textTheme.titleSmall,
                                // keyboardType: TextInputType.number,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.allow(
                                //       RegExp(r'[0-9]')),
                                // ],
                                decoration: InputDecoration(
                                  hintText: "HID Card No.",
                                  hintStyle: Get.textTheme.titleSmall!
                                      .copyWith(color: Colors.grey),
                                  labelText: 'HID Card No.',
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
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: MSkollBtn(
                                    title: "Add To HRMS",
                                    onPress: () async {
                                      if (_key.currentState!.validate()) {
                                        newList.clear();
                                        newList.addAll({
                                          "HRCD_Id": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDId,
                                          "MI_Id": controller
                                              .candidateDetailsList.first.mIId,
                                          "HRMPT_Id": controller
                                              .candidateDetailsList
                                              .first
                                              .hrmpTId,
                                          "HRMC_Id": selectedCast!.hrmCId,
                                          "HRME_Id": candidateselected!.hrmEID,
                                          "HRCD_MRFNO": selectedDep!.hrcDMRFNO,
                                          "HRCD_FullName":
                                              candidateselected!.hrcDFullName,
                                          "HRCD_FirstName": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDFirstName,
                                          "HRCD_MiddleName": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDMiddleName,
                                          "HRCD_LastName": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDLastName,
                                          "HRMJ_Id": controller
                                              .candidateDetailsList
                                              .first
                                              .hrmJId,
                                          "HRCD_Skills": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDSkills ??
                                              "",
                                          "HRCD_DOB": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDDOB,
                                          "IVRMMG_Id": controller
                                              .candidateDetailsList
                                              .first
                                              .ivrmmGId,
                                          "HRCD_MobileNo": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDMobileNo,
                                          "HRCD_EmailId": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDEmailId,
                                          "HRCD_ExpFrom": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDExpFrom,
                                          "HRCD_ExpTo": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDExpTo,
                                          "HRCD_CurrentCompany": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDCurrentCompany ??
                                              "",
                                          "HRCD_ResumeSource": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDResumeSource ??
                                              "",
                                          "HRCD_JobPortalName": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDJobPortalName ??
                                              "",
                                          "HRCD_RefCode": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDRefCode ??
                                              "",
                                          "HRCD_LastCTC": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDLastCTC,
                                          "HRCD_ExpectedCTC": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDExpectedCTC,
                                          "HRCD_AppDate": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDAppDate,
                                          "HRCD_InterviewDate": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDInterviewDate,
                                          "HRCD_ExitDate":
                                              candidateselected!.hrcDExitDate,
                                          "HRCD_NoticePeriod": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDNoticePeriod,
                                          "HRCD_Remarks": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDRemarks ??
                                              "",
                                          "HRCD_Resume": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDResume ??
                                              "",
                                          "HRCD_RecruitmentStatus": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDRecruitmentStatus ??
                                              "",
                                          "HRCD_ActiveFlg": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDActiveFlg,
                                          "HRCD_UpdatedBy":
                                              widget.loginSuccessModel.userId,
                                          "HRCD_Department":
                                              departmentController.text,
                                          "HRME_ID": candidateselected!.hrmEID,
                                          "candidateflage":
                                              candidateselected!.candidateflage,
                                          "HRME_RFCardId":
                                              cardNoController.text,
                                          "HRCED_ActiveFlag":
                                              selectedCast!.hrceDActiveFlag,
                                          "HRCD_Photo": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDPhoto,
                                          "HRCD_AadharNo": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDAadharNo,
                                          "HRCD_Designation":
                                              designationController.text,
                                          "HRCD_AddressLocal": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDAddressLocal,
                                          "HRCD_AddressPermanent": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDAddressPermanent,
                                          "HRMET_Id": empSelectedType!.hrmeTId,
                                          "HRMGT_Id": selectGroupType!.hrmgTId,
                                          "HRMG_Id": selectedGrade!.hrmGId,
                                          "HRME_EmployeeCode":
                                              empCodeController.text,
                                          "HRCISC_InterviewDateTime":
                                              candidateselected!
                                                  .hrcisCInterviewDateTime,
                                          "HRCD_NationalityId": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDNationalityId,
                                          "HRCD_Religion":
                                              religionSelected!.hrcDReligion,
                                          "HRCD_MaritalStatus": selectedMarital!
                                              .hrcDMaritalStatus,
                                          "HRCD_BloodGroup": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDBloodGroup ??
                                              "",
                                          "HRCD_CasteId":
                                              selectedCast!.hrcDCasteId,
                                          "HRCD_AddLocalPlace": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDAddressLocal,
                                          "HRCD_AddPermanentPlace": controller
                                              .candidateDetailsList
                                              .first
                                              .hrcDAddressPermanent,
                                          "HRMP_Id": controller
                                              .candidateDetailsList
                                              .first
                                              .hrmPId,
                                          "CreatedDate": controller
                                              .candidateDetailsList
                                              .last
                                              .createdDate,
                                          "UpdatedDate": controller
                                              .candidateDetailsList
                                              .last
                                              .updatedDate
                                        });
                                        await AddToHRMSAPI.i.addHrms(
                                            base: baseUrlFromInsCode(
                                                "recruitement",
                                                widget.mskoolController),
                                            body: {
                                              "HRCD_Id": controller
                                                  .candidateDetailsList
                                                  .first
                                                  .hrcDId,
                                              "MI_Id":
                                                  widget.loginSuccessModel.mIID,
                                              "Employeedto": newList
                                            });
                                        Get.back();
                                      }
                                    }),
                              ),
                              const SizedBox(height: 15),
                            ],
                          )),
                    ],
                  );
      }),
    );
  }

  Map<String, dynamic> newList = {};
}
