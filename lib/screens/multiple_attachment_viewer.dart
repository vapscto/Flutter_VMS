import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_file_upload_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class MultipleAttachmentViewer extends StatefulWidget {
  final List<PlannerFileUpload> value;

  const MultipleAttachmentViewer({super.key, required this.value});

  @override
  State<MultipleAttachmentViewer> createState() =>
      _MultipleAttachmentViewerState();
}

class _MultipleAttachmentViewerState extends State<MultipleAttachmentViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Attaachments").getAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.value.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return (widget.value[index].path.isNotEmpty)
                ? InkWell(
                    onTap: () {
                      createPreview(context, widget.value[index].path);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 150,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 163, 157, 253)),
                      child: getFileIcon(widget.value[index].path),
                    ))
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
