import 'package:flutter/material.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class JobPostingHomeScreen extends StatefulWidget {
  const JobPostingHomeScreen({super.key});

  @override
  State<JobPostingHomeScreen> createState() => _JobPostingHomeScreenState();
}

class _JobPostingHomeScreenState extends State<JobPostingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Job Posting').getAppBar(),
    );
  }
}
