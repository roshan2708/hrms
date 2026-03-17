import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/wfh_controller.dart';
import '../../core/theme/app_colors.dart';

class WFHRequestsView extends GetView<WFHController> {
  const WFHRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WFH Requests', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_rounded)),
        ],
      ),
      body: Column(
        children: [
          _buildKPIs(),
          _buildFilters(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.filteredRequests.isEmpty) {
                return const Center(child: Text('No WFH requests found'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredRequests.length,
                itemBuilder: (context, index) {
                  final request = controller.filteredRequests[index];
                  return _buildRequestCard(request);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildKPIs() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildKPICard('Total', '12', Colors.indigo),
          _buildKPICard('Pending', '2', Colors.orange),
          _buildKPICard('Approved', '8', Colors.green),
          _buildKPICard('Rejected', '2', Colors.red),
        ],
      ),
    );
  }

  Widget _buildKPICard(String label, String value, Color color) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (val) => controller.searchTerm.value = val,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search_rounded, size: 18),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Obx(() => DropdownButton<String>(
            value: controller.statusFilter.value,
            items: ['All', 'Pending', 'Approved', 'Rejected'].map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12)))).toList(),
            onChanged: (val) { if (val != null) controller.statusFilter.value = val; },
          )),
        ],
      ),
    );
  }

  Widget _buildRequestCard(dynamic request) {
    Color statusColor = Colors.orange;
    if (request['status'] == 'Approved') statusColor = Colors.green;
    if (request['status'] == 'Rejected') statusColor = Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(request['avatar'] ?? '?', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request['employee'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(request['dept'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    request['status'],
                    style: TextStyle(fontSize: 10, color: statusColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${request['startDate']} to ${request['endDate']}', style: const TextStyle(fontSize: 12)),
                const Spacer(),
                Text('${request['days']} Days', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              request['reason'],
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (request['status'] == 'Pending') ...[
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => controller.rejectRequest(request['id']),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Reject'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => controller.approveRequest(request['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: const Text('Approve'),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}
