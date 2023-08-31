import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/check_box_container.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_board_api.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_board_get_section.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/notice_section.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class StudentWidget extends StatefulWidget {
  final NoticeBoardController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StudentWidget(
      {super.key,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  // RxBool studentSelection = RxBool(false);
  RxBool selectAllClass = RxBool(false);

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    StaffNoticeBoardApi.instance.getClassList(
        miId: widget.loginSuccessModel.mIID!,
        hrme: widget.loginSuccessModel.empcode!,
        userId: widget.loginSuccessModel.userId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        noticeBoardController: widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Obx(() {
              return Checkbox(
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                  ),
                  value: widget.controller.studentSelection.value,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (b) {
                    widget.controller.updateStudentSeclection(b!);
                  });
            }),
            Text(
              "Student Selection",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        Obx(() {
          return widget.controller.isErrorOccuredWhileLoadingClass.value
              ? ErrWidget(err: {
                  "errorTite": "An Error Occured",
                  "errorMsg": widget.controller.viewWorkLoadingStatus.value
                })
              : widget.controller.isClassLoading.value
                  ? const AnimatedProgressWidget(
                      title: "Loading Classes and other details",
                      desc:
                          "Please wait we are doing your work.. it will appear here.",
                      animationPath: "assets/json/default.json")
                  : Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              // height: 140,
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
                                                            BorderRadius
                                                                .circular(6)),
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
                                                value: selectAllClass.value,
                                                onChanged: (value) {
                                                  selectAllClass.value = value!;

                                                  if (value) {
                                                    widget.controller
                                                        .selectedClasses
                                                        .addAll(widget
                                                            .controller
                                                            .classesList);
                                                    loadSection();
                                                  } else {
                                                    widget.controller
                                                        .selectedClasses
                                                        .clear();
                                                    widget.controller.sections
                                                        .clear();
                                                    widget.controller.students
                                                        .clear();
                                                  }
                                                },
                                              );
                                            })),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        ListView.builder(
                                          itemCount: widget
                                              .controller.classesList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              height: 35,
                                              child: Obx(() {
                                                return CheckBoxContainer(
                                                  sectionName:
                                                      "${widget.controller.classesList.elementAt(index).asmcLClassName}",
                                                  func: (b) {
                                                    if (b) {
                                                      widget.controller
                                                          .addToSelectedClasses(
                                                              widget.controller
                                                                  .classesList
                                                                  .elementAt(
                                                                      index));
                                                    } else {
                                                      widget.controller
                                                          .removeSelectedClass(
                                                              widget.controller
                                                                  .classesList
                                                                  .elementAt(
                                                                      index));
                                                    }
                                                    if (widget
                                                        .controller
                                                        .selectedClasses
                                                        .isEmpty) {
                                                      widget.controller.sections
                                                          .clear();
                                                      widget.controller.students
                                                          .clear();
                                                      return;
                                                    }

                                                    loadSection();
                                                  },
                                                  isChecked:
                                                      selectAllClass.value
                                                          ? RxBool(true)
                                                          : RxBool(
                                                              widget.controller
                                                                  .selectedClasses
                                                                  .contains(
                                                                widget
                                                                    .controller
                                                                    .classesList
                                                                    .elementAt(
                                                                        index),
                                                              ),
                                                            ),
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 16.0,
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            Positioned(
                              top: -20,
                              left: 14,
                              child: Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 7),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFEBEA),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/classnew.png',
                                      fit: BoxFit.cover,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      ' Class Name ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(
                                            const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                              color: Color(0xFFFF6F67),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 36.0,
                        ),
                        NoticeSection(
                          controller: widget.controller,
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                        )
                      ],
                    );
        }),
      ],
    );
  }

  void loadSection() {
    List<Map<String, dynamic>> map = [];

    for (var element in widget.controller.selectedClasses) {
      map.add({
        "ASMCL_Id": element.asmcLId,
      });
    }
    GetSectionsApi.instance.getSections(
        asmayId: widget.loginSuccessModel.asmaYId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        classlsttwo: map,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        noticeBoardController: widget.controller);
  }
}
