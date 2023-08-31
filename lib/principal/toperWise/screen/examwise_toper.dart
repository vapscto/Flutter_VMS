import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/Principal/toperWise/api/toper_academic_year.dart';
import 'package:m_skool_flutter/Principal/toperWise/api/toper_result_api.dart';
import 'package:m_skool_flutter/Principal/toperWise/controller/examwise_toper_home_controller.dart';
import 'package:m_skool_flutter/Principal/toperWise/controller/toper_wise_result.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/academic_year_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/exam_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/section_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/subject_list_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/model/top_class_model.dart';
import 'package:m_skool_flutter/Principal/toperWise/screen/toper_list_show.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class ClasswiseTopper extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ClasswiseTopper(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});
  @override
  State<ClasswiseTopper> createState() => _ClasswiseTopperState();
}

class _ClasswiseTopperState extends State<ClasswiseTopper> {
  String? year_asmayId;
  String? class_asmclId;
  int? section_asmsId;
  String? exam_emeId;
  int? subject_ismsId = 0;
  int sub_check_type = 0;
  ExamWiseToperController controller = Get.put(ExamWiseToperController());
  ToperWiseController marksEntryController = Get.put(ToperWiseController());
  TextEditingController editTextController = TextEditingController();
  @override
  void initState() {
    loadApi();
    super.initState();
  }

