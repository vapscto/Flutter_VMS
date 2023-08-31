import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/check_box_container.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_board_api.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/notice_get_designation.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_designation.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class StaffWidget extends StatefulWidget {
  final NoticeBoardController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffWidget(
      {super.key,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<StaffWidget> createState() => _StaffWidgetState();
}

class _StaffWidgetState extends State<StaffWidget> {
  @override
  void initState() {
    StaffNoticeBoardApi.instance.getDepartmentList(
        miId: widget.loginSuccessModel.mIID!,
        hrme: widget.loginSuccessModel.empcode!,
        userId: widget.loginSuccessModel.userId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        noticeBoardController: widget.controller);
    super.initState();
  }

  final ScrollController _controller = ScrollController();
  final RxBool selectAllDept = RxBool(false);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 36.0,
        ),
        Obx(() {
          return widget.controller.isErrorOccuredWhileLoadingDepartment.value
              ? const ErrWidget(
                  err: {
                    "errorTite": "An Error Occured",
                    "errorMsg":
                        "An error occured while trying to get department list",
                  },
                )
              : widget.controller.isDepartmentLoading.value
                  ? const AnimatedProgressWidget(
                      title: "Loading Department's",
                      desc: "Please wait while we load departments for you.",
                      animationPath: "assets/json/default.json")
                  : Obx(() {
                      return widget.controller.departments.isEmpty
                          ? const AnimatedProgressWidget(
                              title: "No Department Found",
                              desc:
                                  "There are no department's available ask them to add",
                              animationPath: "assets/json/nodata.json",
                              animatorHeight: 250,
                            )
                          : Column(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 160,
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
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
                                        trackColor: const Color.fromRGBO(
                                            223, 239, 253, 1),
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
                                                                      .circular(
                                                                          6)),
                                                      dense: true,
                                                      activeColor:
                                                          Theme.of(context)
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
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.3)),
                                                      ),
                                                      value:
                                                          selectAllDept.value,
                                                      onChanged: (bool? value) {
                                                        selectAllDept.value =
                                                            value!;

                                                        if (!value) {
                                                          widget.controller
                                                              .selectedDepartment
                                                              .clear();
                                                          widget.controller
                                                              .designation
                                                              .clear();
                                                          return;
                                                        }
                                                        widget.controller
                                                            .selectAllDept(widget
                                                                .controller
                                                                .departments);

                                                        loadDesignation();
                                                      },
                                                    );
                                                  })),
                                              const SizedBox(
                                                height: 6.0,
                                              ),
                                              ListView.builder(
                                                itemCount: widget.controller
                                                    .departments.length,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return SizedBox(
                                                      height: 35,
                                                      child: Obx(() {
                                                        return CheckBoxContainer(
                                                            sectionName:
                                                                "${widget.controller.departments.elementAt(index).hRMDCName}",
                                                            func: (b) {
                                                              if (b) {
                                                                widget
                                                                    .controller
                                                                    .addToSelectedDepartment(
                                                                  widget
                                                                      .controller
                                                                      .departments
                                                                      .elementAt(
                                                                    index,
                                                                  ),
                                                                );
                                                              } else {
                                                                widget
                                                                    .controller
                                                                    .removeFromSelectedDepartment(
                                                                  widget
                                                                      .controller
                                                                      .departments
                                                                      .elementAt(
                                                                    index,
                                                                  ),
                                                                );
                                                              }

                                                              if (widget
                                                                  .controller
                                                                  .selectedDepartment
                                                                  .isEmpty) {
                                                                widget
                                                                    .controller
                                                                    .designation
                                                                    .clear();
                                                                return;
                                                              }

                                                              loadDesignation();
                                                            },
                                                            isChecked: selectAllDept
                                                                        .value ==
                                                                    true
                                                                ? RxBool(true)
                                                                : RxBool(
                                                                    widget
                                                                        .controller
                                                                        .selectedDepartment
                                                                        .contains(
                                                                      widget
                                                                          .controller
                                                                          .departments
                                                                          .elementAt(
                                                                              index),
                                                                    ),
                                                                  ));
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
                                    const ContainerTitle(
                                      iT: Color(0xFFFF6F67),
                                      bg: Color(0xFFFFEBEA),
                                      image:
                                          'assets/images/subjectfielicon.png',
                                      title: 'Select Department',
                                    ),
                                  ],
                                ),
                                StaffDesignation(
                                    controller: widget.controller,
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController),
                              ],
                            );
                    });
        }),
      ],
    );
  }

  void loadDesignation() {
    List<Map<String, dynamic>> mList = [];
    for (var element in widget.controller.selectedDepartment) {
      mList.add({"HRMDC_ID": element.hRMDCID});
    }

    NoticeBoardGetDesignation.instance.getDesignation(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      userId: widget.loginSuccessModel.userId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      departmentList: mList,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      noticeBoardController: widget.controller,
    );
  }
}

class ContainerTitle extends StatelessWidget {
  final String title;
  final String image;
  final Color iT;
  final Color bg;
  const ContainerTitle({
    Key? key,
    required this.title,
    required this.image,
    required this.iT,
    required this.bg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -20,
      left: 14,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 24,
            ),
            const SizedBox(width: 5),
            Text(
              ' $title ',
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      color: iT,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
