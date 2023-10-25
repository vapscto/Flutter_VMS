import 'package:flutter/material.dart';

class ContainerTitle extends StatelessWidget {
  final String title;
  final String image;
  final Color iT;
  final Color bg;
  const ContainerTitle({
    Key? key,
    required this.title,
    required this.image,
    required this.iT,
    required this.bg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -20,
      left: 14,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 24,
            ),
            const SizedBox(width: 5),
            Text(
              ' $title ',
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      color: iT,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
