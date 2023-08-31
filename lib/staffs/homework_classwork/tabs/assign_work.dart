import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/hw_cw_academic_dd.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/hw_cw_class_dd.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class HwCwAssignWork extends StatefulWidget {
  final bool forHw;
  final HwCwController hwCwController;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const HwCwAssignWork(
      {super.key,
      required this.forHw,
      required this.hwCwController,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<HwCwAssignWork> createState() => _HwCwAssignWorkState();
}

class _HwCwAssignWorkState extends State<HwCwAssignWork> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.hwCwController.isErrorOccuredLoadingAcademicYear.value
          ? Center(
              child: ErrWidget(
                err: {
                  "errorTitle": "Unexpected Error Occured",
                  "errorMsg": widget.hwCwController.errorStatus.value,
                },
              ),
            )
          : widget.hwCwController.isAcademicYearLoading.value
              ? Center(
                  child: AnimatedProgressWidget(
                    title: "Loading Academic Year",
                    desc: widget.hwCwController.loadingStatus.value,
                    animationPath: "assets/json/hwanim.json",
                  ),
                )
              : widget.hwCwController.session.isEmpty
                  ? const Center(
                      child: AnimatedProgressWidget(
                        animationPath: "assets/json/nodata.json",
                        desc:
                            'No Academic year present in database, tell your team to add academic year',
                        title: 'No Academic Year Found',
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
                          HwCwAcademicYearDD(
                            hwCwController: widget.hwCwController,
                            loginSuccessModel: widget.loginSuccessModel,
                            mskoolController: widget.mskoolController,
                            forHw: widget.forHw,
                            forVerify: false,
                          ),
                          Obx(() {
                            return widget.hwCwController.isClassLoading.value
                                ? Center(
                                    child: AnimatedProgressWidget(
                                      title: "Loading Available Classes",
                                      desc: widget
                                          .hwCwController.loadingStatus.value,
                                      animationPath: "assets/json/hwanim.json",
                                    ),
                                  )
                                : widget.hwCwController
                                        .isErrorOccuredLoadingClass.value
                                    ? ErrWidget(err: {
                                        "errorTitle":
                                            "Unexpected Error Occured",
                                        "errorMsg": widget
                                            .hwCwController.errorStatus.value
                                      })
                                    : widget.hwCwController.classes.isEmpty
                                        ? const Center(
                                            child: AnimatedProgressWidget(
                                              title: "No Classes Available",
                                              desc:
                                                  "Sorry but there are no classes available, try changing academic year",
                                              animationPath:
                                                  "assets/json/nodata.json",
                                              animatorHeight: 250,
                                            ),
                                          )
                                        : HwCwClassDD(
                                            hwCwController:
                                                widget.hwCwController,
                                            forHw: widget.forHw,
                                            loginSuccessModel:
                                                widget.loginSuccessModel,
                                            mskoolController:
                                                widget.mskoolController,
                                          );
                          })
                        ],
                      ),
                    );
    });
  }
}
