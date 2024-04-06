import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/api/interviewsc_api.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/controller/interview_sc_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/model/candidate_list_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/interview_schdule/model/interviewer_list_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class InterViewSchduleHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  const InterViewSchduleHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<InterViewSchduleHome> createState() => _InterViewSchduleHomeState();
}

class _InterViewSchduleHomeState extends State<InterViewSchduleHome> {
  InterviewScController controller = Get.put(InterviewScController());
  //
  final candidateController = TextEditingController();
  int hrcdId = 0;
  int hrcisId = 0;
  final interviewerct = TextEditingController();
  int hrmeId = 0;
  //
  final ivRoundct = TextEditingController();
  final statusController = TextEditingController();
  final SuggestionsBoxController _suggestionsBoxController =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController1 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController3 =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController4 =
      SuggestionsBoxController();
  final dateController = TextEditingController();
  DateTime? fromDate;
  final addressController = TextEditingController();
  _onload() async {
    controller.loading(true);
    await InterViewSchduleAPI.i.onLoad(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        controller: controller);
    controller.loading(false);
  }

  @override
  void initState() {
    _onload();
    super.initState();
  }

  _saveData(Map<String, dynamic> body) async {
    controller.saveing(true);
    await InterViewSchduleAPI.i.saveAPI(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        body: body,
        controller: controller);
    controller.saveing(false);
  }

