import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/task%20creation/model/get_project_category.dart';

class TaskProjectsController extends GetxController{
RxBool tskPrjtloading = RxBool(false);
RxBool tskPrjErrorLoading = RxBool(false);

RxBool categoryLoading = RxBool(false);
RxBool projectUiLoading = RxBool(true);
void updateTaskProjectsLoading(bool val)
{
tskPrjtloading.value = val;
}

void updateTaskProjectsErrorLoading(bool val){
  tskPrjErrorLoading.value = val; 
}
void updateCategoryLoading(bool val){
 categoryLoading.value = val; 
}

void projectUi(bool val){
  projectUiLoading.value = val;
}
RxList<GeTskProjectsValues> getTaskProjectsList = <GeTskProjectsValues>[].obs;
// loading Category
RxList<GeTskCategoryValues> getTaskCategoryList = <GeTskCategoryValues>[].obs;

}