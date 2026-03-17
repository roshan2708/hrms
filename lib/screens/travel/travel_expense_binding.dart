import 'package:get/get.dart';
import '../../controllers/travel_expense_controller.dart';

class TravelExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelExpenseController>(() => TravelExpenseController());
  }
}
