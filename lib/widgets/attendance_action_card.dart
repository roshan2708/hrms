import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class AttendanceActionCard extends StatelessWidget {
  final bool isCheckedIn;
  final String formattedWorkedTime;
  final VoidCallback onToggleCheckIn;

  const AttendanceActionCard({
    super.key,
    required this.isCheckedIn,
    required this.formattedWorkedTime,
    required this.onToggleCheckIn,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: isCheckedIn
              ? [Colors.teal.shade400, Colors.teal.shade700]
              : [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            isCheckedIn ? 'Currently Clocked In' : 'Ready to Start?',
            style: AppTypography.title(context).copyWith(color: Colors.white),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            isCheckedIn
                ? 'Hours Worked Today: $formattedWorkedTime'
                : 'Clock in to begin tracking time',
            style: AppTypography.body(context).copyWith(color: Colors.white70),
          ),
          SizedBox(height: size.height * 0.03),
          ElevatedButton(
            onPressed: onToggleCheckIn,
            style: ElevatedButton.styleFrom(
              backgroundColor: isCheckedIn ? Colors.red.shade400 : Colors.white,
              foregroundColor: isCheckedIn ? Colors.white : AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: size.height * 0.015,
              ),
            ),
            child: Text(
              isCheckedIn ? 'CLOCK OUT' : 'CLOCK IN',
              style: AppTypography.button(context).copyWith(
                color: isCheckedIn ? Colors.white : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
