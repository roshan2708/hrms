import 'package:get/get.dart';
import '../models/department_model.dart';
import '../data/dummy_data.dart';

class DepartmentController extends GetxController {
  final isLoading = false.obs;
  final departments = <Department>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDepartments();
  }

  void loadDepartments() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    departments.assignAll(DummyData.departments);
    isLoading.value = false;
  }
}
