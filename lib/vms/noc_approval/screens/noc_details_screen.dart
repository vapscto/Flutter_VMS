import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/api/noc_approve_api.dart';
import 'package:m_skool_flutter/vms/noc_approval/controller/noc_approved_controller.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/noc_details_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/noc_list_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/screens/approved_list_screen.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:m_skool_flutter/widget/reject_btn.dart';

class NocDetailsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final NocApprovedController controller;
  final NocAppliedListModelValues value;
  const NocDetailsScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller,
      required this.value});

  @override
  State<NocDetailsScreen> createState() => _NocDetailsScreenState();
}

class _NocDetailsScreenState extends State<NocDetailsScreen> {
  bool isLoading = false;
  List<NocDetailsModelValues> newListData = [];
  _getData() async {
    newListData.clear();
    setState(() {
      isLoading = true;
    });

    await NocApproveAPI.i
        .nocDetails(
            base: baseUrlFromInsCode('recruitement', widget.mskoolController),
            controller: widget.controller,
            userId: widget.loginSuccessModel.userId!,
            miId: widget.loginSuccessModel.mIID!,
            iSMCERTREQId: int.parse(widget.value.iSMCERTREQId!),
            hrmeId: int.parse(widget.value.hRMEId!))
        .then((value) {
      getData();
      newListData.addAll(value!.values!);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  DateTime dt = DateTime.now();

  final approveController = TextEditingController();
  int bgColor = -1;
  List<TextEditingController> remarksListController = [];
  getData() {
    for (int i = 0; i < widget.controller.checkListModel.length; i++) {
      remarksListController.add(TextEditingController(text: ''));
    }
  }

  bool isApproveLoading = false;
  bool isRejectLoading = false;
  approveNoc(Map<String, dynamic> body) async {
    setState(() {
      isApproveLoading = true;
    });
    await NocApproveAPI.i.nocApprove(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        body: body);
    setState(() {
      isApproveLoading = false;
    });
  }

  rejectNoc(Map<String, dynamic> body) async {
    setState(() {
      isRejectLoading = true;
    });
    await NocApproveAPI.i.nocApprove(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        body: body);
    setState(() {
      isRejectLoading = false;
    });
  }

  List<Map<String, dynamic>> checkList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Noc Details').getAppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              children: [
                Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          newListData.first.hRMEPhoto!,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newListData.first.employeename ?? '',
                            style: Get.textTheme.titleMedium,
                          ),
                          Text(
                            newListData.first.mIName ?? '',
                            style: Get.textTheme.titleSmall!
                                .copyWith(color: Colors.red),
                          ),
                          Text(
                            newListData.first.hRMDDepartmentName ?? "",
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            newListData.first.hRMDESDesignationName ?? "",
                            style: Get.textTheme.titleSmall,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Date of Joining:',
                          style: Get.textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:
                              ' ${dateFormat(DateTime.parse(newListData.first.hRMEDOJ!))}',
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Email:',
                          style: Get.textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: ' ${newListData.first.hRMEEmailId}',
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Phone No:',
                          style: Get.textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: ' ${newListData.first.hRMEMNOMobileNo}',
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Employee Remark:',
                          style: Get.textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: ' ${widget.controller.remarks}',
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("Previous Approver Remark",
                        style: Get.textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor)),
                    IconButton(
                        onPressed: () {
                          if (widget.controller.approvedListModel.isNotEmpty) {
                            Get.to(() => ApprovedListScreen(
                                  data: widget.controller.approvedListModel,
                                ));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Data is not available");
                          }
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                ),
                Column(
                  children: List.generate(
                      widget.controller.checkListModel.length, (index) {
                    bgColor += 1;
                    if (bgColor % 6 == 0) {
                      bgColor = 0;
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: lighterColor.elementAt(bgColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.controller.checkListModel
                                      .elementAt(index)
                                      .iSMRESGMCLCheckListName!,
                                  style: Get.textTheme.titleMedium,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Damage Amount: ',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' ',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: remarksListController[index],
                                    style: Get.textTheme.titleSmall,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.all(4),
                                        hintText: 'Remark',
                                        hintStyle: Get.textTheme.titleSmall!
                                            .copyWith(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey))),
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextFormField(
                    controller: approveController,
                    style: Get.textTheme.titleSmall,
                    maxLines: 3,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 6),
                        labelText: 'Approver remark',
                        labelStyle: Get.textTheme.titleSmall,
                        hintText: 'Approver remark',
                        hintStyle: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      (isApproveLoading == true)
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : MSkollBtn(
                              title: 'Approve',
                              onPress: () {
                                checkList.clear();
                                for (int i = 0;
                                    i < widget.controller.checkListModel.length;
                                    i++) {
                                  var data = widget.controller.checkListModel
                                      .elementAt(i);
                                  checkList.add({
                                    "ISMRESGMCL_Id": data.iSMRESGMCLId,
                                    "Remarks": remarksListController[i].text,
                                    "DamageAmount": ''
                                  });
                                }
                                approveNoc({
                                  "ISMCERTREQ_Id": widget.value.iSMCERTREQId,
                                  "Fromdate": dt.toIso8601String(),
                                  "Todate": dt.toIso8601String(),
                                  "ISMCERTREQAPP_Remarks":
                                      approveController.text,
                                  "ISMCERTREQAPP_AppRejFlag": 'Approved',
                                  "ISMCERTREQ_FilePath": '',
                                  // "maxmumlevel": $scope.maxmumlevel,
                                  "HRME_Id": widget.value.hRMEId,
                                  "MI_Id": widget.loginSuccessModel.mIID,
                                  "UserId": widget.loginSuccessModel.userId,
                                  "roleid": widget.loginSuccessModel.roleId,
                                  "doc_list2": checkList
                                });
                              }),
                      (isRejectLoading == true)
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : RejectBtn(
                              title: 'Reject',
                              onPress: () {
                                checkList.clear();
                                for (int i = 0;
                                    i < widget.controller.checkListModel.length;
                                    i++) {
                                  var data = widget.controller.checkListModel
                                      .elementAt(i);
                                  checkList.add({
                                    "ISMRESGMCL_Id": data.iSMRESGMCLId,
                                    "Remarks": remarksListController[i],
                                    "DamageAmount": ''
                                  });
                                }
                                rejectNoc({
                                  "ISMCERTREQ_Id": widget.value.iSMCERTREQId,
                                  "Fromdate": dt.toIso8601String(),
                                  "Todate": dt.toIso8601String(),
                                  "ISMCERTREQAPP_Remarks":
                                      approveController.text,
                                  "ISMCERTREQAPP_AppRejFlag": 'Rejected',
                                  "ISMCERTREQ_FilePath": '',
                                  // "maxmumlevel": $scope.maxmumlevel,
                                  "HRME_Id": widget.value.hRMEId,
                                  "MI_Id": widget.loginSuccessModel.mIID,
                                  "UserId": widget.loginSuccessModel.userId,
                                  "roleid": widget.loginSuccessModel.roleId,
                                  "doc_list2": checkList
                                });
                              })
                    ],
                  ),
                )
              ],
            ),
    );
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }
}
