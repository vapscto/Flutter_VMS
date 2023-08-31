import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/api/class_teacher_api.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/api/getYear_Api.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/controller/class_teacher_controller.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/model/teacher_report_yearlist_model.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/screen/class_teacher.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/screen/subject_teacher.dart';
import 'package:m_skool_flutter/principal/class_teacher_report/screen/teacher_attendance_previleges.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ClassTeacherHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ClassTeacherHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<ClassTeacherHome> createState() => _ClassTeacherHomeState();
}

class _ClassTeacherHomeState extends State<ClassTeacherHome> {
  final ClassTeacherController handler = Get.put(ClassTeacherController());
  int? getAsmayId;

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  onLoad() {
    GetTeacherYearListApi.instance.getYearList(
        mIID: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("admission", widget.mskoolController),
        controller: handler);

    // GetClassTeacherApi.instance.getClassTeacherList(
    //     mIID: widget.loginSuccessModel.mIID!,
    //     asmayId: widget.loginSuccessModel.asmaYId!,
    //     base: baseUrlFromInsCode("admission", widget.mskoolController),
    //     controller: handler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Teacher Report"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: CustomContainer(
                  child: DropdownButtonFormField<YearListModelValues>(
                    hint: Center(
                      child: Text(handler.yearList.isNotEmpty
                          ? "Select year"
                          : "No data available"),
                    ),
                    value: handler.selectedYearList,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 16.0, bottom: 16.0, left: 10, right: 10),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 5),
                        decoration: BoxDecoration(
                            color: const Color(0xFFDFFBFE),
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/cap.png",
                              height: 16.0,
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
                                      fontSize: 20, color: Color(0xFF28B6C8))),
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
                      handler.yearList.length,
                      (index) => DropdownMenuItem<YearListModelValues>(
                        value: handler.yearList.elementAt(index),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 0, right: 0),
                          child: Text(
                            "${handler.yearList.elementAt(index).asmaYYear}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    letterSpacing: 0.3)),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (s) async {
                      handler.selectedYearList = s;
                         handler.setacademicYear(s!.asmaYId!);
                        if(   handler.classTeacherList.isNotEmpty ){
                           handler.classTeacherList.clear();

                    }
                        await getClassTeacherList(
                          mIID: widget.loginSuccessModel.mIID!,
                          asmayId:  handler.setacademic.value,
                          base: baseUrlFromInsCode(
                              "admission", widget.mskoolController),
                          controller: handler);
                    },
                  ),
                ),
              );
            }),
            SizedBox(
              height: 20,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Obx(
                  () => SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: RadioListTile(
                      dense: true,
                      activeColor: Theme.of(context).primaryColor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      visualDensity: const VisualDensity(horizontal: -4.0),
                      title: Text(
                        "Class Teacher",
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                letterSpacing: 0.3,
                              ),
                            ),
                        maxLines: 3,
                      ),
                      value: "1",
                      groupValue: handler.grpOrInd.value,
                      onChanged: (value) async{
                        handler.groupOrIndividual(value!);
                          if(   handler.classTeacherList.isNotEmpty ){
                           handler.classTeacherList.clear();

                    }
                        await getClassTeacherList(
                          mIID: widget.loginSuccessModel.mIID!,
                          asmayId:  handler.setacademic.value,
                          base: baseUrlFromInsCode(
                              "admission", widget.mskoolController),
                          controller: handler);
                      },
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: RadioListTile(
                      dense: true,
                      activeColor: Theme.of(context).primaryColor,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      visualDensity: const VisualDensity(horizontal: -4.0),
                      title: Text(
                        "Subject Teacher",
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                              TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                letterSpacing: 0.3,
                              ),
                            ),
                        maxLines: 1,
                      ),
                      value: "3",
                      groupValue: handler.grpOrInd.value,
                      onChanged: (value) async{
                        logger.d("Prathap ${value}");

                        handler.groupOrIndividual(value!);
                         if(   handler.classTeacherList.isNotEmpty ){
                           handler.classTeacherList.clear();

                    }
                        await getClassTeacherList(
                          mIID: widget.loginSuccessModel.mIID!,
                          asmayId:  handler.setacademic.value,
                          base: baseUrlFromInsCode(
                              "admission", widget.mskoolController),
                          controller: handler);
                      },
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => SizedBox(
                width: MediaQuery.of(context).size.width / 1.9,
                child: RadioListTile(
                  dense: true,
                  activeColor: Theme.of(context).primaryColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: const VisualDensity(horizontal: -4.0),
                  title: Text(
                    "Class Teacher having Attendance Privilege",
                    style: Theme.of(context).textTheme.labelSmall!.merge(
                          TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            letterSpacing: 0.3,
                          ),
                        ),
                    maxLines: 5,
                  ),
                  value: "2",
                  groupValue: handler.grpOrInd.value,
                  onChanged: (value) async{
                    logger.d("Prathap ${value}");
                    handler.groupOrIndividual(value!);
                     if(   handler.classTeacherList.isNotEmpty ){
                           handler.classTeacherList.clear();

                    }
                        await getClassTeacherList(
                          mIID: widget.loginSuccessModel.mIID!,
                          asmayId:  handler.setacademic.value,
                          base: baseUrlFromInsCode(
                              "admission", widget.mskoolController),
                          controller: handler);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Obx(() =>
             handler.classTeacherList.isEmpty ?
            const  Align(
                alignment: Alignment.center,
                child: AnimatedProgressWidget(
                    title: "No data available",
                    desc: "There are no data available",
                    animationPath: "assets/json/nodata.json",
                    animatorHeight: 250),
                    
              ):
             handler.grpOrInd == "1"
                ? Visibility(
                    visible: true,
                    child: ClassTeacher(
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                      controller: handler,
                    ))
                : handler.grpOrInd == "2"
                    ? Visibility(
                        visible: true,
                        child: TeacherAttendancePrevileges(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                          controller: handler,
                        ))
                    : handler.grpOrInd == "3"
                        ? Visibility(
                            visible: true,
                            child: SubjectTeacher(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              controller: handler,
                            ))
                        : Text("No data")),
                        SizedBox(
              height: 20,
            ),
          ],
        ),
        
      ),
    );
  }
 
}
