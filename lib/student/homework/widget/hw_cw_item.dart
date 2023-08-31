import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/constants/constants.dart';

class HwCwItem extends StatelessWidget {
  final bool isRead;
  final String sub;
  final String topic;
  final Color color;
  final int verified;
  const HwCwItem({
    Key? key,
    required this.sub,
    required this.topic,
    required this.isRead,
    required this.color,
    required this.verified,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: CustomThemeData.getShadow(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: getIconFromSubject(
                            sub.trim().toLowerCase())['chipBgColor']),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          getIconFromSubject(sub.trim().toLowerCase())['icon'],
                          color: getIconFromSubject(
                              sub.trim().toLowerCase())['chipColor'],
                          height: 24.0,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          sub.capitalizeFirst!,
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                TextStyle(
                                    fontSize: 14.0,
                                    color: getIconFromSubject(
                                        sub.trim().toLowerCase())['chipColor']),
                              ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: .0,
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          topic,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                                const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.2,
                                    color: Color(0xFF1a1a1a),
                                    fontSize: 16),
                              ),
                        ),
                      ),
                      Text(
                        verified == 1 ? "Verified" : "",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .merge(const TextStyle(color: Colors.green)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          // Icon(
          //   Icons.chevron_right_outlined,
          //   color: Theme.of(context).primaryColor,
          // ),
          // const SizedBox(
          //   width: 12.0,
          // )

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // width: 48.0,
                // height: 24.0,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    color: Theme.of(context).primaryColor),
                child: const Icon(
                  Icons.chevron_right_outlined,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Icon(
                  Icons.done_all,
                  color: isRead ? Colors.green : Colors.grey.shade600,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
