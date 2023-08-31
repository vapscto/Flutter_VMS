import 'package:flutter/material.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/fees/widgets/custom_analysis_container.dart';

class InstallmentDetailWidget extends StatefulWidget {
  final String leadText;
  final String instalText;
  final int netAmount;
  final int concessionAmount;
  final int paidAmount;
  final int balanceAmount;

  const InstallmentDetailWidget({
    super.key,
    required this.leadText,
    required this.instalText,
    required this.netAmount,
    required this.concessionAmount,
    required this.paidAmount,
    required this.balanceAmount,
  });

  @override
  State<InstallmentDetailWidget> createState() =>
      _InstallmentDetailWidgetState();
}

class _InstallmentDetailWidgetState extends State<InstallmentDetailWidget> {
  @override
  Widget build(BuildContext context) {
    logger.d(widget.leadText);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 8, top: 12, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.leadText,
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            letterSpacing: 0.2,
                          ),
                        ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    height: 30,
                    decoration: BoxDecoration(
                      color: widget.leadText == 'Tution Fees'
                          ? const Color(0xFFDFEFFD)
                          : widget.leadText == 'Term Fees'
                              ? const Color(0xFFF1E5FF)
                              : const Color(0xFFFFEEFF),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.instalText,
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: widget.leadText == 'Tution Fees'
                                    ? const Color(0xFF015DAF)
                                    : widget.leadText == 'Term Fees'
                                        ? const Color(0xFF824CC3)
                                        : const Color(0xFFEC16F0),
                              ),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              thickness: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 6, right: 10, top: 8, bottom: 8),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAnalysisContainer(
                      title: "  Total\nCharges",
                      amount: widget.netAmount.toInt(),
                    ),
                    const VerticalDivider(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      thickness: 1,
                    ),
                    CustomAnalysisContainer(
                      title: " Total Paid",
                      amount: widget.paidAmount.toInt(),
                    ),
                    const VerticalDivider(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      thickness: 1,
                    ),
                    CustomAnalysisContainer(
                      title: "     Total\nConcession",
                      amount: widget.concessionAmount.toInt(),
                    ),
                    const VerticalDivider(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      thickness: 1,
                    ),
                    CustomAnalysisContainer(
                      title: "   Now\nPayable",
                      amount: widget.balanceAmount.toInt(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
