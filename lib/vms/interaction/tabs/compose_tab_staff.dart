import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/interaction/api/staff_interaction_compose_related_api.dart';
import 'package:m_skool_flutter/staffs/interaction/controller/staff_interaction_compose_related_controller.dart';
import 'package:m_skool_flutter/staffs/interaction/model/initialDropdownDetailModel.dart';
import 'package:m_skool_flutter/staffs/interaction/model/interactionSectionModel.dart';
import 'package:m_skool_flutter/staffs/interaction/model/interactionStudentListModel.dart';
import 'package:m_skool_flutter/staffs/interaction/widget/attachment_file_widget.dart';
import 'package:m_skool_flutter/staffs/interaction/widget/student_list_widget.dart';
import 'package:m_skool_flutter/staffs/interaction/widget/teacher_list_widget.dart';
import 'package:m_skool_flutter/student/interaction/apis/messaging_api.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ComposeTabStaff extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final TabController tabController;
  final bool animateToInbox;
  const ComposeTabStaff({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.tabController,
    required this.animateToInbox,
  });

  @override
  State<ComposeTabStaff> createState() => _ComposeTabStaffState();
}

class _ComposeTabStaffState extends State<ComposeTabStaff> {
  final StaffInteractionComposeController staffInteractionComposeController =
      Get.put(StaffInteractionComposeController());
  final TextEditingController about = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final List<Map<String, dynamic>> arrayStudents = [];
  final List<Map<String, dynamic>> arrayTeachers = [];
  // final textFocus = FucusNode();
  final ScrollController _controller = ScrollController();
  GetdetailsValues? selectedInitialDropdown;
  InteractionSectionListValue? selectedsection;
  GetStudentValue? selectedstudent;
  RxBool selectAll = RxBool(false);
  RxBool selectAllStaff = RxBool(false);
  RxList<String> attachment = <String>[].obs;

  @override
  void dispose() {
    Get.delete<StaffInteractionComposeController>();
    super.dispose();
  }

  void getInitialData(String selectedStaff) async {
    staffInteractionComposeController.isgetdetailloading(true);
    await staffInteractionComposeController
        .getFirstDropdownData(
      asmayId: widget.loginSuccessModel.asmaYId!,
      roleId: widget.loginSuccessModel.roleId!,
      miId: widget.loginSuccessModel.mIID!,
      roleFlag: widget.loginSuccessModel.roleforlogin!,
      selectedRadioButton: selectedStaff,
      userId: widget.loginSuccessModel.userId.toString(),
      base: baseUrlFromInsCode(
        'portal',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (!value) {
        staffInteractionComposeController.isgetdetailloading(false);
      }
    });
    staffInteractionComposeController.isgetdetailloading(false);
  }

  void getSectionData(int asmclId) async {
    staffInteractionComposeController.issectionloading(true);
    await staffInteractionComposeController
        .getSectionListData(
      asmayId: widget.loginSuccessModel.asmaYId!,
      roleId: widget.loginSuccessModel.roleId!,
      miId: widget.loginSuccessModel.mIID!,
      roleFlag: widget.loginSuccessModel.roleforlogin!,
      userId: widget.loginSuccessModel.userId!,
      asmclId: asmclId,
      base: baseUrlFromInsCode(
        'portal',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (!value) {
        staffInteractionComposeController.issectionloading(false);
        return;
      }
      if (staffInteractionComposeController.interactionSectionList.isEmpty) {
        Fluttertoast.showToast(msg: 'No section for selected class.');
      }
    });
    staffInteractionComposeController.issectionloading(false);
  }

  void getStudentData(int asmsId) async {
    staffInteractionComposeController.isstudentloading(true);
    await staffInteractionComposeController
        .getStudentListData(
      asmayId: widget.loginSuccessModel.asmaYId!,
      roleId: widget.loginSuccessModel.roleId!,
      miId: widget.loginSuccessModel.mIID!,
      roleFlag: widget.loginSuccessModel.roleforlogin!,
      userId: widget.loginSuccessModel.userId.toString(),
      asmclId: selectedInitialDropdown!.asmclId!,
      asmsId: asmsId,
      base: baseUrlFromInsCode(
        'portal',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (!value) {
        staffInteractionComposeController.isstudentloading(false);
      }
    });
    staffInteractionComposeController.isstudentloading(false);
  }

