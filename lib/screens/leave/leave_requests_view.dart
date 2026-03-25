import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/leave_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../widgets/leave/leave_request_card.dart';

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
            return LeaveRequestCard(request: request);
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
}
