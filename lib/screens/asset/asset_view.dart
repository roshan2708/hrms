import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/asset_controller.dart';
import '../../models/asset_model.dart';
import '../../core/theme/app_colors.dart';

class AssetListView extends GetView<AssetController> {
  const AssetListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              Get.snackbar('Info', 'Create asset coming soon');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.assets.isEmpty) {
          return const Center(child: Text('No assets found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.assets.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final asset = controller.assets[index];
            return _buildAssetCard(context, asset);
          },
        );
      }),
    );
  }

  Widget _buildAssetCard(BuildContext context, Asset asset) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.withValues(alpha: 0.1),
          child: const Icon(Icons.inventory_2, color: Colors.orange),
        ),
        title: Text(asset.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${asset.category} • ${asset.status}'),
        trailing: asset.serialNumber != null 
          ? Text(asset.serialNumber!, style: const TextStyle(fontSize: 12, color: Colors.grey))
          : null,
      ),
    );
  }
}
