import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/helpdesk_controller.dart';
import '../../core/theme/app_colors.dart';

class HelpdeskView extends GetView<HelpdeskController> {
  const HelpdeskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Support Helpdesk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Raise and track your support requests', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => controller.createTicket(),
            icon: const Icon(Icons.add_circle_outline_rounded),
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
          _buildTicketMetrics(),
          _buildTabSwitcher(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.tickets.length,
                itemBuilder: (context, index) {
                  final ticket = controller.tickets[index];
                  return _buildTicketCard(ticket);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketMetrics() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildStatCard('Total', controller.tickets.length.toString(), Icons.confirmation_number_outlined, Colors.blue),
          _buildStatCard('Open', controller.tickets.where((t) => t['status'] == 'Open').length.toString(), Icons.error_outline_rounded, Colors.red),
          _buildStatCard('Resolved', controller.tickets.where((t) => t['status'] == 'Resolved').length.toString(), Icons.check_circle_outline_rounded, Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 150,
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
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600], fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 2)),
      ),
      child: Row(
        children: [
          _buildTabItem('Dashboard', 'dashboard'),
          const SizedBox(width: 24),
          _buildTabItem('My Tickets', 'tickets'),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, String tab) {
    return Obx(() {
      final isSelected = controller.activeTab.value == tab;
      return GestureDetector(
        onTap: () => controller.activeTab.value = tab,
        child: Container(
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: isSelected ? Border(bottom: BorderSide(color: AppColors.primary, width: 3)) : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTicketCard(dynamic ticket) {
    final status = ticket['status'];
    Color statusColor = Colors.blue;
    if (status == 'Open') statusColor = Colors.red;
    if (status == 'Resolved') statusColor = Colors.green;
    if (status == 'In Progress') statusColor = Colors.orange;

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
                Text(ticket['id'], style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                const Spacer(),
                _buildPriorityBadge(ticket['priority']),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ticket['subject'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('By: ${ticket['creator']} • ${ticket['date']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
                _buildStatusBadge(status, statusColor),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ticket['category'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.forum_outlined, size: 14),
                  label: const Text('Chat', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    foregroundColor: Colors.blue,
                    elevation: 0,
                    minimumSize: const Size(0, 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = Colors.grey;
    if (priority == 'High' || priority == 'Urgent') color = Colors.red;
    if (priority == 'Medium') color = Colors.orange;

    return Row(
      children: [
        Icon(Icons.flag_rounded, size: 14, color: color),
        const SizedBox(width: 4),
        Text(priority, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildStatusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
