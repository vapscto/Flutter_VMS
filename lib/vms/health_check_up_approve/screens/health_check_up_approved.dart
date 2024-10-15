import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/health_check_up_approve_api.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/get_loaded_data_model.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_check_up_comments.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class HealthCheckUpApprovedData extends StatefulWidget {
  final List<GetLoadedDataModelValues> data;
  final MskoolController mskoolController;
  final int miId;
  const HealthCheckUpApprovedData(
      {super.key,
      required this.data,
      required this.mskoolController,
      required this.miId});

  @override
  State<HealthCheckUpApprovedData> createState() =>
      _HealthCheckUpApprovedDataState();
}

class _HealthCheckUpApprovedDataState extends State<HealthCheckUpApprovedData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Health CheckUp Approved Details")
          .getAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: DataTable(
              showCheckboxColumn: true,
              headingRowColor:
                  MaterialStatePropertyAll(Theme.of(context).primaryColor),
              headingTextStyle: Get.textTheme.titleSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              dataTextStyle: Get.textTheme.titleSmall!,
              dataRowHeight: MediaQuery.of(context).size.height * 0.2,
              headingRowHeight: MediaQuery.of(context).size.height * 0.08,
              horizontalMargin: 10,
              columnSpacing: MediaQuery.of(context).size.width * 0.08,
              dividerThickness: 1,
              border: TableBorder.all(
                  borderRadius: BorderRadius.circular(10), width: 0.5),
              columns: const [
                DataColumn(
                  label: Text("SL No."),
                ),
                DataColumn(
                  label: Text("Details"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: List.generate(widget.data.length, (index) {
                var i = index + 1;
                var d = widget.data.elementAt(index);

                return DataRow(cells: [
                  DataCell(Text(i.toString())),
                  DataCell(SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Client:- ",
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(text: d.iSMMCLTClientName ?? "")
                        ])),
                        const SizedBox(height: 3),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Vosited Persion:- ",
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(text: d.hRMEEmployeeFirstName ?? "")
                        ])),
                        const SizedBox(height: 3),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Applied Date:- ",
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(text: d.appliedDate ?? "")
                        ])),
                        const SizedBox(height: 3),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Approved Date:- ",
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(text: d.approvedDate ?? "")
                        ])),
                        const SizedBox(height: 3),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Final Status:- ",
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(text: d.overAllStatus ?? "")
                        ])),
                        const SizedBox(height: 3),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Approved Status:- ",
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                          TextSpan(text: d.approvedStatus ?? "")
                        ])),
                      ],
                    ),
                  )),
                  DataCell(
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 30),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.5,
                                  minHeight: 100,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize
                                      .min, // This makes sure the dialog doesn't exceed the content's size
                                  children: [
                                    Expanded(
                                      child: FutureBuilder<
                                          List<HealthCheckupCommentsValues>?>(
                                        future:
                                            HealthCheckUpApproveAPI.i.comments(
                                          base: baseUrlFromInsCode(
                                              "issuemanager",
                                              widget.mskoolController),
                                          hwhchupId: d.hWHCHUPId!,
                                          miId: widget.miId,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: AnimatedProgressWidget(
                                                title: "Loading",
                                                desc: "",
                                                animationPath:
                                                    "assets/json/default.json",
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                snapshot.error.toString(),
                                                style:
                                                    Get.textTheme.titleMedium,
                                              ),
                                            );
                                          } else if (snapshot.hasData) {
                                            final data = snapshot.data;
                                            if (data!.isEmpty) {
                                              return Center(
                                                child: Text(
                                                  "Comment is not Available",
                                                  style:
                                                      Get.textTheme.titleMedium,
                                                ),
                                              );
                                            }
                                            return ListView.separated(
                                              padding: const EdgeInsets.all(16),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text:
                                                              "Approved User:- ",
                                                          style: Get.textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                            text: data[index]
                                                                    .userName ??
                                                                ""),
                                                      ])),
                                                      const SizedBox(height: 3),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text: "Date:- ",
                                                          style: Get.textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                            text: getDate(DateTime
                                                                .parse(data[
                                                                        index]
                                                                    .visitedDate!))),
                                                      ])),
                                                      const SizedBox(height: 3),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text: "Remarks:- ",
                                                          style: Get.textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                            text: data[index]
                                                                    .remarks ??
                                                                ""),
                                                      ])),
                                                      const SizedBox(height: 3),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text: "Level No.:- ",
                                                          style: Get.textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                            text: data[index]
                                                                .levelNo
                                                                .toString()),
                                                      ])),
                                                      const SizedBox(height: 3),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text: "Status:- ",
                                                          style: Get.textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                            text: data[index]
                                                                    .status ??
                                                                ""),
                                                      ])),
                                                    ],
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(
                                                    height: 10);
                                              },
                                              itemCount: data.length,
                                            );
                                          } else {
                                            return Center(
                                              child: Text(
                                                "Comment is not Available",
                                                style:
                                                    Get.textTheme.titleMedium,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: MSkollBtn(
                                        onPress: () {
                                          Navigator.of(context).pop();
                                        },
                                        title: "Close",
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ]);
              }),
            ),
          ),
        ),
      ),
    );
  }
}
