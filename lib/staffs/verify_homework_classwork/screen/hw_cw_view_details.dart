import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_cw_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_hw_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/save_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/controller/pick_image_controller.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/filtered_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/upload_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_cw_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_hw_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/widget/verify_item.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class VerifyHwCwViewDetails extends StatefulWidget {
  final String title;
  final bool forHw;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final int asmayId;
  final int asmclId;
  final int asmsId;
  final int ismsId;
  final String fromDate;
  final String toDate;
  final int topicId;
  const VerifyHwCwViewDetails(
      {super.key,
      required this.title,
      required this.forHw,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.asmayId,
      required this.asmclId,
      required this.asmsId,
      required this.ismsId,
      required this.fromDate,
      required this.toDate,
      required this.topicId});

  @override
  State<VerifyHwCwViewDetails> createState() => _VerifyHwCwViewDetailsState();
}

class _VerifyHwCwViewDetailsState extends State<VerifyHwCwViewDetails> {
  final PickImageController imageController = Get.put(PickImageController());
  RxBool selectAll = RxBool(false);
  @override
  void dispose() {
    Get.delete<PickImageController>();
    super.dispose();
  }

  saveCw() async {
    bool someWhereMarksisNotThere = false;

    if (imageController.selectedEntry.isEmpty) {
      Fluttertoast.showToast(
          msg: "Before saving please verify at least one student");
      return;
    }

    for (int i = 0; i < imageController.selectedEntry.length; i++) {
      if (imageController.selectedEntry.elementAt(i).text.isEmpty) {
        someWhereMarksisNotThere = true;
        break;
      }
    }

    if (someWhereMarksisNotThere) {
      Fluttertoast.showToast(
          msg:
              "Somewhere you missed to provide marks.. You can provide marks to continue or uncheck the checkbox");

      return;
    }

    Map<String, dynamic> saveJson = {
      "MI_Id": widget.loginSuccessModel.mIID,
      "HRME_Id": widget.loginSuccessModel.empcode,
      "Login_Id": widget.loginSuccessModel.userId,
      "UserId": widget.loginSuccessModel.userId,
      "IVRMRT_Id": widget.loginSuccessModel.roleId,
      "Role_flag": "Staff",
    };

    final List<Map<String, dynamic>> getClassworkList = [];
    for (int i = 0; i < imageController.cwList.length; i++) {
      Map<String, dynamic> stuDet = {
        "AMST_Id": imageController.cwList.elementAt(i).aMSTId,
        "ICW_Id": imageController.cwList.elementAt(i).iCWId,
        "ICWUPL_Id": imageController.cwList.elementAt(i).iCWUPLId,
        "Marks": imageController.selectedEntry.elementAt(i).text,
        // "ICWUPL_FileName": "filename",
        // "ICWUPL_StaffUplaod": "filename",
        "ICWUPL_StaffRemarks": "",
      };

      if (imageController.hwCwModel.isNotEmpty) {
        final UploadAttModel att = imageController.hwCwModel.firstWhere(
            (element) =>
                imageController.cwList.elementAt(i).aMSTId == element.amstId,
            orElse: () => UploadAttModel(
                amstId: -1, model: UploadHwCwModel(name: "", path: "")));
        if (att.amstId == -1) {
          stuDet.addAll({
            "ICWUPL_FileName": "",
            "ICWUPL_StaffUplaod": "",
          });
        } else {
          stuDet.addAll({
            "ICWUPL_FileName": att.model.name,
            "ICWUPL_StaffUplaod": att.model.path,
          });
        }
      }

      final FilteredAttachment att = imageController.saveAttachment.firstWhere(
          (element) =>
              imageController.cwList.elementAt(i).aMSTId == element.amstId);

      stuDet.addAll({"doclist_temp": att.attachments});
      getClassworkList.add(stuDet);
    }

    saveJson.addAll({
      "getclasswork_list_array": getClassworkList,
    });

    logger.d(saveJson);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            child: FutureBuilder(
                future: SaveApi.instance.saveNow(
                    base: baseUrlFromInsCode("portal", widget.mskoolController),
                    body: saveJson,
                    forHw: widget.forHw),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            minRadius: 36,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 36.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Updation Successfully",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(
                                  const TextStyle(fontWeight: FontWeight.w600),
                                ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MSkollBtn(
                              title: "Ok Understood",
                              onPress: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return ErrWidget(
                        err: snapshot.error as Map<String, dynamic>);
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      AnimatedProgressWidget(
                          title: "Updating Marks",
                          desc: "Please wait while we update marks for you..",
                          animationPath: "assets/json/default.json"),
                    ],
                  );
                }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    int color = -1;
    return Scaffold(
      appBar: CustomAppBar(title: widget.title, action: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
            onPressed: () async {
              if (widget.forHw) {
                saveHw();
                return;
              }
              saveCw();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0),
              ),
              backgroundColor: Colors.white,
            ),
            child: Text(
              "Save",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
          ),
        ),
      ]).getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.all(8.0),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8.0),
            //           color: const Color(0xFFFBCFCF)),
            //       child: Text(
            //         "Maximum Marks : 20",
            //         style: Theme.of(context)
            //             .textTheme
            //             .titleSmall!
            //             .merge(const TextStyle(color: Color(0xFFA83232))),
            //       ),
            //     ),
            //     Obx(() {
            //       return Checkbox(
            //           value: selectAll.value,
            //           onChanged: (b) {
            //             selectAll.value = b!;
            //           });
            //     }),
            //   ],
            // ),
            const SizedBox(
              height: 16.0,
            ),
            widget.forHw
                ? FutureBuilder<List<VerifyHwListModelValues>>(
                    future: GetHwApi.instance.getHwForVerification(
                      miId: widget.loginSuccessModel.mIID!,
                      hrmeId: widget.loginSuccessModel.empcode!,
                      loginId: widget.loginSuccessModel.userId!,
                      userId: widget.loginSuccessModel.userId!,
                      ivrmrtId: widget.loginSuccessModel.roleId!,
                      roleFlag: "Staff",
                      asmayId: widget.asmayId,
                      ismsId: widget.ismsId,
                      asmclId: widget.asmclId,
                      asmsId: widget.asmsId,
                      fromDate: widget.fromDate,
                      toDate: widget.toDate,
                      controller: imageController,
                      base: baseUrlFromInsCode(
                        "portal",
                        widget.mskoolController,
                      ),
                      topic: widget.topicId,
                    ),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: AnimatedProgressWidget(
                              title: "No HomeWork uploaded",
                              desc:
                                  "There are no assignment uploaded by the student's",
                              animationPath: "assets/json/nodata.json",
                              animatorHeight: 250,
                            ),
                          );
                        }
                        logger.d(snapshot.data!.length);
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              color += 1;
                              if (color % 6 == 0) {
                                color = 0;
                              }

                              imageController.updateTextEditingControllers(
                                  TextEditingController(
                                      text: snapshot.data!
                                                  .elementAt(index)
                                                  .iHWUPLMarks ==
                                              null
                                          ? "0"
                                          : snapshot.data!
                                              .elementAt(index)
                                              .iHWUPLMarks
                                              .toString()));

                              return VerifyHwCwItem(
                                forHw: widget.forHw,
                                imageController: imageController,
                                marks: imageController.textEditingControllers
                                    .elementAt(index),
                                model: snapshot.data!.elementAt(0),
                                color: lighterColor.elementAt(color),
                                base: baseUrlFromInsCode(
                                    "portal", widget.mskoolController),
                                miId: widget.loginSuccessModel.mIID!,
                                loginSuccessModel: widget.loginSuccessModel,
                                asmayId: widget.asmayId,
                                selectAll: selectAll,
                                onSelect: (b) {
                                  if (b) {
                                    for (var element
                                        in imageController.filteredAttachment) {
                                      if (element.amstId ==
                                          snapshot.data!
                                              .elementAt(index)
                                              .aMSTId) {
                                        imageController
                                            .updateSaveAttachment(element);

                                        break;
                                      }
                                    }

                                    imageController.addSingleHwEntry(
                                        snapshot.data!.elementAt(index));
                                    imageController.addToSelectedEntry(
                                        imageController.textEditingControllers
                                            .elementAt(index));
                                    return;
                                  }
                                  for (var element
                                      in imageController.saveAttachment) {
                                    if (element.amstId ==
                                        snapshot.data!
                                            .elementAt(index)
                                            .aMSTId) {
                                      imageController.saveAttachment
                                          .remove(element);
                                      break;
                                    }
                                  }
                                  imageController.selectedEntry.remove(
                                      imageController.textEditingControllers
                                          .elementAt(index));
                                  imageController.hwList
                                      .remove(snapshot.data!.elementAt(index));
                                },
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 16.0,
                              );
                            },
                            itemCount: snapshot.data!.length);
                      }

                      if (snapshot.hasError) {
                        return ErrWidget(
                            err: snapshot.error as Map<String, dynamic>);
                      }
                      return const AnimatedProgressWidget(
                          title: "Loading uploaded Homework",
                          desc:
                              "Please wait while we load uploaded assignments for you.",
                          animationPath: "assets/json/default.json");
                    },
                  )
                : FutureBuilder<List<VerifyClassworkListValues>>(
                    future: GetCwApi.instance.getCwList(
                      miId: widget.loginSuccessModel.mIID!,
                      hrmeId: widget.loginSuccessModel.empcode!,
                      loginId: widget.loginSuccessModel.userId!,
                      userId: widget.loginSuccessModel.userId!,
                      ivrmrtId: widget.loginSuccessModel.roleId!,
                      roleFlag: "Staff",
                      asmayId: widget.asmayId,
                      ismsId: widget.ismsId,
                      asmclId: widget.asmclId,
                      asmsId: widget.asmsId,
                      fromDate: widget.fromDate,
                      toDate: widget.toDate,
                      base:
                          baseUrlFromInsCode("portal", widget.mskoolController),
                      controller: imageController,
                      topic: widget.topicId,
                    ),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: AnimatedProgressWidget(
                              title: "No Classwork uploaded",
                              desc:
                                  "There are no assignment uploaded by the student's",
                              animationPath: "assets/json/nodata.json",
                              animatorHeight: 250,
                            ),
                          );
                        }

                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              color += 1;
                              if (color % 6 == 0) {
                                color = 0;
                              }
                              imageController.updateTextEditingControllers(
                                  TextEditingController(
                                      text: snapshot.data!
                                                  .elementAt(index)
                                                  .iCWUPLMarks ==
                                              null
                                          ? "0"
                                          : snapshot.data!
                                              .elementAt(index)
                                              .iCWUPLMarks
                                              .toString()));
                              return VerifyHwCwItem(
                                asmayId: widget.asmayId,
                                imageController: imageController,
                                marks: imageController.textEditingControllers
                                    .elementAt(index),
                                base: baseUrlFromInsCode(
                                    "portal", widget.mskoolController),
                                color: lighterColor.elementAt(color),
                                forHw: widget.forHw,
                                loginSuccessModel: widget.loginSuccessModel,
                                miId: widget.loginSuccessModel.mIID!,
                                cwList: snapshot.data!.elementAt(index),
                                selectAll: selectAll,
                                onSelect: (b) {
                                  if (b) {
                                    for (var element
                                        in imageController.filteredAttachment) {
                                      if (element.amstId ==
                                          snapshot.data!
                                              .elementAt(index)
                                              .aMSTId) {
                                        imageController
                                            .updateSaveAttachment(element);

                                        break;
                                      }
                                    }
                                    imageController.addToCwList(
                                        snapshot.data!.elementAt(index));
                                    imageController.addToSelectedEntry(
                                        imageController.textEditingControllers
                                            .elementAt(index));
                                    return;
                                  }

                                  for (var element
                                      in imageController.saveAttachment) {
                                    if (element.amstId ==
                                        snapshot.data!
                                            .elementAt(index)
                                            .aMSTId) {
                                      imageController.saveAttachment
                                          .remove(element);
                                      break;
                                    }
                                  }

                                  imageController.selectedEntry.remove(
                                      imageController.textEditingControllers
                                          .elementAt(index));
                                  imageController.cwList
                                      .remove(snapshot.data!.elementAt(index));
                                },
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 16.0,
                              );
                            },
                            itemCount: snapshot.data!.length);
                      }
                      if (snapshot.hasError) {
                        return ErrWidget(
                            err: snapshot.error as Map<String, dynamic>);
                      }
                      return const AnimatedProgressWidget(
                          title: "Loading uploaded Classwork",
                          desc:
                              "Please wait while we load uploaded assignments for you.",
                          animationPath: "assets/json/default.json");
                    }),
          ],
        ),
      ),
    );
  }

  void saveHw() {
    bool someWhereMarksisNotThere = false;

    if (imageController.selectedEntry.isEmpty) {
      Fluttertoast.showToast(
          msg: "Before saving please verify at least one student");
      return;
    }

    for (int i = 0; i < imageController.selectedEntry.length; i++) {
      if (imageController.selectedEntry.elementAt(i).text.isEmpty) {
        someWhereMarksisNotThere = true;
        break;
      }
    }

    if (someWhereMarksisNotThere) {
      Fluttertoast.showToast(
          msg:
              "Somewhere you missed to provide marks.. You can provide marks to continue or uncheck the checkbox");

      return;
    }

    Map<String, dynamic> saveJson = {
      "MI_Id": widget.loginSuccessModel.mIID,
      "HRME_Id": widget.loginSuccessModel.empcode,
      "Login_Id": widget.loginSuccessModel.userId,
      "UserId": widget.loginSuccessModel.userId,
      "IVRMRT_Id": widget.loginSuccessModel.roleId,
      "Role_flag": "Staff",
    };

    final List<Map<String, dynamic>> getClassworkList = [];
    for (int i = 0; i < imageController.hwList.length; i++) {
      Map<String, dynamic> stuDet = {
        "AMST_Id": imageController.hwList.elementAt(i).aMSTId,
        "IHW_Id": imageController.hwList.elementAt(i).iHWId,
        "IHWUPL_Id": imageController.hwList.elementAt(i).iHWUPLId,
        "Marks": imageController.selectedEntry.elementAt(i).text,
        // "ICWUPL_FileName": "filename",
        // "ICWUPL_StaffUplaod": "filename",
        "IHWUPL_StaffRemarks": "",
      };

      if (imageController.hwCwModel.isNotEmpty) {
        final UploadAttModel att = imageController.hwCwModel.firstWhere(
            (element) =>
                imageController.hwList.elementAt(i).aMSTId == element.amstId,
            orElse: () => UploadAttModel(
                amstId: -1, model: UploadHwCwModel(name: "", path: "")));
        if (att.amstId == -1) {
          stuDet.addAll({
            "IHWUPL_FileName": "",
            "IHWUPL_StaffUpload": "",
          });
        } else {
          stuDet.addAll({
            "IHWUPL_FileName": att.model.name,
            "IHWUPL_StaffUpload": att.model.path,
          });
        }
      }

      final FilteredAttachment att = imageController.saveAttachment.firstWhere(
          (element) =>
              imageController.hwList.elementAt(i).aMSTId == element.amstId);

      stuDet.addAll({"doclist_temp": att.attachments});
      getClassworkList.add(stuDet);
    }

    saveJson.addAll({
      "gethomework_list_array": getClassworkList,
    });

    logger.d(saveJson);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            child: FutureBuilder(
                future: SaveApi.instance.saveNow(
                    base: baseUrlFromInsCode("portal", widget.mskoolController),
                    body: saveJson,
                    forHw: widget.forHw),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            minRadius: 36,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 36.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Updation Successfully",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(
                                  const TextStyle(fontWeight: FontWeight.w600),
                                ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          MSkollBtn(
                              title: "Ok Understood",
                              onPress: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return ErrWidget(
                        err: snapshot.error as Map<String, dynamic>);
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      AnimatedProgressWidget(
                          title: "Updating Marks",
                          desc: "Please wait while we update marks for you..",
                          animationPath: "assets/json/default.json"),
                    ],
                  );
                }),
          );
        });
  }
}
