import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/interaction/api/staff_interaction_compose_related_api.dart';
import 'package:m_skool_flutter/vms/interaction/controller/staff_interaction_compose_related_controller.dart';
import 'package:m_skool_flutter/vms/interaction/model/interaction_staff_list_mode.dart';
import 'package:m_skool_flutter/vms/interaction/widget/student_list_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ComposeTabStaff extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final TabController tabController;
  final bool animateToInbox;
  const ComposeTabStaff({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.tabController,
    required this.animateToInbox,
  });

  @override
  State<ComposeTabStaff> createState() => _ComposeTabStaffState();
}

class _ComposeTabStaffState extends State<ComposeTabStaff> {
  final StaffInteractionComposeController staffInteractionComposeController =
      Get.put(StaffInteractionComposeController());
  final TextEditingController about = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final List<Map<String, dynamic>> arrayStudents = [];
  // final textFocus = FucusNode();
  final ScrollController _controller = ScrollController();
  InteractionStaffListModelValues? selectedstaff;
  RxBool selectAll = RxBool(false);
  RxBool selectAllStaff = RxBool(false);
  RxList<String> attachment = <String>[].obs;

  @override
  void dispose() {
    Get.delete<StaffInteractionComposeController>();
    super.dispose();
  }

  void addStudentInList(int amstId, String empName) {
    arrayStudents.add({"HRME_Id": amstId, "employeeName": empName});
    logger.d(arrayStudents);
  }

  void removeFromStudentInList(int amstId, String empName) {
    arrayStudents.removeWhere((v) => v['HRME_Id'] == amstId);
    arrayStudents.removeWhere((v) => v['employeeName'] == empName);
    logger.d(arrayStudents);
  }

  changeTabAfterCompose(bool value) async {
    if (value) {
      Fluttertoast.showToast(msg: 'Compose successfully');
      widget.tabController.animateTo(1);
      return;
    }
    Fluttertoast.showToast(msg: 'Something went wrong');
  }

  // Future<void> documentToNetworkUrl(String filePath) async {
  //   var document = await jpgToNetworkImageUrl(
  //       base: baseUrlFromInsCode('login', widget.mskoolController),
  //       image: filePath,
  //       miId: widget.loginSuccessModel.mIID!);

  //   attachment.add(document!);
  // }

  _gettaffList() async {
    staffInteractionComposeController.dataLoading(true);
    await InteractionStaffListAPI.instance.getStaffList(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        staffInteractionComposeController: staffInteractionComposeController,
        asmayId: widget.loginSuccessModel.asmaYId!,
        flag: 'A',
        irmrtId: widget.loginSuccessModel.roleId!,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!);
    if (staffInteractionComposeController.interactionStaffList.isNotEmpty) {
      selectedstaff =
          staffInteractionComposeController.interactionStaffList.first;
    }
    staffInteractionComposeController.dataLoading(false);
  }

