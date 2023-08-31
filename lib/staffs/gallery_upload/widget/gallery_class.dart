import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';

import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/controller/attendance_entry_related_controller.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/api/get_gallery_section_Api.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/controller/gallery_controller.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/model/gallery_classList_model.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/widget/gallery_section.dart';
 
// import 'package:m_skool_flutter/staffs/gallery_upload/api/get_gallery_class_Api.dart';
// import 'package:m_skool_flutter/staffs/gallery_upload/controller/gallery_controller.dart';
// import 'package:m_skool_flutter/staffs/gallery_upload/model/gallery_classList_model.dart';
// import 'package:m_skool_flutter/staffs/gallery_upload/widget/gallery_section.dart';

import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class GalleryClass extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final StaffGalleryController galleryController;

  TextEditingController galleryTextEditingController = TextEditingController();
  GalleryClass({
    Key? key,
    required this.galleryController,
    required this.loginSuccessModel,
    required this.mskoolController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 32.0,
              ),
              SizedBox(
                height: 25,
              ),
              CustomContainer(
                child: DropdownButtonFormField<
                        StaffGalleryClassListModelValues>(
                    value: galleryController.selectedClass.value,
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(fontSize: 16.0),
                        ),
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
                              " Class ",
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
                      border: const OutlineInputBorder(),
                    ),
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 4.5),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 30,
                      ),
                    ),
                    items: galleryController.classes
                        .map((e) =>
                            DropdownMenuItem<StaffGalleryClassListModelValues>(
                                value: e,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 5),
                                  child: Text(e.asmcLClassName ?? "N/a"),
                                )))
                        .toList(),
                    onChanged: (e) async {
                      galleryController.updateSelectedClass(e!);
                      await loadAgain();
                    }),
              ),
              Obx(() {
                return galleryController.isErrorOccuredLoadingSection.value
                    ? ErrWidget(err: {
                        "errorTitle": "An Unexpected Error Occurred",
                        "errorMsg": galleryController.errorStatus.value
                      })
                    : galleryController.isSectionLoading.value
                        ? Center(
                            child: AnimatedProgressWidget(
                              title: "Loading Available Section's",
                              desc: galleryController.loadingStatus.value,
                              animationPath: "assets/json/hwanim.json",
                            ),
                          )
                        : galleryController.sections.isEmpty
                            ? const Center(
                                child: AnimatedProgressWidget(
                                  title: "No Section Available",
                                  desc:
                                      "Sorry but there are no section available, try changing academic year",
                                  animationPath: "assets/json/nodata.json",
                                  animatorHeight: 250,
                                ),
                              )
                            : GallerySection(
                                galleryController: galleryController,
                                loginSuccessModel: loginSuccessModel,
                                mskoolController: mskoolController,
                              );
              })
            ],
          ),
        ));
  }

  Future<void> loadAgain() async {
    await GetGallerySectionApi.instance.getGallerySection(
      miId: loginSuccessModel.mIID!,
      userId: loginSuccessModel.userId!,
      asmaYId: loginSuccessModel.asmaYId!,
      ivrmrtId: loginSuccessModel.roleId!,
      amstId: loginSuccessModel.amsTId!,
      roleFlag: loginSuccessModel.roleforlogin!,
      galleryController: galleryController,
      asmcLId: galleryController.selectedClass.value.asmcLId!,
      base: baseUrlFromInsCode("portal", mskoolController),
      fromVerifyCat: false,
    );
    if (galleryController.isErrorOccuredLoadingSection.value ||
        galleryController.sections.isEmpty) {
      return;
    }

    // await HwCwGetSubjectsApi.instance.getSubjects(
    //   miId: loginSuccessModel.mIID!,
    //   hrmeId: loginSuccessModel.empcode!,
    //   asmayId: galleryController.selectedSession.value.asmaYId!,
    //   asmclId: galleryController.selectedClass.value.asmcLId!,
    //   sections: [
    //     {"ASMS_Id": galleryController.selectedSection.first.asmSId!}
    //   ],
    //   ivrmrtId: loginSuccessModel.roleId!,
    //   loginId: loginSuccessModel.userId!,
    //   base: baseUrlFromInsCode("portal", mskoolController),
    //   galleryController: galleryController,
    // );
  }
}
