import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
  
 
class BtnSave extends StatefulWidget {
  final String title;
  final Function()? onPress;
  
  const BtnSave({super.key, required this.title, this.onPress});

  @override
  State<BtnSave> createState() => _BtnSaveState();
}

class _BtnSaveState extends State<BtnSave> {
  DrDetailsCtrlr controller = Get.put(DrDetailsCtrlr());
 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: widget.onPress,
      child: Obx(
        () =>  controller.tabLoading.value
            ? Center(
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )),
              )
            : Text(
                widget.title,
                style: Theme.of(context).textTheme.labelSmall!.merge(
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 0.3,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              ),
      ),
    );
  }
}
