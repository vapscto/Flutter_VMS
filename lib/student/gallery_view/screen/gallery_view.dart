import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/gallery_view/api/viewImageApi.dart';
import 'package:m_skool_flutter/student/gallery_view/api/yearListApi.dart';
import 'package:m_skool_flutter/student/gallery_view/controller/academicYear_controller.dart';
import 'package:m_skool_flutter/student/gallery_view/controller/viewGallery_controller.dart';
import 'package:m_skool_flutter/student/gallery_view/model/AcademicYearList.dart';
import 'package:m_skool_flutter/student/gallery_view/widget/previewImage.dart';
import 'package:m_skool_flutter/student/gallery_view/widget/videoPlayerUrl.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class ViewGallery extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ViewGallery(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});
  @override
  State<ViewGallery> createState() => _ViewGalleryState();
}

class _ViewGalleryState extends State<ViewGallery> {
  final ViewGalleryController _controller = Get.put(ViewGalleryController());
  final AcadmeicController _yearController = Get.put(AcadmeicController());
  @override
  void initState() {
    loaddata();
    onLoad();
    super.initState();
  }

  onLoad() {
    GetFeatchApiImages.instance.featchApiImages(
      ctr: _controller,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      miId: widget.loginSuccessModel.mIID.toString(),
      amstId: widget.loginSuccessModel.amsTId.toString(),
      asmayId: widget.loginSuccessModel.asmaYId.toString(),
      userId: widget.loginSuccessModel.userId.toString(),
      roleId: widget.loginSuccessModel.roleId.toString(),
    );
  }

  Future<void> loaddata() async {
    await GetAcademicYearDataApi.instance.getExamSelectedYear(
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        controller: _yearController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "View Gallery",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        titleSpacing: 0,
      ),
      body: Column(children: [
        Obx(() => _yearController.isErrorOccuredWhileLoadingAcademic.value
            ? const Center(
                child: ErrWidget(
                  err: {
                    "errorTitle": "Unexpected Error Occured",
                    "errorMsg": "While loading academic we encountered an error"
                  },
                ),
              )
            : _yearController.isLoadingCategory.value
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    title: 'Loading session',
                    desc: "Please wait we are loading session",
                  )
                : Container(
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
                    child: DropdownButtonFormField<AcademicYearListValues>(
                      value: _yearController.selectedAcademic,
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
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .merge(const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                letterSpacing: 0.3)),
                        hintText: _yearController.academic.isNotEmpty
                            ? 'Select Year'
                            : 'No data available',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        isDense: true,
                        label: const CustomDropDownLabel(
                          icon: 'assets/images/hat.png',
                          containerColor: Color.fromRGBO(223, 251, 254, 1),
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
                      items: List.generate(_yearController.academic.length,
                          (index) {
                        return DropdownMenuItem(
                          value: _yearController.academic[index],
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13, left: 5),
                            child: Text(
                              _yearController.academic[index].asmaYYear!,
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
                      onChanged: (s) async {
                        _yearController.selectedAcademic = s;
                        GetFeatchApiImages.instance.featchApiImages(
                          ctr: _controller,
                          base: baseUrlFromInsCode(
                              "portal", widget.mskoolController),
                          miId: widget.loginSuccessModel.mIID.toString(),
                          amstId: widget.loginSuccessModel.amsTId.toString(),
                          asmayId: s!.asmaYId.toString(),
                          userId: widget.loginSuccessModel.userId.toString(),
                          roleId: widget.loginSuccessModel.roleId.toString(),
                        );
                      },
                    ),
                  )),
        Obx(() => Expanded(
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 7,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 150),
                itemCount: _controller.viewImagesList.length,
                itemBuilder: (context, index) {
                  // ignore: unnecessary_null_comparison
                  return (_controller.viewImagesList[index].iGAPPhotos != null)
                      ? InkWell(
                          onTap: () {
                            Get.to(() => PreviewImage(
                                imageUrl: _controller
                                    .viewImagesList[index].iGAPPhotos!,
                                galleryName: _controller
                                    .viewImagesList[index].iGAGalleryName!));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(_controller
                                    .viewImagesList[index].iGAPPhotos!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Get.to(() => VideoPlayerURL(
                                  url: _controller
                                      .viewImagesList[index].iGAVVideos!,
                                  name: _controller
                                      .viewImagesList[index].iGAGalleryName!,
                                  appBar: true,
                                ));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 150,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: VideoPlayerURL(
                                  url: _controller
                                      .viewImagesList[index].iGAVVideos!,
                                  name: "",
                                  appBar: false)),
                        );
                },
              ),
            ))
      ]),
    );
  }

  loadAgainYear() async {}
}
