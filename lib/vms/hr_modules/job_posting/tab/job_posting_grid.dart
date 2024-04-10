import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/api/job_posting_api.dart';
import 'package:m_skool_flutter/vms/hr_modules/job_posting/controller/job_posting_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

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

  _onload() async {
    widget.controller.gridloading(true);
    await JobPostingAPI.i.onLoadGrid(
        base: baseUrlFromInsCode("recruitement", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        controller: widget.controller);
    widget.controller.gridloading(false);
  }

  @override
  void initState() {
    _onload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return widget.controller.isGridLoading.value
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading ",
                desc: "We are under process to get your details from server.")
            : widget.controller.jobGridList.isEmpty
                ? const AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'Data is not available',
                    desc: "",
                    animatorHeight: 250,
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // TextFormField(
                      //   controller: searchController,
                      //   decoration: InputDecoration(
                      //       hintText: "Search...",
                      //       hintStyle:
                      //           Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: const BorderSide(color: Colors.grey)),
                      //       suffixIcon: const Icon(
                      //         Icons.search,
                      //         color: Colors.black,
                      //       )),
                      //   onChanged: (value) {
                      //     setState(() {});
                      //   },
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text.rich(
                      //         TextSpan(
                      //           children: [
                      //             TextSpan(
                      //                 text: 'Total Grid Records : ',
                      //                 style: Get.textTheme.titleSmall),
                      //             TextSpan(
                      //               text: '',
                      //               style: Get.textTheme.titleSmall!
                      //                   .copyWith(color: Theme.of(context).primaryColor),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Text.rich(
                      //         TextSpan(
                      //           children: [
                      //             TextSpan(
                      //                 text: 'Total Records Searched : ',
                      //                 style: Get.textTheme.titleSmall),
                      //             TextSpan(
                      //               text: '',
                      //               style: Get.textTheme.titleSmall!
                      //                   .copyWith(color: Theme.of(context).primaryColor),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                            headingRowColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor),
                            headingTextStyle: Get.textTheme.titleSmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                            headingRowHeight: 40,
                            dataRowHeight: 40,
                            dataTextStyle: Get.textTheme.titleSmall,
                            dividerThickness: 1,
                            border: TableBorder.all(
                                borderRadius: BorderRadius.circular(10),
                                width: 0.5),
                            columns: const [
                              DataColumn(label: Text("Sl.No.")),
                              DataColumn(label: Text("MRF")),
                              DataColumn(label: Text("Position")),
                              DataColumn(label: Text("Location")),
                              DataColumn(label: Text("Priority")),
                              DataColumn(label: Text("No. of Position")),
                              DataColumn(label: Text("Status")),
                            ],
                            rows: List.generate(
                                widget.controller.jobGridList.length, (index) {
                              var v = index + 1;
                              var data = widget.controller.jobGridList
                                  .elementAt(index);
                              return DataRow(cells: [
                                DataCell(Text(v.toString())),
                                DataCell(Text(data.hrmrfRMRFNO.toString())),
                                DataCell(Text(data.hrmPPosition ?? "")),
                                DataCell(
                                    Text(data.hrmrfRJobLocation.toString())),
                                DataCell(Text(data.hrmpTName ?? "")),
                                DataCell(
                                    Text(data.hrmrfRNoofPosition.toString())),
                                DataCell(Text(data.hrmrfRStatus.toString())),
                              ]);
                            }),
                          ),
                        ),
                      )
                    ],
                  );
      }),
    );
  }
}
