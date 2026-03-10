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
        CircleAvatar(
          radius: size.width * 0.08,
          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
          child: Icon(
            Icons.person,
            size: size.width * 0.1,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: size.width * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: AppTypography.title(context),
              ),
              Text(
                '$role | $department',
                style: AppTypography.body(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
