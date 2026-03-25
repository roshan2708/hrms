import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'attendance_summary_item.dart';

class AttendanceSummaryHeader extends StatelessWidget {
  const AttendanceSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      color: isDark ? AppColors.darkSurface : AppColors.primary,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AttendanceSummaryItem(
            label: 'Present',
            value: '20',
            icon: Icons.check_circle_rounded,
            color: AppColors.success,
          ),
          AttendanceSummaryItem(
            label: 'Late',
            value: '2',
            icon: Icons.watch_later_rounded,
            color: AppColors.warning,
          ),
          AttendanceSummaryItem(
            label: 'Absent',
            value: '1',
            icon: Icons.cancel_rounded,
            color: AppColors.error,
          ),
        ],
      ),
    );
  }
}
