import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/staffs/marks_entry/controller/marks_entry_related_controller.dart';
import 'package:m_skool_flutter/staffs/marks_entry/model/academicyearmodel.dart';
import 'package:m_skool_flutter/staffs/marks_entry/model/classdropdownmodel.dart';
import 'package:m_skool_flutter/staffs/marks_entry/model/examdropdownmodel.dart';
import 'package:m_skool_flutter/staffs/marks_entry/model/sectiondropdownmodel.dart';
import 'package:m_skool_flutter/staffs/marks_entry/model/subexamlist.dart';
import 'package:m_skool_flutter/staffs/marks_entry/model/subjectdropdownmodel.dart';
import 'package:m_skool_flutter/staffs/marks_entry/model/subsubjectdropdownmodel.dart';
import 'package:m_skool_flutter/staffs/marks_entry/screen/marks_entry_detail_screen.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:video_player/video_player.dart';

import '../../../controller/mskoll_controller.dart';
import '../../../model/login_success_model.dart';
import '../../../widget/custom_back_btn.dart';

class MarksEntryHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const MarksEntryHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<MarksEntryHome> createState() => _MarksEntryHomeState();
}

class _MarksEntryHomeState extends State<MarksEntryHome> {
  final MarksEntryController marksEntryController =
      Get.put(MarksEntryController());

  final VideoPlayerController controller =
      VideoPlayerController.asset("assets/video/marksentry_illustration.mp4");

  AcdlistClassValue? selectedAcademicYear;
  CtlistValue? selectedClass;
  SeclistValue? selectedSection;
  ExamlistValue? selectedExam;
  SubjectlistValue? selectedSubjectName;
  SubsubjectlistValue? selectedSubSubject;
  SubExamListValues? selectedSubExam;

  void getAcademicYear() async {
    marksEntryController.isacademicyearloading(true);
    marksEntryController.classList.clear();
    marksEntryController.sectionList.clear();
    marksEntryController.examList.clear();
    marksEntryController.subjectNameList.clear();
    // marksEntryController.subExamList.clear();
    await marksEntryController
        .getacademicyear(
      miId: widget.loginSuccessModel.mIID!,
      userId: widget.loginSuccessModel.userId!,
      roleId: widget.loginSuccessModel.roleId!,
      base: baseUrlFromInsCode(
        'exam',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (value) {
        if (marksEntryController.academicYearList.isNotEmpty) {
          selectedAcademicYear = marksEntryController.academicYearList.first;
          getClass(selectedAcademicYear!.asmaYId!.toInt());
        }
      }
    });
    marksEntryController.isacademicyearloading(false);
  }

  void getClass(int asmayId) async {
    marksEntryController.isclassloading(true);
    marksEntryController.sectionList.clear();
    marksEntryController.examList.clear();
    marksEntryController.subjectNameList.clear();
    // marksEntryController.subExamList.clear();
    await marksEntryController
        .getclass(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: asmayId,
      userId: widget.loginSuccessModel.userId!,
      base: baseUrlFromInsCode(
        'exam',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (value) {
        if (marksEntryController.classList.isNotEmpty) {
          selectedClass = marksEntryController.classList.first;
          getSection(selectedClass!.asmcLId!.toInt());
        }
      }
    });
    marksEntryController.isclassloading(false);
  }

  void getSection(int asmclId) async {
    marksEntryController.issectionloading(true);
    marksEntryController.examList.clear();
    marksEntryController.subjectNameList.clear();
    // marksEntryController.subExamList.clear();

    await marksEntryController
        .getsection(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      userId: widget.loginSuccessModel.userId!,
      asmclId: asmclId,
      base: baseUrlFromInsCode('exam', widget.mskoolController),
    )
        .then((value) {
      if (value) {
        if (marksEntryController.sectionList.isNotEmpty) {
          selectedSection = marksEntryController.sectionList.first;
          getExam(selectedSection!.asmSId!.toInt());
        }
      }
    });
    marksEntryController.issectionloading(false);
  }

  void getExam(int asmsId) async {
    marksEntryController.isexamloading(true);
    marksEntryController.subjectNameList.clear();
    // marksEntryController.subExamList.clear();

    await marksEntryController
        .getexam(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      asmclId: selectedClass!.asmcLId!.toInt(),
      asmsId: asmsId,
      base: baseUrlFromInsCode('exam', widget.mskoolController),
    )
        .then((value) {
      if (value) {
        if (marksEntryController.examList.isNotEmpty) {
          selectedExam = marksEntryController.examList.first;
          getSubject(selectedExam!.emEId!.toInt());
        }
      }
    });
    marksEntryController.isexamloading(false);
  }

