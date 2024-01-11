import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/gallery_view/widget/gallery_checkbox.container.dart';
import 'package:m_skool_flutter/student/homework/model/upload_hw_cw_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/city_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/clint_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_advance_apply/model/state_list_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/check_apply_planner_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/city_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/state_list_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/tada_apply_allowense_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/tada_apply_edit_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/tada_apply_save_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/widgets/applied_table_widget.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/widgets/select_state.dart';
import 'package:m_skool_flutter/vms/task%20creation/api/sava_task.dart';
import 'package:m_skool_flutter/vms/widgets/level_widget.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:open_filex/open_filex.dart';

class TadaApplyWidget extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final TadaApplyDataController tadaApplyDataController;
  int previousScreen;
  TadaApplyWidget(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.previousScreen,
      required this.tadaApplyDataController});

  @override
  State<TadaApplyWidget> createState() => _TadaApplyWidgetState();
}

class _TadaApplyWidgetState extends State<TadaApplyWidget> {
  // widget.tadaApplyDataController widget.tadaApplyDataController =
  //     Get.put(widget.tadaApplyDataController());
  final ScrollController _controller = ScrollController();
  final RxBool selectAllDepartment = RxBool(false);
  final _addressController = TextEditingController();
  final _remarkController = TextEditingController();
  final _extraAmountController = TextEditingController();
  final _remainingAmountController = TextEditingController();
  //
  StateListModelValues? stateListModelValues;
  CityListModelValues? citySelectedValue;
  //
  List<StateListModelValues> stateNew = [];
  List<ClintListModelValues> clintlist = [];
  //
  List addAmountType = ['Add Amount', 'Minus Amount'];
  bool amountSelectedValue1 = false;
  bool amountSelectedValue2 = false;
  //
  int stateId = 0;
  getStateList() async {
    // widget.tadaApplyDataController.stateLoading(true);
    // widget.tadaApplyDataController.cityListValues.clear();
    // await StateListAPI.instance.tadastateList(
    //     miId: widget.loginSuccessModel.mIID!,
    //     userId: widget.loginSuccessModel.userId!,
    //     base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
    //     tadaApplyController: widget.tadaApplyDataController);
    if (widget.tadaApplyDataController.stateList.isNotEmpty) {
      stateListModelValues = widget.tadaApplyDataController.stateList.first;
      for (int i = 0;
          i < widget.tadaApplyDataController.stateList.length;
          i++) {
        stateId =
            widget.tadaApplyDataController.stateList.elementAt(i).ivrmmSId!;
      }
    }
    // widget.tadaApplyDataController.stateLoading(false);
  }

//After apply
  void getState(int query) {
    stateNew = widget.tadaApplyDataController.stateList
        .where((value) => value.ivrmmSId! == (query))
        .toList();
    for (int i = 0; i < stateNew.length; i++) {
      state = stateNew[i].ivrmmSName ?? '';
    }
  }

  void getClint(int query) {
    clintlist = widget.tadaApplyDataController.clintListValues
        .where((value) => value.ismmclTId! == (query))
        .toList();
    for (int i = 0; i < clintlist.length; i++) {
      client += '${clintlist[i].ismmclTClientName}, ';
    }
  }

  String state = '';
  String city = '';
  String client = '';
  int advanceAmount = 0;
  int paidAmount = 0;
  int balanceAmount = 0;
  String address = '';
  String remarks = '';
  String date1 = '';
  String time1 = '';
  String date2 = '';
  String time2 = '';
  bool a = false;
  int vtadaaaId = 0;
  int ctId = 0;
  int vtadaaId = 0;

