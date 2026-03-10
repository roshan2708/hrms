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
      padding: EdgeInsets.all(size.width * 0.06),
      decoration: BoxDecoration(
        color: isCheckedIn ? AppColors.accent : AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCheckedIn ? 'Status: Active' : 'Status: Inactive',
                    style: AppTypography.caption(context)
                        .copyWith(color: Colors.white70, letterSpacing: 1.2),
                  ),
                  SizedBox(height: 4),
                  Text(
                    isCheckedIn ? formattedWorkedTime : '--:--:--',
                    style: AppTypography.heading(context).copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCheckedIn ? Icons.timer : Icons.timer_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onToggleCheckIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: isCheckedIn ? AppColors.error : AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                isCheckedIn ? 'CLOCK OUT' : 'CLOCK IN',
                style: AppTypography.button(context).copyWith(
                  color: isCheckedIn ? AppColors.error : AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
