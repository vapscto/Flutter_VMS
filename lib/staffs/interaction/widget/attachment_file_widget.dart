import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/staffs/interaction/controller/staff_interaction_compose_related_controller.dart';
import 'package:m_skool_flutter/student/interaction/controller/compose_tab_controller.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:open_filex/open_filex.dart';

class AttachmentFileWidget extends StatefulWidget {
  final StaffInteractionComposeController? staffInteractionComposeController;
  final ComposeController? studentInteractionComposeController;
  final String login;

  const AttachmentFileWidget({
    super.key,
    this.staffInteractionComposeController,
    this.studentInteractionComposeController,
    required this.login,
  });

  @override
  State<AttachmentFileWidget> createState() => _AttachmentFileWidgetState();
}

class _AttachmentFileWidgetState extends State<AttachmentFileWidget> {
  final ImagePicker pickImage = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: CustomContainer(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Upload Attachment's",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);
                                          final XFile? xfile =
                                              await pickImage.pickImage(
                                                  source: ImageSource.camera);
                                          if (xfile == null) {
                                            Fluttertoast.showToast(
                                                msg: "No Image selected");
                                            return;
                                          }
                                          widget.login == 'student'
                                              ? widget
                                                  .studentInteractionComposeController!
                                                  .addToAttachment(xfile)
                                              : widget
                                                  .staffInteractionComposeController!
                                                  .addToAttachment(xfile);
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              minRadius: 36.0,
                                              backgroundColor: Theme.of(context)
                                                  .dividerColor,
                                              child: Icon(
                                                Icons.camera_alt,
                                                size: 36.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .color,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            const Text("Camera"),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16.0,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);
                                          final List<XFile?> pickedImage =
                                              await pickImage.pickMultiImage();
                                          if (pickedImage.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "No Image selected for attachment");
                                            return;
                                          }
                                          widget.login == 'student'
                                              ? widget
                                                  .studentInteractionComposeController!
                                                  .addMultipleAttachment(
                                                      pickedImage)
                                              : widget
                                                  .staffInteractionComposeController!
                                                  .addMultipleAttachment(
                                                      pickedImage);
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              minRadius: 36.0,
                                              backgroundColor: Theme.of(context)
                                                  .dividerColor,
                                              child: Icon(
                                                Icons.image,
                                                size: 36.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .color,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            const Text("Gallery"),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16.0,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);

                                          final FilePickerResult? pickerRes =
                                              await FilePicker.platform
                                                  .pickFiles(
                                                      dialogTitle:
                                                          "Select Attachment's",
                                                      allowMultiple: true);

                                          if (pickerRes == null) {
                                            Fluttertoast.showToast(
                                                msg: "No File selected..");
                                            return;
                                          }

