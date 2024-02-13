import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/tada_tour_plan/model/lead_details.dart';

class LeadController extends GetxController{
  RxList<LeadCilentValues> getLeadList =<LeadCilentValues>[].obs;
  RxBool   loading = RxBool(false);

  void updateLoading(bool val){
    loading.value = val;
  }

}