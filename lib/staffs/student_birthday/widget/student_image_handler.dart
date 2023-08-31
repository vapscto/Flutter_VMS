import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/student_birthday/model/student_bday_model.dart';

class StudentImage extends StatelessWidget {
  const StudentImage({
    Key? key,
    required this.value,
    required this.color,
  }) : super(key: key);

  final StudentBdayModelValues value;
  final int color;

  @override
  Widget build(BuildContext context) {
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(48.0),
    //   child: Image.network(
    //     value.amstPhoto!,
    //     frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) {
    //       if (wasSynchronouslyLoaded) {
    //         return child;
    //       }
    //       return CircleAvatar(
    //         radius: 36.0,
    //         backgroundColor: noticeColor.elementAt(color),
    //         child: const CircularProgressIndicator(
    //           color: Colors.white,
    //         ),
    //       );
    //     }),
    //     // loadingBuilder: (context, child, loadingProgress) => CircleAvatar(
    //     //   radius: 36.0,
    //     //   backgroundColor: noticeColor.elementAt(color),
    //     //   child: const CircularProgressIndicator(
    //     //     color: Colors.white,
    //     //   ),
    //     // ),
    //     errorBuilder: ((context, error, stackTrace) => CircleAvatar(
    //           radius: 36.0,
    //           backgroundColor: noticeColor.elementAt(color),
    //           child: const Icon(
    //             Icons.warning,
    //             color: Colors.white,
    //           ),
    //         )),
    //     width: 60,
    //     height: 60,
    //     fit: BoxFit.cover,
    //   ),
    // );

    return CachedNetworkImage(
      imageUrl: value.amstPhoto ??
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      imageBuilder: (context, imageProvider) => CircleAvatar(
        minRadius: 36.0,
        backgroundImage: imageProvider,
        backgroundColor: noticeColor.elementAt(color),
      ),
      placeholder: (context, url) => CircleAvatar(
        minRadius: 36.0,
        backgroundColor: noticeColor.elementAt(color),
        child: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 1.0,
        ),
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        minRadius: 36.0,
        backgroundColor: noticeColor.elementAt(color),
        child: const Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
