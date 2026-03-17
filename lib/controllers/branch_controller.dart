import 'dart:convert';
import 'package:get/get.dart';
import '../../models/branch_model.dart';
import '../../services/branch_service.dart';

class BranchController extends GetxController {
  final branches = <Branch>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBranches();
  }

  Future<void> fetchBranches() async {
    try {
      isLoading.value = true;
      final response = await BranchService.getAllBranches();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        branches.assignAll(
          data.map((json) => Branch.fromJson(json)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch branches: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while fetching branches');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteBranch(String id) async {
    try {
      isLoading.value = true;
      final response = await BranchService.deleteBranch(id);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.snackbar('Success', 'Branch deleted successfully');
        fetchBranches();
      } else {
        Get.snackbar('Error', 'Failed to delete branch: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while deleting branch');
    } finally {
      isLoading.value = false;
    }
  }
}
