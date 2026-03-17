import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/delegation_controller.dart';
import '../../core/theme/app_colors.dart';

class DelegationView extends GetView<DelegationController> {
  const DelegationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delegation Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Manage temporary authority delegation', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
          _buildDelegationStats(),
          _buildSearchBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.delegations.length,
                itemBuilder: (context, index) {
                  final del = controller.delegations[index];
                  return _buildDelegationCard(del);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDelegationStats() {
    final activeCount = controller.delegations.where((d) => d['status'] == 'Active').length;
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildStatCard('Active', activeCount.toString(), Icons.check_circle_rounded, Colors.green),
          _buildStatCard('Total Logs', controller.delegations.length.toString(), Icons.layers_rounded, AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600], fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search delegation...',
          prefixIcon: const Icon(Icons.search_rounded, size: 18),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDelegationCard(dynamic del) {
    final status = del['status'];
    Color statusColor = Colors.green;
    if (status == 'Expired') statusColor = Colors.grey;
    if (status == 'Cancelled') statusColor = Colors.red;

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
                _buildUserAvatar(del['delegated_by']),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delegated By', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text(del['delegated_by'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.grey),
                const SizedBox(width: 12),
                _buildUserAvatar(del['delegated_to']),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delegated To', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text(del['delegated_to'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                _buildTag(del['module'], Colors.indigo),
                const Spacer(),
                _buildStatusDot(status, statusColor),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${del['start_date']} to ${del['end_date']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const Spacer(),
                if (status == 'Active')
                  TextButton(
                    onPressed: () => controller.cancelDelegation(del['id']),
                    style: TextButton.styleFrom(foregroundColor: Colors.red, padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                    child: const Text('Cancel', style: TextStyle(fontSize: 11)),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar(String name) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      child: Text(name[0], style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStatusDot(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
