import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_elevated_button.dart';

class AppUpdateAlertDialog extends StatefulWidget {
  final Function? onCancel;
  final Function onConfirm;
  const AppUpdateAlertDialog({required this.onConfirm, this.onCancel, Key? key})
      : super(key: key);

  @override
  State<AppUpdateAlertDialog> createState() => _AppUpdateAlertDialogState();
}

class _AppUpdateAlertDialogState extends State<AppUpdateAlertDialog>
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

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Color headerTextColor = Theme.of(context).textTheme.bodyText1!.color!;
    Color suHeaderTextColor = Theme.of(context).textTheme.bodyText2!.color!;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: ScaleTransition(
            scale: curvedAnimation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardTheme.color,
              ),
              height: Get.height * 0.2731,
              width: Get.width / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Update App', //'Repair Quotation',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: Get.height * 0.0216,
                        fontFamily: "Poppins",
                        color: headerTextColor),
                  ),
                  Text(
                      'Please Update Your App\nYou Are Using Older Version', //'Repair Quotation',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Get.height * 0.0196,
                          fontFamily: "Poppins",
                          color: headerTextColor),
                      textAlign: TextAlign.center),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (widget.onCancel != null)
                        SizedBox(
                          height: Get.height * 0.0372,
                          width: Get.width * 0.1672,
                          child: CustomElevatedButton(
                            onPressed: () {
                              if (widget.onCancel != null) widget.onCancel!();
                            },
                            child: Text(
                              "Later".tr,
                              // style: TextStyle(
                              //   fontFamily: "Poppins",
                              //   fontWeight: FontWeight.bold,
                              //   fontSize:
                              //       MediaQuery.of(context).size.height * 0.0170,
                              //   color: (themeData.isLightMode.value)
                              //       ? Colors.white
                              //       : Colors.black,
                              // ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: Get.height * 0.0372,
                        width: Get.width * 0.1672,
                        child: CustomElevatedButton(
                          onPressed: () {
                            widget.onConfirm();
                          },
                          child: Text(
                            "Update".tr,
                            // style: TextStyle(
                            //   fontFamily: "Poppins",
                            //   fontWeight: FontWeight.bold,
                            //   fontSize:
                            //       MediaQuery.of(context).size.height * 0.0170,
                            //   color: (themeData.isLightMode.value)
                            //       ? Colors.white
                            //       : Colors.black,
                            // ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
