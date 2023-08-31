import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_academic.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_section_api.dart';
import 'package:m_skool_flutter/manager/student_details/api/get_student_api.dart';
import 'package:m_skool_flutter/manager/student_details/controller/student_details_controller.dart';
import 'package:m_skool_flutter/manager/student_details/widgets/manager_academic_dd.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class IndividualTab extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final StudentDetailsController studentDetails;
  const IndividualTab(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.studentDetails});

  @override
  State<IndividualTab> createState() => _IndividualTabState();
}

class _IndividualTabState extends State<IndividualTab> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await ManagerGetAcademic.instance.getAcademics(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      controller: widget.studentDetails,
    );
    if (widget.studentDetails.isErrorOccuredWhileLoadingAcademicYear.value ||
        widget.studentDetails.academicYear.isEmpty) {
      return;
    }

    await ManagerGetAcademic.instance.getClassName(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      controller: widget.studentDetails,
    );

    if (widget.studentDetails.isErrorOccuredWhileLoadingClass.value ||
        widget.studentDetails.className.isEmpty) {
      return;
    }
    await GetSectionApi.instance.getSection(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.studentDetails.selectedAcademicYear.value.asmaYId!,
      asmclId: widget.studentDetails.selectedClass.value.asmcLId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      controller: widget.studentDetails,
    );
    if (widget.studentDetails.isErrorOccuredWhileLoadingSection.value ||
        widget.studentDetails.sections.isEmpty) {
      return;
    }
    logger.d(widget.studentDetails.selectedSections.value.toJson());
    await GetStudentApi.instance.getStudents(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.studentDetails.selectedAcademicYear.value.asmaYId!,
      asmcld: widget.studentDetails.selectedClass.value.asmcLId!,
      asmsId: widget.studentDetails.selectedSections.value.asmSId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      controller: widget.studentDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.studentDetails.isErrorOccuredWhileLoadingAcademicYear.value
          ? Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected ErrorOccured",
                  "errorMsg": widget.studentDetails.status.value,
                },
              ),
            )
          : widget.studentDetails.isAcademicYearLoading.value
              ? Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    desc: widget.studentDetails.status.value,
                    title: "Please wait we are loading.",
                  ),
                )
              : widget.studentDetails.academicYear.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        title: "No Academic Found",
                        desc:
                            "There is no academic available currently.. Please ask your technical team to add some",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 250,
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16.0,
                          ),
                          ManagerAcademicYearDD(
                            studentDetails: widget.studentDetails,
                            baseUrl: baseUrlFromInsCode(
                                "portal", widget.mskoolController),
                            miId: widget.loginSuccessModel.mIID!,
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                        ],
                      ),
                    );
    });
  }
}
