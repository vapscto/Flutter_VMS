import 'package:flutter/material.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class InterViewSchduleHome extends StatefulWidget {
  const InterViewSchduleHome({super.key});

  @override
  State<InterViewSchduleHome> createState() => _InterViewSchduleHomeState();
}

class _InterViewSchduleHomeState extends State<InterViewSchduleHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Interview Schdule").getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [],
      ),
    );
  }
}
