import 'package:flutter/material.dart';
import 'package:m_skool_flutter/manager/student_notice_board/tabs/new_notice.dart';
import 'package:m_skool_flutter/manager/student_notice_board/tabs/view_notice.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class StudentNoticeBoardHome extends StatefulWidget {
  const StudentNoticeBoardHome({super.key});

  @override
  State<StudentNoticeBoardHome> createState() => _StudentNoticeBoardHomeState();
}

class _StudentNoticeBoardHomeState extends State<StudentNoticeBoardHome>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: CustomAppBar(
        title: "Notice Board",
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
            color: Colors.white,
            child: CustomTabBar(
              tabs: const [
                CustomTab(
                    name: "New Notice", asset: "assets/svg/file-text.svg"),
                CustomTab(name: "View Notice", asset: "assets/svg/eye_svg.svg"),
              ],
              tabController: tabController!,
            ),
          ),
        ),
      ).getAppBar(),
      body: TabBarView(
        controller: tabController,
        children: const [
          NewNoticeTab(),
          ViewNoticeTab(),
        ],
      ),
    );
  }
}
