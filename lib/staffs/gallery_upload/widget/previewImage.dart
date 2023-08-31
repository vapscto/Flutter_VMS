import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PreviewImage extends StatefulWidget {
  String imageUrl;
  String galleryName;
  PreviewImage({
    super.key,
    required this.imageUrl,
    required this.galleryName,
  });

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
