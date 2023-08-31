import 'package:flutter/material.dart';

class ProfileItemsCard extends StatelessWidget {
  final Color cardColor;
  final String logoAsset;
  final String title;
  final Function? onTap;
  const ProfileItemsCard(
      {super.key,
      required this.cardColor,
      required this.logoAsset,
      required this.title,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border.fromBorderSide(BorderSide.none),
        backgroundBlendMode: BlendMode.overlay,
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardTheme.color,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 2,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: InkWell(
        onTap: (onTap != null)
            ? () {
                onTap!();
              }
            : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: cardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    logoAsset,
                  ),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
