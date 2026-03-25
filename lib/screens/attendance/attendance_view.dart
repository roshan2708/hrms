import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/attendance/attendance_card.dart';
import '../../widgets/attendance/attendance_summary_header.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.attendanceList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today_outlined, size: 64, color: secondaryColor.withValues(alpha: 0.3)),
                const SizedBox(height: 16),
                Text('No records found', style: TextStyle(color: secondaryColor)),
              ],
            ),
          );
        }

        return Column(
          children: [
            const AttendanceSummaryHeader(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: controller.attendanceList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final record = controller.attendanceList[index];
                  return AttendanceCard(record: record);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
