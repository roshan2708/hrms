import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/leave_controller.dart';
import '../../models/leave_model.dart';
import '../../core/theme/app_colors.dart';
import '../../routes/app_routes.dart';
import 'package:intl/intl.dart';

class LeaveRequestsView extends GetView<LeaveController> {
  const LeaveRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Requests'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => Get.toNamed(Routes.applyLeave),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

        if (controller.leaveRequests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.beach_access_rounded, size: 64, color: secondaryColor.withValues(alpha: 0.2)),
                const SizedBox(height: 16),
                Text('No leave requests found', style: TextStyle(color: secondaryColor)),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: controller.leaveRequests.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final request = controller.leaveRequests[index];
            return _buildLeaveCard(context, request);
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.applyLeave),
        label: const Text('New Request'),
        icon: const Icon(Icons.add_rounded),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.primary,
        foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      ),
    );
  }

  Widget _buildLeaveCard(BuildContext context, LeaveRequest request) {
    Color statusColor;
    IconData statusIcon;
    switch (request.status.toLowerCase()) {
      case 'approved':
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'pending':
        statusColor = AppColors.warning;
        statusIcon = Icons.pending_rounded;
        break;
      case 'rejected':
        statusColor = AppColors.error;
        statusIcon = Icons.cancel_rounded;
        break;
      default:
        statusColor = AppColors.lightTextSecondary;
        statusIcon = Icons.info_rounded;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? Colors.white : AppColors.accent;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    request.leaveType,
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(statusIcon, color: statusColor, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      request.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateCol(context, 'Start Date', request.startDate),
                ),
                Container(width: 1, height: 30, color: isDark ? AppColors.darkBorder : AppColors.lightBorder, margin: const EdgeInsets.symmetric(horizontal: 16)),
                Expanded(
                  child: _buildDateCol(context, 'End Date', request.endDate),
                ),
              ],
            ),
            if (request.reason.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Reason',
                style: TextStyle(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary, 
                  fontSize: 11, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                request.reason,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDateCol(BuildContext context, String label, DateTime date) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('dd MMM, yyyy').format(date),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}
