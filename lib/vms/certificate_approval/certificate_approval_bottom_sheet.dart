import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/api/certificate_api.dart';
import 'package:m_skool_flutter/vms/certificate_approval/controller/certificate_controller.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';
import 'package:m_skool_flutter/widget/reject_btn.dart';

class CertificateApprovalSheet extends StatefulWidget {
  final CertificateController controller;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String iSMCERTREQId;
  final String hrmeId;
  const CertificateApprovalSheet(
      {super.key,
      required this.controller,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.iSMCERTREQId,
      required this.hrmeId});

  @override
  State<CertificateApprovalSheet> createState() =>
      _CertificateApprovalSheetState();
}

class _CertificateApprovalSheetState extends State<CertificateApprovalSheet> {
  List<int> newImage = [];
  final remarkController = TextEditingController();
  _loadData() async {
    widget.controller.certificatDocList.clear();
    widget.controller.approvedloading(true);
    await CertificateLoadAPI.instance.documentLoad(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: widget.controller,
        iSMCERTREQId: widget.iSMCERTREQId,
        userId: widget.loginSuccessModel.userId!,
        hrmeId: widget.hrmeId);
    widget.controller.approvedloading(false);
  }

  @override
  void initState() {
    newImage.add(1);
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.controller.isApprovedloading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AnimatedContainer(
              duration: const Duration(milliseconds: 10),
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color.fromARGB(255, 247, 140, 140),
                  //     Color.fromARGB(255, 155, 248, 158)
                  //   ],
                  //   begin: Alignment.bottomLeft,
                  //   end: Alignment.topRight,
                  // ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 2.1),
                        blurRadius: 3,
                        spreadRadius: 1,
                        color: Colors.black12)
                  ]),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Text(
                        'Employee Details',
                        style: Get.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: const Border(
                                    left: BorderSide(color: Colors.grey),
                                    right: BorderSide(color: Colors.grey),
                                    top: BorderSide(color: Colors.grey),
                                    bottom: BorderSide(color: Colors.grey))),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Employee Name:',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' Tapan Kumar Padhi',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Date of joining:',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: '',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Department:',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' abc',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Designation:',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' Software',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Company Name:',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' VTs',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Employee Certificates',
                        style: Get.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      (widget.controller.certificatDocList.isEmpty)
                          ? const SizedBox()
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: DataTable(
                                    dataRowHeight: 35,
                                    headingRowHeight: 40,
                                    columnSpacing: 20,
                                    headingTextStyle:
                                        const TextStyle(color: Colors.white),
                                    border: TableBorder.all(
                                      color: Colors.black,
                                      width: 0.6,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) =>
                                                Theme.of(context).primaryColor),
                                    columns: const [
                                      DataColumn(label: Text("SL.NO.")),
                                      DataColumn(label: Text("Document  Name")),
                                      DataColumn(label: Text("View")),
                                    ],
                                    rows: List.generate(
                                        widget.controller.certificatDocList
                                            .length, (index) {
                                      var v = index + 1;
                                      var value = widget
                                          .controller.certificatDocList
                                          .elementAt(index);
                                      return DataRow(cells: [
                                        DataCell(Text(v.toString())),
                                        DataCell(Text(value.hrmedSDocumentName
                                            .toString())),
                                        DataCell(IconButton(
                                          onPressed: () {
                                            createPreview(context,
                                                value.hrmedSDocumentImageName!);
                                          },
                                          icon: Icon(
                                            Icons.visibility,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )),
                                      ]);
                                    })),
                              ),
                            ),
                      const SizedBox(height: 16),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Employee Remarks:',
                                style: Get.textTheme.titleSmall!
                                    .copyWith(fontWeight: FontWeight.w600)),
                            TextSpan(
                                text:
                                    ' ${widget.controller.employeeRemarks.value}',
                                style: Get.textTheme.titleSmall!.copyWith()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomContainer(
                          child: TextFormField(
                        style: Get.textTheme.titleSmall,
                        maxLines: 2,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        controller: remarkController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 12),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(
                                        const TextStyle(
                                          fontSize: 20.0,
                                          color:
                                              Color.fromRGBO(40, 182, 200, 1),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MSkollBtn(title: 'Approve', onPress: () {}),
                            RejectBtn(
                              title: 'Reject',
                              onPress: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
    });
  }
}