  void getSubject(int emeId) async {
    marksEntryController.issubjectloading(true);

    await marksEntryController
        .getsubjectname(
      miId: widget.loginSuccessModel.mIID!,
      userId: widget.loginSuccessModel.userId!,
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      asmclId: selectedClass!.asmcLId!.toInt(),
      asmsId: selectedSection!.asmSId!.toInt(),
      amstId: widget.loginSuccessModel.amsTId!,
      emeId: emeId,
      base: baseUrlFromInsCode('exam', widget.mskoolController),
    )
        .then((value) {
      if (value) {
        if (marksEntryController.subjectNameList.isNotEmpty) {
          selectedSubjectName = marksEntryController.subjectNameList.first;
          getSubSubject(selectedSubjectName!.ismSId!.toInt());
        }
      }
    });
    marksEntryController.issubjectloading(false);
  }

  void getSubSubject(int ismsId) async {
    marksEntryController.issubsubjectloading(true);
    // marksEntryController.subExamList.clear();
    await marksEntryController
        .getSubSubject(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      asmclId: selectedClass!.asmcLId!.toInt(),
      asmsId: selectedSection!.asmSId!.toInt(),
      amstId: widget.loginSuccessModel.amsTId!,
      emeId: selectedExam!.emEId!.toInt(),
      userId: widget.loginSuccessModel.userId!,
      ismsId: ismsId,
      base: baseUrlFromInsCode(
        'exam',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (value) {
        if (marksEntryController.subSubjectList.isNotEmpty) {
          selectedSubSubject = marksEntryController.subSubjectList.first;
          marksEntryController.updateIsSelceted(false);
        }
        if (marksEntryController.subExamList.isNotEmpty) {
          selectedSubExam = marksEntryController.subExamList.first;
        }
      }
    });
    marksEntryController.issubsubjectloading(false);
  }

