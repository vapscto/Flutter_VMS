import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/feehead/api/fee_academicyear_api.dart';
import 'package:m_skool_flutter/manager/feehead/api/fill_group_fee_api.dart';
import 'package:m_skool_flutter/manager/feehead/controller/fee_head_details_controller.dart';
import 'package:m_skool_flutter/manager/feehead/model/fee_details_selected_year_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class FeeFillWiseTap extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController controller;

  const FeeFillWiseTap({
    super.key,
    required this.loginSuccessModel,
    required this.controller,
  });

  @override
  State<FeeFillWiseTap> createState() => _FeeFillWiseTapState();
}

class _FeeFillWiseTapState extends State<FeeFillWiseTap> {
  FeeheadDetailsController handler = Get.put(FeeheadDetailsController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetFeeAcademicYearDataApi.instance.getSelectedYear(
          miId: widget.loginSuccessModel.mIID!,
          base: baseUrlFromInsCode("portal", widget.controller),
          controller: handler);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return handler.isErrorOccurredWhileLoadingSelectedYear.value
          ? const Center(
              child: ErrWidget(err: {
                "errorTitle": "An Error Occurred",
                "errorMsg":
                    "While Loading the Fee Details , we encountered an error, or server returned an error"
              }),
            )
          : handler.isloadingSelectedYear.value
              ? AnimatedProgressWidget(
                  title: "Loading Academic Session's",
                  desc: "please wait we're loading academic year",
                  animationPath: "assets/json/COE.json")
              : Obx(() {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(children: [
                      const SizedBox(
                        height: 08.0,
                      ),
                      Container(
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
                            FeeDetailsSelectedYearValues>(
                          value: handler.selectedacademicyear,
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
                            hintText: handler.selectedYear.isNotEmpty
                                ? 'Select Year'
                                : "No data available.",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                    " Academic Year ",
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
                          items: List.generate(handler.selectedYear.length,
                              (index) {
                            return DropdownMenuItem(
                              value: handler.selectedYear[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  handler.selectedYear[index].asmaYYear!,
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
                            handler.selectedacademicyear = s;
                            GetFillGroupFeeDataApi.instance.getFeeGroup(
                                miId: widget.loginSuccessModel.mIID!,
                                asmayId: s!.asmaYId!,
                                base: baseUrlFromInsCode(
                                    "portal", widget.controller),
                                controller: handler);
                          },
                        ),
                      ),
                      Obx(() {
                        return handler
                                .isErrorOccuredWhileLoadingFillFeeDetails.value
                            ? const Center(
                                child: ErrWidget(err: {
                                  "errorTitle": "An Error Occurred",
                                  "errorMsg":
                                      "While Loading the Fee Details , we encountered an error, or server returned an error"
                                }),
                              )
                            : handler.isloadingFillFeeDetails.value
                                ? const AnimatedProgressWidget(
                                    title: "Loading Academic Session's",
                                    desc:
                                        "please wait we're loading academic year",
                                    animationPath: "assets/json/COE.json")
                                : Container(
                                    margin: EdgeInsets.only(top: 16.0),
                                    height: Get.height * 0.7,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DataTable(
                                                dataTextStyle: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.95),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                dataRowHeight: 40,
                                                headingRowHeight: 40,
                                                horizontalMargin: 10,
                                                columnSpacing: 40,
                                                dividerThickness: 1,
                                                border: TableBorder.all(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    width: 0.5),
                                                headingRowColor:
                                                    MaterialStateProperty.all(
                                                        Theme.of(context)
                                                            .primaryColor),
                                                columns: [
                                                  DataColumn(
                                                      label: Text(
                                                    "Group Name",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                  DataColumn(
                                                      label: Text("receviable",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                  DataColumn(
                                                      label: Text("Collection",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                  DataColumn(
                                                      label: Text("Concession",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                  DataColumn(
                                                      label: Text("Balance",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                ],
                                                rows: List.generate(
                                                    handler
                                                        .feefilldetails.length,
                                                    (index) => DataRow(cells: [
                                                          DataCell(Text(
                                                              "${handler.feefilldetails.elementAt(index).groupname}")),
                                                          DataCell(Text(
                                                              "${handler.feefilldetails.elementAt(index).recived}")),
                                                          DataCell(Text(
                                                              "${handler.feefilldetails.elementAt(index).paid}")),
                                                          DataCell(Text(
                                                              "${handler.feefilldetails.elementAt(index).concession}")),
                                                          DataCell(Text(
                                                              "${handler.feefilldetails.elementAt(index).ballance}")),
                                                        ]))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                      })
                    ]),
                  );
                });
    });
  }
}
