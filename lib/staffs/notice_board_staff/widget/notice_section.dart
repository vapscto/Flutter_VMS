import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/check_box_container.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_board_get_section.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_get_student.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/notice_all_student.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class NoticeSection extends StatefulWidget {
  const NoticeSection({
    Key? key,
    required this.controller,
    required this.loginSuccessModel,
    required this.mskoolController,
  }) : super(key: key);

  final NoticeBoardController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  @override
  State<NoticeSection> createState() => _NoticeSectionState();
}

class _NoticeSectionState extends State<NoticeSection> {
  final RxBool selectAllSection = RxBool(false);

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return widget.controller.isErrorOccuredWhileLoadingSection.value
              ? ErrWidget(err: {
                  "errorTitle": "An error Occured",
                  "errorMsg": widget.controller.viewWorkLoadingStatus.value,
                })
              : widget.controller.isSectionLoading.value
                  ? const AnimatedProgressWidget(
                      title: "Loading Sections",
                      desc: "We are loading section from selected classes",
                      animationPath: "assets/json/default.json")
                  : widget.controller.sections.isEmpty
                      ? const AnimatedProgressWidget(
                          title: "No Section Found",
                          desc:
                              "There is no section available, ask them to add or select another class",
                          animationPath: "assets/json/nodata.json",
                          animatorHeight: 250,
                        )
                      : Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 150,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
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
                                              height: 35,
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
                                                      const EdgeInsets
                                                              .symmetric(
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
                                                            letterSpacing:
                                                                0.3)),
                                                  ),
                                                  value: selectAllSection.value,
                                                  onChanged: (value) {
                                                    selectAllSection.value =
                                                        value!;
                                                    if (!value) {
                                                      widget.controller.students
                                                          .clear();
                                                      widget.controller
                                                          .selectedSections
                                                          .clear();
                                                    } else {
                                                      widget.controller
                                                          .selectedSections
                                                          .clear();
                                                      widget.controller
                                                          .selectedSections
                                                          .addAll(widget
                                                              .controller
                                                              .sections);
                                                      if (widget
                                                          .controller
                                                          .studentSelection
                                                          .value) {
                                                        loadStudent();
                                                      }
                                                    }
                                                  },
                                                );
                                              })),
                                          ListView.builder(
                                            // padding: const EdgeInsets.only(top: 1),
                                            //controller: _controller,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: widget
                                                .controller.sections.length,
                                            shrinkWrap:
                                                true, // till lenght is 5 is will true
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                height: 35,
                                                child: Obx(() {
                                                  return CheckBoxContainer(
                                                    sectionName:
                                                        "${widget.controller.sections.elementAt(index).asmcLClassName}-${widget.controller.sections.elementAt(index).aSMCSectionName}",
                                                    func: (b) {
                                                      if (b) {
                                                        widget.controller
                                                            .addToSection(widget
                                                                .controller
                                                                .sections
                                                                .elementAt(
                                                                    index));
                                                      } else {
                                                        widget.controller
                                                            .removeFromSection(
                                                                widget
                                                                    .controller
                                                                    .sections
                                                                    .elementAt(
                                                                        index));
                                                      }

                                                      if (widget
                                                          .controller
                                                          .selectedSections
                                                          .isEmpty) {
                                                        widget
                                                            .controller.students
                                                            .clear();
                                                        return;
                                                      }

                                                      if (widget
                                                          .controller
                                                          .studentSelection
                                                          .value) {
                                                        loadStudent();
                                                      }
                                                    },
                                                    isChecked:
                                                        selectAllSection.value
                                                            ? RxBool(true)
                                                            : RxBool(
                                                                widget
                                                                    .controller
                                                                    .selectedSections
                                                                    .contains(
                                                                  widget
                                                                      .controller
                                                                      .sections
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
                                      color: Color(0xFFDBFDF5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/section_.svg',
                                          fit: BoxFit.cover,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          ' Sections ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(
                                                const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                  color: Color(0xFF47BA9E),
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() {
                              return widget.controller.studentSelection.value
                                  ? NoticeAllStudent(
                                      mskoolController: widget.mskoolController,
                                      loginSuccessModel:
                                          widget.loginSuccessModel,
                                      controller: widget.controller)
                                  : const SizedBox();
                            })
                          ],
                        );
        }),
      ],
    );
  }

  void loadStudent() async {
    List<Map<String, dynamic>> sections = [];
    List<Map<String, dynamic>> classT = [];

    for (var element in widget.controller.selectedClasses) {
      classT.add({"ASMCL_Id": element.asmcLId});
    }

    for (var element in widget.controller.selectedSections) {
      sections.add({"ASMS_Id": element.asmSId, "ASMCL_Id": element.asmcLId});
    }

    NoticeGetStudent.instance.getStudents(
        asmayId: widget.loginSuccessModel.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        miId: widget.loginSuccessModel.mIID!,
        sectionListArray: sections,
        classlsttwo: classT,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        noticeBoardController: widget.controller);
  }
}
