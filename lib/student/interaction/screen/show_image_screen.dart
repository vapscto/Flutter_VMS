import 'package:flutter/cupertino.dart';

class ShowImageScreen extends StatelessWidget {
  final String image;
  const ShowImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Image.network(image),
    );
  }
}
