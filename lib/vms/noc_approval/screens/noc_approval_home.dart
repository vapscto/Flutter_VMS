import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/noc_approval/api/noc_approve_api.dart';
import 'package:m_skool_flutter/vms/noc_approval/controller/noc_approved_controller.dart';
import 'package:m_skool_flutter/vms/noc_approval/screens/noc_approved_list.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class NocApproval extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const NocApproval(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<NocApproval> createState() => _NocApprovalState();
}

class _NocApprovalState extends State<NocApproval> {
  NocApprovedController controller = Get.put(NocApprovedController());
  _getData() async {
    controller.approved(true);
    await NocApproveAPI.i.certificateLoad(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        controller: controller,
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!);
    controller.approved(false);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  int bgColor = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'NOC Approval').getAppBar(),
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemBuilder: (context, index) {
            return Container();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MSkollBtn(
          title: "NOC Approve/Reject Details",
          onPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NocApprovedListScreen(
                          controller: controller,
                          mskoolController: widget.mskoolController,
                          loginSuccessModel: widget.loginSuccessModel,
                        )));
          }),
    );
  }
}
