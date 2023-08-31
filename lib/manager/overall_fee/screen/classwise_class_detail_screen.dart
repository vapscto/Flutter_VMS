import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/overall_fee/controller/overall_classwise_related_controller.dart';
import 'package:m_skool_flutter/manager/overall_fee/widget/manager_fee_card.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ClasswiseClassDetailScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String heading;
  final int asmayId;
  final int asmclId;
  const ClasswiseClassDetailScreen({
    super.key,
    required this.heading,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.asmayId,
    required this.asmclId,
  });

  @override
  State<ClasswiseClassDetailScreen> createState() =>
      _ClasswiseClassDetailScreenState();
}

class _ClasswiseClassDetailScreenState
    extends State<ClasswiseClassDetailScreen> {
  final OverallClasswiseController overallClasswiseController =
      Get.put(OverallClasswiseController());

  void getSectionList() async {
    overallClasswiseController.issectionwiseloading(true);
    await overallClasswiseController.getSectionwiseData(
        base: baseUrlFromInsCode('portal', widget.mskoolController),
        asmayId: widget.asmayId,
        asmclId: widget.asmclId,
        miId: widget.loginSuccessModel.mIID!);
    overallClasswiseController.issectionwiseloading(false);
  }

  @override
  void initState() {
    getSectionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.heading).getAppBar(),
      body: Obx(
        () => overallClasswiseController.isSectionwiseData.value
            ? const Align(
                alignment: Alignment.center,
                child: AnimatedProgressWidget(
                    title: "Loading Fee Results",
                    desc: "",
                    animationPath: "assets/json/default.json"),
              )
            : overallClasswiseController.sectionwiseList.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        overallClasswiseController.sectionwiseList.length,
                    itemBuilder: (context, index) {
                      return ManagerFeeCard(
                        title: 'Section',
                        classname: overallClasswiseController.sectionwiseList
                            .elementAt(index)
                            .asmcSectionName!,
                        concession: overallClasswiseController.sectionwiseList
                            .elementAt(index)
                            .concession!,
                        payable: overallClasswiseController.sectionwiseList
                            .elementAt(index)
                            .balance!,
                        totalCharges: overallClasswiseController.sectionwiseList
                            .elementAt(index)
                            .fssCurrentYrCharges!,
                        totalPaid: overallClasswiseController.sectionwiseList
                            .elementAt(index)
                            .fssPaidAmount!,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 25,
                    ),
                  )
                : const Center(
                    child: Text('No data avaiable for this class'),
                  ),
      ),
    );
  }
}
