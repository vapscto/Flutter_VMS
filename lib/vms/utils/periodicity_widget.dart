import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';

class PeriodicityWidget extends StatelessWidget {
  final ProfileController controller;
  const PeriodicityWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(controller.periodicityList.length, (index) {
          var v = controller.periodicityList.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(1, 2.1),
                          blurRadius: 0,
                          spreadRadius: -1,
                          color: Colors.grey),
                    ],
                    color: (v.hRMPName!.toLowerCase() == 'critical')
                        ? Colors.red
                        : (v.hRMPName!.toLowerCase() == 'blocker')
                            ? Colors.blue
                            : (v.hRMPName!.toLowerCase() == 'major')
                                ? Colors.yellow
                                : Colors.green),
                child: Column(
                  children: [
                    Text(
                      v.mIName ?? '',
                      style: Get.textTheme.titleSmall!.copyWith(
                          color: (v.hRMPName!.toLowerCase() == 'critical')
                              ? Colors.white
                              : (v.hRMPName!.toLowerCase() == 'blocker')
                                  ? Colors.white
                                  : (v.hRMPName!.toLowerCase() == 'major')
                                      ? Colors.black
                                      : Colors.white),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${v.hRMPName}:-',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: (v.hRMPName!.toLowerCase() ==
                                          'critical')
                                      ? Colors.white
                                      : (v.hRMPName!.toLowerCase() == 'blocker')
                                          ? Colors.white
                                          : (v.hRMPName!.toLowerCase() ==
                                                  'major')
                                              ? Colors.black
                                              : Colors.white)),
                          TextSpan(
                              text: ' ${v.totalcount}',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: (v.hRMPName!.toLowerCase() ==
                                          'critical')
                                      ? Colors.white
                                      : (v.hRMPName!.toLowerCase() == 'blocker')
                                          ? Colors.white
                                          : (v.hRMPName!.toLowerCase() ==
                                                  'major')
                                              ? Colors.black
                                              : Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
