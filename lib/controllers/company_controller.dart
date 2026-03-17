import 'dart:convert';
import 'package:get/get.dart';
import '../../models/company_model.dart';
import '../../services/company_service.dart';

class CompanyController extends GetxController {
  final companies = <Company>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    try {
      isLoading.value = true;
      final response = await CompanyService.getAllCompanies();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        companies.assignAll(
          data.map((json) => Company.fromJson(json)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch companies: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while fetching companies');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCompany(String id) async {
    try {
      isLoading.value = true;
      final response = await CompanyService.deleteCompany(id);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.snackbar('Success', 'Company deleted successfully');
        fetchCompanies();
      } else {
        Get.snackbar('Error', 'Failed to delete company: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while deleting company');
    } finally {
      isLoading.value = false;
    }
  }
}
