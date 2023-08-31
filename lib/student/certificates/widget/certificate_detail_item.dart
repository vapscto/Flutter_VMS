import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/student/certificates/model/stud_list.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class CertificateDetailItem extends StatelessWidget {
  final StudListValues values;
  const CertificateDetailItem({
    super.key,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: Row(
          //     children: [
          //       Icon(
          //         Icons.circle,
          //         size: 18.0,
          //         color: values.ascAStatus!.toLowerCase() == "pending"
          //             ? Colors.grey.shade600
          //             : Colors.green,
          //       ),
          //       const SizedBox(
          //         width: 12.0,
          //       ),
          //     ],
          //   ),
          // ),
          // const Divider(
          //   thickness: 1,
          //   height: 1,
          // ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      values.acertapPCertificateName ?? "N/a",
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.0)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: values.ascAStatus!.toLowerCase() == "pending"
                            ? Colors.grey.shade100
                            : const Color(0xffE7ffE7),
                      ),
                      child: Text(
                        values.ascAStatus ?? "N/a",
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                              TextStyle(
                                fontSize: 15.0,
                                letterSpacing: 0.2,
                                color: values.ascAStatus == null
                                    ? Colors.grey.shade600
                                    : values.ascAStatus!.toLowerCase() ==
                                            "pending"
                                        ? Colors.grey.shade600
                                        : const Color(0xFF21AA21),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(values.ascaReason == null
                    ? "Reason field is not present in db"
                    : values.ascaReason!),
                const SizedBox(
                  height: 8.0,
                ),
                Text(values.ascAApplyDate == null
                    ? "N/a"
                    : "Applied Date  : ${getFormatedDate(DateTime.parse(values.ascAApplyDate!))}")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
