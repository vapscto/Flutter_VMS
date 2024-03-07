import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/api/interview_feedback_api.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/controller/interview_feedback_controller.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/model/interview_grid_list_model.dart';
import 'package:m_skool_flutter/vms/interviewer_feedback/model/update_data_model.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class UpdatedInterviewStatus extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final InterviewFeedbackController controller;
  final InterviewModelListValues values;
  const UpdatedInterviewStatus(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller,
      required this.values});

  @override
  State<UpdatedInterviewStatus> createState() => _UpdatedInterviewStatusState();
}

class _UpdatedInterviewStatusState extends State<UpdatedInterviewStatus> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  InterviewUPdateModelValues? data;
  _getData() async {
    widget.controller.updateLoading(true);
    await InterviewFeedbackAPI.i.detailsAPI(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: widget.controller,
        id: widget.values.hrcisCId!);
    widget.controller.updateLoading(false);
    data = widget.controller.updateData.first;
  }

  _saveData(Map<String, dynamic> data) async {
    widget.controller.saveLoading(true);
    await InterviewFeedbackAPI.i.saveFeedback(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: widget.controller,
        body: data);
    widget.controller.saveLoading(false);
    widget.controller.listLoading(true);
    await InterviewFeedbackAPI.i.onload(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: widget.controller,
        body: {"UserId": widget.loginSuccessModel.userId});
    widget.controller.listLoading(false);
    Get.back();
  }

  final remarkController = TextEditingController();
  String selectedRadio = '';
  List<String> radioList = ['Selected', 'Rejected', 'Short Listed', 'Hold'];
  List<String> dropDownList = ['InProgress', 'Completed'];
  String selectedData = 'Completed';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Candidate Interview').getAppBar(),
      body: Obx(() {
        return widget.controller.isUpdateLoading.value
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading",
                desc: "We are under process to get your details from server.")
            : widget.controller.updateData.isEmpty
                ? const SizedBox()
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                data!.hrcDPhoto ?? '',
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      createPreview(
                                          context, data!.hrcDResume ?? '');
                                    },
                                    child: Text(
                                      'View Resume',
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '${data!.hrcDFullName}',
                                    style: Get.textTheme.titleSmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Candidate Status ',
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      Wrap(
                        children: List.generate(radioList.length, (index) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                                listTileTheme: const ListTileThemeData(
                                    horizontalTitleGap: 2),
                                unselectedWidgetColor:
                                    Theme.of(context).primaryColor),
                            child: RadioListTile(
                                activeColor: Theme.of(context).primaryColor,
                                title: Text(
                                  radioList[index],
                                  style: Get.textTheme.titleSmall,
                                ),
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    vertical: VisualDensity.minimumDensity,
                                    horizontal: VisualDensity.minimumDensity),
                                value: radioList[index],
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  selectedRadio = value!;
                                  logger.i(selectedRadio);
                                  setState(() {});
                                }),
                          );
                        }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: dropDownList[1],
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
                            hintText: dropDownList.isNotEmpty
                                ? 'Select Status'
                                : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(223, 251, 254, 1),
                              text: 'Interview Status',
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
                          items: List.generate(dropDownList.length, (index) {
                            return DropdownMenuItem(
                              value: dropDownList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  dropDownList[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) async {
                            selectedData = s!;
                            logger.v(selectedData);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 16),
                        child: CustomContainer(
                            child: TextFormField(
                          style: Get.textTheme.titleSmall,
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          controller: remarkController,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 12),
                            border: const OutlineInputBorder(),
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
                            hintText: "Interviewer Feedback",
                            label: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFFBFE),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/noteicon.svg',
                                    color:
                                        const Color.fromRGBO(40, 182, 200, 1),
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    "Interviewer Feedback",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(
                                          const TextStyle(
                                            fontSize: 20.0,
                                            color:
                                                Color.fromRGBO(40, 182, 200, 1),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: MSkollBtn(
                            title: "Update",
                            onPress: () {
                              if (selectedRadio == '') {
                                Fluttertoast.showToast(
                                    msg: "Select Candidate Status");
                                return;
                              } else if (remarkController.text.isEmpty) {
                                Fluttertoast.showToast(msg: "Enter Remarks");
                                return;
                              } else {
                                _saveData({
                                  "HRCISC_Id": data!.hrcisCId,
                                  "HRCD_Id": data!.hrcDId,
                                  "MI_Id": widget.loginSuccessModel.mIID,
                                  "HRCISC_InterviewRounds":
                                      data!.hrcisCInterviewRounds,
                                  "HRCISC_InterviewDateTime":
                                      data!.hrcisCInterviewDateTime,
                                  "HRCISC_InterviewVenue":
                                      data!.hrcisCInterviewVenue!,
                                  "HRCISC_CreatedBy":
                                      widget.loginSuccessModel.userId,
                                  "HRCISC_UpdatedBy":
                                      widget.loginSuccessModel.userId,
                                  "HRCISC_Status": selectedData,
                                  "HRCISC_NotifyEmail": true,
                                  "HRCISC_NotifySMS": true,
                                  "HRCD_FullName": data!.hrcDFullName,
                                  "HRCD_Resume": data!.hrcDResume ?? '',
                                  "HRCIS_InterviewFeedBack":
                                      remarkController.text,
                                  "HRCIS_CandidateStatus": selectedRadio
                                });
                              }
                            }),
                      ),
                    ],
                  );
      }),
    );
  }
}
