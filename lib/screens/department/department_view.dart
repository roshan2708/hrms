import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/department_controller.dart';
import '../../models/department_model.dart';
import '../../core/theme/app_colors.dart';

class DepartmentView extends GetView<DepartmentController> {
  const DepartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              Get.snackbar('Coming Soon', 'Add department feature will be implemented soon.');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.departments.isEmpty) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.business_rounded, size: 64, color: secondaryColor.withOpacity(0.3)),
                const SizedBox(height: 16),
                Text('No departments found', style: TextStyle(color: secondaryColor)),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.departments.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final dept = controller.departments[index];
            return _buildDepartmentCard(context, dept);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar('Coming Soon', 'Add department feature will be implemented soon.');
        },
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.primary,
        foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
        child: const Icon(Icons.add_business_rounded),
      ),
    );
  }

  Widget _buildDepartmentCard(BuildContext context, Department department) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  department.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${department.employeeCount} Employees',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.person_outline, size: 20, color: secondaryColor),
                const SizedBox(width: 8),
                Text('Head:', style: TextStyle(color: secondaryColor, fontSize: 13)),
                const SizedBox(width: 8),
                Text(
                  department.head,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
