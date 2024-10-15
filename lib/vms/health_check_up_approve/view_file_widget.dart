import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/save_service_notification.dart';
import 'package:m_skool_flutter/vms/health_check_up_approve/model/health_check_up_file_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';

// Reusable Widget for the dialog
class ViewHealthCheckupFileDialog extends StatelessWidget {
  final List<HealthCheckupFileModelValues> files;
  const ViewHealthCheckupFileDialog({Key? key, required this.files})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(10),
      content: SizedBox(
          width: double.infinity, // Ensures full width usage in the dialog
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(files.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          files[index].filename ?? "",
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Handles long file names
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _openFile(context, File(files[index].filepath!));
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (Platform.isIOS) {
                            Dio dio = Dio();
                            PermissionStatus permissionStatus =
                                await Permission.storage.request();
                            if (permissionStatus.isDenied) {
                              Fluttertoast.showToast(
                                  msg: "Unable to download, permission denied");
                              return;
                            }
                            Directory? directory =
                                await getApplicationDocumentsDirectory();
                            String savePath =
                                "${directory.path}${Platform.pathSeparator}/Media/${files[index].filepath!.split("/").last}";
                            await dio.download(
                              files[index].filepath!,
                              savePath,
                              onReceiveProgress: (count, total) {
                                SaveServiceNotification
                                    .showProgressNotification(
                                  total,
                                );
                              },
                            ).then((value) {
                              Fluttertoast.showToast(
                                  msg:
                                      "File downloaded successfully in your device");
                              SaveServiceNotification.showSaveNotification(
                                  directory.path,
                                  "File Downloaded",
                                  "You can tap here to view the file");
                            });
                          } else {
                            FileDownloader.downloadFile(
                                url: files[index].filepath!,
                                onProgress: (name, progress) {
                                  SaveServiceNotification
                                      .showProgressNotification(
                                    progress,
                                  );
                                },
                                onDownloadCompleted: (String? path) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "File downloaded successfully in your device");
                                  SaveServiceNotification.showSaveNotification(
                                      path!,
                                      "File Downloaded",
                                      "You can tap here to view the file");
                                });
                          }
                        },
                        icon: Icon(
                          Icons.download,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          )),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Close',
            style: Get.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

  void _openFile(BuildContext context, File file) {
    String extension = file.path.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif'].contains(extension)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(imageFile: file),
        ),
      );
    } else if (extension == 'pdf') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(pdfFile: file),
        ),
      );
    } else if (['mp4', 'mov'].contains(extension)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(videoFile: file),
        ),
      );
    } else {
      OpenFilex.open(file.path);
    }
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final File imageFile;

  const ImagePreviewScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Preview").getAppBar(),
      body: Center(
        child: Image.network(imageFile.path),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final File pdfFile;

  const PdfViewerScreen({super.key, required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Preview").getAppBar(),
      body: SfPdfViewer.network(
        pdfFile.path,
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final File videoFile;

  const VideoPlayerScreen({super.key, required this.videoFile});

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(widget.videoFile.uri)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Preview").getAppBar(),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
