import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class HwCwUploadedContentItem extends StatelessWidget {
  final Function() onViewClicked;
  final Function() onDownloadClicked;
  final String title;
  final bool isPdf;
  final String? deleteAsset;
  const HwCwUploadedContentItem({
    Key? key,
    required this.onViewClicked,
    required this.onDownloadClicked,
    required this.title,
    required this.isPdf,
    this.deleteAsset,
  }) : super(key: key);

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
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    deleteAsset ?? "assets/svg/download.svg",
                    color: Colors.white,
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
