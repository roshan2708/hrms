import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/notification_controller.dart';
import '../../models/notification_model.dart';
import '../../core/theme/app_colors.dart';
import 'package:intl/intl.dart';

class NotificationsView extends GetView<NotificationController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded),
            tooltip: 'Mark all as read',
            onPressed: () {
              controller.markAllAsRead();
              Get.snackbar('Done', 'All notifications marked as read');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_off_outlined, size: 64, color: secondaryColor.withValues(alpha: 0.3)),
                const SizedBox(height: 16),
                Text('No notifications', style: TextStyle(color: secondaryColor)),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return _buildNotificationTile(context, notification);
          },
        );
      }),
    );
  }

  Widget _buildNotificationTile(BuildContext context, AppNotification notification) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    IconData icon;
    Color iconColor;

    switch (notification.type.toLowerCase()) {
      case 'leave':
        icon = Icons.beach_access_rounded;
        iconColor = AppColors.primary;
        break;
      case 'attendance':
        icon = Icons.access_time_filled_rounded;
        iconColor = AppColors.warning;
        break;
      case 'system':
        icon = Icons.system_update_rounded;
        iconColor = AppColors.accent;
        break;
      default:
        icon = Icons.notifications_rounded;
        iconColor = secondaryColor;
    }

    return Container(
      color: notification.isRead ? Colors.transparent : AppColors.primary.withValues(alpha: 0.05),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withValues(alpha: 0.15),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            if (!notification.isRead)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: TextStyle(
                color: notification.isRead ? secondaryColor : (isDark ? Colors.white70 : Colors.black87),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _formatTimeAgo(notification.timestamp),
              style: TextStyle(color: secondaryColor, fontSize: 11),
            ),
          ],
        ),
        onTap: () {
          if (!notification.isRead) {
            controller.markAsRead(notification.id);
          }
        },
      ),
    );
  }

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 1) {
      return DateFormat('MMM d, yyyy').format(timestamp);
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${DateFormat('h:mm a').format(timestamp)}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} mins ago';
    } else {
      return 'Just now';
    }
  }
}
