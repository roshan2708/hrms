import 'package:get/get.dart';
import '../../controllers/setup_organization_controller.dart';

class SetupOrganizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupOrganizationController>(() => SetupOrganizationController());
  }
}
