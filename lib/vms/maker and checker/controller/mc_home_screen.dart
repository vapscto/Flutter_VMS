import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/adavnceList_mode.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/applyList_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/department_list.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/designation.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/model/employee_model_list.dart';

class MakerCheckerController extends GetxController{
   RxBool loading = RxBool(false);
   RxBool errorLoading = RxBool(false);
   RxBool checkLeaveandCompoff  =RxBool(false);

   RxBool dsgloading = RxBool(false);
   RxBool dsgerrorLoading = RxBool(false);
   
   RxBool emloading = RxBool(false);
   RxBool empErrorrorLoading =RxBool(false);

   void updateLoading(bool val){
    loading.value = val;
   }
   void upateErrorLoading(bool val){
    errorLoading.value = val;
   }
   void updateCompoff(bool val){
    checkLeaveandCompoff.value = val;
   }

   void updatedsgLoading(bool val){
    dsgloading.value=val;
   }
   void updatempLoading(bool val){
    emloading.value=val;
   }
  void updatempErrorLoading(bool val){
 empErrorrorLoading.value=val;
  }
   RxList<DepartmentModelListValues> departmentList = <DepartmentModelListValues>[].obs;
   RxList<dsgnModelValues> designationList = <dsgnModelValues>[].obs;
   RxList<EmployeeModelListValues> employeeList = <EmployeeModelListValues>[].obs;
   RxList<AdavanceListModelValues> adavanceListModel =<AdavanceListModelValues>[].obs;
   RxList<ApplyListModelValues> applyListModel = <ApplyListModelValues>[].obs;
}