  savedDataListAPI() async {
    if (widget.tadaApplyDataController.tadaSavedData.isNotEmpty) {
      for (int index = 0;
          index < widget.tadaApplyDataController.tadaSavedData.length;
          index++) {
        DateTime dt1 = DateTime.parse(widget
            .tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAFromDate!);
        _startDate.text = '${dt1.day}:${dt1.month}:${dt1.year}';
        //
        DateTime dt2 = DateTime.parse(widget
            .tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAToDate!);
        _endDate.text = '${dt2.day}:${dt2.month}:${dt2.year}';
        //
        TimeOfDay startTime = TimeOfDay(
            hour: int.parse(widget.tadaApplyDataController.tadaSavedData[index]
                .vtadaaADepartureTime!
                .split(":")[0]),
            minute: int.parse(widget.tadaApplyDataController
                .tadaSavedData[index].vtadaaADepartureTime!
                .split(":")[1]));
        fromTime = startTime;
        _startTime.text =
            '${startTime.hourOfPeriod}:${startTime.minute} ${startTime.period.name.toUpperCase()}';
        fromDate = DateTime.parse(widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAFromDate!);
        toDate = DateTime.parse(widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAToDate!);
        widget.tadaApplyDataController.clintSelectedValues.first.ismmclTId =
            widget.tadaApplyDataController.tadaSavedData
                .elementAt(index)
                .ivrmmcTId;

        //
        TimeOfDay startTime2 = TimeOfDay(
            hour: int.parse(widget.tadaApplyDataController.tadaSavedData[index]
                .vtadaaADepartureTime!
                .split(":")[0]),
            minute: int.parse(widget.tadaApplyDataController
                .tadaSavedData[index].vtadaaADepartureTime!
                .split(":")[1]));
        toTime = startTime2;
        _endTime.text =
            '${startTime2.hourOfPeriod}:${startTime2.minute} ${startTime2.period.name.toUpperCase()}';
        //
        getState(widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .ivrmmSId!);
        getClint(widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAClientId!);
        city = widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .ivrmmcTName!;
        clintName = city;
        ctId = widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .ivrmmcTId!;
        advanceAmount = widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaATotalAppliedAmount!
            .toInt();
        paidAmount = widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaATotalPaidAmount!
            .toInt();
        balanceAmount = ((advanceAmount) - (paidAmount));
        allAmount += balanceAmount;
        address =
            '${widget.tadaApplyDataController.tadaSavedData.elementAt(index).vtadaaAToAddress}';
        remarks =
            '${widget.tadaApplyDataController.tadaSavedData.elementAt(index).vtadaaARemarks}';
        _remarkController.text = remarks;
        _addressController.text = address;
        clintId = widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAClientId!;
        vtadaaaId = widget.tadaApplyDataController.tadaSavedData
            .elementAt(index)
            .vtadaaAId!;
        // vtadaaId = widget.tadaApplyDataController.tadaSavedData.elementAt(index).vtadaa
      }
    }
  }

//
  getCity(int countryId, int stateId) async {
    widget.tadaApplyDataController.cityLoading(true);
    await CityListAPI.instance.tadaCityList(
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        countryId: countryId,
        stateId: stateId,
        tadaApplyController: widget.tadaApplyDataController);
    if (widget.tadaApplyDataController.tadaSavedData.isEmpty) {
      if (widget.tadaApplyDataController.cityListValues.isEmpty) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                iconPadding: const EdgeInsets.symmetric(horizontal: 16),
                contentPadding: const EdgeInsets.all(12),
                backgroundColor: Colors.white,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "City is not Mapped !",
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              Get.back();
                            });
                          },
                          child: Text(
                            "OK",
                            style: Get.textTheme.titleMedium,
                          ))
                    ],
                  ),
                ),
              );
            });
      } else if (widget.tadaApplyDataController.cityListValues.isNotEmpty) {
        citySelectedValue = widget.tadaApplyDataController.cityListValues.last;
        getAllowenseData(citySelectedValue!.ivrmmcTId!);
      }
    }

    widget.tadaApplyDataController.cityLoading(false);
  }

  //Controller
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final _startTime = TextEditingController();
  final _endTime = TextEditingController();
  final _key = GlobalKey<FormState>();
  //Food
  final foodTotalSlotController = TextEditingController();
  final foodRemarksController = TextEditingController();
  bool isFoodSelected = false;
  bool isFoodTextField = false;
  //Accommodation
  final accommodationTotalSlotController = TextEditingController();
  final accommodationRemarksController = TextEditingController();
  bool isAccommodationSelected = false;
  bool isAccommodationTextField = false;
  //others
  final otherAmountController = TextEditingController();
  final otherremarksController = TextEditingController();
  bool isOthersSelected = false;
  bool isOthetrsTextField = false;
  //Date and time
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  String fromSelectedDate = '';
  String toSelectedDate = '';
  int dayCount = 0;
  List<Map<String, dynamic>> allowanceData = [];
  List<Map<String, dynamic>> uploadArray = [];
  double allAmount = 0;
  List<TextEditingController> allAmountController = [];
  void addTotalAmount() {
    int sum = 0;
    for (TextEditingController controller in allAmountController) {
      controller.addListener(() {
        int value = int.tryParse(controller.text) ?? 0;
        sum += value;
        logger.i(sum);
      });
    }
    setState(() {
      allAmount = double.parse(sum.toString());
      logger.e(allAmount);
    });
  }

  List<int> newList = [];
  void addRow(int value) {
    newList.add(value);
    for (int i = 0; i < newList.length; i++) {
      allAmountController.add(TextEditingController(text: ''));
      allAmountController[i].addListener(() {
        addTotalAmount();
      });
    }
    setState(() {});
  }

  void addAmount(double amount) {
    // int sum = 0;
    // sum += amount;
    allAmount += amount.toDouble();
  }

  void removeAmount(double amount) {
    allAmount -= amount;
  }

//

  double foodAmt = 0.0;
  double accommodationAmount = 0.0;
  double otherAmount = 0.0;
  getAllowenseData(int ctId) async {
    widget.tadaApplyDataController.allowenseLoading(true);
    await TadaAllowenceAPI.instance.getApplyAllowense(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        ivrmCtId: ctId,
        tadaApplyController: widget.tadaApplyDataController);
    widget.tadaApplyDataController.allowenseLoading(false);
  }

  //
  double foodSlot = 0.0;
  double accommudationSlot = 0.0;

  void calculateHour(String newStartDate, String startTime, String newEndDate,
      String endtime) {
    String startDateStr = '$newStartDate $startTime';
    String endDateStr = '$newEndDate $endtime';
    DateFormat dateFormat = DateFormat('dd:MM:yyyy hh:mm a');
    DateTime startDate = dateFormat.parse(startDateStr);
    DateTime endDate = dateFormat.parse(endDateStr);
    Duration duration = endDate.difference(startDate);
    double totalHours = duration.inSeconds / 3600.0;
    print('Total hours between the two dates: $totalHours hours');
    var fSlot = totalHours / 8;
    var aSlot = totalHours / 24;
    foodSlot = double.parse(fSlot.toStringAsFixed(0));
    accommudationSlot = double.parse(aSlot.toStringAsFixed(0));
  }

  List<UploadHwCwModel> uploadAttachment = [];

