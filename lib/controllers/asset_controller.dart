import 'dart:convert';
import 'package:get/get.dart';
import '../../models/asset_model.dart';
import '../../services/asset_service.dart';

class AssetController extends GetxController {
  final assets = <Asset>[].obs;
  final categories = <String>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssets();
    fetchCategories();
  }

  Future<void> fetchAssets() async {
    try {
      isLoading.value = true;
      final response = await AssetService.getAllAssets();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        assets.assignAll(
          data.map((json) => Asset.fromJson(json)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch assets: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while fetching assets');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await AssetService.getAssetCategories();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        categories.assignAll(data.map((e) => e.toString()).toList());
      }
    } catch (e) {
    }
  }
}
