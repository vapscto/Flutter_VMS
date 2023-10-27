import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/client_model_list.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/hc_emp_list.dart';
import 'package:m_skool_flutter/vms/health_chequeup/models/institute_model.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_departments.dart';

class HealthCheckUpController extends GetxController{
  RxList<InstituteListModelValues> getInstituteList = <InstituteListModelValues>[].obs;
  RxList<ClientListModelValues> getClientList = <ClientListModelValues>[].obs;
  RxList<GetHCEmpListModelValues> getEmpList = <GetHCEmpListModelValues>[].obs;
  RxList<AtachmentFile> addListBrowser = <AtachmentFile>[].obs ;
  final ImagePicker _imagePicker = ImagePicker();

  RxBool loadpage = RxBool(false);
  updateLoadPage(bool val){
  loadpage.value = val;
  }
}