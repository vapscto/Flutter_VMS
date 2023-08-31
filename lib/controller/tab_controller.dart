import 'package:get/get.dart';

class TabStateController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
