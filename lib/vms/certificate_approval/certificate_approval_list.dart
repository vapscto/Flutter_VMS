import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class CertificateApprovalList extends StatefulWidget {
  const CertificateApprovalList({super.key});

  @override
  State<CertificateApprovalList> createState() =>
      _CertificateApprovalListState();
}

class _CertificateApprovalListState extends State<CertificateApprovalList> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Certificate Approval/ Reject Details')
          .getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                hintText: 'Search Employee name',
                hintStyle:
                    Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey))),
          )
        ],
      ),
    );
  }
}
