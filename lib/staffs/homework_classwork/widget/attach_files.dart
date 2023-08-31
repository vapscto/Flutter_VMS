import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:open_filex/open_filex.dart';

class AttachedFiles extends StatelessWidget {
  final HwCwController hwCwController;
  const AttachedFiles({super.key, required this.hwCwController});

  @override
  Widget build(BuildContext context) {
    final ImagePicker pickImage = ImagePicker();
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
                                            hwCwController
                                                .addToAttachment(xfile);
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                minRadius: 36.0,
                                                backgroundColor:
                                                    Theme.of(context)
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
                                                await pickImage
                                                    .pickMultiImage();
                                            if (pickedImage.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "No Image selected for attachment");
                                              return;
                                            }
                                            hwCwController
                                                .addMultipleAttachment(
                                                    pickedImage);
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                minRadius: 36.0,
                                                backgroundColor:
                                                    Theme.of(context)
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

                                            hwCwController.addMultipleAttFiles(
                                                pickerRes.files);
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                minRadius: 36.0,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .dividerColor,
                                                child: Icon(
                                                  Icons
                                                      .document_scanner_outlined,
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
                            });
                      },
                      child: SvgPicture.asset("assets/svg/upload_svg.svg")),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(() {
                      return hwCwController.attachment.isEmpty &&
                              hwCwController.attFiles.isEmpty
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
                          :
                          // : ListView.separated(
                          //     //padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //     shrinkWrap: true,
                          //     itemBuilder: (_, index) {
                          //       // if(hwCwController)
                          //       return Row(
                          //         children: [
                          //           Expanded(
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(8.0),
                          //                 border: Border.all(
                          //                     color: Colors.grey.shade300,
                          //                     width: 1.0),
                          //               ),
                          //               child: ListTile(
                          //                 dense: true,
                          //                 minLeadingWidth: 10,
                          //                 visualDensity: const VisualDensity(
                          //                     horizontal:
                          //                         VisualDensity.minimumDensity),
                          //                 leading: Icon(
                          //                   Icons.image_outlined,
                          //                   color:
                          //                       Theme.of(context).primaryColor,
                          //                 ),
                          //                 title: Text(
                          //                   hwCwController.attachment
                          //                       .elementAt(index)!
                          //                       .name,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .titleSmall,
                          //                   maxLines: 1,
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             width: 16.0,
                          //           ),
                          //           IconButton(
                          //               onPressed: () {
                          //                 hwCwController
                          //                     .removeAttachment(index);
                          //               },
                          //               icon: const Icon(Icons.close))
                          //         ],
                          //       );
                          //     },
                          //     separatorBuilder: (_, index) {
                          //       return const SizedBox(
                          //         height: 12.0,
                          //       );
                          //     },
                          //     itemCount: hwCwController.attachment.length);
                          Column(
                              children: [
                                ...List.generate(
                                  hwCwController.attachment.length,
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
                                              hwCwController.attachment
                                                  .elementAt(index)!
                                                  .name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16.0,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            OpenFilex.open(hwCwController
                                                .attachment
                                                .elementAt(index)!
                                                .path);
                                          },
                                          icon:
                                              const Icon(Icons.remove_red_eye)),
                                      IconButton(
                                          onPressed: () {
                                            hwCwController
                                                .removeAttachment(index);
                                          },
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                ),
                                ...List.generate(
                                    hwCwController.attFiles.length,
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
                                                    hwCwController.attFiles
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
                                                  OpenFilex.open(hwCwController
                                                      .attFiles
                                                      .elementAt(index)
                                                      .path);
                                                },
                                                icon: const Icon(
                                                    Icons.remove_red_eye)),
                                            const SizedBox(
                                              width: 16.0,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  hwCwController
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
                " Attach Files ",
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
