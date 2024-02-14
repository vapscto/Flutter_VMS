import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/driver_indent/api/driver_ind_api.dart';
import 'package:m_skool_flutter/vms/driver_indent/controller/driver_intent_controller.dart';
import 'package:m_skool_flutter/vms/driver_indent/model/driver_ind_approve.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:m_skool_flutter/widget/reject_btn.dart';

class IndentApprovePopup extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final DriverIndentController controller;
  final DriverloadModelValues values;
  const IndentApprovePopup(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller,
      required this.values});

  @override
  State<IndentApprovePopup> createState() => _IndentApprovePopupState();
}

class _IndentApprovePopupState extends State<IndentApprovePopup> {
  final controller = TextEditingController();
  List<Map<String, dynamic>> listData = [];

  @override
  void dispose() {
    controller.clear();
    listData.clear();
    super.dispose();
  }

  load() async {
    widget.controller.loadingData(true);
    await DriverIndentAPI.i.onload(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        controller: widget.controller,
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "User_Id": widget.loginSuccessModel.userId,
          "roleId": widget.loginSuccessModel.roleId
        });
    widget.controller.loadingData(false);
  }

  bool isSaveLoading = false;
  bool isRejectLoading = false;
  _saveData(Map<String, dynamic> data) async {
    setState(() {
      isSaveLoading = true;
    });
    await DriverIndentAPI.i.approveIndentAPI(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        body: data);
    setState(() {
      isSaveLoading = false;
    });
    load();
    Get.back();
  }

  _rejectData(Map<String, dynamic> data) async {
    setState(() {
      isRejectLoading = true;
    });
    await DriverIndentAPI.i.rejectIndentAPI(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        body: data);
    setState(() {
      isRejectLoading = false;
    });
    load();
    Get.back();
  }

  @override
  void initState() {
    // if(widget.values.)
    listData.add({
      "ISMDIT_Date": widget.values.iSMDITDate,
      "TRMV_Id": widget.values.tRMVId,
      "ISMDIT_BillNo": widget.values.iSMDITBillNo,
      "ISMDIT_Qty": widget.values.iSMDITQty,
      "ISMDIT_Amount": widget.values.iSMDITAmount,
      "ISMDIT_OpeningKM": widget.values.iSMDITOpeningKM,
      "ISMDIT_ClosingKM": widget.values.iSMDITClosingKM,
      "ISMDIT_PreparedByUserId": widget.values.iSMDITPreparedByUserId,
      "TRMV_VehicleNo": widget.values.tRMVVehicleNo,
      "ISMDIT_Id": widget.values.iSMDITId,
      "TRMV_VehicleName": widget.values.tRMVVehicleName,
      "HRME_EmployeeFirstName": widget.values.hRMEEmployeeFirstName,
      "ISMDIT_Remark": widget.values.iSMDITRemark
    });
    super.initState();
    logger.w(listData);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      insetPadding: const EdgeInsets.all(10),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),
            CustomContainer(
                child: TextFormField(
              style: Get.textTheme.titleSmall,
              maxLines: 2,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.multiline,
              controller: controller,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                border: const OutlineInputBorder(),
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
                hintText: "Approve Remark",
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFFBFE),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
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
                        "Approve Remark",
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
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (isSaveLoading == true)
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : MSkollBtn(
                          title: 'Approve',
                          onPress: () {
                            if (widget.loginSuccessModel.roleforlogin ==
                                "ADMIN") {
                              _saveData({
                                "MI_Id": widget.loginSuccessModel.mIID,
                                "User_Id": widget.loginSuccessModel.userId,
                                "ISMDIT_Remark": controller.text,
                                "get_indent_status": listData,
                                "roleId": widget.loginSuccessModel.roleId
                              });
                            } else {
                              _saveData({
                                "MI_Id": widget.loginSuccessModel.mIID,
                                "User_Id": widget.loginSuccessModel.userId,
                                "ISMDIT_Remark": controller.text,
                                "get_indent_status": listData,
                                "roleId": widget.loginSuccessModel.roleId
                              });
                            }
                          }),
                  (isRejectLoading == true)
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : RejectBtn(
                          title: "Reject",
                          onPress: () {
                            if (widget.loginSuccessModel.roleforlogin ==
                                "ADMIN") {
                              _rejectData({
                                "MI_Id": widget.loginSuccessModel.mIID,
                                "User_Id": widget.loginSuccessModel.userId,
                                "ISMDIT_Remark": controller.text,
                                "get_indent_status": listData,
                                "roleId": widget.loginSuccessModel.roleId
                              });
                            } else {
                              _rejectData({
                                "MI_Id": widget.loginSuccessModel.mIID,
                                "User_Id": widget.loginSuccessModel.userId,
                                "ISMDIT_Remark": controller.text,
                                "get_indent_status": listData,
                                "roleId": widget.loginSuccessModel.roleId
                              });
                            }
                          })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
