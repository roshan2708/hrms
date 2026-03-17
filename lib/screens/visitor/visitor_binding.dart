import 'package:get/get.dart';
import '../../controllers/visitor_controller.dart';

class VisitorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitorController>(() => VisitorController());
  }
}
