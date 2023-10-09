import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
 
 import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';

class GpasHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const GpasHomeScreen({
    required  this.loginSuccessModel,
    required this.mskoolController, 
    super.key});

  @override
  State<GpasHomeScreen> createState() => _GpasHomeScreenState();
}

class _GpasHomeScreenState extends State<GpasHomeScreen> {
  GetEmpDetailsController getEmpDetailsController =  Get.put(GetEmpDetailsController());
  @override
  void initState() {
     intial();
    super.initState();
  }
  intial()async{
    getEmpDetailsController.getLocation().then(
  (value) {
    if(!value){
      Fluttertoast.showToast(msg: "Please provide a location permission");
    }
  },
); 
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Container(
        child: Center(child: Obx
        (()=> Text("latitude${getEmpDetailsController.latitude}\n longitude ${getEmpDetailsController.longitude}")),),
      ),
    );
  }
 
}