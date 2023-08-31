import 'package:flutter/material.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/fees/apis/trans_status_api.dart';
import 'package:m_skool_flutter/student/fees/model/trans_status_model.dart';
import 'package:m_skool_flutter/student/fees/model/transaction_his_model.dart';

class TransHisItem extends StatefulWidget {
  
  final TransDetailHisModelValues value;
  final LoginSuccessModel loginSuccessMode;
  final MskoolController mskoolController;
  const TransHisItem({
    Key? key,
    required this.value,
    required this.loginSuccessMode,
    required this.mskoolController,
  }) : super(key: key);

  @override
  State<TransHisItem> createState() => _TransHisItemState();
}

class _TransHisItemState extends State<TransHisItem> {
  bool showStatus = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: CustomThemeData.getShadow(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFDFFBFE),
                    borderRadius: BorderRadius.circular(8)
                    // boxShadow: const BoxShadow(),
                    ),
                // style: TextButton.styleFrom(
                //     backgroundColor: const Color(0xFFF9E5EA)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.value.fmoTPayGatewayType!,
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                            color: Color(0xFF28B6C8),
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    showStatus = !showStatus;
                    setState(() {});
                  },
                  child: Container(
                    child: Text(
                      showStatus ? "Hide Status" : "Show Status",
                      style: Theme.of(context).textTheme.button!.merge(
                            TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).primaryColor,
                              letterSpacing: 0.2,
                              fontSize: 14.0,
                            ),
                          ),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Transaction Id : ${widget.value.transId}",
                            style:
                                Theme.of(context).textTheme.titleMedium!.merge(
                                      const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
                          children: [
                            Text(
                              "₹ ${widget.value.amount}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .merge(const TextStyle(fontSize: 16.0)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getFormatedDate(
                              DateTime.parse(widget.value.fyPDate!)),
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              TextStyle(
                                  letterSpacing: 0.2,
                                  fontSize: 14.0,
                                  color: Colors.grey.shade500)),
                        ),
                        showStatus
                            ? FutureBuilder<List<TransLogResultValues>>(
                                future: TransApiStatus.instance.getStatus(
                                    miId: widget.loginSuccessMode.mIID!,
                                    asmayId: widget.loginSuccessMode.asmaYId!,
                                    amstId: widget.loginSuccessMode.amsTId!,
                                    transId: widget.value.transId!,
                                    base: baseUrlFromInsCode(
                                        "portal", widget.mskoolController),
                                    gateway: widget.value.fmoTPayGatewayType!),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.isEmpty) {
                                      return Row(
                                        children: const [
                                          Icon(
                                            Icons.warning,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text("N/A")
                                        ],
                                      );
                                    }
                                    return Text(snapshot
                                        .data!.first.responsestatuslogs!);
                                  }
                                  if (snapshot.hasError) {
                                    return Row(
                                      children: const [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text("N/A")
                                      ],
                                    );
                                  }

                                  return const SizedBox(
                                    height: 12.0,
                                    width: 12.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3.0,
                                    ),
                                  );
                                })
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6.0,
          ),
        ],
      ),
    );
  }
}
