import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/controller/job_posting_controller.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/tab/new_job_post.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class JobPostingHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  const JobPostingHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<JobPostingHomeScreen> createState() => _JobPostingHomeScreenState();
}

class _JobPostingHomeScreenState extends State<JobPostingHomeScreen>
    with SingleTickerProviderStateMixin {
  JobPostingController controller = Get.put(JobPostingController());
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: [
                CustomTab(name: widget.title, asset: "assets/svg/bell.svg"),
                CustomTab(
                    name: "${widget.title} List", asset: "assets/svg/bell.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                NewJobPost(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  controller: controller,
                ),
                Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
