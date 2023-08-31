import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/attach_files.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/widget/references_widget.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/api/save_notice.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/staff_widget.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/widget/student_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class NewNoticeTabScreen extends StatefulWidget {
  final NoticeBoardController noticeBoardController;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwController hwCwController;
  const NewNoticeTabScreen(
      {super.key,
      required this.noticeBoardController,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.hwCwController});

  @override
  State<NewNoticeTabScreen> createState() => _NewNoticeTabScreenState();
}

class _NewNoticeTabScreenState extends State<NewNoticeTabScreen> {
  final _controller = ScrollController();
  TextEditingController description = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController displayDate = TextEditingController();

  List<String> noticeType = [
    "Others",
    'Syllabus',
    'Timetable',
    "Portion",
  ];

  List<String> noticeTitle = [
    'Demo',
    'Demo1',
    'Demo2',
    'Demo3',
  ];
  String selectedNoticeType = 'Others';
  String selectedNoticeTitle = 'Demo1';

  RxBool wantToProvideReference = RxBool(false);
  RxString forStudent = RxString("stu");
  RxBool forStu = RxBool(false);
  RxBool forStaff = RxBool(false);
  RxBool isStartDateProvided = RxBool(false);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      forStu.value = !forStu.value;
                    },
                    child: Obx(() {
                      return AnimatedContainer(
                          height: 18,
                          width: 18,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              border: forStu.value
                                  ? null
                                  : Border.all(color: Colors.grey, width: 2.0)),
                          child: forStu.value
                              ? Image.asset("assets/images/checkbox.png")
                              : null);
                    }),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "Student",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
              const SizedBox(
                width: 24.0,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      forStaff.value = !forStaff.value;
                    },
                    child: Obx(() {
                      return AnimatedContainer(
                          height: 18,
                          width: 18,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              border: forStaff.value
                                  ? null
                                  : Border.all(color: Colors.grey, width: 2.0)),
                          child: forStaff.value
                              ? Image.asset(
                                  "assets/images/checkbox.png",
                                )
                              : null);
                    }),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "Staff",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 36,
          ),
          CustomContainer(
            child: DropdownButtonFormField<String>(
                value: widget.noticeBoardController.noticeType.value,
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
                      color: const Color(0xFFDFFBFE),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/noteicon.svg',
                          color: const Color.fromRGBO(40, 182, 200, 1),
                          height: 24,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " Notice Type ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(40, 182, 200, 1),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
                items: List.generate(
                  noticeType.length,
                  (index) => DropdownMenuItem(
                    value: noticeType[index],
                    child: Text(
                      noticeType[index],
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                  ),
                ),
                onChanged: (e) {
                  widget.noticeBoardController.noticeType.value = e!;
                }),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),

              controller: widget.noticeBoardController.noticeTitle.value,
              // maxLines: 5,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 46, right: 16, left: 12),
                border: const OutlineInputBorder(),
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEA),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/noteicon.svg',
                        color: const Color.fromRGBO(255, 111, 103, 1),
                        height: 24,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Notice Title ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(255, 111, 103, 1),
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
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
              controller: widget.noticeBoardController.desc.value,
              maxLines: 5,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBFDF5),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/file-text.svg",
                        color: const Color.fromRGBO(71, 186, 158, 1),
                        height: 24,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Description ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(71, 186, 158, 1),
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
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              controller: startDate,
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
              readOnly: true,
              //maxLines: 4,
              onTap: () async {
                if (widget.noticeBoardController.endDt.value.year ==
                        DateTime.now().year &&
                    widget.noticeBoardController.endDt.value.day ==
                        DateTime.now().day &&
                    widget.noticeBoardController.endDt.value.month ==
                        DateTime.now().month) {
                  widget.noticeBoardController.endDt.value =
                      DateTime(DateTime.now().year + 1);
                }
                var date = await showDatePicker(
                  context: context,
                  initialDate: widget.noticeBoardController.startDt.value,
                  firstDate: widget.noticeBoardController.startDt.value,
                  lastDate: widget.noticeBoardController.endDt.value,
                );
                if (date != null) {
                  startDate.text =
                      "${numberList[date.day]}-${numberList[date.month]}-${date.year}";
                  widget.noticeBoardController.startDt.value = date;
                }
              },
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/svg/calendar_icon.svg",
                    color: const Color(0xFF3E78AA),
                    height: 24.0,
                  ),
                ),
                contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                border: const OutlineInputBorder(),
                label: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xFFE5F3FF)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/calendar_icon.svg",
                        color: const Color(0xFF3E78AA),
                        height: 24.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Start Date ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF3E78AA),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                hintText: 'Select Date',
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
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              controller: endDate,
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
              readOnly: true,
              //maxLines: 4,
              onTap: () async {
                widget.noticeBoardController.endDt.value =
                    widget.noticeBoardController.startDt.value;
                var date = await showDatePicker(
                  context: context,
                  initialDate: widget.noticeBoardController.endDt.value,
                  firstDate: widget.noticeBoardController.startDt.value,
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (date != null) {
                  endDate.text =
                      "${numberList[date.day]}-${numberList[date.month]}-${date.year}";
                  widget.noticeBoardController.endDt.value = date;
                }
              },
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/svg/calendar_icon.svg",
                    color: const Color(0xFF6F58B4),
                    height: 24.0,
                  ),
                ),
                contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                border: const OutlineInputBorder(),
                label: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xFFEEE8FF)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/calendar_icon.svg",
                        color: const Color(0xFF6F58B4),
                        height: 24.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " End Date ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF6F58B4),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                hintText: 'Select Date',
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
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              controller: displayDate,
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
              readOnly: true,
              //maxLines: 4,
              onTap: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: widget.noticeBoardController.displayDt.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (date != null) {
                  displayDate.text =
                      "${numberList[date.day]}-${numberList[date.month]}-${date.year}";
                  widget.noticeBoardController.displayDt.value = date;
                }
              },
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/svg/calendar_icon.svg",
                    color: const Color(0xFFBBAC2C),
                    height: 24.0,
                  ),
                ),
                contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                border: const OutlineInputBorder(),
                label: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xFFFFFCE1)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/calendar_icon.svg",
                        color: const Color(0xFFBBAC2C),
                        height: 24.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Display Date ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFFBBAC2C),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                hintText: '(Optional)',
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
          ReferencesWidget(
            wantToProvideReference: wantToProvideReference,
            hwCwController: widget.hwCwController,
          ),
          const SizedBox(
            height: 16.0,
          ),
          AttachedFiles(
            hwCwController: widget.hwCwController,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Obx(() {
            return forStu.value
                ? StudentWidget(
                    controller: widget.noticeBoardController,
                    loginSuccessModel: widget.loginSuccessModel,
                    mskoolController: widget.mskoolController,
                  )
                : const SizedBox();
          }),
          Obx(() {
            return forStaff.value
                ? StaffWidget(
                    controller: widget.noticeBoardController,
                    loginSuccessModel: widget.loginSuccessModel,
                    mskoolController: widget.mskoolController)
                : const SizedBox();
          }),
          const SizedBox(
            height: 32,
          ),
          MSkollBtn(
            title: "Save Details",
            onPress: () {
              if (!forStaff.value && !forStu.value) {
                Fluttertoast.showToast(
                    msg:
                        "Please Select for whom you are creating notice i.e, Student or Staff");
                return;
              }

              if (widget.noticeBoardController.noticeTitle.value.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please provide notice title to continue");
                return;
              }

              if (widget.noticeBoardController.desc.value.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please provide notice desc to continue");
                return;
              }

              if (startDate.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please provide start date to continue");
                return;
              }

              if (endDate.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please provide end date to continue");
              }

              if (wantToProvideReference.value) {
                if (widget.hwCwController.textEditors.isEmpty) {
                  Fluttertoast.showToast(
                      msg:
                          "You selected to provide reference, but you didn't added any .. Try adding reference or uncheck reference");
                  return;
                }

                for (var element in widget.hwCwController.textEditors) {
                  if (element.text.isEmpty && !element.text.isURL) {
                    Fluttertoast.showToast(
                        msg:
                            "Please provide a valid url or somewhere you missed to provide reference");
                    continue;
                  }
                }
              }

              if (forStaff.value && forStu.value) {
                saveForBoth(context);
                return;
              }

              if (forStu.value) {
                saveForStudent(context);
                return;
              }

              if (forStaff.value) {
                saveForEmp(context);
                return;
              }
            },
            size: Size(Get.width * 0.4, 50),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  void saveForBoth(BuildContext context) {
    if (widget.noticeBoardController.selectedClasses.isEmpty) {
      Fluttertoast.showToast(
          msg:
              "It may happen that we are loading Please wait until it load's OR You didn't selected any classes ... Please do select one");
      return;
    }

    if (widget.noticeBoardController.selectedSections.isEmpty) {
      Fluttertoast.showToast(
          msg:
              "It may happen that we are loading Please wait until it load's OR You didn't selected any classes ... Please do select one");
      return;
    }

    if (widget.noticeBoardController.studentSelection.value &&
        widget.noticeBoardController.selectedStuden.isEmpty) {
      Fluttertoast.showToast(
          msg: "May be we are loading or you didn't selected any student");
      return;
    }

    if (widget.noticeBoardController.departments.isEmpty) {
      Fluttertoast.showToast(
          msg: "May be we are loading or you didn't selected any department");
      return;
    }

    if (widget.noticeBoardController.designation.isEmpty) {
      Fluttertoast.showToast(
          msg: "May be we are loading or you didn't selected any designation");
      return;
    }

    if (widget.noticeBoardController.selectedEmployee.isEmpty) {
      Fluttertoast.showToast(
          msg: "May be we are loading or you didn't selected any employee");
      return;
    }

    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(),
            child: FutureBuilder(
                future: StaffSaveNoticeApi.instance.saveForBoth(
                    asmayId: widget.loginSuccessModel.asmaYId!,
                    userId: widget.loginSuccessModel.userId!,
                    ivrmrtId: widget.loginSuccessModel.roleId!,
                    miId: widget.loginSuccessModel.mIID!,
                    title: widget.noticeBoardController.noticeTitle.value.text,
                    description: widget.noticeBoardController.desc.value.text,
                    displayDisableFlag: displayDate.text.isNotEmpty,
                    toStaffFlag: true,
                    toStudentFlag: true,
                    displayDate: displayDate.text.isEmpty
                        ? DateTime.now().toLocal().toString()
                        : widget.noticeBoardController.displayDt.value
                            .toLocal()
                            .toString(),
                    startDate: widget.noticeBoardController.startDt.value
                        .toLocal()
                        .toString(),
                    endDate: widget.noticeBoardController.endDt.value
                        .toLocal()
                        .toString(),
                    controller: widget.hwCwController,
                    base: baseUrlFromInsCode("portal", widget.mskoolController),
                    nbController: widget.noticeBoardController,
                    nTBTTSyllabusFlag: widget
                                .noticeBoardController.noticeType.value
                                .toLowerCase() ==
                            "others"
                        ? "O"
                        : widget.noticeBoardController.noticeType.value
                                    .toLowerCase() ==
                                "portion"
                            ? "P"
                            : widget.noticeBoardController.noticeType.value
                                        .toLowerCase() ==
                                    "syllabus"
                                ? "S"
                                : "TT"),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            minRadius: 28,
                            child: Icon(
                              Icons.check,
                              size: 36.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Successfully Saved",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          const Text(
                              "We have sent your notice to respective selection.."),
                          const SizedBox(
                            height: 12.0,
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
                    children: [
                      Obx(() {
                        return AnimatedProgressWidget(
                            title: "Please wait we are saving",
                            desc: widget.hwCwController.saveStatus.toString(),
                            animationPath: "assets/json/default.json");
                      })
                    ],
                  );
                }),
          );
        });
  }

  void saveForStudent(BuildContext context) {
    if (widget.noticeBoardController.selectedClasses.isEmpty) {
      Fluttertoast.showToast(
          msg:
              "It may happen that we are loading Please wait until it load's OR You didn't selected any classes ... Please do select one");
      return;
    }

    if (widget.noticeBoardController.selectedSections.isEmpty) {
      Fluttertoast.showToast(
          msg:
              "It may happen that we are loading Please wait until it load's OR You didn't selected any classes ... Please do select one");
      return;
    }

    if (widget.noticeBoardController.studentSelection.value &&
        widget.noticeBoardController.selectedStuden.isEmpty) {
      Fluttertoast.showToast(
          msg: "May be we are loading or you didn't selected any student");
      return;
    }

    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: FutureBuilder(
                future: StaffSaveNoticeApi.instance.saveForStudent(
                    asmayId: widget.loginSuccessModel.asmaYId!,
                    userId: widget.loginSuccessModel.userId!,
                    ivrmrtId: widget.loginSuccessModel.roleId!,
                    miId: widget.loginSuccessModel.mIID!,
                    title: widget.noticeBoardController.noticeTitle.value.text,
                    description: widget.noticeBoardController.desc.value.text,
                    displayDisableFlag: displayDate.text.isNotEmpty,
                    toStaffFlag: false,
                    toStudentFlag: true,
                    displayDate: displayDate.text.isEmpty
                        ? DateTime.now().toLocal().toString()
                        : widget.noticeBoardController.displayDt.value
                            .toLocal()
                            .toString(),
                    startDate: widget.noticeBoardController.startDt.value
                        .toLocal()
                        .toString(),
                    endDate: widget.noticeBoardController.endDt.value
                        .toLocal()
                        .toString(),
                    controller: widget.hwCwController,
                    base: baseUrlFromInsCode("portal", widget.mskoolController),
                    nbController: widget.noticeBoardController,
                    nTBTTSyllabusFlag: widget
                                .noticeBoardController.noticeType.value
                                .toLowerCase() ==
                            "others"
                        ? "O"
                        : widget.noticeBoardController.noticeType.value
                                    .toLowerCase() ==
                                "portion"
                            ? "P"
                            : widget.noticeBoardController.noticeType.value
                                        .toLowerCase() ==
                                    "syllabus"
                                ? "S"
                                : "TT"),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            minRadius: 28,
                            child: Icon(
                              Icons.check,
                              size: 36.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Successfully Saved",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          const Text(
                              "We have sent your notice to respective selection.."),
                          const SizedBox(
                            height: 12.0,
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
                    children: [
                      Obx(() {
                        return AnimatedProgressWidget(
                            title: "Please wait we are saving",
                            desc: widget.hwCwController.saveStatus.toString(),
                            animationPath: "assets/json/default.json");
                      })
                    ],
                  );
                }),
          );
        });
  }

  void saveForEmp(BuildContext context) {
    if (widget.noticeBoardController.departments.isEmpty) {
      Fluttertoast.showToast(
          msg: "May be we are loading or you didn't selected any department");
      return;
    }

    if (widget.noticeBoardController.designation.isEmpty) {
      Fluttertoast.showToast(
          msg: "May be we are loading or you didn't selected any designation");
      return;
    }

    if (widget.noticeBoardController.selectedEmployee.isEmpty) {
      Fluttertoast.showToast(
          msg: "May be we are loading or you didn't selected any employee");
      return;
    }
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(),
            child: FutureBuilder(
                future: StaffSaveNoticeApi.instance.saveForEmployee(
                    asmayId: widget.loginSuccessModel.asmaYId!,
                    userId: widget.loginSuccessModel.userId!,
                    ivrmrtId: widget.loginSuccessModel.roleId!,
                    miId: widget.loginSuccessModel.mIID!,
                    title: widget.noticeBoardController.noticeTitle.value.text,
                    description: widget.noticeBoardController.desc.value.text,
                    displayDisableFlag: displayDate.text.isNotEmpty,
                    toStaffFlag: true,
                    toStudentFlag: false,
                    displayDate: displayDate.text.isEmpty
                        ? DateTime.now().toLocal().toString()
                        : widget.noticeBoardController.displayDt.value
                            .toLocal()
                            .toString(),
                    startDate: widget.noticeBoardController.startDt.value
                        .toLocal()
                        .toString(),
                    endDate: widget.noticeBoardController.endDt.value
                        .toLocal()
                        .toString(),
                    controller: widget.hwCwController,
                    base: baseUrlFromInsCode("portal", widget.mskoolController),
                    nbController: widget.noticeBoardController),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            minRadius: 28,
                            child: Icon(
                              Icons.check,
                              size: 36.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Successfully Saved",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          const Text(
                              "We have sent your notice to respective selection.."),
                          const SizedBox(
                            height: 12.0,
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
                    children: [
                      Obx(() {
                        return AnimatedProgressWidget(
                            title: "Please wait we are saving",
                            desc: widget.hwCwController.saveStatus.toString(),
                            animationPath: "assets/json/default.json");
                      })
                    ],
                  );
                }),
          );
        });
  }
}
