import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/desk_controller.dart';
import '../../core/theme/app_colors.dart';

class DeskManagementView extends GetView<DeskController> {
  const DeskManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Desk Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Manage office workspace and bookings', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildOccupancyStats(),
          _buildTabSwitcher(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.activeTab.value == 'occupancy') {
                return _buildOccupancyView();
              }
              return _buildDeskListView();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOccupancyStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildMiniStat('Total', controller.desks.length.toString(), Colors.blue),
          const SizedBox(width: 8),
          _buildMiniStat('Available', controller.desks.where((d) => d['status'] == 'Available').length.toString(), Colors.green),
          const SizedBox(width: 8),
          _buildMiniStat('Booked', controller.desks.where((d) => d['status'] == 'Booked').length.toString(), Colors.orange),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildSmallTab('Occupancy', 'occupancy'),
          const SizedBox(width: 8),
          _buildSmallTab('Book Desk', 'booking'),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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

  Widget _buildOccupancyView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFloorCard('1st Floor', 0.7, '28/40 occupied', Colors.blue),
        _buildFloorCard('2nd Floor', 0.3, '12/40 occupied', Colors.green),
        _buildFloorCard('3rd Floor', 0.45, '18/40 occupied', Colors.orange),
      ],
    );
  }

  Widget _buildFloorCard(String floor, double progress, String detail, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(floor, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text('Manage', style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(detail, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text('${(progress * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDeskListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.desks.length,
      itemBuilder: (context, index) {
        final desk = controller.desks[index];
        return _buildDeskCard(desk);
      },
    );
  }

  Widget _buildDeskCard(dynamic desk) {
    final status = desk['status'];
    Color statusColor = Colors.green;
    if (status == 'Booked') statusColor = Colors.blue;
    if (status == 'Assigned') statusColor = Colors.indigo;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(Icons.window_rounded, color: statusColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(desk['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${desk['floor']} - ${desk['type']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStatusBadge(status, statusColor),
                const SizedBox(height: 8),
                if (status == 'Available')
                  ElevatedButton(
                    onPressed: () => controller.bookDesk(desk['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      minimumSize: const Size(0, 32),
                      elevation: 0,
                    ),
                    child: const Text('Book', style: TextStyle(fontSize: 11)),
                  )
                else
                  Text(desk['bookedBy'] ?? '-', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            )
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
}
