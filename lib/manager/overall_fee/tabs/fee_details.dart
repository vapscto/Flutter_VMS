import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/manager/overall_fee/controller/overall_fee_details_related_controller.dart';
import 'package:m_skool_flutter/manager/overall_fee/model/overallFeeAcademicYearModel.dart';
import 'package:m_skool_flutter/manager/overall_fee/widget/manager_fee_bar_chart.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';

class ManagerFeeDetails extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ManagerFeeDetails({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<ManagerFeeDetails> createState() => _ManagerFeeDetailsState();
}

class _ManagerFeeDetailsState extends State<ManagerFeeDetails> {
  final OverallFeeDetailsController overallFeeDetailsController =
      Get.put(OverallFeeDetailsController());

  YearlistValue? selectedYear;

  void getAcademicYear() async {
    overallFeeDetailsController.isacademicyearloading(true);
    await overallFeeDetailsController
        .getAcademicList(
      miId: widget.loginSuccessModel.mIID!,
      base: baseUrlFromInsCode(
        'portal',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (value) {
        if (overallFeeDetailsController.academicYearList.isNotEmpty) {
          selectedYear = overallFeeDetailsController.academicYearList.first;
          getFeeDetail(selectedYear!.asmaYId!);
        }
      }
    });
    overallFeeDetailsController.isacademicyearloading(false);
  }

  void getFeeDetail(int asmayId) async {
    overallFeeDetailsController.isfeedetailloading(true);
    await overallFeeDetailsController
        .getFeeDetail(
            base: baseUrlFromInsCode('portal', widget.mskoolController),
            miId: widget.loginSuccessModel.mIID!,
            asmayId: asmayId)
        .then((value) {
      if (value) {
        logger.d(value);
      }
    });
    overallFeeDetailsController.isfeedetailloading(false);
  }

  @override
  void initState() {
    getAcademicYear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => overallFeeDetailsController.isAcademicYear.value
            ? const Align(
                alignment: Alignment.center,
                child: AnimatedProgressWidget(
                    title: "Loading Fee Details",
                    desc:
                        "Please wait while we load fee details and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 40, left: 16, right: 16, bottom: 16),
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
                    child: DropdownButtonFormField<YearlistValue>(
                      value: selectedYear,
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
                        hintText: overallFeeDetailsController
                                .academicYearList.isNotEmpty
                            ? 'Select Year'
                            : 'No data available',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: const CustomDropDownLabel(
                          icon: 'assets/images/hat.png',
                          containerColor: Color.fromRGBO(223, 251, 254, 1),
                          text: 'Academic Year',
                          textColor: Color.fromRGBO(40, 182, 200, 1),
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
                          overallFeeDetailsController.academicYearList.length,
                          (index) {
                        return DropdownMenuItem(
                          value: overallFeeDetailsController
                              .academicYearList[index],
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13, left: 5),
                            child: Text(
                              overallFeeDetailsController.academicYearList
                                  .elementAt(index)
                                  .asmaYYear!,
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
                        selectedYear = s!;
                        getFeeDetail(s.asmaYId!);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Result",
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                    ),
                  ),
                  overallFeeDetailsController.isFeeDetail.value
                      ? const Align(
                          alignment: Alignment.center,
                          child: AnimatedProgressWidget(
                              title: "Loading Fee Details",
                              desc:
                                  "Please wait while we load fee details and create a view for you.",
                              animationPath: "assets/json/default.json"),
                        )
                      : overallFeeDetailsController.overallFeeDetail.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 22),
                              child: ManagerFeeBarChart(
                                chipText: overallFeeDetailsController
                                    .overallFeeDetail.first.asmayYear!,
                                totalCharges: overallFeeDetailsController
                                    .overallFeeDetail.first.fssCurrentYrCharges!
                                    .toDouble(),
                                payable: overallFeeDetailsController
                                    .overallFeeDetail.first.balance!
                                    .toDouble(),
                                totalConcession: overallFeeDetailsController
                                    .overallFeeDetail.first.concession!
                                    .toDouble(),
                                totalPaid: overallFeeDetailsController
                                    .overallFeeDetail.first.fssPaidAmount!
                                    .toDouble(),
                              ),
                            )
                          : const Center(
                              child:
                                  Text('No data available for selected year')),
                ],
              ),
      ),
    );
  }
}