//

  saveData() async {
    String iRemarks = '';
    if (widget.tadaApplyDataController.addListBrowser.isNotEmpty) {
      for (int i = 0;
          i < widget.tadaApplyDataController.addListBrowser.length;
          i++) {
        iRemarks = widget.tadaApplyDataController.newRemarksController
            .elementAt(i)
            .text;
      }
    }

    for (var element in widget.tadaApplyDataController.addListBrowser) {
      try {
        uploadAttachment.add(await uploadAtt(
            miId: widget.loginSuccessModel.mIID!,
            file: File(element.file!.path)));
      } catch (e) {
        Fluttertoast.showToast(msg: "Please Upload Image");
        return Future.error({
          "errorTitle": "An Error Occured",
          "errorMsg":
              "While trying to upload attchement, we encountered an error"
        });
      }
    }
    for (var element in uploadAttachment) {
      uploadArray.add({
        "VTADAAF_FilePath": element.path,
        "VTADAAF_FileName": element.name,
        "VTADAAF_Remarks": iRemarks
      });
    }
    widget.tadaApplyDataController.saveData(true);
    await TadaSaveApi.instance.tadaApplySave(
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        ctId: ((widget.tadaApplyDataController.tadaSavedData.isEmpty))
            ? citySelectedValue!.ivrmmcTId!
            : ctId,
        fromDate: fromDate!.toIso8601String(),
        toDate: toDate!.toIso8601String(),
        clintId: clintId,
        totalAppliedAmount: (_extraAmountController.text.isNotEmpty)
            ? double.parse(allAmount.toString())
            : 0,
        toAddress: _addressController.text,
        remarks: _remarkController.text,
        vtadaaaId: vtadaaaId,
        departureTime: _startTime.text,
        arrivalTime: _endTime.text,
        clintMultiple: clintName,
        allowanceArray: allowanceData,
        tadaApplyController: widget.tadaApplyDataController,
        fileList: uploadArray,
        vtadaaId: (widget.tadaApplyDataController.tadaSavedData.isNotEmpty)
            ? widget.tadaApplyDataController.tadaSavedData.first.vtadaaAId!
            : 0,
        extraBalance: double.parse(_extraAmountController.text),
        finalDocument: isFinalSubmition);
    widget.tadaApplyDataController.saveData(false);
    getStateList();
    Get.back();
  }

//
  checkPlanner() async {
    widget.tadaApplyDataController.plannerCreate(true);
    await CheckPlannerAPI.instance.applyCheckPlannerAPI(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        fromDate: fromSelectedDate,
        toDate: toSelectedDate,
        tadaApplyController: widget.tadaApplyDataController);
    if (widget.tadaApplyDataController.checkPlanner.isEmpty) {
      Get.dialog(showPopup());
      _startDate.clear();
      _endDate.clear();
    }
    widget.tadaApplyDataController.plannerCreate(false);
  }

