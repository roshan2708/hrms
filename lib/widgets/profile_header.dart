import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String role;
  final String department;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.role,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent, width: 2),
          ),
          child: CircleAvatar(
            radius: size.width * 0.07,
            backgroundColor: AppColors.lightBackground,
            child: Icon(
              Icons.person_rounded,
              size: size.width * 0.09,
              color: AppColors.primary,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: AppTypography.title(context).copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    role,
                    style: AppTypography.caption(context).copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(width: 1, height: 12, color: AppColors.lightBorder),
                  const SizedBox(width: 8),
                  Text(
                    department,
                    style: AppTypography.caption(context).copyWith(
                      color: AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