                                          widget.login == 'student'
                                              ? widget
                                                  .studentInteractionComposeController!
                                                  .addMultipleAttFiles(
                                                      pickerRes.files)
                                              : widget
                                                  .staffInteractionComposeController!
                                                  .addMultipleAttFiles(
                                                      pickerRes.files);
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              minRadius: 36.0,
                                              backgroundColor: Theme.of(context)
                                                  .dividerColor,
                                              child: Icon(
                                                Icons.document_scanner_outlined,
                                                size: 36.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .color,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            const Text("Others"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset("assets/svg/upload_svg.svg")),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(() {
                      return (widget.login == 'staff' &&
                                  widget.staffInteractionComposeController!
                                      .attachment.isEmpty &&
                                  widget.staffInteractionComposeController!
                                      .attFiles.isEmpty) ||
                              (widget.login == 'student' &&
                                  widget.studentInteractionComposeController!
                                      .attachment.isEmpty &&
                                  widget.studentInteractionComposeController!
                                      .attFiles.isEmpty)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "No Attachment attached",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                const Text(
                                  "When you add attachment, it will appear here",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                ...List.generate(
                                  widget.login == 'student'
                                      ? widget
                                          .studentInteractionComposeController!
                                          .attachment
                                          .length
                                      : widget
                                          .staffInteractionComposeController!
                                          .attachment
                                          .length,
                                  (index) => Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 12.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 1.0),
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              widget.login == 'student'
                                                  ? OpenFilex.open(widget
                                                      .studentInteractionComposeController!
                                                      .attachment
                                                      .elementAt(index)!
                                                      .path)
                                                  : OpenFilex.open(widget
                                                      .staffInteractionComposeController!
                                                      .attachment
                                                      .elementAt(index)!
                                                      .path);
                                            },
                                            dense: true,
                                            minLeadingWidth: 10,
                                            visualDensity: const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity),
                                            leading: Icon(
                                              Icons.image_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            title: Text(
                                              widget.login == 'student'
                                                  ? widget
                                                      .studentInteractionComposeController!
                                                      .attachment
                                                      .elementAt(index)!
                                                      .name
                                                  : widget
                                                      .staffInteractionComposeController!
                                                      .attachment
                                                      .elementAt(index)!
                                                      .name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16.0,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            widget.login == 'student'
                                                ? OpenFilex.open(widget
                                                    .studentInteractionComposeController!
                                                    .attachment
                                                    .elementAt(index)!
                                                    .path)
                                                : OpenFilex.open(widget
                                                    .staffInteractionComposeController!
                                                    .attachment
                                                    .elementAt(index)!
                                                    .path);
                                          },
                                          icon:
                                              const Icon(Icons.remove_red_eye)),
                                      IconButton(
                                          onPressed: () {
                                            widget.login == 'student'
                                                ? widget
                                                    .studentInteractionComposeController!
                                                    .removeAttachment(index)
                                                : widget
                                                    .staffInteractionComposeController!
                                                    .removeAttachment(index);
                                          },
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                ),
                                ...List.generate(
                                    widget.login == 'student'
                                        ? widget
                                            .studentInteractionComposeController!
                                            .attFiles
                                            .length
                                        : widget
                                            .staffInteractionComposeController!
                                            .attFiles
                                            .length,
                                    (index) => Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 12.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1.0),
                                                ),
                                                child: ListTile(
                                                  onTap: () {
                                                    widget.login == 'student'
                                                        ? OpenFilex.open(widget
                                                            .studentInteractionComposeController!
                                                            .attFiles
                                                            .elementAt(index)
                                                            .path)
                                                        : OpenFilex.open(widget
                                                            .staffInteractionComposeController!
                                                            .attFiles
                                                            .elementAt(index)
                                                            .path);
                                                  },
                                                  dense: true,
                                                  minLeadingWidth: 10,
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: VisualDensity
                                                              .minimumDensity),
                                                  leading: Icon(
                                                    Icons.file_open_outlined,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  title: Text(
                                                    widget.login == 'student'
                                                        ? widget
                                                            .studentInteractionComposeController!
                                                            .attFiles
                                                            .elementAt(index)
                                                            .name
                                                        : widget
                                                            .staffInteractionComposeController!
                                                            .attFiles
                                                            .elementAt(index)
                                                            .name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16.0,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  widget.login == 'student'
                                                      ? OpenFilex.open(widget
                                                          .studentInteractionComposeController!
                                                          .attFiles
                                                          .elementAt(index)
                                                          .path)
                                                      : OpenFilex.open(widget
                                                          .staffInteractionComposeController!
                                                          .attFiles
                                                          .elementAt(index)
                                                          .path);
                                                },
                                                icon: const Icon(
                                                    Icons.remove_red_eye)),
                                            IconButton(
                                                onPressed: () {
                                                  widget.login == 'student'
                                                      ? widget
                                                          .studentInteractionComposeController!
                                                          .removeAtt(index)
                                                      : widget
                                                          .staffInteractionComposeController!
                                                          .removeAtt(index);
                                                },
                                                icon: const Icon(Icons.close))
                                          ],
                                        ))
                              ],
                            );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          //height: 30,
          margin: const EdgeInsets.only(bottom: 5, left: 12.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: const Color(0xFFEBFDFF)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/attach.svg",
                height: 14.0,
              ),
              const SizedBox(
                width: 6.0,
              ),
              Text(
                " Attach Files (Optional)",
                style: Theme.of(context).textTheme.labelMedium!.merge(
                      const TextStyle(fontSize: 15.0, color: Color(0xFF32B9CA)),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
