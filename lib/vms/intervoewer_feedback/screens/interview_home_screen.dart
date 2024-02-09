import 'package:flutter/material.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class InterviewerHomeScreen extends StatefulWidget {
  const InterviewerHomeScreen({super.key});

  @override
  State<InterviewerHomeScreen> createState() => _InterviewerHomeScreenState();
}

class _InterviewerHomeScreenState extends State<InterviewerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Candidate Interview Feedback').getAppBar(),
      body: ListView(),
    );
  }
}