  final _key = GlobalKey<FormState>();
  List notifyList = ['E-Mail', 'SMS'];
  bool email = false;
  bool sms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Obx(() {
        return controller.isLoading.value
            ? AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading ${widget.title}",
                desc: "We are under process to get your details from server.")
            : (controller.candidateList.isEmpty)
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "",
                    animatorHeight: 250,
                  )
                : Form(
                    key: _key,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        TypeAheadFormField<CandidateListModelValues>(
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          suggestionsBoxController: _suggestionsBoxController,
                          getImmediateSuggestions: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            style: Get.textTheme.titleSmall,
                            controller: candidateController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
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
                                    .copyWith(color: Colors.grey, fontSize: 14),
                                hintText: controller.candidateList.isNotEmpty
                                    ? 'Candidate Name'
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Candidate Name',
                                labelStyle: Get.textTheme.titleSmall,
                                suffixIcon: (candidateController.text.isEmpty)
                                    ? const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          candidateController.clear();
                                          hrcdId = 0;
                                          hrcisId = 0;
                                          setState(() {});
                                        },
                                        icon:
                                            const Icon(Icons.clear_outlined))),
                          ),
                          suggestionsCallback: (v) {
                            return controller.candidateList.where((d) => d
                                .hrcDFirstName!
                                .toLowerCase()
                                .contains(v.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              onTap: () async {
                                candidateController.text =
                                    '${suggestion.hrcDFirstName!} ${suggestion.hrcDMiddleName ?? ""} ${suggestion.hrcDLastName ?? ""}';
                                hrcdId = suggestion.hrcDId!;
                                hrcisId = suggestion.hrcisCId!;
                                logger.v(hrcdId);
                                _suggestionsBoxController.close();
                                setState(() {});
                              },
                              title: Text(
                                '${suggestion.hrcDFirstName!} ${suggestion.hrcDMiddleName ?? ""} ${suggestion.hrcDLastName ?? ""}',
                                style: Get.textTheme.titleSmall,
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {},
                          noItemsFoundBuilder: (context) {
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          controller: dateController,
                          style: Get.textTheme.titleSmall,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "Interview Date",
                              hintStyle: Get.textTheme.titleSmall!
                                  .copyWith(color: Colors.grey),
                              labelText: 'Interview Date',
                              labelStyle: Get.textTheme.titleSmall,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).primaryColor,
                              )),
                          onTap: () async {
                            fromDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2063));
                            if (fromDate != null) {
                              dateController.text = dateFormat1(fromDate!);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Date is not selected");
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TypeAheadFormField(
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          suggestionsBoxController: _suggestionsBoxController1,
                          getImmediateSuggestions: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            style: Get.textTheme.titleSmall,
                            controller: ivRoundct,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
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
                                    .copyWith(color: Colors.grey, fontSize: 14),
                                hintText: interviewRound.isNotEmpty
                                    ? 'Interview Rounds'
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Interview Rounds',
                                labelStyle: Get.textTheme.titleSmall,
                                suffixIcon: (ivRoundct.text.isEmpty)
                                    ? const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          ivRoundct.clear();

                                          setState(() {});
                                        },
                                        icon:
                                            const Icon(Icons.clear_outlined))),
                          ),
                          suggestionsCallback: (v) {
                            return interviewRound.where((d) => d['name']
                                .toLowerCase()
                                .contains(v.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              onTap: () async {
                                ivRoundct.text = '${suggestion['name']}';
                                logger.v(ivRoundct.text);
                                _suggestionsBoxController1.close();
                                setState(() {});
                              },
                              title: Text(
                                '${suggestion['name']}',
                                style: Get.textTheme.titleSmall,
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {},
                          noItemsFoundBuilder: (context) {
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 10),
                        TypeAheadFormField<InterviewerListModelValues>(
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          suggestionsBoxController: _suggestionsBoxController3,
                          getImmediateSuggestions: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            style: Get.textTheme.titleSmall,
                            controller: interviewerct,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
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
                                    .copyWith(color: Colors.grey, fontSize: 14),
                                hintText: controller.interviewerList.isNotEmpty
                                    ? 'Interviewer Name'
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Interviewer Name',
                                labelStyle: Get.textTheme.titleSmall,
                                suffixIcon: (interviewerct.text.isEmpty)
                                    ? const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          interviewerct.clear();
                                          hrmeId = 0;
                                          setState(() {});
                                        },
                                        icon:
                                            const Icon(Icons.clear_outlined))),
                          ),
                          suggestionsCallback: (v) {
                            return controller.interviewerList.where((d) => d
                                .hrmEEmployeeFirstName!
                                .toLowerCase()
                                .contains(v.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              onTap: () async {
                                interviewerct.text =
                                    '${suggestion.hrmEEmployeeFirstName!} ${suggestion.hrmEEmployeeMiddleName ?? ""} ${suggestion.hrmEEmployeeLastName ?? ""}';
                                hrmeId = suggestion.id!;
                                logger.v(hrmeId);
                                _suggestionsBoxController3.close();
                                setState(() {});
                              },
                              title: Text(
                                '${suggestion.hrmEEmployeeFirstName!} ${suggestion.hrmEEmployeeMiddleName ?? ""} ${suggestion.hrmEEmployeeLastName ?? ""}',
                                style: Get.textTheme.titleSmall,
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {},
                          noItemsFoundBuilder: (context) {
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          controller: addressController,
                          style: Get.textTheme.titleSmall,
                          decoration: InputDecoration(
                            hintText: "Interview Venue",
                            hintStyle: Get.textTheme.titleSmall!
                                .copyWith(color: Colors.grey),
                            labelText: 'Interview Venue',
                            labelStyle: Get.textTheme.titleSmall,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TypeAheadFormField(
                          validator: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          suggestionsBoxController: _suggestionsBoxController4,
                          getImmediateSuggestions: true,
                          direction: AxisDirection.up,
                          textFieldConfiguration: TextFieldConfiguration(
                            style: Get.textTheme.titleSmall,
                            controller: statusController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
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
                                    .copyWith(color: Colors.grey, fontSize: 14),
                                hintText: interviewstatus.isNotEmpty
                                    ? 'Status '
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Status',
                                labelStyle: Get.textTheme.titleSmall,
                                suffixIcon: (statusController.text.isEmpty)
                                    ? const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          statusController.clear();

                                          setState(() {});
                                        },
                                        icon:
                                            const Icon(Icons.clear_outlined))),
                          ),
                          suggestionsCallback: (v) {
                            return interviewstatus.where((d) => d['name']
                                .toLowerCase()
                                .contains(v.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              onTap: () async {
                                statusController.text = '${suggestion['name']}';
                                logger.v(statusController.text);
                                _suggestionsBoxController4.close();
                                setState(() {});
                              },
                              title: Text(
                                '${suggestion['name']}',
                                style: Get.textTheme.titleSmall,
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {},
                          noItemsFoundBuilder: (context) {
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Notify Candidate By:",
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                checkColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                visualDensity: const VisualDensity(
                                    vertical: 0, horizontal: 0),
                                value: email,
                                onChanged: (value) {
                                  setState(() {
                                    email = value!;
                                  });
                                }),
                            Text(
                              notifyList[0],
                              style: Get.textTheme.titleSmall,
                            ),
                            const SizedBox(width: 10),
                            Checkbox(
                                checkColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                visualDensity: const VisualDensity(
                                    vertical: 0, horizontal: 0),
                                value: sms,
                                onChanged: (value) {
                                  setState(() {
                                    sms = value!;
                                  });
                                }),
                            Text(
                              notifyList[1],
                              style: Get.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: controller.isSaving.value == true
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : MSkollBtn(
                                      title: "Save & Schedule",
                                      onPress: () {
                                        if (_key.currentState!.validate()) {
                                          _saveData({
                                            "HRCISC_Id": hrcisId,
                                            "HRCD_Id": hrcdId,
                                            "MI_Id":
                                                widget.loginSuccessModel.mIID,
                                            "HRCISC_InterviewRounds":
                                                ivRoundct.text,
                                            "HRCISC_InterviewDateTime":
                                                fromDate!.toIso8601String(),
                                            "HRCISC_InterviewVenue":
                                                addressController.text,
                                            "HRCISC_UpdatedBy":
                                                widget.loginSuccessModel.userId,
                                            "HRCISC_Interviewer": hrmeId,
                                            "HRCISC_Status":
                                                statusController.text,
                                            "HRCISC_NotifyEmail": email,
                                            "HRCISC_NotifySMS": sms
                                          });
                                        }
                                      })),
                        )
                      ],
                    ),
                  );
      }),
    );
  }
}
