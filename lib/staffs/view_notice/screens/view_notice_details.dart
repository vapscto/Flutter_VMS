import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/view_notice/api/view_attachment_api.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/attachment_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_filter_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/model/view_notice_model.dart';
import 'package:m_skool_flutter/staffs/view_notice/widget/pdf_attachment.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:readmore/readmore.dart';

import '../widget/other_attachment.dart';

class ViewNoticeDetailsScreen extends StatelessWidget {
  final Color bgColor;
  final Color chipColor;
  final ViewNoticeModelValues? values;
  final ViewNoticeFilterModelValues? val;
  final String base;
  final int intBId;
  const ViewNoticeDetailsScreen({
    super.key,
    required this.bgColor,
    required this.chipColor,
    this.values,
    required this.base,
    required this.intBId,
    this.val,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "View Notice").getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset("assets/images/hwnewbanner.png"),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Chip(
              backgroundColor: bgColor,
              label: Text(
                val != null
                    ? val!.intBStartDate == null || val!.intBEndDate == null
                        ? "N/a"
                        : "${getFormatedDate(DateTime.parse(val!.intBStartDate!))} to ${getFormatedDate(DateTime.parse(val!.intBEndDate!))}"
                    : values!.iNTBStartDate == null ||
                            values!.iNTBEndDate == null
                        ? "N/a"
                        : "${getFormatedDate(DateTime.parse(values!.iNTBStartDate!))} to ${getFormatedDate(DateTime.parse(values!.iNTBEndDate!))}",
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      TextStyle(color: chipColor),
                    ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              val != null
                  ? values!.iNTBTitle ?? "N/a"
                  : values!.iNTBTitle ?? "N/a",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16.0),
                  ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ReadMoreText(
              val != null
                  ? val!.intBDescription ?? "N/a"
                  : values!.iNTBDescription ?? "N/a",
              style: Theme.of(context).textTheme.labelSmall!.merge(
                    const TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.3,
                      height: 1.2,
                      //color: Color(0xFF1A1A1A),
                    ),
                  ),
              trimExpandedText: " Read Less",
              trimCollapsedText: "Read More",
              moreStyle: const TextStyle(color: Color(0xFFF97A33)),
              lessStyle: const TextStyle(color: Color(0xFFF97A33)),
            ),
            const SizedBox(
              height: 36.0,
            ),
            FutureBuilder<List<AttachmentModelValues>>(
                future: ViewAttachmentApi.instance
                    .getAttachment(intBId: intBId, base: base),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot.data!.isNotEmpty
                            ? Text(
                                "Attached Files",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return snapshot.data!
                                          .elementAt(index)
                                          .intbfLFileName ==
                                      null
                                  ? OtherAttachment(
                                      attachmentUrl: snapshot.data!
                                              .elementAt(index)
                                              .intbfLFilePath ??
                                          "",
                                      attachmentName: snapshot.data!
                                              .elementAt(index)
                                              .intbfLFileName ??
                                          "N/a")
                                  : snapshot.data!
                                          .elementAt(index)
                                          .intbfLFileName!
                                          .endsWith(".pdf")
                                      ? PdfAttachment(
                                          attachmentName: snapshot.data!
                                                  .elementAt(index)
                                                  .intbfLFileName ??
                                              "N/a",
                                          attachmentUrl: snapshot.data!
                                                  .elementAt(index)
                                                  .intbfLFilePath ??
                                              "",
                                        )
                                      : OtherAttachment(
                                          attachmentName: snapshot.data!
                                                  .elementAt(index)
                                                  .intbfLFileName ??
                                              "N/a",
                                          attachmentUrl: snapshot.data!
                                                  .elementAt(index)
                                                  .intbfLFilePath ??
                                              "",
                                        );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 12.0,
                              );
                            },
                            itemCount: snapshot.data!.length),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red.shade100,
                          child: const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        const Expanded(
                          child: Text(
                              "An error occured while loading attachment for this particular notice"),
                        ),
                      ],
                    );
                  }

                  return const AnimatedProgressWidget(
                      title: "Loding Attachment's",
                      desc:
                          "Please wait while we load attachment for you, If available it will appear here ",
                      animationPath: "assets/json/default.json");
                })
          ],
        ),
      ),
    );
  }
}
