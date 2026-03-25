import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProfileViewHeader extends StatelessWidget {
  final String userName;
  final String role;
  final String department;
  final String? profileImageUrl;

  const ProfileViewHeader({
    super.key,
    required this.userName,
    required this.role,
    required this.department,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? Colors.white : AppColors.accent;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: accentColor.withValues(alpha: 0.5), width: 2),
          ),
          child: CircleAvatar(
            radius: 54,
            backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl!) : null,
            child: profileImageUrl == null 
              ? const Icon(Icons.person_outline_rounded, size: 50) 
              : null,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          userName,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          role,
          style: TextStyle(
            fontSize: 16,
            color: secondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            department,
            style: TextStyle(
              fontSize: 12,
              color: accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