  @override
  void initState() {
    // controller.initialize().then((value) {

    //   controller.play();
    //   controller.setLooping(true);
    // });
    getAcademicYear();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 25,
        title: const Text('Marks Entry'),
      ),
      floatingActionButton: const HomeFab(),
      //  StaffHomeFab(
      //   loginSuccessModel: widget.loginSuccessModel,
      //   mskoolController: widget.mskoolController,
      // ),
      body: Obx(
        () => marksEntryController.isAcamedicYear.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Marks Entry",
                    desc:
                        "Please wait while we load marks entry and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : marksEntryController.academicYearList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 36.0,
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 36.0,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          'Something went wrong',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                const TextStyle(fontSize: 20.0),
                              ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Unable to load data try after some time.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .merge(const TextStyle(letterSpacing: 0.2)),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 40, left: 16, right: 16, bottom: 16),
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
                          child: DropdownButtonFormField<AcdlistClassValue>(
                            value: selectedAcademicYear,
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
                              hintText: marksEntryController
                                      .academicYearList.isNotEmpty
                                  ? 'select year'
                                  : "No data available",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              label: const CustomDropDownLabel(
                                icon: 'assets/images/hat.png',
                                containerColor:
                                    Color.fromRGBO(223, 251, 254, 1),
                                text: 'Academic Year',
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
                            items: List.generate(
                                marksEntryController.academicYearList.length,
                                (index) {
                              return DropdownMenuItem(
                                value: marksEntryController
                                    .academicYearList[index],
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 13, left: 5),
                                  child: Text(
                                    marksEntryController.academicYearList
                                        .elementAt(index)
                                        .asmaYYear!,
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
                              selectedAcademicYear = s!;
                              marksEntryController.subSubjectList.clear();
                              marksEntryController.subExamList.clear();
                              selectedSubSubject = null;
                              selectedSubExam = null;
                              getClass(s.asmaYId!.toInt());
                            },
                          ),
                        ),
                        marksEntryController.isClass.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : marksEntryController.academicYearList.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 8,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child: DropdownButtonFormField<CtlistValue>(
                                      value: selectedClass,
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
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3)),
                                        hintText: marksEntryController
                                                .classList.isNotEmpty
                                            ? 'select class'
                                            : "No data available",
                                        label: const CustomDropDownLabel(
                                          icon: 'assets/images/classnew.png',
                                          containerColor:
                                              Color.fromRGBO(255, 235, 234, 1),
                                          text: 'Class',
                                          textColor:
                                              Color.fromRGBO(255, 111, 103, 1),
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
                                          marksEntryController.classList.length,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: marksEntryController
                                              .classList[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 5),
                                            child: Text(
                                              marksEntryController.classList
                                                  .elementAt(index)
                                                  .asmcLClassName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .merge(const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.3)),
                                            ),
                                          ),
                                        );
                                      }),
                                      onChanged: (s) {
                                        selectedClass = s!;
                                        marksEntryController.subSubjectList
                                            .clear();
                                        marksEntryController.subExamList
                                            .clear();
                                        selectedSubSubject = null;
                                        selectedSubExam = null;
                                        getSection(s.asmcLId!.toInt());
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                        marksEntryController.isSection.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : marksEntryController.classList.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 8,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child:
                                        DropdownButtonFormField<SeclistValue>(
                                      value: selectedSection,
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
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3)),
                                        hintText: marksEntryController
                                                .sectionList.isNotEmpty
                                            ? 'select section'
                                            : "No data available",
                                        label: const CustomDropDownLabel(
                                          icon: 'assets/images/sectionnew.png',
                                          containerColor:
                                              Color.fromRGBO(219, 253, 245, 1),
                                          text: 'Section',
                                          textColor:
                                              Color.fromRGBO(71, 186, 158, 1),
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
                                          marksEntryController
                                              .sectionList.length, (index) {
                                        return DropdownMenuItem(
                                          value: marksEntryController
                                              .sectionList[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 5),
                                            child: Text(
                                              marksEntryController.sectionList
                                                  .elementAt(index)
                                                  .asmCSectionName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .merge(const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.3)),
                                            ),
                                          ),
                                        );
                                      }),
                                      onChanged: (s) {
                                        selectedSection = s!;
                                        marksEntryController.subSubjectList
                                            .clear();
                                        marksEntryController.subExamList
                                            .clear();
                                        selectedSubSubject = null;
                                        selectedSubExam = null;
                                        getExam(s.asmSId!.toInt());
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                        marksEntryController.isExam.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : marksEntryController.sectionList.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 8,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child:
                                        DropdownButtonFormField<ExamlistValue>(
                                      value: selectedExam,
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
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3)),
                                        hintText: marksEntryController
                                                .examList.isNotEmpty
                                            ? 'select exam'
                                            : "No data available",
                                        label: const CustomDropDownLabel(
                                          icon: 'assets/images/examnew.png',
                                          containerColor:
                                              Color.fromRGBO(229, 243, 255, 1),
                                          text: 'Exam',
                                          textColor:
                                              Color.fromRGBO(62, 120, 170, 1),
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
                                          marksEntryController.examList.length,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: marksEntryController
                                              .examList[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 5),
                                            child: Text(
                                              marksEntryController.examList
                                                  .elementAt(index)
                                                  .emEExamName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .merge(const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.3)),
                                            ),
                                          ),
                                        );
                                      }),
                                      onChanged: (s) {
                                        selectedExam = s!;
                                        marksEntryController.subSubjectList
                                            .clear();
                                        marksEntryController.subExamList
                                            .clear();
                                        selectedSubSubject = null;
                                        selectedSubExam = null;
                                        getSubject(s.emEId!.toInt());
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                        marksEntryController.isSubject.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : marksEntryController.examList.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
                                        SubjectlistValue>(
                                      value: selectedSubjectName,
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
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3)),
                                        hintText: marksEntryController
                                                .subjectNameList.isNotEmpty
                                            ? 'select subject'
                                            : "No data available",
                                        label: const CustomDropDownLabel(
                                          icon: 'assets/images/subname.png',
                                          containerColor:
                                              Color.fromRGBO(238, 232, 255, 1),
                                          text: 'Subject Name',
                                          textColor:
                                              Color.fromRGBO(111, 88, 180, 1),
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
                                          marksEntryController
                                              .subjectNameList.length, (index) {
                                        return DropdownMenuItem(
                                          value: marksEntryController
                                              .subjectNameList[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 5),
                                            child: Text(
                                              marksEntryController
                                                  .subjectNameList
                                                  .elementAt(index)
                                                  .ismSSubjectName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .merge(const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.3)),
                                            ),
                                          ),
                                        );
                                      }),
                                      onChanged: (s) {
                                        selectedSubjectName = s!;
                                        marksEntryController.subSubjectList
                                            .clear();
                                        marksEntryController.subExamList
                                            .clear();
                                        selectedSubSubject = null;
                                        selectedSubExam = null;
                                        marksEntryController
                                            .updateIsSelceted(true);

                                        getSubSubject(s.ismSId!.toInt());
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                        Obx(() {
                          return marksEntryController.isSubSubject.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Column(
                                  children: [
                                    marksEntryController
                                            .subSubjectList.isNotEmpty
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(0, 1),
                                                  blurRadius: 8,
                                                  color: Colors.black12,
                                                ),
                                              ],
                                            ),
                                            child: DropdownButtonFormField<
                                                SubsubjectlistValue>(
                                              //   value: selectedSubSubject,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                isDense: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3)),
                                                hintText: marksEntryController
                                                        .subSubjectList
                                                        .isNotEmpty
                                                    ? 'select sub subject'
                                                    : "No data available",
                                                label:
                                                    const CustomDropDownLabel(
                                                  icon:
                                                      'assets/images/subsubject.png',
                                                  containerColor:
                                                      Color.fromRGBO(
                                                          252, 244, 222, 1),
                                                  text: 'Sub Subject',
                                                  textColor: Color.fromRGBO(
                                                      206, 167, 61, 1),
                                                ),
                                              ),
                                              icon: const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 3),
                                                child: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  size: 30,
                                                ),
                                              ),
                                              iconSize: 30,
                                              items: List.generate(
                                                  marksEntryController
                                                      .subSubjectList
                                                      .length, (index) {
                                                return DropdownMenuItem(
                                                  value: marksEntryController
                                                      .subSubjectList[index],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 13, left: 5),
                                                    child: Text(
                                                      marksEntryController
                                                              .subSubjectList
                                                              .elementAt(index)
                                                              .emsSSubSubjectName ??
                                                          "N/a",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .merge(
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.3)),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              onChanged: (s) {
                                                selectedSubSubject = s!;
                                                marksEntryController
                                                    .updateIsSelceted(true);
                                              },
                                            ),
                                          )
                                        : const SizedBox(),
                                    marksEntryController.subExamList.isNotEmpty
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(0, 1),
                                                  blurRadius: 8,
                                                  color: Colors.black12,
                                                ),
                                              ],
                                            ),
                                            child: DropdownButtonFormField<
                                                SubExamListValues>(
                                              value: selectedSubExam,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                                isDense: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .merge(const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.3)),
                                                hintText: marksEntryController
                                                        .subExamList.isNotEmpty
                                                    ? 'Select sub exam'
                                                    : "No data available",
                                                label:
                                                    const CustomDropDownLabel(
                                                  icon:
                                                      'assets/images/subsubject.png',
                                                  containerColor:
                                                      Color.fromRGBO(
                                                          252, 244, 222, 1),
                                                  text: 'Sub Exam',
                                                  textColor: Color.fromRGBO(
                                                      206, 167, 61, 1),
                                                ),
                                              ),
                                              icon: const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 3),
                                                child: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  size: 30,
                                                ),
                                              ),
                                              iconSize: 30,
                                              items: List.generate(
                                                  marksEntryController
                                                      .subExamList
                                                      .length, (index) {
                                                return DropdownMenuItem(
                                                  value: marksEntryController
                                                      .subExamList[index],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 13, left: 5),
                                                    child: Text(
                                                      marksEntryController
                                                              .subExamList
                                                              .elementAt(index)
                                                              .emsESubExamName ??
                                                          "N/a",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .merge(
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.3)),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              onChanged: (s) {
                                                selectedSubExam = s!;
                                              },
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                );
                        }),
                        const SizedBox(height: 20),
                        MSkollBtn(
                          title: 'View Details',
                          onPress: marksEntryController
                                      .academicYearList.isNotEmpty &&
                                  marksEntryController.classList.isNotEmpty &&
                                  marksEntryController.sectionList.isNotEmpty &&
                                  marksEntryController.examList.isNotEmpty &&
                                  marksEntryController
                                      .subjectNameList.isNotEmpty
                              ? () {
                                  if (marksEntryController.isSelected.value) {
                                    Get.to(() => MarksEntryDetailScreen(
                                          loginSuccessModel:
                                              widget.loginSuccessModel,
                                          mskoolController:
                                              widget.mskoolController,
                                          asmayId: selectedAcademicYear!
                                              .asmaYId!
                                              .toInt(),
                                          asmclId:
                                              selectedClass!.asmcLId!.toInt(),
                                          asmsId:
                                              selectedSection!.asmSId!.toInt(),
                                          emeId: selectedExam!.emEId!.toInt(),
                                          ismsId: selectedSubjectName!.ismSId!
                                              .toInt(),
                                          emssId: selectedSubSubject == null
                                              ? 0
                                              : selectedSubSubject!.emsSId!
                                                  .toInt(),
                                          emseId: selectedSubExam == null
                                              ? 0
                                              : selectedSubExam!.emsEId ?? 0,
                                        ));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Select sub subject');
                                  }
                                }
                              : () {
                                  Fluttertoast.showToast(
                                      msg: 'Select all fields..');
                                },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            height: 200,
                            child: AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: VideoPlayer(controller),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
