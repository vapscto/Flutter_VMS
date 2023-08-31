import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/feedemo/api/get_fee_report_api.dart';
import 'package:m_skool_flutter/manager/feedemo/api/get_initial_class_api.dart';
import 'package:m_skool_flutter/manager/feedemo/api/get_initial_data_api.dart';
import 'package:m_skool_flutter/manager/feedemo/api/get_initial_section_api.dart';
import 'package:m_skool_flutter/manager/feedemo/controller/fee_demo_controller.dart';
import 'package:m_skool_flutter/manager/feedemo/model/category_class_model.dart';
import 'package:m_skool_flutter/manager/feedemo/model/category_sec_model.dart';
import 'package:m_skool_flutter/manager/feedemo/model/fee_demo_year_model.dart';
import 'package:m_skool_flutter/manager/feedemo/screen/fee_report.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/model/section_detail_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:m_skool_flutter/widget/pgr_widget.dart';

class FeeDemoHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController controller;
  const FeeDemoHome(
      {super.key, required this.loginSuccessModel, required this.controller, required MskoolController mskoolController,});

  @override
  State<FeeDemoHome> createState() => _FeeDemoHomeState();
}

class _FeeDemoHomeState extends State<FeeDemoHome> {
  final FeeDemoController controller = Get.put(FeeDemoController());

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    await GetFeeDemoInitialDataApi.instance.getYearList(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.controller),
        controller: controller);

    await GetinitialClassApi.instance.getclasses(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: controller.selectedAcademicYear!.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.controller),
        controller: controller);
        
         await GetinitialSectionApi.instance.getSection(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: controller.selectedAcademicYear!.asmaYId!,
        asmcLId: controller.selectedClass!.asmcLId!,
        base: baseUrlFromInsCode("portal", widget.controller),
        controller: controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Class Wise Fee Details").getAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() {
              return controller.isErrorOccuredWhileLoadingAcademicYear.value
            ? const Center(
                child: ErrWidget(
                  err: {
                    "errorTitle": "Unexpected Error Occured",
                    "errorMsg":
                        "While loading academic year we encountered an error"
                  },
                ),
              )
            : controller.isloadingAcademicYear.value
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: 'assets/json/default.json',
                      title: 'Loading academic year',
                      desc: "Please wait we are loading academic",
                    ),
                  )
                : controller.academicYear.isEmpty
                    ? const Center(
                        child: AnimatedProgressWidget(
                          animationPath: 'assets/json/nodata.json',
                          title: 'No Department Found',
                          desc: "There are no department available",
                          animatorHeight: 250,
                        ),
                      )
                    : CustomContainer(

                child: DropdownButtonFormField<FeeDemoAcademicYearValues>(
                  value: controller.selectedAcademicYear,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16.0),
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
                    controller.academicYear.length,
                    (index) => DropdownMenuItem<FeeDemoAcademicYearValues>(
                      value: controller.academicYear.elementAt(index),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                        child: Text(
                          controller.academicYear.elementAt(index).asmaYYear!,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    ),
                  ),
                  onChanged: (s) async {
                    controller.selectedAcademicYear = s;

                    await GetinitialClassApi.instance.getclasses(
                        miId: widget.loginSuccessModel.mIID!,
                        asmayId: controller.selectedAcademicYear!.asmaYId!,
                        base: baseUrlFromInsCode("portal", widget.controller),
                        controller: controller);
                  },
                ),
              );
            }),
            const SizedBox(
              height: 32.0,
            ),
             Obx(() {
              return  controller.isErrorOccuredWhileLoadingclass.value
            ? const Center(
                child: ErrWidget(
                  err: {
                    "errorTitle": "Unexpected Error Occured",
                    "errorMsg":
                        "While loading department we encountered an error"
                  },
                ),
              )
            : controller.isloadingclass.value
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: 'assets/json/default.json',
                      title: 'Loading Department',
                      desc: "Please wait we are loading department",
                    ),
                  )
                : controller.classes.isEmpty
                    ? const Center(
                        child: AnimatedProgressWidget(
                          animationPath: 'assets/json/nodata.json',
                          title: 'No Department Found',
                          desc: "There are no department available",
                          animatorHeight: 250,
                        ),
                      )
                    :
            CustomContainer(
              child: DropdownButtonFormField<ClassCategoryListValues>(
                value: controller.selectedClass,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
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
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEA),
                        borderRadius: BorderRadius.circular(24.0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/calendar.png",
                          color: const Color(0xFFFF6F67),
                          height: 22.0,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          "Select Class",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  fontSize: 20, color: Color(0xFFFF6F67))),
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
                  controller.classes.length,
                  (index) => DropdownMenuItem<ClassCategoryListValues>(
                    value: controller.classes.elementAt(index),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                      child: Text(
                        controller.classes
                            .elementAt(index)
                            .className!,
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                letterSpacing: 0.3)),
                      ),
                    ),
                  ),
                ),
                onChanged: (s) async {
                   controller.selectedClass = s;
                  GetinitialSectionApi.instance.getSection(
                      miId: widget.loginSuccessModel.mIID!,
                      asmayId: controller.selectedAcademicYear!.asmaYId!,
                       asmcLId: controller.selectedClass!.asmcLId!,
                      base: baseUrlFromInsCode("portal", widget.controller),
                      controller: controller,);
                },
              ),
            );
            }),
             const SizedBox(
              height: 16.0,
            ),
            const SizedBox(
              height: 16.0,
            ),

    Obx(() {
              return  controller.isErrorOccuredWhileLoadingSection.value
            ? const Center(
                child: ErrWidget(
                  err: {
                    "errorTitle": "Unexpected Error Occured",
                    "errorMsg":
                        "While loading department we encountered an error"
                  },
                ),
              )
            : controller.isloadingSection.value
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: 'assets/json/default.json',
                      title: 'Loading Department',
                      desc: "Please wait we are loading department",
                    ),
                  )
                : controller.section.isEmpty
                    ? const Center(
                        child: AnimatedProgressWidget(
                          animationPath: 'assets/json/nodata.json',
                          title: 'No Department Found',
                          desc: "There are no department available",
                          animatorHeight: 250,
                        ),
                      )
                    :
            CustomContainer(
              child: DropdownButtonFormField<ClasssectionValues>(
                value: controller.selectedsection,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
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
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEA),
                        borderRadius: BorderRadius.circular(24.0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/calendar.png",
                          color: const Color(0xFFFF6F67),
                          height: 22.0,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          "Select Section",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                  fontSize: 20, color: Color(0xFFFF6F67))),
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
                  controller.section.length,
                  (index) => DropdownMenuItem<ClasssectionValues>(
                    value: controller.section.elementAt(index),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                      child: Text(
                        controller.section
                            .elementAt(index)
                            .sectionname!,
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                letterSpacing: 0.3)),
                      ),
                    ),
                  ),
                ),
                onChanged: (s) async {
                  controller.selectedsection = s;
                 
                },
              ),
            );
            }),
  
            const SizedBox(
              height: 16.0,
            ),
            
             MSkollBtn(
                          onPress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return FeeReporthome(
                                loginSuccessModel: widget.loginSuccessModel,
                                controller: widget.controller,
                                feeDemoController: controller,
                              );
                            }));
                          },
                          title: 'View Details',
                        ),
            // MSkollBtn(title: "View Details", onPress: (){
            //   Get.to(FeeReporthome (controller: widget.controller, loginSuccessModel: widget.loginSuccessModel,));
            // })

           
          ],
        ),
      ),
    );
  }

 
}
