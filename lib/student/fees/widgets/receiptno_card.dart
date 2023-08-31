import 'package:flutter/material.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_no_model.dart';

class ReceiptNoCard extends StatefulWidget {
  final ReceiptNoList receiptDetail;
  final int index;
  final int asmayId;
  final Function(int) function;
  final Function(int) function1;
  const ReceiptNoCard({
    super.key,
    required this.receiptDetail,
    required this.index,
    required this.asmayId,
    required this.function,
    required this.function1,
  });

  @override
  State<ReceiptNoCard> createState() => _ReceiptNoCardState();
}

class _ReceiptNoCardState extends State<ReceiptNoCard> {
  bool isChecked = false;
  addAndRemove(bool b) async {
    if (b) {
      await widget.function(widget.receiptDetail.fyPId!.toInt());
    } else {
      widget.function1(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            value: isChecked,
            onChanged: (value) {
              setState(
                () {
                  isChecked = value!;
                  addAndRemove(value);
                },
              );
            },
          ),
          Text(widget.receiptDetail.fyPReceiptNo!),
        ],
      ),
    );
  }
}
