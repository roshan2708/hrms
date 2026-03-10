import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_controller.dart';
import '../../models/attendance_model.dart';
import '../../core/theme/app_colors.dart';
import 'package:intl/intl.dart';

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
                Icon(Icons.calendar_today_outlined, size: 64, color: secondaryColor.withOpacity(0.3)),
                const SizedBox(height: 16),
                Text('No records found', style: TextStyle(color: secondaryColor)),
              ],
            ),
          );
        }

        return Column(
          children: [
            _buildSummaryHeader(context),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: controller.attendanceList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final record = controller.attendanceList[index];
                  return _buildAttendanceCard(context, record);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSummaryHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      color: isDark ? AppColors.darkSurface : AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Present', '20', Icons.check_circle_rounded, AppColors.success),
          _buildSummaryItem('Late', '2', Icons.watch_later_rounded, AppColors.warning),
          _buildSummaryItem('Absent', '1', Icons.cancel_rounded, AppColors.error),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAttendanceCard(BuildContext context, AttendanceRecord record) {
    bool isPresent = record.status.toLowerCase() == 'present';
    Color statusColor = isPresent ? AppColors.success : AppColors.error;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                isPresent ? Icons.login_rounded : Icons.logout_rounded,
                color: statusColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, MMM d').format(record.date),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded, size: 14, color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                      const SizedBox(width: 6),
                      Text(
                        record.checkInTime != null 
                          ? '${DateFormat('hh:mm a').format(record.checkInTime!)} - ${record.checkOutTime != null ? DateFormat('hh:mm a').format(record.checkOutTime!) : '--:--'}'
                          : '--:-- - --:--',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary, 
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                record.status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
