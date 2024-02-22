import 'package:flutter/material.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class AllEmpReviewHome extends StatefulWidget {
  const AllEmpReviewHome({super.key});

  @override
  State<AllEmpReviewHome> createState() => _AllEmpReviewHomeState();
}

class _AllEmpReviewHomeState extends State<AllEmpReviewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Employee Ratings').getAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: const [],
      ),
    );
  }
}