  void addStudentInList(int amstId) {
    arrayStudents.add({"AMST_Id": amstId});
    logger.d(arrayStudents);
  }

  void removeFromStudentInList(int amstId) {
    arrayStudents.removeWhere((v) => v['AMST_Id'] == amstId);
    logger.d(arrayStudents);
  }

  void addStaffInList(int hrmeId) {
    arrayTeachers.add({"HRME_Id": hrmeId});
    logger.d(arrayTeachers);
  }

  void removeStaffFromList(int hrmeId) {
    arrayTeachers.removeWhere((v) => v['HRME_Id'] == hrmeId);
    logger.d(arrayTeachers);
  }

  changeTabAfterCompose(bool value) async {
    if (value) {
      Fluttertoast.showToast(msg: 'Compose successfully');
      widget.tabController.animateTo(1);
      return;
    }
    Fluttertoast.showToast(msg: 'Something went wrong');
  }

  Future<void> documentToNetworkUrl(String filePath) async {
    var document = await jpgToNetworkImageUrl(
        base: baseUrlFromInsCode('login', widget.mskoolController),
        image: filePath,
        miId: widget.loginSuccessModel.mIID!);

    attachment.add(document!);
  }

  @override
  void initState() {
    if (widget.animateToInbox) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.tabController.animateTo(1);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 33,
                  width: 130,
                  child: RadioListTile(
                    dense: true,
                    activeColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    visualDensity: const VisualDensity(horizontal: -4.0),
                    title: Text(
                      "Group",
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                    value: "Group",
                    groupValue:
                        staffInteractionComposeController.grpOrInd.value,
                    onChanged: (value) {
                      staffInteractionComposeController
                          .groupOrIndividual(value!);
                    },
                  ),
                ),
                SizedBox(
                  height: 33,
                  width: 140,
                  child: RadioListTile(
                    dense: true,
                    activeColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    visualDensity: const VisualDensity(horizontal: -4.0),
                    title: Text(
                      "Individual",
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                    value: "Individual",
                    groupValue:
                        staffInteractionComposeController.grpOrInd.value,
                    onChanged: (value) {
                      staffInteractionComposeController
                          .groupOrIndividual(value!);
                      arrayStudents.clear();
                      arrayTeachers.clear();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: CustomContainer(
                child: TextField(
                  style: Theme.of(context).textTheme.titleSmall,
                  controller: subject,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: const Color(0xFFFFEBEA)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/subjectfielicon.png",
                            height: 24.0,
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            " Subject ",
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
                                      const TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFFFF6F67)),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Enter here.',
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
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomContainer(
                child: TextField(
                  style: Theme.of(context).textTheme.titleSmall,
                  controller: about,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: const Color(0xFFDBFDF5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30.0,
                            child: Image.asset(
                              "assets/images/abouticon.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            " About ",
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
                                      const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF47BA9E),
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Enter here.',
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
            const SizedBox(height: 10),
            // SizedBox(
            //   height: 33,
            //   child: RadioListTile(
            //     dense: true,
            //     activeColor: Theme.of(context).primaryColor,
            //     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            //     visualDensity: const VisualDensity(horizontal: -4.0),
            //     title: Text(
            //       "Student",
            //       style: Theme.of(context).textTheme.labelSmall!.merge(
            //           const TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               letterSpacing: 0.3)),
            //     ),
            //     value: "Student",
            //     groupValue:
            //         staffInteractionComposeController.selectedradio.value,
            //     onChanged: (value) {
            //       selectedInitialDropdown = null;
            //       selectedsection = null;
            //       selectedstudent = null;
            //       staffInteractionComposeController.selectedValue(value!);
            //       getInitialData(value);
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 33,
            //   child: RadioListTile(
            //     dense: true,
            //     activeColor: Theme.of(context).primaryColor,
            //     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            //     visualDensity: const VisualDensity(horizontal: -4.0),
            //     title: Text(
            //       "Teachers",
            //       style: Theme.of(context).textTheme.labelSmall!.merge(
            //           const TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               letterSpacing: 0.3)),
            //     ),
            //     value: "Teachers",
            //     groupValue:
            //         staffInteractionComposeController.selectedradio.value,
            //     onChanged: (value) {
            //       selectedInitialDropdown = null;
            //       selectedsection = null;
            //       selectedstudent = null;
            //       staffInteractionComposeController.selectedValue(value!);
            //       getInitialData(value);
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 33,
            //   child: RadioListTile(
            //     dense: true,
            //     activeColor: Theme.of(context).primaryColor,
            //     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            //     visualDensity: const VisualDensity(horizontal: -4.0),
            //     title: Text(
            //       "HOD",
            //       style: Theme.of(context).textTheme.labelSmall!.merge(
            //           const TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               letterSpacing: 0.3)),
            //     ),
            //     value: "HOD",
            //     groupValue:
            //         staffInteractionComposeController.selectedradio.value,
            //     onChanged: (value) {
            //       selectedInitialDropdown = null;
            //       selectedsection = null;
            //       selectedstudent = null;
            //       staffInteractionComposeController.selectedValue(value!);
            //       getInitialData(value);
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 33,
            //   child: RadioListTile(
            //     dense: true,
            //     activeColor: Theme.of(context).primaryColor,
            //     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            //     visualDensity: const VisualDensity(horizontal: -4.0),
            //     title: Text(
            //       "Principal",
            //       style: Theme.of(context).textTheme.labelSmall!.merge(
            //           const TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               letterSpacing: 0.3)),
            //     ),
            //     value: "Principal",
            //     groupValue:
            //         staffInteractionComposeController.selectedradio.value,
            //     onChanged: (value) {
            //       selectedInitialDropdown = null;
            //       selectedsection = null;
            //       selectedstudent = null;
            //       staffInteractionComposeController.selectedValue(value!);
            //       getInitialData(value);
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 33,
            //   child: RadioListTile(
            //     dense: true,
            //     activeColor: Theme.of(context).primaryColor,
            //     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            //     visualDensity: const VisualDensity(horizontal: -4.0),
            //     title: Text(
            //       "Academic Supervisor",
            //       style: Theme.of(context).textTheme.labelSmall!.merge(
            //           const TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               letterSpacing: 0.3)),
            //     ),
            //     value: "AS",
            //     groupValue:
            //         staffInteractionComposeController.selectedradio.value,
            //     onChanged: (value) {
            //       selectedInitialDropdown = null;
            //       selectedsection = null;
            //       selectedstudent = null;
            //       staffInteractionComposeController.selectedValue(value!);
            //       getInitialData(value);
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            //   child: RadioListTile(
            //     dense: true,
            //     activeColor: Theme.of(context).primaryColor,
            //     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            //     visualDensity: const VisualDensity(horizontal: -4.0),
            //     title: Text(
            //       "Exam Co-ordinator",
            //       style: Theme.of(context).textTheme.labelSmall!.merge(
            //           const TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16.0,
            //               letterSpacing: 0.3)),
            //     ),
            //     value: "EC",
            //     groupValue:
            //         staffInteractionComposeController.selectedradio.value,
            //     onChanged: (value) {
            //       selectedInitialDropdown = null;
            //       selectedsection = null;
            //       selectedstudent = null;
            //       staffInteractionComposeController.selectedValue(value!);
            //       getInitialData(value);
            //     },
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            staffInteractionComposeController.selectedradio.value.isNotEmpty
                ? staffInteractionComposeController.isGetDetail.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : staffInteractionComposeController.grpOrInd.value ==
                                'Group' &&
                            staffInteractionComposeController
                                    .selectedradio.value !=
                                'Student'
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: staffInteractionComposeController
                                              .getDetailList.length ==
                                          1
                                      ? 80
                                      : staffInteractionComposeController
                                                  .getDetailList.length ==
                                              2
                                          ? 120
                                          : staffInteractionComposeController
                                                      .getDetailList.length ==
                                                  3
                                              ? 140
                                              : 200,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
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
                                    child: SizedBox(
                                      height: 200,
                                      child: SingleChildScrollView(
                                        controller: _controller,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: CheckboxListTile(
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
                                                  'Select all',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .merge(const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.3)),
                                                ),
                                                value: selectAllStaff.value,
                                                onChanged: (value) {
                                                  selectAllStaff.value = value!;

                                                  if (value) {
                                                    arrayTeachers.clear();
                                                    for (var i = 0;
                                                        i <
                                                            staffInteractionComposeController
                                                                .getDetailList
                                                                .length;
                                                        i++) {
                                                      arrayTeachers.add(
                                                        {
                                                          "HRME_Id": staffInteractionComposeController
                                                                          .selectedradio
                                                                          .value ==
                                                                      'Principal' ||
                                                                  staffInteractionComposeController
                                                                          .selectedradio
                                                                          .value ==
                                                                      'EC'
                                                              ? staffInteractionComposeController
                                                                  .getDetailList
                                                                  .elementAt(i)
                                                                  .id
                                                              : staffInteractionComposeController
                                                                  .getDetailList
                                                                  .elementAt(i)
                                                                  .iD,
                                                        },
                                                      );
                                                    }
                                                    logger.d(arrayTeachers);
                                                    return;
                                                  }
                                                  arrayTeachers.clear();
                                                  logger.d(arrayTeachers);
                                                },
                                              ),
                                            ),
                                            // Expanded(
                                            //   child: ListView.builder(
                                            //     shrinkWrap: true,
                                            //     controller: _controller,
                                            //     itemCount:
                                            //         staffInteractionComposeController
                                            //             .getDetailList.length,
                                            //     itemBuilder: (context, index) {
                                            //       return TeacherListWidget(
                                            //         data:
                                            //             staffInteractionComposeController
                                            //                 .getDetailList
                                            //                 .elementAt(index),
                                            //         function: addStaffInList,
                                            //         function1: removeStaffFromList,
                                            //         selectAll: selectAllStaff.value,
                                            //       );
                                            //     },
                                            //   ),
                                            // ),
                                            Column(
                                              children: List.generate(
                                                  staffInteractionComposeController
                                                      .getDetailList
                                                      .length, (index) {
                                                return TeacherListWidget(
                                                  data:
                                                      staffInteractionComposeController
                                                          .getDetailList
                                                          .elementAt(index),
                                                  function: addStaffInList,
                                                  function1:
                                                      removeStaffFromList,
                                                  selectAll:
                                                      selectAllStaff.value,
                                                );
                                              }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -8,
                                  left: 30,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(229, 243, 255, 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/images/selectteachericon.png',
                                          height: 18,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Select Staff',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(
                                                const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0,
                                                  color: Color.fromRGBO(
                                                      60, 120, 170, 1),
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<GetdetailsValues>(
                              value: selectedInitialDropdown,
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
                                isDense: true,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                                hintText: staffInteractionComposeController
                                        .getDetailList.isNotEmpty
                                    ? 'select'
                                    : 'No data available.',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFEBEA),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/class_.svg",
                                        height: 24.0,
                                        color: const Color(0xFFFF6F67),
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        staffInteractionComposeController
                                                    .selectedradio.value ==
                                                'Student'
                                            ? ' Class '
                                            : ' Staff ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20.0,
                                                  color: Color(0xFFFF6F67)),
                                            ),
                                      )
                                    ],
                                  ),
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
                              items: List.generate(
                                  staffInteractionComposeController
                                      .getDetailList.length, (index) {
                                return DropdownMenuItem(
                                  value: staffInteractionComposeController
                                      .getDetailList
                                      .elementAt(index),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 6, left: 5),
                                    child: Text(
                                      staffInteractionComposeController
                                                  .selectedradio.value ==
                                              'Student'
                                          ? staffInteractionComposeController
                                              .getDetailList
                                              .elementAt(index)
                                              .asmclClassName!
                                          : staffInteractionComposeController
                                                      .selectedradio.value ==
                                                  'EC'
                                              ? staffInteractionComposeController
                                                  .getDetailList
                                                  .elementAt(index)
                                                  .examCoordinatorName!
                                              : staffInteractionComposeController
                                                  .getDetailList
                                                  .elementAt(index)
                                                  .empName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0,
                                              letterSpacing: 0.3)),
                                    ),
                                  ),
                                );
                              }),
                              onChanged: (s) {
                                selectedInitialDropdown = s!;
                                if (staffInteractionComposeController
                                        .selectedradio.value ==
                                    'Student') {
                                  selectedstudent = null;
                                  selectedsection = null;
                                  getSectionData(s.asmclId!);
                                  setState(() {});
                                }
                              },
                            ),
                          )
                : const SizedBox(),
            staffInteractionComposeController.selectedradio.value ==
                        'Student' &&
                    selectedInitialDropdown != null
                ? staffInteractionComposeController.isSection.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<
                            InteractionSectionListValue>(
                          value: selectedsection,
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
                            isDense: true,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            hintText: 'select section',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFDBFDF5),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/section_.svg",
                                    height: 24.0,
                                    color: const Color(0xFF47BA9E),
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    " Section ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(
                                          const TextStyle(
                                              fontSize: 20.0,
                                              color: Color(0xFF47BA9E)),
                                        ),
                                  ),
                                ],
                              ),
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
                          items: List.generate(
                              staffInteractionComposeController
                                  .interactionSectionList.length, (index) {
                            return DropdownMenuItem(
                              value: staffInteractionComposeController
                                  .interactionSectionList
                                  .elementAt(index),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6, left: 5),
                                child: Text(
                                  staffInteractionComposeController
                                      .interactionSectionList
                                      .elementAt(index)
                                      .asmCSectionName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) {
                            selectedsection = s!;
                            selectedstudent = null;
                            getStudentData(s.asmSId!);
                            setState(() {});
                          },
                        ),
                      )
                : const SizedBox(),
            staffInteractionComposeController.selectedradio.value ==
                        'Student' &&
                    selectedInitialDropdown != null &&
                    selectedsection != null &&
                    staffInteractionComposeController.grpOrInd.value ==
                        'Individual'
                ? staffInteractionComposeController.isStudent.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<GetStudentValue>(
                          value: selectedstudent,
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
                            isDense: true,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            hintText: 'select',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 4),
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(229, 243, 255, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/selectteachericon.png',
                                    height: 26,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Select Student',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0,
                                            color:
                                                Color.fromRGBO(60, 120, 170, 1),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
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
                          items: List.generate(
                            staffInteractionComposeController
                                .studentList.length,
                            (index) {
                              return DropdownMenuItem(
                                value: staffInteractionComposeController
                                    .studentList
                                    .elementAt(index),
                                child: Text(
                                  staffInteractionComposeController.studentList
                                      .elementAt(index)
                                      .studentName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3)),
                                ),
                              );
                            },
                          ),
                          onChanged: (s) {
                            selectedstudent = s!;
                          },
                        ),
                      )
                : const SizedBox(),
            staffInteractionComposeController.selectedradio.value ==
                        'Student' &&
                    selectedInitialDropdown != null &&
                    selectedsection != null &&
                    staffInteractionComposeController.grpOrInd.value == 'Group'
                ? staffInteractionComposeController.isStudent.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 200,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            padding: const EdgeInsets.only(top: 5, bottom: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                              child: SizedBox(
                                height: 200,
                                child: SingleChildScrollView(
                                  controller: _controller,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          checkboxShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          dense: true,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                          visualDensity: const VisualDensity(
                                              horizontal: -4.0),
                                          title: Text(
                                            'Select all',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .merge(const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.3)),
                                          ),
                                          value: selectAll.value,
                                          onChanged: (value) {
                                            selectAll.value = value!;

                                            if (value) {
                                              arrayStudents.clear();
                                              for (var i = 0;
                                                  i <
                                                      staffInteractionComposeController
                                                          .studentList.length;
                                                  i++) {
                                                arrayStudents.add({
                                                  "AMST_Id":
                                                      staffInteractionComposeController
                                                          .studentList
                                                          .elementAt(i)
                                                          .amstId
                                                });
                                              }
                                              logger.d(arrayStudents);
                                              return;
                                            }
                                            arrayStudents.clear();
                                            logger.d(arrayStudents);
                                          },
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: ListView.builder(
                                      //     shrinkWrap: true,
                                      //     controller: _controller,
                                      //     itemCount:
                                      //         staffInteractionComposeController
                                      //             .studentList.length,
                                      //     itemBuilder: (context, index) {
                                      //       return StudentListWidget(
                                      //         data:
                                      //             staffInteractionComposeController
                                      //                 .studentList
                                      //                 .elementAt(index),
                                      //         function: addStudentInList,
                                      //         function1: removeFromStudentInList,
                                      //         selectAll: selectAll.value,
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
                                      Column(
                                        children: List.generate(
                                            staffInteractionComposeController
                                                .studentList.length, (index) {
                                          return StudentListWidget(
                                            data:
                                                staffInteractionComposeController
                                                    .studentList
                                                    .elementAt(index),
                                            function: addStudentInList,
                                            function1: removeFromStudentInList,
                                            selectAll: selectAll.value,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -8,
                            left: 30,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(229, 243, 255, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/selectteachericon.png',
                                    height: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Select Student',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.0,
                                            color:
                                                Color.fromRGBO(60, 120, 170, 1),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AttachmentFileWidget(
                  staffInteractionComposeController:
                      staffInteractionComposeController,
                  login: 'staff'),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  if (subject.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Enter Subject');
                  } else if (about.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Enter About');
                  } else if (staffInteractionComposeController
                      .selectedradio.value.isEmpty) {
                    Fluttertoast.showToast(msg: 'Select Staff');
                  } else if (staffInteractionComposeController.grpOrInd.value ==
                          'Individual' &&
                      selectedInitialDropdown == null) {
                    if (staffInteractionComposeController.selectedradio.value ==
                        'Student') {
                      Fluttertoast.showToast(msg: 'Select class');
                    } else {
                      Fluttertoast.showToast(msg: 'Select staff');
                    }
                  } else if (staffInteractionComposeController.grpOrInd.value == 'Group' &&
                      staffInteractionComposeController.selectedradio.value !=
                          'Student' &&
                      arrayTeachers.isEmpty) {
                    Fluttertoast.showToast(msg: 'Select staff.');
                  } else if (staffInteractionComposeController
                              .selectedradio.value ==
                          'Student' &&
                      selectedsection == null) {
                    Fluttertoast.showToast(msg: 'Select section');
                  } else if (staffInteractionComposeController
                              .selectedradio.value ==
                          'Student' &&
                      staffInteractionComposeController.grpOrInd.value ==
                          'Group' &&
                      arrayStudents.isEmpty) {
                    Fluttertoast.showToast(msg: 'Select student');

                    if (staffInteractionComposeController.grpOrInd.value ==
                            'Individual' &&
                        selectedstudent == null) {
                      Fluttertoast.showToast(msg: 'Select student');
                    }
                  } else if (staffInteractionComposeController.grpOrInd.value ==
                          'Group' &&
                      staffInteractionComposeController.selectedradio.value ==
                          'Student') {
                    staffInteractionComposeController.issubmitloading(true);
                    if (staffInteractionComposeController.attFiles.isNotEmpty) {
                      await documentToNetworkUrl(
                          staffInteractionComposeController
                              .attFiles.first.path!);
                    }
                    if (staffInteractionComposeController
                        .attachment.isNotEmpty) {
                      await documentToNetworkUrl(
                          staffInteractionComposeController
                              .attachment.first!.path);
                    }
                    logger.d(attachment);
                    await submitComposeStaff(
                      data: {
                        "ASMAY_Id": widget.loginSuccessModel.asmaYId!,
                        "ISMINT_ComposedByFlg":
                            widget.loginSuccessModel.roleforlogin!,
                        "ISMINT_GroupOrIndFlg":
                            staffInteractionComposeController.grpOrInd.value,
                        "ISMINT_Interaction": about.text,
                        "ISMINT_Subject": subject.text,
                        "mI_ID": widget.loginSuccessModel.mIID!,
                        "arrayStudent": arrayStudents,
                        "roleflg": widget.loginSuccessModel.roleforlogin!,
                        "userflag": staffInteractionComposeController
                            .selectedradio.value,
                        "userId": widget.loginSuccessModel.userId!.toString(),
                        "images_paths": attachment.isNotEmpty ? attachment : "",
                      },
                      base: baseUrlFromInsCode(
                        'portal',
                        widget.mskoolController,
                      ),
                    ).then((value) {
                      changeTabAfterCompose(value);
                    });
                    staffInteractionComposeController.issubmitloading(false);
                  } else if (staffInteractionComposeController.grpOrInd.value ==
                          'Group' &&
                      staffInteractionComposeController.selectedradio.value !=
                          'Student') {
                    staffInteractionComposeController.issubmitloading(true);
                    if (staffInteractionComposeController.attFiles.isNotEmpty) {
                      await documentToNetworkUrl(
                          staffInteractionComposeController
                              .attFiles.first.path!);
                    }
                    if (staffInteractionComposeController
                        .attachment.isNotEmpty) {
                      await documentToNetworkUrl(
                          staffInteractionComposeController
                              .attachment.first!.path);
                    }
                    logger.d(attachment);
                    await submitComposeStaff(
                      data: {
                        "ASMAY_Id": widget.loginSuccessModel.asmaYId!,
                        "ISMINT_ComposedByFlg":
                            widget.loginSuccessModel.roleforlogin!,
                        "ISMINT_GroupOrIndFlg":
                            staffInteractionComposeController.grpOrInd.value,
                        "ISMINT_Interaction": about.text,
                        "ISMINT_Subject": subject.text,
                        "mI_ID": widget.loginSuccessModel.mIID!,
                        "arrayTeachers": arrayTeachers,
                        "roleflg": widget.loginSuccessModel.roleforlogin!,
                        "userflag": staffInteractionComposeController
                            .selectedradio.value,
                        "userId": widget.loginSuccessModel.userId!.toString(),
                        "images_paths": attachment.isNotEmpty ? attachment : ""
                      },
                      base: baseUrlFromInsCode(
                        'portal',
                        widget.mskoolController,
                      ),
                    ).then((value) {
                      changeTabAfterCompose(value);
                    });
                    staffInteractionComposeController.issubmitloading(false);
                  } else if (staffInteractionComposeController.grpOrInd.value ==
                          'Individual' &&
                      staffInteractionComposeController.selectedradio.value ==
                          'Student') {
                    staffInteractionComposeController.issubmitloading(true);
                    if (staffInteractionComposeController.attFiles.isNotEmpty) {
                      await documentToNetworkUrl(
                          staffInteractionComposeController
                              .attFiles.first.path!);
                    }
                    if (staffInteractionComposeController
                        .attachment.isNotEmpty) {
                      await documentToNetworkUrl(
                          staffInteractionComposeController
                              .attachment.first!.path);
                    }
                    logger.d(attachment);
                    await submitComposeStaff(
                      data: {
                        "ASMAY_Id": widget.loginSuccessModel.asmaYId!,
                        "ISMINT_ComposedByFlg":
                            widget.loginSuccessModel.roleforlogin!,
                        "ISMINT_GroupOrIndFlg":
                            staffInteractionComposeController.grpOrInd.value,
                        "ISMINT_Interaction": about.text,
                        "ISMINT_Subject": subject.text,
                        "mI_ID": widget.loginSuccessModel.mIID!,
                        "student_Id": selectedstudent!.amstId,
                        "roleflg": widget.loginSuccessModel.roleforlogin!,
                        "userflag": staffInteractionComposeController
                            .selectedradio.value,
                        "userId": widget.loginSuccessModel.userId!.toString(),
                        "images_paths": attachment.isNotEmpty ? attachment : ""
                      },
                      base: baseUrlFromInsCode(
                        'portal',
                        widget.mskoolController,
                      ),
                    ).then((value) {
                      changeTabAfterCompose(value);
                    });
                    staffInteractionComposeController.issubmitloading(false);
                  } else {
                    staffInteractionComposeController.issubmitloading(true);
                    if (staffInteractionComposeController.attFiles.isNotEmpty) {
                      await documentToNetworkUrl(
                          staffInteractionComposeController
                              .attFiles.first.path!);
                    }
                    if (staffInteractionComposeController
                        .attachment.isNotEmpty) {
                      await documentToNetworkUrl(
                          staffInteractionComposeController
                              .attachment.first!.path);
                    }
                    logger.d(attachment);
                    await submitComposeStaff(
                      data: {
                        "ASMAY_Id": widget.loginSuccessModel.asmaYId!,
                        "ISMINT_ComposedByFlg":
                            widget.loginSuccessModel.roleforlogin!,
                        "ISMINT_GroupOrIndFlg":
                            staffInteractionComposeController.grpOrInd.value,
                        "ISMINT_Interaction": about.text,
                        "ISMINT_Subject": subject.text,
                        "mI_ID": widget.loginSuccessModel.mIID!,
                        "employee_Id": staffInteractionComposeController
                                        .selectedradio.value ==
                                    'EC' ||
                                staffInteractionComposeController
                                        .selectedradio.value ==
                                    'Principal'
                            ? selectedInitialDropdown!.id
                            : selectedInitialDropdown!.iD,
                        "roleflg": widget.loginSuccessModel.roleforlogin!,
                        "userflag": staffInteractionComposeController
                            .selectedradio.value,
                        "userId": widget.loginSuccessModel.userId!.toString(),
                        "images_paths": attachment.isNotEmpty ? attachment : ""
                      },
                      base: baseUrlFromInsCode(
                        'portal',
                        widget.mskoolController,
                      ),
                    ).then((value) {
                      changeTabAfterCompose(value);
                    });
                    staffInteractionComposeController.issubmitloading(false);
                  }
                },
                child: staffInteractionComposeController.isSubmit.value
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Submit',
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.3,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
