import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class HwCwContentItem extends StatelessWidget {
  final Function() onDownloadClicked;
  final Function() onViewClicked;
  final String title;
  final bool isPdf;
  const HwCwContentItem(
      {super.key,
      required this.onDownloadClicked,
      required this.title,
      required this.isPdf,
      required this.onViewClicked});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: CustomContainer(
            child: ListTile(
              minLeadingWidth: 10,
              leading: isPdf
                  ? SvgPicture.asset(
                      "assets/svg/pdf.svg",
                      height: 36.0,
                    )
                  : Icon(
                      Icons.image_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: onViewClicked,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/svg/eye_svg.svg",
                    color: Colors.white,
                    height: 24,
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              InkWell(
                onTap: onDownloadClicked,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xFFD9EDFF),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/svg/download.svg",
                    color: Theme.of(context).primaryColor,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
