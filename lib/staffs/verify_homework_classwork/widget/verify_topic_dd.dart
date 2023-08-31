import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_classwork_topic_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_homework_topic_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/screen/hw_cw_view_details.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class VerifyTopicDD extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccesModel;
  final HwCwController verifyController;
  final bool forHw;
  const VerifyTopicDD(
      {super.key,
      required this.mskoolController,
      required this.loginSuccesModel,
      required this.verifyController,
      required this.forHw});

  @override
  State<VerifyTopicDD> createState() => _VerifyTopicDDState();
}

class _VerifyTopicDDState extends State<VerifyTopicDD> {
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  DateTime startDT = DateTime.now();
  DateTime endDT = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.verifyController.isErrorOccuredWhileLoadingTopic.value
          ? const ErrWidget(err: {
              "errorTitle": "Unexpected Error Occured",
              "errorMsg":
                  "Currently we are unable to load topic for you.. try after some time",
            })
          : widget.verifyController.isTopicLoading.value
              ? const AnimatedProgressWidget(
                  title: "Loading Topic's",
                  desc: "Please wait while we load topic for you...",
                  animationPath: "assets/json/default.json")
              : Obx(() {
                  return widget.verifyController.classWorkTopic.isEmpty &&
                          widget.verifyController.homeworkTopic.isEmpty
                      ? const AnimatedProgressWidget(
                          title: "No Topic found",
                          desc:
                              "There is no corresponding topic available for the selected subject",
                          animationPath: "assets/json/nodata.json",
                          animatorHeight: 250,
                        )
                      : Column(
                          children: [
                            CustomContainer(
                              child: DropdownButtonFormField(
                                  value: widget.forHw
                                      ? widget.verifyController.selectedHwTopic
                                          .value
                                      : widget.verifyController.selectedCwTopic
                                          .value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(
                                        const TextStyle(fontSize: 16.0),
                                      ),
                                  decoration: InputDecoration(
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
                                    label: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF2EC),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/images/HINDI.png",
                                            height: 24.0,
                                            color: const Color(0xFFD77643),
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " Topic ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                    color: Color(0xFFD77643),
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 4.5),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 30,
                                    ),
                                  ),
                                  items: !widget.forHw
                                      ? widget.verifyController.classWorkTopic
                                          .map((e) => DropdownMenuItem<
                                                  ClassworkTopicModelValues>(
                                              value: e,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, left: 5),
                                                child:
                                                    Text(e.iCWTopic ?? "N/a"),
                                              )))
                                          .toList()
                                      : widget.verifyController.homeworkTopic
                                          .map((e) => DropdownMenuItem<
                                                  HomeworkTopicModelValues>(
                                              value: e,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, left: 5),
                                                child:
                                                    Text(e.iHWTopic ?? "N/a"),
                                              )))
                                          .toList(),
                                  onChanged: (e) {
                                    if (widget.forHw) {
                                      widget.verifyController
                                          .updateSelectedHwTopic(
                                              e as HomeworkTopicModelValues);
                                      return;
                                    }
                                    widget.verifyController
                                        .updateSelectedCwTopic(
                                            e as ClassworkTopicModelValues);
                                  }),
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomContainer(
                                    child: TextField(
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      readOnly: true,
                                      //maxLines: 4,
                                      controller: startDate,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            final DateTime? dt =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: startDT,
                                                    firstDate: DateTime(2011),
                                                    lastDate: endDT);
                                            if (dt == null) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "No Start date selected");
                                              return;
                                            }
                                            startDate.text =
                                                "${dt.day}-${dt.month}-${dt.year}";
                                            startDT = dt;
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/svg/calendar_icon.svg',
                                            color: const Color(0xFF3E78AA),
                                            height: 22.0,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 48.0, left: 12),
                                        border: const OutlineInputBorder(),
                                        label: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              color: const Color(0xFFE5F3FF)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/svg/calendar_icon.svg",
                                                color: const Color(0xFF3E78AA),
                                                height: 24.0,
                                              ),
                                              const SizedBox(
                                                width: 6.0,
                                              ),
                                              Text(
                                                " Start Date ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(
                                                      const TextStyle(
                                                        fontSize: 20.0,
                                                        color:
                                                            Color(0xFF3E78AA),
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        hintText: 'Select Date',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  child: CustomContainer(
                                    child: TextField(
                                      readOnly: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      controller: endDate,
                                      //maxLines: 4,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 48.0, left: 12),
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            final DateTime? dt =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: endDT,
                                                    firstDate: startDT,
                                                    lastDate: DateTime.now());
                                            if (dt == null) {
                                              Fluttertoast.showToast(
                                                  msg: "No End date selected");
                                              return;
                                            }
                                            endDate.text =
                                                "${dt.day}-${dt.month}-${dt.year}";
                                            endDT = dt;
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/svg/calendar_icon.svg',
                                            color: const Color(0xFF3E78AA),
                                            height: 22.0,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(),
                                        label: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                              color: const Color(0xFFE5F3FF)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/svg/calendar_icon.svg",
                                                color: const Color(0xFF3E78AA),
                                                height: 24.0,
                                              ),
                                              const SizedBox(
                                                width: 6.0,
                                              ),
                                              Text(
                                                " End Date ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(
                                                      const TextStyle(
                                                          fontSize: 20.0,
                                                          color: Color(
                                                              0xFF3E78AA)),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        hintText: 'Select Date',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            MSkollBtn(
                              title: "View Details",
                              onPress: () {
                                if (startDate.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please select start date to continue");
                                  return;
                                }
                                if (endDate.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please select end date to continue");
                                  return;
                                }
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return VerifyHwCwViewDetails(
                                    title: widget.forHw
                                        ? "View Homework"
                                        : "View Classwork",
                                    forHw: widget.forHw,
                                    asmayId: widget.verifyController
                                        .selectedSession.value.asmaYId!,
                                    asmclId: widget.verifyController
                                        .selectedClass.value.asmcLId!,
                                    asmsId: widget.verifyController
                                        .verifySelectedSection.value.asmSId!,
                                    fromDate: startDT.toLocal().toString(),
                                    ismsId: widget.forHw
                                        ? widget.verifyController
                                            .selectedSubject.value.ismSId!
                                        : widget.verifyController.selectedCwSub
                                            .value.iSMSId!,
                                    loginSuccessModel: widget.loginSuccesModel,
                                    mskoolController: widget.mskoolController,
                                    toDate: endDT.toLocal().toString(),
                                    topicId: widget.forHw
                                        ? widget.verifyController
                                            .selectedHwTopic.value.iHWId!
                                        : widget.verifyController
                                            .selectedCwTopic.value.iCWId!,
                                  );
                                }));
                              },
                              size: Size(
                                Get.width * 0.5,
                                50,
                              ),
                            ),
                            // const AnimatedProgressWidget(
                            //   title: "",
                            //   desc: "",
                            //   animationPath: "assets/json/nodata.json",
                            //   animatorHeight: 250,
                            // ),
                          ],
                        );
                });
    });
  }
}
