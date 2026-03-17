import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/branch_controller.dart';
import '../../models/branch_model.dart';
import '../../core/theme/app_colors.dart';

class BranchListView extends GetView<BranchController> {
  const BranchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Branches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              // TODO: Implement Create Branch Screen
              Get.snackbar('Info', 'Create branch coming soon');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.branches.isEmpty) {
          return const Center(child: Text('No branches found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.branches.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final branch = controller.branches[index];
            return _buildBranchCard(context, branch);
          },
        );
      }),
    );
  }

  Widget _buildBranchCard(BuildContext context, Branch branch) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.withValues(alpha: 0.1),
          child: const Icon(Icons.location_on, color: Colors.blue),
        ),
        title: Text(branch.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(branch.location),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () => controller.deleteBranch(branch.id),
        ),
      ),
    );
  }
}
