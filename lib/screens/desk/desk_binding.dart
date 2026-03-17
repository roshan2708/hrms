import 'package:get/get.dart';
import '../../controllers/desk_controller.dart';

class DeskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeskController>(() => DeskController());
  }
}