  @override
  void initState() {
    _gettaffList();
    if (widget.animateToInbox) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.tabController.animateTo(1);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 33,
                  width: 130,
                  child: RadioListTile(
                    dense: true,
                    activeColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    visualDensity: const VisualDensity(horizontal: -4.0),
                    title: Text(
                      "Group",
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                    value: "Group",
                    groupValue:
                        staffInteractionComposeController.grpOrInd.value,
                    onChanged: (value) {
                      setState(() {
                        staffInteractionComposeController
                            .groupOrIndividual(value!);
                        _gettaffList();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 33,
                  width: 140,
                  child: RadioListTile(
                    dense: true,
                    activeColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    visualDensity: const VisualDensity(horizontal: -4.0),
                    title: Text(
                      "Individual",
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                    value: "Individual",
                    groupValue:
                        staffInteractionComposeController.grpOrInd.value,
                    onChanged: (value) {
                      setState(() {
                        staffInteractionComposeController
                            .groupOrIndividual(value!);
                        arrayStudents.clear();
                        _gettaffList();
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: CustomContainer(
                child: TextField(
                  style: Theme.of(context).textTheme.titleSmall,
                  controller: subject,
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
                            " Subject ",
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
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
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomContainer(
                child: TextField(
                  style: Theme.of(context).textTheme.titleSmall,
                  controller: about,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: const Color(0xFFDBFDF5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30.0,
                            child: Image.asset(
                              "assets/images/abouticon.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            " About ",
                            style:
                                Theme.of(context).textTheme.labelMedium!.merge(
                                      const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF47BA9E),
                                      ),
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
            const SizedBox(
              height: 10,
            ),
            staffInteractionComposeController.grpOrInd.value == 'Individual'
                ? staffInteractionComposeController.isDataLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
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
                        child: DropdownButtonFormField<
                            InteractionStaffListModelValues>(
                          value: selectedstaff,
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
                            hintText: 'select',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 4),
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(229, 243, 255, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/selectteachericon.png',
                                    height: 26,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Select Staff',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0,
                                            color:
                                                Color.fromRGBO(60, 120, 170, 1),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
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
                            staffInteractionComposeController
                                .interactionStaffList.length,
                            (index) {
                              return DropdownMenuItem(
                                value: staffInteractionComposeController
                                    .interactionStaffList
                                    .elementAt(index),
                                child: Text(
                                  staffInteractionComposeController
                                      .interactionStaffList
                                      .elementAt(index)
                                      .employeeName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3)),
                                ),
                              );
                            },
                          ),
                          onChanged: (s) {
                            setState(() {
                              selectedstaff = s;
                              arrayStudents.add({
                                "HRME_Id": s!.hRMEId,
                                "employeeName": s.employeeName
                              });
                            });
                          },
                        ),
                      )
                : const SizedBox(),
            staffInteractionComposeController.grpOrInd.value == 'Group'
                ? staffInteractionComposeController.isStudent.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 230,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              padding: const EdgeInsets.only(top: 5, bottom: 6),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: RawScrollbar(
                                thumbColor: const Color(0xFF1E38FC),
                                trackColor:
                                    const Color.fromRGBO(223, 239, 253, 1),
                                trackRadius: const Radius.circular(10),
                                trackVisibility: true,
                                radius: const Radius.circular(10),
                                thickness: 14,
                                thumbVisibility: true,
                                controller: _controller,
                                child: SizedBox(
                                  height: 200,
                                  child: SingleChildScrollView(
                                    controller: _controller,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          child: CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                            dense: true,
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8),
                                            visualDensity: const VisualDensity(
                                                horizontal: -4.0),
                                            title: Text(
                                              'Select all',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .merge(const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.3)),
                                            ),
                                            value: selectAll.value,
                                            onChanged: (value) {
                                              selectAll.value = value!;

                                              if (value) {
                                                arrayStudents.clear();
                                                for (var i = 0;
                                                    i <
                                                        staffInteractionComposeController
                                                            .interactionStaffList
                                                            .length;
                                                    i++) {
                                                  arrayStudents.add({
                                                    "HRME_Id":
                                                        staffInteractionComposeController
                                                            .interactionStaffList
                                                            .elementAt(i)
                                                            .hRMEId,
                                                    "employeeName":
                                                        staffInteractionComposeController
                                                            .interactionStaffList
                                                            .elementAt(i)
                                                            .employeeName
                                                  });
                                                }
                                                logger.d(arrayStudents);
                                                return;
                                              }
                                              arrayStudents.clear();
                                              logger.d(arrayStudents);
                                            },
                                          ),
                                        ),
                                        Column(
                                          children: List.generate(
                                              staffInteractionComposeController
                                                  .interactionStaffList
                                                  .length, (index) {
                                            return StudentListWidget(
                                              data:
                                                  staffInteractionComposeController
                                                      .interactionStaffList
                                                      .elementAt(index),
                                              function: addStudentInList,
                                              function1:
                                                  removeFromStudentInList,
                                              selectAll: selectAll.value,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              left: 30,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(229, 243, 255, 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/selectteachericon.png',
                                      height: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Select Staff',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(
                                            const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0,
                                              color: Color.fromRGBO(
                                                  60, 120, 170, 1),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                : const SizedBox(),
            const SizedBox(height: 40),
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
                  if (about.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Enter About");
                  } else if (subject.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Enter Subject");
                  } else {
                    staffInteractionComposeController.issubmitloading(true);
                    if (staffInteractionComposeController.grpOrInd.value ==
                        'Group') {
                      await submitComposeStaff(
                        data: {
                          "MI_Id": widget.loginSuccessModel.mIID,
                          "ASMAY_Id": widget.loginSuccessModel.asmaYId,
                          "UserId": widget.loginSuccessModel.userId,
                          "Role_flag": "S",
                          "roletype": widget.loginSuccessModel.roleforlogin,
                          "IVRMRT_Id": widget.loginSuccessModel.roleId,
                          "ISMINTR_GroupOrIndFlg": "G",
                          "ISMINTR_Subject": subject.text,
                          "ISMINTR_Interaction": about.text,
                          "arraymessage": arrayStudents
                        },
                        base: baseUrlFromInsCode(
                          'issuemanager',
                          widget.mskoolController,
                        ),
                      ).then((value) {
                        changeTabAfterCompose(value);
                      });
                    } else if (staffInteractionComposeController
                            .grpOrInd.value ==
                        'Individual') {
                      await submitComposeIndivisual(
                        data: {
                          "MI_Id": widget.loginSuccessModel.mIID,
                          "ASMAY_Id": widget.loginSuccessModel.asmaYId,
                          "UserId": widget.loginSuccessModel.userId,
                          "Role_flag": "S",
                          "roletype": "Staff",
                          "IVRMRT_Id": widget.loginSuccessModel.roleId,
                          "ISMINTR_GroupOrIndFlg": "I",
                          "ISMINTR_Subject": subject.text,
                          "ISMINTR_Interaction": about.text,
                          "ISMINTRD_ToId": selectedstaff!.hRMEId,
                        },
                        base: baseUrlFromInsCode(
                          'issuemanager',
                          widget.mskoolController,
                        ),
                      ).then((value) {
                        changeTabAfterCompose(value);
                      });
                    }

                    staffInteractionComposeController.issubmitloading(false);
                  }
                },
                child: staffInteractionComposeController.isSubmit.value
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Submit',
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.3,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
