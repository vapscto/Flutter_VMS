import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/api/get_gallery_class_Api.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/api/get_gallery_section_Api.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/api/upload.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/controller/gallery_controller.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/widget/gallery_class.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:open_filex/open_filex.dart';
import 'package:video_player/video_player.dart';

class GalleryUploadPage extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
 const GalleryUploadPage({
    Key? key,
    required this.loginSuccessModel,
    required this.mskoolController,
  }) : super(key: key);

  @override
  _GalleryUploadPageState createState() => _GalleryUploadPageState();
}

class _GalleryUploadPageState extends State<GalleryUploadPage>
    with SingleTickerProviderStateMixin {
  final StaffGalleryController galleryController =
      Get.put<StaffGalleryController>(StaffGalleryController());
  String? statusCode;
  var getDate;
  bool isLoding = false;
  // List<File> selectedImages = [];
  // List<File> selectedVideos = [];
  final ImagePicker _imagePicker = ImagePicker();

  var todayDate = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  DateTime selecteddate = DateTime.now();
  DateTime? selectedstartdate;
  DateTime? selectedenddate;
  TextEditingController galleryEditTextController = TextEditingController();

  Future<void> pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        galleryController.selectedMedia.add(File(pickedImage.path));
      });
    }
  }

  Future<void> pickVideo() async {
    final pickedVideo =
        await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        galleryController.selectedVideos.add(File(pickedVideo.path));
      });
    }
  }

  void deleteImage(int index) {
    setState(() {
      galleryController.selectedMedia.removeAt(index);
    });
  }

  void deleteVideo(int index) {
    setState(() {
      galleryController.selectedVideos.removeAt(index);
    });
  }

  // StaffGalleryClassListModelValues? selectedClass;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await GetGalleryInitialDataApi.instance.getGalleryClass(
      miId: widget.loginSuccessModel.mIID!,
      userId: widget.loginSuccessModel.userId!,
      asmaYId: widget.loginSuccessModel.asmaYId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      amstId: widget.loginSuccessModel.amsTId!,
      roleFlag: widget.loginSuccessModel.roleforlogin!,
      galleryController: galleryController,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
    );

    await GetGallerySectionApi.instance.getGallerySection(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        asmaYId: widget.loginSuccessModel.asmaYId!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        amstId: widget.loginSuccessModel.amsTId!,
        roleFlag: widget.loginSuccessModel.roleforlogin!,
        galleryController: galleryController,
        asmcLId: galleryController.selectedClass.value.asmcLId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        fromVerifyCat: false);

    if (galleryController.isErrorOccuredLoadingSection.value ||
        galleryController.sections.isEmpty) {
      return;
    }
    List<Map<String, dynamic>> map = [];
    for (var element in galleryController.selectedSection) {
      map.add({
        "ASMS_Id": element.asmSId,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //
        appBar: AppBar(
          title: Text('Gallery Upload'),
          titleSpacing: 0,
          leading: const CustomGoBackButton(),
          
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: CustomContainer(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: galleryEditTextController,
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
                              " Gallery Name ",
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
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: RadioListTile(
                          dense: true,
                          activeColor: Theme.of(context).primaryColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          title: Text(
                            "Common",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    letterSpacing: 0.3)),
                          ),
                          value: "Common",
                          groupValue: galleryController.grpOrInd.value,
                          onChanged: (value) {
                            galleryController.groupOrIndividual(value!);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: RadioListTile(
                          dense: true,
                          activeColor: Theme.of(context).primaryColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          title: Text(
                            "Class",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    letterSpacing: 0.3)),
                          ),
                          value: "Class",
                          groupValue: galleryController.grpOrInd.value,
                          onChanged: (value) {
                            galleryController.groupOrIndividual(value!);
                          },
                        ),
                      ),
                    ],
                  )),
              Obx(() => galleryController.grpOrInd.value == "Class"
                  ? Visibility(
                      visible: true,
                      child: GalleryClass(
                        loginSuccessModel: widget.loginSuccessModel,
                        mskoolController: widget.mskoolController,
                        galleryController: galleryController,
                      ),
                    )
                  : const SizedBox()),
              const SizedBox(height: 20),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                child: CustomContainer(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleSmall,
                    controller: todayDate,
                    onTap: () async {
                      showDatePicker(
                        context: context,
                        initialDate: selecteddate,
                        selectableDayPredicate: (DateTime date) {
                          if (date.weekday == DateTime.sunday) {
                            return false;
                          }
                          return true;
                        },
                        firstDate: DateTime(DateTime.now().year - 15),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          selecteddate = value;
                          setState(() {
                          
                            getDate =
                                "${selecteddate.year}/${numberList[selecteddate.month]}/${numberList[selecteddate.day]}";

                            todayDate.text =   getDate;
                          });
                        }
                      });
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(229, 243, 255, 1),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/calendar_icon.svg",
                              color: const Color(0xFF3E78AA),
                              height: 18.0,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              " Select Date ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                      fontSize: 20.0,
                                      color: Color.fromRGBO(62, 120, 170, 1),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      hintText: 'Select date.'.tr,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/svg/calendar_icon.svg",
                          color: const Color(0xFF3E78AA),
                        ),
                      ),
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
                    readOnly: true,
                  ),
                ),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: RadioListTile(
                          dense: true,
                          activeColor: Theme.of(context).primaryColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          title: Text(
                            "Image",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    letterSpacing: 0.3)),
                          ),
                          value: "I",
                          groupValue: galleryController.videoOrImage.value,
                          onChanged: (value) {
                            if(galleryController.selectedVideos.isNotEmpty){
                              galleryController.selectedVideos.clear();
                              setState(() {
                                
                              });
                            }
                            galleryController.checkVideoOrImage(value!);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: RadioListTile(
                          dense: true,
                          activeColor: Theme.of(context).primaryColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          title: Text(
                            "Video",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    letterSpacing: 0.3)),
                          ),
                          value: "V",
                          groupValue: galleryController.videoOrImage.value,
                          onChanged: (value) {
                            if(galleryController.selectedMedia.isNotEmpty){
                              galleryController.selectedMedia.clear();
                              setState(() {
                                
                              });
                            }
                            galleryController.checkVideoOrImage(value!);
                          },
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () =>  galleryController.videoOrImage == "I"
                    ? Center(
                        child:   TextButton(
                          onPressed:   pickImage,
                          child:  Padding(
                            padding: EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 30, right: 30),
                            child: Text(
                              'Upload Image',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor:const Color.fromARGB(255, 255, 233, 240),
                          ),
                        ),
                      )
                    : Center(
                        child: TextButton(
                          onPressed: pickVideo,
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 12.0, bottom: 12.0, left: 30, right: 30),
                            child: Text(
                              'Upload Video',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                          ),
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              backgroundColor:
                                  Color.fromARGB(255, 230, 244, 248)),
                        ),
                      ),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (galleryController.selectedMedia.isNotEmpty ||
                      galleryController.selectedVideos.isNotEmpty)
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
                         
                          if(galleryEditTextController.text.isNotEmpty){
                             
                           isLoding = true;
                          setState(() {
                            
                          });
               statusCode =   await UploadGallery.instance.upload(
                              miId: widget.loginSuccessModel.mIID!,
                              userId: widget.loginSuccessModel.userId!,
                              asmayId: widget.loginSuccessModel.asmaYId!,
                              ivrmrtId: widget.loginSuccessModel.roleTypeId!,
                              roleFlag: widget.loginSuccessModel.roleforlogin!,
                              amstId: widget.loginSuccessModel.amsTId!,
                             // "150168895",
                              //  widget.loginSuccessModel.amsTId!
                              asmcelId: galleryController
                                  .selectedClass.value.asmcLId!,
                              igaGalleryName:
                                  galleryEditTextController.text.toString(),
                              date: getDate,
                              time: DateTime.now().toString(),
                              mediatype: galleryController.videoOrImage.value
                                  .toString(),
                              controller: galleryController,
                              base: baseUrlFromInsCode(
                                  "portal", widget.mskoolController));
                          if (statusCode == "200") {
                            isLoding = false;
                            setState(() {
                             "I" == galleryController.videoOrImage.value ? galleryController.selectedMedia.clear() : "V" == galleryController.videoOrImage.value ? galleryController.selectedVideos.clear():false;
                            });
                            galleryEditTextController.text="";
                            todayDate.text ="";
                           Fluttertoast.showToast(msg: "Uploaded Successfully");

                          }
                          }else{
                            Fluttertoast.showToast(msg: "Please fill all fields");
                          }
                        },
                        child: isLoding
                            ? 
                            SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ):Text("Submt"),
                      ),
                    ),
                  const SizedBox(height: 20),
                  galleryController.selectedMedia.isNotEmpty ||
                          galleryController.selectedVideos.isNotEmpty
                      ? Visibility(
                          visible: true,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: CustomContainer(
                              child: Scrollbar(
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: galleryController
                                          .selectedMedia.length +
                                      galleryController.selectedVideos.length,
                                  itemBuilder: (context, index) {
                                    if (index <
                                        galleryController
                                            .selectedMedia.length) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.8,
                                              decoration: ShapeDecoration(
                                                  shape: BeveledRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.0),
                                                      side: const BorderSide(
                                                          color: Colors.black,
                                                          width: .2))),
                                              height: 40,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    galleryController
                                                        .selectedMedia[index]
                                                        .path
                                                        .split('/')
                                                        .last,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: SizedBox(
                                                child: InkWell(
                                                  onTap: () {
                                                    deleteImage(index);
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: IconButton(
                                                  onPressed: () {
                                                OpenFilex.open(galleryController
                                                    .selectedMedia
                                                    .elementAt(index)
                                                    .path);
                                                         },
                                                   icon:
                                                  const Icon(Icons.remove_red_eye)),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      int videoIndex = index -
                                          galleryController
                                              .selectedMedia.length;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.8,
                                              decoration: ShapeDecoration(
                                                  shape: BeveledRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.0),
                                                      side: const BorderSide(
                                                          color: Colors.black,
                                                          width: .2))),
                                              height: 40,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    galleryController
                                                        .selectedVideos[
                                                            videoIndex]
                                                        .path
                                                        .split('/')
                                                        .last,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: SizedBox(
                                                child: InkWell(
                                                  onTap: () {
                                                    deleteVideo(videoIndex);
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            )
                                            
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ));
  }

  void getStudentListOnChangeOfSection(String asmsId) async {
    // attendanceEntryController.isstudentdataloading(true);
    // await attendanceEntryController
    //     .getAttendanceDataOnChangeOfSection(
    //   asmayId: selectedAcademicYear!.asmaYId!.toInt(),
    //   userId: widget.loginSuccessModel.userId!,
    //   miId: widget.loginSuccessModel.mIID!,
    //   username: widget.loginSuccessModel.userName!,
    //   roleId: widget.loginSuccessModel.roleId!,
    //   fromDate: todayDate.text,
    //   asmclId: selectedClass!.asmcLId!.toString(),
    //   asmsId: asmsId,
    //   monthFlag: attendanceEntryController.attendanceEntry.value,
    //   monthFlag1: attendanceEntryController.attendanceEntry.value == 'D'
    //       ? 'Dailyonce'
    //       : attendanceEntryController.attendanceEntry.value == 'H'
    //           ? 'Dailytwice '
    //           : '',
    //   base: baseUrlFromInsCode(
    //     'admission',
    //     widget.mskoolController,
    //   ),
    // )
    //     .then(
    //   (value) {
    //     if (!value) {
    //       logger.d(value);
    //       attendanceEntryController.isstudentdataloading(false);
    //       return;
    //     }
    //   },
    // );
    // attendanceEntryController.isstudentdataloading(false);
  }

  // void loadSection() {
  //   List<Map<String, dynamic>> map = [];

  // for (var element in galleryController.se!) {
  //   map.add({
  //     "ASMCL_Id": element.asmcLId,
  //   });
  // }
  // GetGallerySectionApi.instance.getGallerySection(
  //   miId: widget.loginSuccessModel.mIID!,
  //   userId: widget.loginSuccessModel.userId!,
  //   asmaYId: widget.loginSuccessModel.asmaYId!,
  //   ivrmrtId: widget.loginSuccessModel.roleId!,
  //   amstId: widget.loginSuccessModel.amsTId!,
  //   roleFlag: widget.loginSuccessModel.roleforlogin!,
  //   controller: galleryController,
  //   asmcLId: widget.galleryController.selectedClass!.asmcLId!,
  //   base: baseUrlFromInsCode("portal", widget.mskoolController),
  // );
  // }
}

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  VideoPlayerWidget({required this.videoFile});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
