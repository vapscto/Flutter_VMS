import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/controller/job_posting_controller.dart';

class JobPostingGrid extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final JobPostingController controller;
  const JobPostingGrid(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controller});

  @override
  State<JobPostingGrid> createState() => _JobPostingGridState();
}

class _JobPostingGridState extends State<JobPostingGrid> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: searchController,
            decoration: InputDecoration(
                hintText: "Search...",
                hintStyle:
                    Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey)),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            onChanged: (value) {
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Total Grid Records : ',
                          style: Get.textTheme.titleSmall),
                      TextSpan(
                        text: '',
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Total Records Searched : ',
                          style: Get.textTheme.titleSmall),
                      TextSpan(
                        text: '',
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                headingRowColor:
                    MaterialStatePropertyAll(Theme.of(context).primaryColor),
                headingTextStyle: Get.textTheme.titleSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                headingRowHeight: 40,
                dataRowHeight: 40,
                dataTextStyle: Get.textTheme.titleSmall,
                dividerThickness: 1,
                border: TableBorder.all(
                    borderRadius: BorderRadius.circular(10), width: 0.5),
                columns: const [
                  DataColumn(label: Text("Sl.No.")),
                ],
                rows: [],
              ),
            ),
          )
        ],
      ),
    );
  }
}
