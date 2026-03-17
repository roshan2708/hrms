import 'package:get/get.dart';
import '../../controllers/recruitment_controller.dart';

class RecruitmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecruitmentController>(() => RecruitmentController());
  }
}
