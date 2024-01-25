import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/vms/dr_genration/model/planner_file_upload_model.dart';

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
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.width * 0.3,
        child: GridView.builder(
          itemCount: widget.value.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  createPreview(context, widget.value[index].path);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 185, 194, 247)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.file_copy,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