//
  editData(int id) {
    widget.tadaApplyDataController.editData(true);
    TadaEditAPI.instance.tadaApplyEditData(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        vtadaaaId: id,
        tadaApplyController: widget.tadaApplyDataController);
    getStateList();
    widget.tadaApplyDataController.editData(false);
  }

  //
  bool checked = false;
  int clintId = 0;
  String clintName = '';
  //File Picker
  addItemListBrowse(int val, String name) {
    setState(() {
      widget.tadaApplyDataController.addListBrowser.add(AtachmentFile(
        id: val,
        FileName: name,
      ));
      for (int i = 0;
          i < widget.tadaApplyDataController.addListBrowser.length;
          i++) {
        widget.tadaApplyDataController.newRemarksController
            .add(TextEditingController(text: ''));
      }
    });
  }

  void removeRow(int value) {
    setState(() {
      widget.tadaApplyDataController.newList.removeAt(value);
    });
  }

  Future<void> pickImage(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'pdf'
      ],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      XFile xFile = XFile(file.path);
      widget.tadaApplyDataController.addListBrowser[index].file = xFile;
      widget.tadaApplyDataController.addListBrowser[index].FileName =
          result.names.first;
      setState(() {});
    } else {
      Fluttertoast.showToast(msg: "Image Is not Uploaded Please try Again");
    }
  }

  removeItemListBrowse(int val) {
    widget.tadaApplyDataController.addListBrowser.removeAt(val);
    setState(() {});
  }

  //File Picker
  @override
  void initState() {
    getStateList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      stateNew;
    });
    savedDataListAPI();
    addRow(1);

    setState(() {
      addItemListBrowse(0, '');
    });
    super.initState();
  }

  bool isFinalSubmition = true;
  @override
  void dispose() {
    widget.tadaApplyDataController.tadaSavedData.clear();
    widget.tadaApplyDataController.addListBrowser.clear();
    widget.previousScreen = 0;
    allowanceData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Note:",
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 8),
                Text(
                  "* TA-DA Should Be Applied with 48 Hours of Arrival",
                  style: Get.textTheme.titleSmall!
                      .copyWith(color: Colors.red, fontSize: 10),
                ),
                Text(
                  "* If Daily Report Not Generated TADA Not Applicable",
                  style: Get.textTheme.titleSmall!
                      .copyWith(color: Colors.red, fontSize: 10),
                ),
                Text(
                  "* New TADA is not applicable until previous TADA is settled",
                  style: Get.textTheme.titleSmall!
                      .copyWith(color: Colors.red, fontSize: 10),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomContainer(
                    child: TextField(
                      style: Theme.of(context).textTheme.titleSmall,
                      readOnly: true,
                      controller: _startDate,
                      onTap: () async {
                        fromDate = await showDatePicker(
                          context: context,
                          helpText: "Select Data",
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          initialDate: DateTime.now(),
                          lastDate: DateTime.now(),
                        );
                        if (fromDate != null) {
                          setState(() {
                            _endDate.clear();
                            _startTime.clear();
                            _endTime.clear();

                            _startDate.text =
                                "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                            fromSelectedDate =
                                '${numberList[fromDate!.month]}-${numberList[fromDate!.day]}-${fromDate!.year}';
                          });
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            fromDate = await showDatePicker(
                              helpText: "Select Data",
                              context: context,
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 30)),
                              initialDate: DateTime.now(),
                              lastDate: DateTime.now(),
                            );

                            if (fromDate != null) {
                              setState(() {
                                _endDate.clear();
                                _startTime.clear();
                                _endTime.clear();

                                _startDate.text =
                                    "${numberList[fromDate!.day]}:${numberList[fromDate!.month]}:${fromDate!.year}";
                                fromSelectedDate =
                                    '${numberList[fromDate!.month]}-${numberList[fromDate!.day]}-${fromDate!.year}';
                              });
                            }
                          },
                          icon: SvgPicture.asset(
                            "assets/svg/calendar_icon.svg",
                            color: const Color(0xFF3E78AA),
                            height: 18,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 40.0, left: 12),
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
                                height: 18,
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                " Start Date ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                        fontSize: 18.0,
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
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: CustomContainer(
                    child: TextField(
                      readOnly: true,
                      style: Theme.of(context).textTheme.titleSmall,
                      controller: _endDate,
                      onTap: () async {
                        if (_startDate.text.isNotEmpty) {
                          toDate = await showDatePicker(
                            context: context,
                            helpText: "Select Date",
                            initialDate:
                                DateTime.parse(fromDate!.toIso8601String()),
                            firstDate:
                                DateTime.parse(fromDate!.toIso8601String()),
                            lastDate: DateTime.now(),
                          );
                          if (toDate != null) {
                            setState(() {
                              _startTime.clear();
                              _endTime.clear();

                              _endDate.text =
                                  "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                              dayCount =
                                  toDate!.difference(fromDate!).inDays + 1;
                              toSelectedDate =
                                  '${numberList[toDate!.month]}-${numberList[toDate!.day]}-${toDate!.year}';
                              checkPlanner();
                            });
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Select Start Date");
                        }
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(top: 40.0, left: 12),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (_startDate.text.isNotEmpty) {
                              toDate = await showDatePicker(
                                context: context,
                                helpText: "Select Date",
                                initialDate:
                                    DateTime.parse(fromDate!.toIso8601String()),
                                firstDate:
                                    DateTime.parse(fromDate!.toIso8601String()),
                                lastDate: DateTime.now(),
                              );
                              if (toDate != null) {
                                setState(() {
                                  _startTime.clear();
                                  _endTime.clear();

                                  _endDate.text =
                                      "${numberList[toDate!.day]}:${numberList[toDate!.month]}:${toDate!.year}";
                                  dayCount =
                                      toDate!.difference(fromDate!).inDays + 1;
                                  toSelectedDate =
                                      '${numberList[toDate!.month]}-${numberList[toDate!.day]}-${toDate!.year}';
                                  checkPlanner();
                                });
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please Select Start Date");
                            }
                          },
                          icon: SvgPicture.asset(
                            "assets/svg/calendar_icon.svg",
                            color: const Color(0xFF3E78AA),
                            height: 18,
                          ),
                        ),
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
                                height: 18,
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                " End Date ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xFF3E78AA)),
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
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomContainer(
                    child: TextField(
                      style: Theme.of(context).textTheme.titleSmall,
                      readOnly: true,
                      controller: _startTime,
                      onTap: () async {
                        if (_endDate.text.isNotEmpty) {
                          fromTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dialOnly,
                              builder: (context, childWidget) {
                                return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: false),
                                    child: childWidget!);
                              });

                          if (fromTime != null) {
                            _startTime.text =
                                '${numberList[fromTime!.hourOfPeriod]}:${numberList[fromTime!.minute]} ${fromTime!.period.name.toUpperCase()}';
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Please select Date");
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.watch_later_outlined,
                          color: Color(0xFF3E78AA),
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 40.0, left: 12),
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
                              const Icon(
                                Icons.watch_later_outlined,
                                color: Color(0xFF3E78AA),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                " Start Time ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xFF3E78AA),
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Select Time',
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
                  width: 12.0,
                ),
                Expanded(
                  child: CustomContainer(
                    child: TextField(
                      readOnly: true,
                      style: Theme.of(context).textTheme.titleSmall,
                      controller: _endTime,
                      onTap: () async {
                        if (fromTime != null) {
                          toTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                  hour: fromTime!.hour,
                                  minute: fromTime!.minute),
                              builder: (context, childWidget) {
                                return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: false),
                                    child: childWidget!);
                              });
                          if (toTime != null) {
                            _endTime.text =
                                '${numberList[toTime!.hourOfPeriod]}:${numberList[toTime!.minute]} ${toTime!.period.name.toUpperCase()}';
                            calculateHour(_startDate.text, _startTime.text,
                                _endDate.text, _endTime.text);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Select Start Time");
                        }
                      },
                      decoration: InputDecoration(
                        // isDense: true,
                        suffixIcon: const Icon(
                          Icons.watch_later_outlined,
                          color: Color(0xFF3E78AA),
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 40.0, left: 12),

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
                              const Icon(
                                Icons.watch_later_outlined,
                                color: Color(0xFF3E78AA),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                " Arrival Time ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xFF3E78AA)),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Select Time',
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
              ],
            ),
          ),
          (widget.tadaApplyDataController.tadaSavedData.isEmpty)
              ? (widget.tadaApplyDataController.isStateLoading.value)
                  ? const Center(
                      child: AnimatedProgressWidget(
                          title: "Loading TA-DA Entry",
                          desc:
                              "Please wait while we load TA-DA entry and create a view for you.",
                          animationPath: "assets/json/default.json"),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.tadaApplyDataController.stateList.isEmpty
                            ? const SizedBox()
                            : Container(
                                margin: const EdgeInsets.only(
                                    top: 30, bottom: 0, left: 16, right: 16),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 8,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                child: DropdownButtonFormField<
                                    StateListModelValues>(
                                  value: stateListModelValues,
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
                                    hintText: widget.tadaApplyDataController
                                            .stateList.isNotEmpty
                                        ? 'Select State'
                                        : "No data available.",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDFFBFE),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/images/cap.png",
                                            height: 28.0,
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " State",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                      backgroundColor:
                                                          Color(0xFFDFFBFE),
                                                      fontSize: 20.0,
                                                      color: Color(0xFF28B6C8)),
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
                                      widget.tadaApplyDataController.stateList
                                          .length, (index) {
                                    return DropdownMenuItem(
                                      value: widget.tadaApplyDataController
                                          .stateList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 13, left: 5),
                                        child: Text(
                                          widget.tadaApplyDataController
                                              .stateList[index].ivrmmSName!,
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
                                  onChanged: (s) {
                                    if (_endTime.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Select Arrival Time");
                                      return;
                                    }
                                    stateListModelValues = s!;
                                    getCity(stateListModelValues!.ivrmmCId!,
                                        stateListModelValues!.ivrmmSId!);
                                  },
                                ),
                              ),
                        widget.tadaApplyDataController.isCityLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : widget.tadaApplyDataController.cityListValues
                                    .isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        top: 30,
                                        bottom: 0,
                                        right: 16,
                                        left: 16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 8,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child: DropdownButtonFormField<
                                        CityListModelValues>(
                                      value: citySelectedValue,
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
                                        hintText: widget.tadaApplyDataController
                                                .cityListValues.isNotEmpty
                                            ? 'Select City'
                                            : "No data available.",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFDFFBFE),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 6.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/cap.png",
                                                height: 28.0,
                                              ),
                                              const SizedBox(
                                                width: 6.0,
                                              ),
                                              Text(
                                                " City",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(
                                                      const TextStyle(
                                                          backgroundColor:
                                                              Color(0xFFDFFBFE),
                                                          fontSize: 20.0,
                                                          color: Color(
                                                              0xFF28B6C8)),
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
                                          widget.tadaApplyDataController
                                              .cityListValues.length, (index) {
                                        return DropdownMenuItem(
                                          value: widget.tadaApplyDataController
                                              .cityListValues[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 5),
                                            child: Text(
                                              widget
                                                  .tadaApplyDataController
                                                  .cityListValues[index]
                                                  .ivrmmcTName
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .merge(const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.3)),
                                            ),
                                          ),
                                        );
                                      }),
                                      onChanged: (s) {
                                        citySelectedValue = s!;
                                        getAllowenseData(
                                            citySelectedValue!.ivrmmcTId!);
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                        widget.tadaApplyDataController.clintListValues
                                .isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                    top: 30, left: 16, right: 16),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 160,
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
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
                                        trackColor: const Color.fromRGBO(
                                            223, 239, 253, 1),
                                        trackRadius: const Radius.circular(10),
                                        trackVisibility: true,
                                        radius: const Radius.circular(10),
                                        thickness: 14,
                                        thumbVisibility: true,
                                        controller: _controller,
                                        child: SingleChildScrollView(
                                          controller: _controller,
                                          child: ListView.builder(
                                            itemCount: widget
                                                .tadaApplyDataController
                                                .clintListValues
                                                .length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                  height: 35,
                                                  child: Obx(() {
                                                    return CheckBoxContainer(
                                                        sectionName:
                                                            "${widget.tadaApplyDataController.clintListValues.elementAt(index).ismmclTClientName}",
                                                        func: (b) {
                                                          setState(() {
                                                            if (b) {
                                                              widget
                                                                  .tadaApplyDataController
                                                                  .addSelectedValues(widget
                                                                      .tadaApplyDataController
                                                                      .clintListValues
                                                                      .elementAt(
                                                                          index));
                                                              clintId = widget
                                                                  .tadaApplyDataController
                                                                  .clintListValues
                                                                  .elementAt(
                                                                      index)
                                                                  .ismmclTId!;
                                                              clintName +=
                                                                  '${index + 1} ) ${widget.tadaApplyDataController.clintListValues.elementAt(index).ismmclTClientName} ';

                                                              widget
                                                                  .tadaApplyDataController
                                                                  .addAddress(widget
                                                                      .tadaApplyDataController
                                                                      .clintListValues
                                                                      .elementAt(
                                                                          index)
                                                                      .ismmclTAddress!);
                                                              int count = 0;
                                                              _addressController
                                                                  .clear();
                                                              for (int i = 0;
                                                                  i <
                                                                      widget
                                                                          .tadaApplyDataController
                                                                          .addressListController
                                                                          .length;
                                                                  i++) {
                                                                count++;
                                                                _addressController
                                                                        .text +=
                                                                    ' $count ) ${widget.tadaApplyDataController.addressListController[i]}  ';
                                                              }
                                                            } else {
                                                              _addressController
                                                                  .clear();
                                                              selectAllDepartment
                                                                      .value =
                                                                  false;
                                                              widget
                                                                  .tadaApplyDataController
                                                                  .removeSelectedValues(widget
                                                                      .tadaApplyDataController
                                                                      .clintListValues
                                                                      .elementAt(
                                                                          index));
                                                              widget
                                                                  .tadaApplyDataController
                                                                  .removeAddress(widget
                                                                      .tadaApplyDataController
                                                                      .clintListValues
                                                                      .elementAt(
                                                                          index)
                                                                      .ismmclTAddress!);
                                                              for (int i = 0;
                                                                  i <
                                                                      widget
                                                                          .tadaApplyDataController
                                                                          .addressListController
                                                                          .length;
                                                                  i++) {
                                                                _addressController
                                                                        .text =
                                                                    '${i + 1} ) ${widget.tadaApplyDataController.addressListController.elementAt(i)} ';
                                                              }
                                                            }
                                                          });
                                                        },
                                                        isChecked: RxBool(
                                                          widget
                                                              .tadaApplyDataController
                                                              .clintSelectedValues
                                                              .contains(
                                                            widget
                                                                .tadaApplyDataController
                                                                .clintListValues
                                                                .elementAt(
                                                                    index),
                                                          ),
                                                        ));
                                                  }));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const ContainerTitle(
                                      iT: Color(0xFFFF6F67),
                                      bg: Color.fromARGB(255, 255, 236, 235),
                                      image:
                                          'assets/images/subjectfielicon.png',
                                      title: 'Select Client',
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 16, right: 16),
                          child: CustomContainer(
                            child: TextFormField(
                              controller: _remarkController,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: Get.textTheme.titleSmall!
                                  .copyWith(fontSize: 15),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "Enter Remark",
                                label: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDFFBFE),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/cap.png",
                                        height: 28.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Remark",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  backgroundColor:
                                                      Color(0xFFDFFBFE),
                                                  fontSize: 20.0,
                                                  color: Color(0xFF28B6C8)),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 16, right: 16),
                          child: CustomContainer(
                            child: TextFormField(
                              controller: _addressController,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: Get.textTheme.titleSmall!
                                  .copyWith(fontSize: 15),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "Enter Address",
                                label: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDFFBFE),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/cap.png",
                                        height: 28.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Address",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  backgroundColor:
                                                      Color(0xFFDFFBFE),
                                                  fontSize: 20.0,
                                                  color: Color(0xFF28B6C8)),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        widget.tadaApplyDataController.allowenseData.isNotEmpty
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(
                                    top: 20, left: 16, right: 16),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: DataTable(
                                        dataRowHeight: 50,
                                        headingRowHeight: 40,
                                        columnSpacing: 20,
                                        headingTextStyle: const TextStyle(
                                            color: Colors.white),
                                        border: TableBorder.all(
                                          color: Colors.black,
                                          width: 0.6,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Theme.of(context)
                                                    .primaryColor),
                                        columns: const [
                                          DataColumn(label: Text("Select")),
                                          DataColumn(
                                              label: Text("Particulars")),
                                          DataColumn(label: Text("Amount")),
                                          DataColumn(label: Text("Days")),
                                          DataColumn(label: Text("Total Sots")),
                                          DataColumn(label: Text("Slots")),
                                          DataColumn(
                                              label: Text("Total Amount")),
                                          DataColumn(label: Text("Remark")),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Checkbox(
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: 0,
                                                          vertical: 0),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isFoodSelected = value!;

                                                      if (value) {
                                                        isFoodTextField = true;
                                                      } else {
                                                        isFoodTextField = false;
                                                        removeAmount(foodAmt);
                                                        foodAmt = 0;
                                                        foodTotalSlotController
                                                            .clear();

                                                        foodTotalSlotController
                                                            .clear();
                                                        foodRemarksController
                                                            .clear();
                                                      }
                                                    });
                                                  },
                                                  value: isFoodSelected,
                                                  activeColor: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                            const DataCell(Text('Food')),
                                            DataCell(Text(widget
                                                .tadaApplyDataController
                                                .foodAmount
                                                .toString())),
                                            DataCell(Text(dayCount.toString())),
                                            DataCell(Text('$foodSlot')),
                                            DataCell(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextField(
                                                    onTap: () {
                                                      if (isFoodTextField ==
                                                          false) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Select Check Box");
                                                      }
                                                    },
                                                    readOnly:
                                                        (isFoodTextField ==
                                                                false)
                                                            ? true
                                                            : false,
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                    controller:
                                                        foodTotalSlotController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (isFoodTextField ==
                                                            true) {
                                                          if (foodSlot >=
                                                              double.parse(
                                                                  value)) {
                                                            foodAmt = 0;
                                                            foodAmt = (widget
                                                                    .tadaApplyDataController
                                                                    .foodAmount /
                                                                3.0 *
                                                                num.parse(
                                                                    value));
                                                          } else {
                                                            foodTotalSlotController
                                                                .text = '';
                                                            foodAmt = 0;
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Error'),
                                                                  content: Text(
                                                                    'Enter Total slots Must Be Below Number of Slots',
                                                                    style: Get
                                                                        .textTheme
                                                                        .titleSmall,
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'OK'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Please Select Check Box");
                                                        }
                                                      });
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor))),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(Text(
                                                foodAmt.toStringAsFixed(0))),
                                            DataCell(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextField(
                                                    onTap: () {
                                                      if (isFoodTextField ==
                                                          false) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Select Check Box");
                                                      }
                                                    },
                                                    readOnly:
                                                        (isFoodTextField ==
                                                                false)
                                                            ? true
                                                            : false,
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                    controller:
                                                        foodRemarksController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor))),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                          DataRow(cells: [
                                            DataCell(
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Checkbox(
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: 0,
                                                          vertical: 0),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isAccommodationSelected =
                                                          value!;

                                                      if (value) {
                                                        isAccommodationTextField =
                                                            true;
                                                      } else {
                                                        removeAmount(
                                                            accommodationAmount);
                                                        accommodationTotalSlotController
                                                            .clear();
                                                        accommodationAmount = 0;
                                                        isAccommodationTextField =
                                                            false;

                                                        accommodationTotalSlotController
                                                            .clear();
                                                        accommodationRemarksController
                                                            .clear();
                                                      }
                                                    });
                                                  },
                                                  value:
                                                      isAccommodationSelected,
                                                  activeColor: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                            const DataCell(
                                                Text('Accommodation Amount')),
                                            DataCell(Text(widget
                                                .tadaApplyDataController
                                                .accomodationAmount
                                                .toString())),
                                            DataCell(Text(dayCount.toString())),
                                            DataCell(
                                                Text('$accommudationSlot')),
                                            DataCell(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextField(
                                                    onTap: () {
                                                      if (isAccommodationTextField ==
                                                          false) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Select Check Box");
                                                      }
                                                    },
                                                    readOnly:
                                                        (isAccommodationTextField ==
                                                                true)
                                                            ? false
                                                            : true,
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                    controller:
                                                        accommodationTotalSlotController,
                                                    onChanged: (value) {
                                                      if (isAccommodationTextField ==
                                                          true) {
                                                        setState(() {
                                                          if (accommudationSlot >=
                                                              double.parse(
                                                                  value)) {
                                                            accommodationAmount =
                                                                0;
                                                            accommodationAmount =
                                                                accommodationAmount = (widget
                                                                            .tadaApplyDataController
                                                                            .accomodationAmount *
                                                                        num.parse(
                                                                            value))
                                                                    .toDouble();
                                                            addTotalAmount();
                                                            // addAmount(
                                                            //     (accommodationAmount));
                                                          } else {
                                                            accommodationTotalSlotController
                                                                .text = '';

                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Error'),
                                                                  content: Text(
                                                                    'Enter Total slots Must Be Below Number of Slots',
                                                                    style: Get
                                                                        .textTheme
                                                                        .titleSmall,
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'OK'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }
                                                        });
                                                      }
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor))),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                                Text('$accommodationAmount')),
                                            DataCell(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextField(
                                                    onTap: () {
                                                      if (isAccommodationTextField ==
                                                          false) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Select Check Box");
                                                      }
                                                    },
                                                    readOnly:
                                                        (isAccommodationTextField ==
                                                                true)
                                                            ? false
                                                            : true,
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                    controller:
                                                        accommodationRemarksController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor))),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                          DataRow(cells: [
                                            DataCell(
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Checkbox(
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: 0,
                                                          vertical: 0),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isOthersSelected = value!;
                                                      if (value) {
                                                        isOthetrsTextField =
                                                            true;
                                                      } else {
                                                        isOthetrsTextField =
                                                            false;
                                                        otherAmount = 0;
                                                        otherAmountController
                                                            .text = '0';
                                                        removeAmount(double.parse(
                                                            otherAmountController
                                                                .text));

                                                        otherAmountController
                                                            .clear();
                                                        otherremarksController
                                                            .clear();
                                                      }
                                                    });
                                                  },
                                                  value: isOthersSelected,
                                                  activeColor: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                            const DataCell(
                                                Text('Other Amount')),
                                            DataCell(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextField(
                                                    onTap: () {
                                                      if (isOthetrsTextField ==
                                                          false) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Select Check Box");
                                                      }
                                                    },
                                                    readOnly:
                                                        (isOthetrsTextField ==
                                                                true)
                                                            ? false
                                                            : true,
                                                    controller:
                                                        otherAmountController,
                                                    onChanged: (value) {
                                                      if (isOthetrsTextField ==
                                                          true) {
                                                        setState(() {
                                                          otherAmount = 0;
                                                          otherAmount =
                                                              double.parse(
                                                                  value);
                                                          addTotalAmount();
                                                        });
                                                      }
                                                    },
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor))),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const DataCell(Text('')),
                                            const DataCell(Text('')),
                                            const DataCell(Text('')),
                                            DataCell(Text(
                                                otherAmountController.text)),
                                            DataCell(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: TextField(
                                                    onTap: () {
                                                      if (isOthetrsTextField ==
                                                          false) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Select Check Box");
                                                      }
                                                    },
                                                    readOnly:
                                                        (isOthetrsTextField ==
                                                                true)
                                                            ? false
                                                            : true,
                                                    style: Get
                                                        .textTheme.titleSmall,
                                                    controller:
                                                        otherremarksController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor))),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                        ])),
                              )
                            : const SizedBox(),
                      ],
                    )
              : Padding(
                  padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: CustomContainer(
                              child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "State : ",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(state,
                                        style: Get.textTheme.titleSmall),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "City : ",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(city, style: Get.textTheme.titleSmall),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Client : ",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(client,
                                        style: Get.textTheme.titleSmall),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Advance Amount : ",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(advanceAmount.toString(),
                                        style: Get.textTheme.titleSmall),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Paid Amount : ",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(paidAmount.toString(),
                                        style: Get.textTheme.titleSmall),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Balance Amount : ",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(balanceAmount.toString(),
                                        style: Get.textTheme.titleSmall),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address : ",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(address,
                                          style: Get.textTheme.titleSmall),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Remarks : ",
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Expanded(
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.65,
                                      child: Text(remarks,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.textTheme.titleSmall),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomContainer(
                        child: TextFormField(
                          controller: _extraAmountController,
                          keyboardType: TextInputType.number,
                          style:
                              Get.textTheme.titleSmall!.copyWith(fontSize: 15),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Extra Amount",
                            label: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFFBFE),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    "assets/images/cap.png",
                                    height: 28.0,
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    " Extra Amount",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .merge(
                                          const TextStyle(
                                              backgroundColor:
                                                  Color(0xFFDFFBFE),
                                              fontSize: 20.0,
                                              color: Color(0xFF28B6C8)),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    fillColor: MaterialStatePropertyAll(
                                        Theme.of(context).primaryColor),
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: 0),
                                    value: amountSelectedValue1,
                                    onChanged: (value) {
                                      setState(() {
                                        if (_extraAmountController
                                            .text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: "Please Enter Amount");
                                        } else {
                                          amountSelectedValue1 = value!;
                                          amountSelectedValue2 = false;
                                          if (amountSelectedValue1 == true) {
                                            allAmount += int.parse(
                                                _extraAmountController.text);
                                          }
                                        }
                                      });
                                    }),
                                Text(
                                  addAmountType[0],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          letterSpacing: 0.3,
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    fillColor: MaterialStatePropertyAll(
                                        Theme.of(context).primaryColor),
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: 0),
                                    value: amountSelectedValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        if (_extraAmountController
                                            .text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: "Please Enter Amount");
                                        } else {
                                          amountSelectedValue2 = value!;
                                          amountSelectedValue1 = false;
                                          if (amountSelectedValue2 == true) {
                                            allAmount -= int.parse(
                                                _extraAmountController.text);
                                          }
                                        }
                                      });
                                    }),
                                Text(
                                  addAmountType[1],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          letterSpacing: 0.3,
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: CustomContainer(
                          child: TextFormField(
                            controller: _remainingAmountController,
                            keyboardType: TextInputType.number,
                            style: Get.textTheme.titleSmall!
                                .copyWith(fontSize: 15),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Extra Amount",
                              label: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDFFBFE),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 6.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/cap.png",
                                      height: 28.0,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " Remaining Paid Amount",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                                backgroundColor:
                                                    Color(0xFFDFFBFE),
                                                fontSize: 20.0,
                                                color: Color(0xFF28B6C8)),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Total Amount: ",
                  style: Get.textTheme.titleSmall!
                      .copyWith(color: Theme.of(context).primaryColor)),
              TextSpan(
                  text: (widget.tadaApplyDataController.tadaSavedData.isEmpty)
                      ? " ₹ ${double.parse(foodAmt.toStringAsFixed(0)) + accommodationAmount + otherAmount}"
                      : '$allAmount',
                  style: Get.textTheme.titleSmall),
            ])),
          ),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              visualDensity: const VisualDensity(vertical: 0, horizontal: 0),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              checkColor: Colors.indigo,
              value: isFinalSubmition,
              title: Text(
                "Final Submission",
                style: Get.textTheme.titleMedium,
              ),
              onChanged: (value) {
                setState(() {
                  isFinalSubmition = value!;
                });
              }),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                  // dataRowHeight: 35,
                  headingRowHeight: 45,
                  columnSpacing: 10,
                  headingTextStyle: const TextStyle(color: Colors.white),
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 0.6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).primaryColor),
                  columns: const [
                    DataColumn(label: Text("SL.NO.")),
                    DataColumn(label: Text("Upload")),
                    DataColumn(label: Text("View")),
                    DataColumn(label: Text("Remarks")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: List.generate(
                      widget.tadaApplyDataController.addListBrowser.length,
                      (index) {
                    var value = index + 1;
                    return DataRow(cells: [
                      DataCell(Text(value.toString())),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                            onPressed: () {
                              pickImage(index);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: Center(
                              child: Text(
                                "Choose File",
                                style: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                            )),
                      )),
                      DataCell(Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                OpenFilex.open(widget.tadaApplyDataController
                                    .addListBrowser[index].file!.path);
                              },
                              child: (widget.tadaApplyDataController
                                          .addListBrowser[index].file ==
                                      null)
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                          ],
                        ),
                      )),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 120,
                          child: TextField(
                            style: Get.textTheme.titleSmall!
                                .copyWith(color: Colors.black),
                            controller: widget
                                .tadaApplyDataController.newRemarksController
                                .elementAt(index),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(3)),
                          ),
                        ),
                      )),
                      DataCell(Align(
                          alignment: Alignment.center,
                          child: index ==
                                  widget.tadaApplyDataController.addListBrowser
                                          .length -
                                      1
                              ? Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          addItemListBrowse(
                                            index + 1,
                                            "",
                                          );
                                        },
                                        child: const Icon(Icons.add)),
                                    index >= 1
                                        ? InkWell(
                                            onTap: () {
                                              removeItemListBrowse(index);
                                            },
                                            child: const Icon(Icons.remove))
                                        : const SizedBox()
                                  ],
                                )
                              : index <
                                      widget.tadaApplyDataController
                                          .addListBrowser.length
                                  ? InkWell(
                                      onTap: () {
                                        removeItemListBrowse(index);
                                      },
                                      child: const Icon(Icons.remove))
                                  : null)),
                    ]);
                  })),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: widget.tadaApplyDataController.isSave.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : MSkollBtn(
                      title: "Save",
                      onPress: () {
                        allAmount = foodAmt +
                            accommodationAmount +
                            otherAmount.toDouble();

                        if (_endTime.text.isEmail) {
                          Fluttertoast.showToast(msg: "Select Arrival Time");
                        } else if (_addressController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Enter Address");
                        } else if (allAmount == 0) {
                          Fluttertoast.showToast(msg: "Fill  Total Amount");
                        } else if (widget
                            .tadaApplyDataController.addListBrowser.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Bill File is Not Attached");
                        } else if (widget.tadaApplyDataController
                            .clintSelectedValues.isEmpty) {
                          Fluttertoast.showToast(msg: "Select Client");
                        } else {
                          int foodamountId = 0;
                          int accamountId = 0;
                          int othersamountId = 0;
                          allowanceData.clear();

                          if (isFoodSelected == true) {
                            foodamountId =
                                (foodamountId == null || foodamountId == "")
                                    ? 0
                                    : foodamountId;
                            allowanceData.add({
                              "Type": "Food",
                              "Amount": foodAmt,
                              "Remarks": foodRemarksController.text,
                              "VTADAAD_Id": foodamountId,
                              "VTADAAD_TotalSlots": foodSlot,
                              "VTADAAD_Slots": foodTotalSlotController.text,
                            });
                          }

                          if (isAccommodationSelected == true) {
                            accamountId =
                                (accamountId == null || accamountId == "")
                                    ? 0
                                    : accamountId;
                            allowanceData.add({
                              "Type": "Accommodation",
                              "Amount": accommodationAmount,
                              "Remarks": accommodationRemarksController.text,
                              "VTADAAD_Id": accamountId,
                              "VTADAAD_TotalSlots": accommudationSlot,
                              "VTADAAD_Slots":
                                  accommodationTotalSlotController.text,
                            });
                          }
                          if (isOthersSelected == true) {
                            othersamountId =
                                (othersamountId == null || othersamountId == "")
                                    ? 0
                                    : othersamountId;
                            allowanceData.add({
                              "Type": "Other",
                              "Amount": otherAmountController.text,
                              "Remarks": otherremarksController.text,
                              "VTADAAD_Id": othersamountId,
                            });
                          }

                          logger.i(allowanceData);
                          saveData();
                        }
                      }),
            ),
          ),
          (widget.tadaApplyDataController.getSavedData.isEmpty)
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: Text(
                          "TA-DA Details",
                          style: Get.textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      AppliedTableWidget(
                        tadaApplyDataController: widget.tadaApplyDataController,
                        loginSuccessModel: widget.loginSuccessModel,
                        mskoolController: widget.mskoolController,
                      ),
                    ],
                  ),
                ),
        ],
      );
    });
  }

  showPopup() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(10),
      content: WillPopScope(
        onWillPop: () async => false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Daily report is not generated between dates !",
                textAlign: TextAlign.center,
                style: Get.textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 40),
              MSkollBtn(
                  title: "OK",
                  onPress: () {
                    setState(() {
                      Get.back();
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }

  bool isAddLoading = false;
  bool isSubstractLoading = false;
}
