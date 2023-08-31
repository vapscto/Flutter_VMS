import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/save_cw_api.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/save_hw_api.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/attach_files.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/references_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class AssignmentDetails extends StatefulWidget {
  final HwCwController hwCwController;
  final bool forHw;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const AssignmentDetails({
    super.key,
    required this.hwCwController,
    required this.forHw,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<AssignmentDetails> createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  RxBool wantToProvideReference = RxBool(false);

  final TextEditingController hwDate = TextEditingController();
  final TextEditingController topic = TextEditingController();
  final TextEditingController ass = TextEditingController();
  final TextEditingController content = TextEditingController();
  final Rx<DateTime> startDt = Rx(DateTime.now());
  final Rx<DateTime> endDt = Rx(DateTime(DateTime.now().year + 1));
  final TextEditingController startDtCtrl = TextEditingController();
  final TextEditingController startDtEndCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 32.0,
        ),
        widget.forHw
            ? CustomContainer(
                child: TextField(
                  readOnly: true,
                  controller: hwDate,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(fontSize: 16.0),
                      ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final DateTime? dt = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year, 12, 31),
                        );

                        if (dt == null) {
                          Fluttertoast.showToast(
                              msg: "No Date Selected for assigning Homework");
                          return;
                        }
                        hwDate.text = "${dt.day}-${dt.month}-${dt.year}";
                        widget.hwCwController.updateHwDate(dt);
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/calendar_icon.svg',
                        color: const Color(0xFF3E78AA),
                        height: 22.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    label: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: const Color(0xFFEEE8FF)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/calendar_icon.svg",
                            color: const Color(0xFF6F58B4),
                            height: 24.0,
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            " Homework Date ",
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
                                      const TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF6F58B4)),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Select Date',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
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
              )
            : Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      child: TextField(
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(fontSize: 16.0),
                            ),
                        readOnly: true,
                        //maxLines: 4,
                        controller: startDtCtrl,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              final DateTime? dt = await showDatePicker(
                                context: context,
                                initialDate: startDt.value,
                                firstDate: startDt.value,
                                lastDate: endDt.value,
                              );

                              if (dt == null) {
                                Fluttertoast.showToast(
                                    msg:
                                        "No Start Date Selected for assigning classwork");
                                return;
                              }
                              startDt.value = dt;
                              startDtCtrl.text =
                                  "${startDt.value.day}-${startDt.value.month}-${startDt.value.year}";
                            },
                            icon: SvgPicture.asset(
                              'assets/svg/calendar_icon.svg',
                              color: const Color(0xFF3E78AA),
                              height: 22.0,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.only(top: 48.0, left: 12),
                          border: const OutlineInputBorder(),
                          label: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
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
                                          color: Color(0xFF3E78AA),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Select Date',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(fontSize: 16.0),
                            ),
                        controller: startDtEndCtrl,
                        //maxLines: 4,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.only(top: 48.0, left: 12),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              final DateTime? dt = await showDatePicker(
                                context: context,
                                initialDate: startDt.value,
                                firstDate: startDt.value,
                                lastDate:
                                    DateTime(DateTime.now().year + 1, 12, 31),
                              );

                              if (dt == null) {
                                Fluttertoast.showToast(
                                    msg:
                                        "No End Date Selected for assigning classwork");
                                return;
                              }
                              endDt.value = dt;
                              startDtEndCtrl.text =
                                  "${endDt.value.day}-${endDt.value.month}-${endDt.value.year}";
                            },
                            icon: SvgPicture.asset(
                              'assets/svg/calendar_icon.svg',
                              color: const Color(0xFF3E78AA),
                              height: 22.0,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          label: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
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
                                            color: Color(0xFF3E78AA)),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Select Date',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
        CustomContainer(
          child: TextField(
            controller: topic,
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  const TextStyle(fontSize: 16.0),
                ),
            readOnly: false,

            //maxLines: 4,
            decoration: InputDecoration(
              // suffixIcon: IconButton(
              //   onPressed: () {},
              //   icon: SvgPicture.asset(
              //     'assets/svg/calendar_icon.svg',
              //     color: const Color(0xFFC1B538),
              //     height: 22.0,
              //   ),
              // ),
              isDense: true,
              contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
              border: const OutlineInputBorder(),
              label: Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: const Color(0xFFFFFDE8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/HINDI.png",
                      color: const Color(0xFFC1B538),
                      height: 24.0,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      " Topic ",
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                            const TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFFC1B538),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
              hintText: 'Enter Topic',

              floatingLabelBehavior: FloatingLabelBehavior.always,
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
        const SizedBox(
          height: 32.0,
        ),
        CustomContainer(
          child: TextField(
            controller: ass,
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  const TextStyle(fontSize: 16.0),
                ),
            readOnly: false,
            maxLines: widget.forHw ? 4 : null,
            decoration: InputDecoration(
              // suffixIcon: IconButton(
              //   onPressed: () {},
              //   icon: SvgPicture.asset(
              //     'assets/svg/calendar_icon.svg',
              //     color: const Color(0xFFC1B538),
              //     height: 22.0,
              //   ),
              // ),
              isDense: true,
              contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
              border: const OutlineInputBorder(),
              label: Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: const Color(0xFFDFFBFE)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/chapter.svg",
                      color: const Color(0xFF28B6C8),
                      height: 20.0,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      widget.forHw ? " Assignment " : " Chapter ",
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                            const TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF28B6C8),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
              hintText: 'Enter Chapter name',

              floatingLabelBehavior: FloatingLabelBehavior.always,
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
        SizedBox(
          height: widget.forHw ? 0 : 32.0,
        ),
        widget.forHw
            ? const SizedBox()
            : CustomContainer(
                child: TextField(
                  controller: content,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(fontSize: 16.0),
                      ),
                  readOnly: false,
                  maxLines: 4,
                  decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   onPressed: () {},
                    //   icon: SvgPicture.asset(
                    //     'assets/svg/calendar_icon.svg',
                    //     color: const Color(0xFFC1B538),
                    //     height: 22.0,
                    //   ),
                    // ),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                    border: const OutlineInputBorder(),
                    label: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: const Color(0xFFFFEBEA)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/content.svg",
                            color: const Color(0xFFFF6F67),
                            height: 20.0,
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            " Content ",
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
                                      const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFFFF6F67),
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Provide Chapter content or insight\'s',

                    floatingLabelBehavior: FloatingLabelBehavior.always,
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
        ReferencesWidget(
          wantToProvideReference: wantToProvideReference,
          hwCwController: widget.hwCwController,
        ),
        const SizedBox(
          height: 16.0,
        ),
        AttachedFiles(
          hwCwController: widget.hwCwController,
        ),
        const SizedBox(
          height: 32.0,
        ),
        MSkollBtn(
          title: "Save Details",
          onPress: () {
            if (!widget.forHw) {
              if (startDtCtrl.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please Select Start Date in order to continue");
                return;
              }

              if (startDtEndCtrl.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please Select End Date in order to continue");
                return;
              }
            } else {
              if (hwDate.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please Select homework Date in order to continue");
                return;
              }
            }

            if (topic.text.isEmpty) {
              Fluttertoast.showToast(msg: "Please Select topic to continue");
              return;
            }

            if (ass.text.isEmpty) {
              widget.forHw
                  ? Fluttertoast.showToast(
                      msg: "Please Provide assignment to continue")
                  : Fluttertoast.showToast(
                      msg: "Please provide chapter to continue");
              return;
            }

            if (content.text.isEmpty && !widget.forHw) {
              Fluttertoast.showToast(msg: "Please Provide Content to continue");
              return;
            }

            if (wantToProvideReference.value &&
                widget.hwCwController.textEditors.isEmpty) {
              Fluttertoast.showToast(
                  msg:
                      "Please provide reference to continue or if you don't want to provide please uncheck the reference");
              return;
            }

            if (wantToProvideReference.value) {
              bool isEmpty = false;

              for (var element in widget.hwCwController.textEditors) {
                if (element.text.isEmpty) {
                  isEmpty = true;
                  break;
                }
              }

              if (isEmpty) {
                Fluttertoast.showToast(
                    msg: "Somewhere your forgot to provide reference");
                return;
              }
            }

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: FutureBuilder<bool>(
                        future: widget.forHw
                            ? SaveHwApi.instance.saveHw(
                                miId: widget.loginSuccessModel.mIID!,
                                asmayId: widget.hwCwController.selectedSession
                                    .value.asmaYId!,
                                asmclId: widget.hwCwController.selectedClass
                                    .value.asmcLId!,
                                ismsId: widget.hwCwController.selectedSubject
                                    .value.ismSId!,
                                controller: widget.hwCwController,
                                base: baseUrlFromInsCode(
                                    "portal", widget.mskoolController),
                                userId: widget.loginSuccessModel.userId!,
                                ivrmrtId: widget.loginSuccessModel.roleId!,
                                hrmeId: widget.loginSuccessModel.empcode!,
                                loginId: widget.loginSuccessModel.userId!,
                                assignment: ass.text,
                                date: widget.hwCwController.hwDate.value
                                    .toLocal()
                                    .toString(),
                                topic: topic.text)
                            : SaveCwApi.instance.save(
                                miId: widget.loginSuccessModel.mIID!,
                                asmayId: widget.hwCwController.selectedSession
                                    .value.asmaYId!,
                                asmclId: widget.hwCwController.selectedClass
                                    .value.asmcLId!,
                                ismsId: widget.hwCwController.selectedSubject.value.ismSId!,
                                topic: topic.text,
                                subTopic: ass.text,
                                content: content.text,
                                fromDate: startDt.value.toLocal().toString(),
                                toDate: endDt.value.toLocal().toString(),
                                controller: widget.hwCwController,
                                base: baseUrlFromInsCode("portal", widget.mskoolController),
                                userId: widget.loginSuccessModel.userId!,
                                ivrmrtId: widget.loginSuccessModel.roleId!,
                                hrmeId: widget.loginSuccessModel.empcode!,
                                loginId: widget.loginSuccessModel.userId!),
                        builder: (_, snapshot) {
                          if (snapshot.hasData && snapshot.data!) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircleAvatar(
                                    minRadius: 36.0,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    widget.forHw
                                        ? "Homework Saved Successfully"
                                        : "Classwork Saved Successfully",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    widget.forHw
                                        ? "We have successfully sent homework to student's"
                                        : "We have successfully sent classwork to student's",
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  MSkollBtn(
                                      title: "Ok Understood!",
                                      onPress: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      })
                                ],
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return ErrWidget(
                                err: snapshot.error as Map<String, dynamic>);
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() {
                                return AnimatedProgressWidget(
                                    title: widget.forHw
                                        ? "Saving HomeWork"
                                        : "Saving classwork",
                                    desc:
                                        widget.hwCwController.saveStatus.value,
                                    animationPath: "assets/json/default.json");
                              }),
                            ],
                          );
                        },
                      ));
                });
          },
          size: Size(Get.width * 0.5, 50),
        )
      ],
    );
  }
}
