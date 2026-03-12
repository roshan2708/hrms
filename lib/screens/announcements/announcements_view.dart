import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/announcement_controller.dart';
import '../../models/announcement_model.dart';
import '../../core/theme/app_colors.dart';
import 'package:intl/intl.dart';

class AnnouncementsView extends GetView<AnnouncementController> {
  const AnnouncementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.announcements.isEmpty) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.campaign_outlined, size: 64, color: secondaryColor.withOpacity(0.3)),
                const SizedBox(height: 16),
                Text('No announcements found', style: TextStyle(color: secondaryColor)),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.announcements.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final announcement = controller.announcements[index];
            return _buildAnnouncementCard(context, announcement);
          },
        );
      }),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, Announcement announcement) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Card(
      elevation: announcement.isImportant ? 4 : (isDark ? 0 : 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: announcement.isImportant 
            ? BorderSide(color: AppColors.error, width: 2) 
            : (isDark ? BorderSide(color: AppColors.darkBorder) : BorderSide.none),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: announcement.isImportant ? AppColors.error.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    announcement.isImportant ? Icons.priority_high_rounded : Icons.campaign_rounded,
                    color: announcement.isImportant ? AppColors.error : AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        announcement.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'By ${announcement.author} • ${DateFormat('MMM d, yyyy').format(announcement.datePosted)}',
                        style: TextStyle(fontSize: 12, color: secondaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              announcement.content,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
