import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationPopup extends StatefulWidget {
  final String title;
  final Widget child;
  final Function? onCancel;
  final Function onConfirm;
  const ConfirmationPopup(
      {required this.child,
      required this.title,
      required this.onConfirm,
      this.onCancel,
      Key? key})
      : super(key: key);

  @override
  State<ConfirmationPopup> createState() => _ConfirmationPopupState();
}

class _ConfirmationPopupState extends State<ConfirmationPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: ScaleTransition(
          scale: curvedAnimation,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            height: Get.height / 4,
            width: Get.width / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.title, //'Repair Quotation',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 18)),
                widget.child,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            primary: Colors.red,
                            onPrimary: Colors.white),
                        onPressed: () {
                          if (widget.onCancel != null) widget.onCancel!();
                          Get.back();
                        },
                        child: const Text('Decline')),
                    TextButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            primary: Theme.of(context).colorScheme.primary,
                            onPrimary: Colors.white),
                        onPressed: () {
                          widget.onConfirm();
                        },
                        child: const Text('Confirm')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