  void loadApi() async {
    await featchAcademic(
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode("exam", widget.mskoolController),
        controller: controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Toper wise list").getAppBar(),
        floatingActionButton: const HomeFab(),
        body: Obx(() {
          return controller.isLoadingCategory.isTrue
                  ? const AnimatedProgressWidget(
                      animationPath: 'assets/json/default.json',
                      title: 'Loading data',
                      desc: "Please wait we are loading data",
                    )
                  : Obx(
                      () {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 8,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                child: DropdownButtonFormField<
                                    AcademicListModelValues>(
                                  value: controller.selectedAcademicYear,
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
                                    hintText:
                                        controller.academicYearTop.isNotEmpty
                                            ? 'Select Year'
                                            : "No data available.",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDFFBFE),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/images/cap.png",
                                            height: 28.0,
                                          ),
                                          const SizedBox(
                                            width: 12.0,
                                          ),
                                          Text(
                                            "Academic Year",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(const TextStyle(
                                                    backgroundColor:
                                                        Color(0xFFDFFBFE),
                                                    fontSize: 20,
                                                    color: Color(0xFF28B6C8))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 30,
                                    ),
                                  ),
                                  iconSize: 30,
                                  items: List.generate(
                                      controller.academicYearTop.length,
                                      (index) {
                                    return DropdownMenuItem(
                                      value: controller.academicYearTop[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0, left: 8, right: 8),
                                        child: Text(
                                          controller.academicYearTop[index]
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
                                    year_asmayId = s!.asmaYId!.toString();
                                  },
                                ),
                              ),
                              // Class Dropdown
                              const SizedBox(
                                height: 30,
                              ),
                              Obx(() => Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 8,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child: DropdownButtonFormField<
                                        TopClassListModelValues>(
                                      //  value: controller.selectedClass,
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
                                        hintText: controller.classTop.isNotEmpty
                                            ? 'Select Class'
                                            : "No data available.",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                255, 235, 234, 1),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 6.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/classnew.png",
                                                height: 28.0,
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Text(
                                                "Select Class",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(const TextStyle(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              255, 235, 234, 1),
                                                      fontSize: 20,
                                                      color: Color.fromRGBO(
                                                          255, 111, 103, 1),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      icon: const Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 30,
                                        ),
                                      ),
                                      iconSize: 30,
                                      items: List.generate(
                                          controller.classTop.length, (index) {
                                        return DropdownMenuItem(
                                          value: controller.classTop[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0, left: 8, right: 8),
                                            child: Text(
                                              controller.classTop[index]
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
                                        class_asmclId = s!.asmcLId!.toString();
                                      },
                                    ),
                                  )),
                              // Section Dropdown
                              const SizedBox(
                                height: 30,
                              ),
                              Obx(() => Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 8,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child: DropdownButtonFormField<
                                        TopSectonListModelValues>(
                                      // value: controller.selectedSection,
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
                                        hintText:
                                            controller.sectionTop.isNotEmpty
                                                ? 'Select Section'
                                                : "No data available.",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                219, 253, 245, 1),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 6.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/sectionnew.png",
                                                height: 28.0,
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Text(
                                                "Select Section",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(const TextStyle(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              219, 253, 245, 1),
                                                      fontSize: 20,
                                                      color: Color.fromRGBO(
                                                          71, 186, 158, 1),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      icon: const Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 30,
                                        ),
                                      ),
                                      iconSize: 30,
                                      items: List.generate(
                                          controller.sectionTop.length,
                                          (index) {
                                        return DropdownMenuItem(
                                          value: controller.sectionTop[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0, left: 8, right: 8),
                                            child: Text(
                                              controller.sectionTop[index]
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
                                        section_asmsId = s!.asmSId!;
                                      },
                                    ),
                                  )),
                              // Exam drop down
                              const SizedBox(
                                height: 30,
                              ),
                              Obx(() => Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 8,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child: DropdownButtonFormField<
                                        TopExamListModelValues>(
                                      //  value: controller.selectedExam,
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
                                        hintText: controller.examTop.isNotEmpty
                                            ? 'Select Exam'
                                            : "No data available.",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                245, 248, 197, 1),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 6.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/examnew.png",
                                                height: 28.0,
                                                color: const Color.fromRGBO(
                                                    241, 207, 52, 1),
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Text(
                                                "Select Exam",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(const TextStyle(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              245, 248, 197, 1),
                                                      fontSize: 20,
                                                      color: Color.fromRGBO(
                                                          241, 207, 52, 1),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      icon: const Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 30,
                                        ),
                                      ),
                                      iconSize: 30,
                                      items: List.generate(
                                          controller.examTop.length, (index) {
                                        return DropdownMenuItem(
                                          value: controller.examTop[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0, left: 8, right: 8),
                                            child: Text(
                                              controller
                                                  .examTop[index].emEExamName!,
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
                                        exam_emeId = s!.emEId!.toString();
                                      },
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              // subject drop down
                              SizedBox(
                                  height: 40,
                                  child: Obx(() {
                                    return CheckboxListTile(
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
                                      visualDensity:
                                          const VisualDensity(horizontal: -4.0),
                                      title: Text(
                                        "Subject wise",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3)),
                                      ),
                                      value: controller.selectSubjectWise.value,
                                      onChanged: (bool? value) {
                                        controller.selectSubjectWise.value =
                                            value!;
                                        value == true
                                            ? sub_check_type = 1
                                            : sub_check_type = 0;
                                      },
                                    );
                                  })),
                              SizedBox(
                                height: 30,
                              ),
                              Obx(
                                () => controller.selectSubjectWise.value == true
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 10),
                                              blurRadius: 8,
                                              color: Colors.black12,
                                            ),
                                          ],
                                        ),
                                        child: DropdownButtonFormField<
                                            TopSubjectListModelValues>(
                                        value: controller.selectedExamSubject,
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
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .merge(const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.3)),
                                            hintText:
                                                controller.subjectTop.isNotEmpty
                                                    ? 'Select Subject'
                                                    : "No data available.",
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            label: Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    186, 195, 241, 0.98),
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 6.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/subname.png",
                                                    height: 28.0,
                                                    color: const Color.fromRGBO(
                                                        71, 52, 241, 1),
                                                  ),
                                                  const SizedBox(
                                                    width: 12.0,
                                                  ),
                                                  Text(
                                                    "Select subject",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .merge(const TextStyle(
                                                          backgroundColor:
                                                              Color.fromRGBO(
                                                                  186,
                                                                  195,
                                                                  241,
                                                                  0.98),
                                                          fontSize: 20,
                                                          color: Color.fromRGBO(
                                                              71, 52, 241, 1),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          icon: const Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 30,
                                            ),
                                          ),
                                          iconSize: 30,
                                          items: List.generate(
                                              controller.sectionTop.length,
                                              (index) {
                                            return DropdownMenuItem(
                                              value:
                                                  controller.subjectTop[index],
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12.0,
                                                    left: 8,
                                                    right: 8),
                                                child: Text(
                                                  controller.subjectTop[index]
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
                                            subject_ismsId = s!.ismSId!.toInt();
                                          },
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0,
                                      ),
                              ),
                              SizedBox(
                                height: 40,
                              ),

                              CustomContainer(
                                child: TextField(
                                  
                                  style: Theme.of(context).textTheme.titleSmall,
                                  controller: editTextController,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                      hintText: "Enter numbers",

                                    label: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          color: const Color(0xFFFFEBEA)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/images/cap.png",
                                            height: 24.0,
                                            color: Color.fromARGB(
                                                255, 241, 86, 75),
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " Top ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color(0xFFFF6F67)),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
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
                              const SizedBox(height: 30),
                              MSkollBtn(
                                onPress: () async {
                                  if( editTextController.text.toString().isEmpty){
                                    Fluttertoast.showToast(msg: "Please enter a number");
                                  }else{
                                  await featchResult(
                                      miId: widget.loginSuccessModel.mIID!,
                                      asmayId: year_asmayId!,
                                      asmclId: class_asmclId!,
                                      asmsId: section_asmsId!,
                                      emeId: exam_emeId!,
                                      ismsId: subject_ismsId!,
                                      examCheckType: 1,
                                      reportType: 1,
                                      subCheckType: sub_check_type,
                                      topper:
                                          editTextController.text.toString(),
                                      base: baseUrlFromInsCode(
                                          "exam", widget.mskoolController),
                                      controller: marksEntryController);
                                  Get.to(() => ToperResultShow(
                                        loginSuccessModel:
                                            widget.loginSuccessModel,
                                        mskoolController:
                                            widget.mskoolController,
                                        sub_checkType: sub_check_type,
                                      ));
                                  }
                                },
                                title: "View Details",
                              )
                            ],
                          ),
                        );
                      },
                    );
        }));
  }
}
