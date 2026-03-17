import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/performance_controller.dart';
import '../../core/theme/app_colors.dart';

class PerformanceView extends GetView<PerformanceController> {
  const PerformanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Performance Reviews', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Manage employee appraisals', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.reviews.length,
                itemBuilder: (context, index) {
                  final review = controller.reviews[index];
                  return _buildReviewCard(review);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildSimpleDropdown(controller.cycleFilter.value, ['Q1 2024', 'Annual 2023']),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSimpleDropdown(controller.deptFilter.value, ['All Departments', 'Engineering', 'Design']),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleDropdown(String value, List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
          onChanged: (val) {},
        ),
      ),
    );
  }

  Widget _buildReviewCard(dynamic review) {
    final status = review['status'];
    final isCompleted = status == 'Completed';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(review['employee'][0], style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review['employee'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(review['department'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                _buildStatusChip(status, isCompleted ? Colors.green : Colors.orange),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow('Reviewer:', review['reviewer']),
            const SizedBox(height: 4),
            _buildInfoRow('Cycle:', review['cycle']),
            const SizedBox(height: 4),
            _buildInfoRow('Score:', review['score'], isBold: true),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('View Details'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(width: 8),
        Text(value, style: TextStyle(fontSize: 12, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
