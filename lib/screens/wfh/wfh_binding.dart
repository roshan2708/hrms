import 'package:get/get.dart';
import '../../controllers/wfh_controller.dart';

class WFHBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WFHController>(() => WFHController());
  }
}
