import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/visitor_controller.dart';
import '../../core/theme/app_colors.dart';

class VisitorTrackingView extends GetView<VisitorController> {
  const VisitorTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Visitor Tracking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Track office guests and logs', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add_rounded),
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
          _buildDailySummary(),
          _buildTabSwitcher(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final filtered = controller.visitors.where((v) {
                if (controller.activeTab.value == 'approvals') return v['status'] == 'Pending';
                if (controller.activeTab.value == 'log') return v['status'] == 'Checked Out';
                return true;
              }).toList();

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final visitor = filtered[index];
                  return _buildVisitorCard(visitor);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDailySummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, Colors.blue]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Expected', '12'),
          _buildSummaryItem('Inside', '4'),
          _buildSummaryItem('Completed', '8'),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  Widget _buildTabSwitcher() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildSmallTab('All', 'request'),
          const SizedBox(width: 8),
          _buildSmallTab('Approvals', 'approvals'),
          const SizedBox(width: 8),
          _buildSmallTab('Logs', 'log'),
        ],
      ),
    );
  }

  Widget _buildSmallTab(String label, String tab) {
    return Obx(() {
      final isSelected = controller.activeTab.value == tab;
      return GestureDetector(
        onTap: () => controller.activeTab.value = tab,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildVisitorCard(dynamic visitor) {
    final status = visitor['status'];
    Color statusColor = Colors.blue;
    if (status == 'Checked Out') statusColor = Colors.grey;
    if (status == 'In Premise') statusColor = Colors.green;

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
                  child: const Icon(Icons.person_pin_rounded, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(visitor['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(visitor['purpose'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                _buildStatusBadge(status, statusColor),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                _buildInfoCol('Host', visitor['host']),
                _buildInfoCol('Entry', visitor['entry']),
                _buildInfoCol('Exit', visitor['exit']),
              ],
            ),
            if (status == 'In Premise') ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updateStatus(visitor['id'], 'Checked Out'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red[50], foregroundColor: Colors.red, elevation: 0),
                  child: const Text('Check Out'),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoCol(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
