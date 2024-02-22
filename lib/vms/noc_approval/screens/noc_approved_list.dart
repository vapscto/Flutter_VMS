import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/api/noc_approve_api.dart';
import 'package:m_skool_flutter/vms/noc_approval/controller/noc_approved_controller.dart';
import 'package:m_skool_flutter/vms/noc_approval/model/noc_details_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class NocApprovedListScreen extends StatefulWidget {
  final NocApprovedController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const NocApprovedListScreen(
      {super.key,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<NocApprovedListScreen> createState() => _NocApprovedListScreenState();
}

class _NocApprovedListScreenState extends State<NocApprovedListScreen> {
  int bgColor = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'NOC Approve/Reject Details').getAppBar(),
      body: Obx(() {
        return (widget.controller.approvedList.isEmpty)
            ? const AnimatedProgressWidget(
                animationPath: 'assets/json/nodata.json',
                title: 'Data is not available',
                desc: "NOC is not available for approval ",
                animatorHeight: 250,
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DataTable(
                        dataRowHeight: 45,
                        headingRowHeight: 45,
                        columnSpacing: 20,
                        headingTextStyle: const TextStyle(color: Colors.white),
                        border: TableBorder.all(
                          color: Colors.black,
                          width: 0.6,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColor),
                        columns: createColumn(),
                        rows: List.generate(
                            widget.controller.approvedList.length, (index) {
                          var v = index + 1;
                          var value =
                              widget.controller.approvedList.elementAt(index);
                          return DataRow(cells: [
                            DataCell(Text(v.toString())),
                            DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child:
                                    Text(value.hRMEEmployeeFirstName!.trim()))),
                            DataCell(Text(dateFormat(
                                DateTime.parse(value.iSMCERTREQRequestDate!)))),
                            DataCell(Text(value.iSMCERTREQAPPAppRejFlag!)),
                            DataCell((value.iSMCERTREQFilePath!.isNotEmpty)
                                ? IconButton(
                                    onPressed: () {
                                      createPreview(
                                          context, value.iSMCERTREQFilePath!);
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : const SizedBox()),
                            DataCell(IconButton(
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return Dialog(
                                        insetPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: FutureBuilder<NocDetailsModel?>(
                                            future: NocApproveAPI.i.nocDetails(
                                                base: baseUrlFromInsCode(
                                                    'recruitement',
                                                    widget.mskoolController),
                                                controller: widget.controller,
                                                userId: widget
                                                    .loginSuccessModel.userId!,
                                                miId: widget
                                                    .loginSuccessModel.mIID!,
                                                iSMCERTREQId:
                                                    value.iSMCERTREQId!,
                                                hrmeId: value.hRMEId!),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                var data = snapshot
                                                    .data!.values!.first;
                                                return SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          '${data.employeename!} NOC is Approved by Managment',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: Get.textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Text(
                                                        //       'NOC Certificate',
                                                        //       textAlign:
                                                        //           TextAlign
                                                        //               .center,
                                                        //       style: Get
                                                        //           .textTheme
                                                        //           .titleSmall!
                                                        //           .copyWith(
                                                        //               color: Colors
                                                        //                   .red),
                                                        //     ),
                                                        //     InkWell(
                                                        //       onTap: () {},
                                                        //       child: Icon(
                                                        //         Icons
                                                        //             .visibility,
                                                        //         color: Theme.of(
                                                        //                 context)
                                                        //             .primaryColor,
                                                        //       ),
                                                        //     )
                                                        //   ],
                                                        // ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 100,
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: Image
                                                                    .network(
                                                                  data.hRMEPhoto!,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Name:',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                        TextSpan(
                                                                            text:
                                                                                ' ${data.employeename}',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Company Name:',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                        TextSpan(
                                                                            text:
                                                                                ' ${data.mIName}',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Department:',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                        TextSpan(
                                                                            text:
                                                                                ' ${data.hRMDDepartmentName}',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Designation:',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                        TextSpan(
                                                                            text:
                                                                                ' ${data.hRMDESDesignationName}',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Date Of JoinIng:',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                        TextSpan(
                                                                            text:
                                                                                ' ${dateFormat(DateTime.parse(data.hRMEDOJ!))}',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Email Id:',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                        TextSpan(
                                                                            text:
                                                                                ' ${data.hRMEEmailId}',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                'Phone No:',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                        TextSpan(
                                                                            text:
                                                                                ' ${data.hRMEMobileNo}',
                                                                            style:
                                                                                Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Previous Approver Remark',
                                                              style: Get
                                                                  .textTheme
                                                                  .titleMedium,
                                                            ),
                                                            InkWell(
                                                              onTap: () {},
                                                              child: Icon(
                                                                Icons
                                                                    .visibility,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Column(
                                                          children: List.generate(
                                                              widget
                                                                  .controller
                                                                  .checkListModel
                                                                  .length,
                                                              (index) {
                                                            bgColor += 1;
                                                            if (bgColor % 6 ==
                                                                0) {
                                                              bgColor = 0;
                                                            }
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0),
                                                              child:
                                                                  CustomContainer(
                                                                      color: lighterColor
                                                                          .elementAt(
                                                                              bgColor),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              widget.controller.checkListModel.elementAt(index).iSMRESGMCLCheckListName!,
                                                                              style: Get.textTheme.titleMedium,
                                                                            ),
                                                                            Text.rich(
                                                                              TextSpan(
                                                                                children: [
                                                                                  TextSpan(text: 'Damage Amount: ', style: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                                  TextSpan(text: ' ', style: Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Text.rich(
                                                                              TextSpan(
                                                                                children: [
                                                                                  TextSpan(text: 'Remarks:', style: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                                                                                  TextSpan(text: ' ', style: Get.textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor)),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                            );
                                                          }),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "Close",
                                                                style: Get
                                                                    .textTheme
                                                                    .titleMedium!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .red),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              if (snapshot.hasError) {
                                                return const SizedBox();
                                              }
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  AnimatedProgressWidget(
                                                      title: "Please Wait",
                                                      desc:
                                                          "We are trying to loging you in.",
                                                      animationPath:
                                                          "assets/json/default.json")
                                                ],
                                              );
                                            }),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                          ]);
                        })),
                  ),
                ),
              );
      }),
    );
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }

  List<DataColumn> createColumn() {
    return const [
      DataColumn(label: Text("SL.NO.")),
      DataColumn(label: Text("Employee Name")),
      DataColumn(label: Text("Requested Date")),
      DataColumn(label: Text("Status")),
      DataColumn(label: Text("Document")),
      DataColumn(label: Text("Action")),
    ];
  }
}
