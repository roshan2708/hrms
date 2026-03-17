import 'package:get/get.dart';
import '../../controllers/daily_task_controller.dart';

class DailyTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyTaskController>(() => DailyTaskController());
  }
}
