import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/check_box_container.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_get_student.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class NoticeAllStudent extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final NoticeBoardController controller;
  const NoticeAllStudent(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.controller});

  @override
  State<NoticeAllStudent> createState() => _NoticeAllStudentState();
}

class _NoticeAllStudentState extends State<NoticeAllStudent> {
  final RxBool selectAllStudent = RxBool(false);

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    List<Map<String, dynamic>> sections = [];
    List<Map<String, dynamic>> classT = [];

    for (var element in widget.controller.selectedClasses) {
      classT.add({"ASMCL_Id": element.asmcLId});
    }

    for (var element in widget.controller.selectedSections) {
      sections.add({"ASMS_Id": element.asmSId, "ASMCL_Id": element.asmcLId});
    }
    logger.d(sections);

    NoticeGetStudent.instance.getStudents(
        asmayId: widget.loginSuccessModel.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        miId: widget.loginSuccessModel.mIID!,
        sectionListArray: sections,
        classlsttwo: classT,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        noticeBoardController: widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 36.0,
        ),
        Obx(() {
          return widget.controller.isErrorOccuredWhileLoadingStudent.value
              ? ErrWidget(err: {
                  "errorTitle": "An error Occured",
                  "errorMsg": widget.controller.viewWorkLoadingStatus.value,
                })
              : widget.controller.isStudentLoading.value
                  ? const AnimatedProgressWidget(
                      title: "Loading Student",
                      desc:
                          "We are loading student from selected classes & section",
                      animationPath: "assets/json/default.json")
                  : widget.controller.students.isEmpty
                      ? const AnimatedProgressWidget(
                          title: "No Student Found",
                          desc:
                              "There is no section available, ask them to add",
                          animationPath: "assets/json/nodata.json",
                          animatorHeight: 250,
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 150,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: RawScrollbar(
                                thumbColor: const Color(0xFF1E38FC),
                                trackColor:
                                    const Color.fromRGBO(223, 239, 253, 1),
                                trackRadius: const Radius.circular(10),
                                trackVisibility: true,
                                radius: const Radius.circular(10),
                                thickness: 14,
                                thumbVisibility: true,
                                controller: _controller,
                                child: SingleChildScrollView(
                                  controller: _controller,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 30,
                                          child: Obx(() {
                                            return CheckboxListTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              checkboxShape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                              dense: true,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -4.0),
                                              title: Text(
                                                "Select All",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3)),
                                              ),
                                              value: selectAllStudent.value,
                                              onChanged: (value) {
                                                selectAllStudent.value = value!;

                                                if (value) {
                                                  widget.controller
                                                      .addAllToStudent(widget
                                                          .controller.students);
                                                  return;
                                                }

                                                widget.controller.selectedStuden
                                                    .clear();
                                              },
                                            );
                                          })),
                                      ListView.builder(
                                        // padding: const EdgeInsets.only(top: 1),
                                        //controller: _controller,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            widget.controller.students.length,
                                        shrinkWrap:
                                            true, // till lenght is 5 is will true
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                              height: 30,
                                              child: Obx(() {
                                                return CheckBoxContainer(
                                                    sectionName:
                                                        "${widget.controller.students.elementAt(index).studentname}",
                                                    func: (b) {
                                                      if (b) {
                                                        widget.controller
                                                            .addToSelectedStudent(
                                                                widget
                                                                    .controller
                                                                    .students
                                                                    .elementAt(
                                                                        index));
                                                      } else {
                                                        widget.controller
                                                            .removeToSelectedStudent(
                                                                widget
                                                                    .controller
                                                                    .students
                                                                    .elementAt(
                                                                        index));
                                                      }
                                                    },
                                                    isChecked:
                                                        selectAllStudent.value
                                                            ? RxBool(true)
                                                            : RxBool(false));
                                              }));
                                        },
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -20,
                              left: 14,
                              child: Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 7),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE5F3FF),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/profile.svg',
                                      fit: BoxFit.cover,
                                      height: 24,
                                      color: const Color(0xFF3E78AA),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      ' Select Student ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(
                                            const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                              color: Color(0xFF3E78AA),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
        }),
      ],
    );
  }
}
