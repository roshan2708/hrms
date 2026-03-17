import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/company_controller.dart';
import '../../models/company_model.dart';
import '../../core/theme/app_colors.dart';

class CompanyListView extends GetView<CompanyController> {
  const CompanyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              // TODO: Implement Create Company Screen
              Get.snackbar('Info', 'Create company coming soon');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.companies.isEmpty) {
          return const Center(child: Text('No companies found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.companies.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final company = controller.companies[index];
            return _buildCompanyCard(context, company);
          },
        );
      }),
    );
  }

  Widget _buildCompanyCard(BuildContext context, Company company) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: const Icon(Icons.business, color: AppColors.primary),
        ),
        title: Text(company.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(company.email ?? 'No email'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () => controller.deleteCompany(company.id),
        ),
      ),
    );
  }
}
