import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class CustomHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const CustomHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Icon(
          icon,
          size: size.width * 0.2,
          color: AppColors.primary,
        ),
        SizedBox(height: size.height * 0.05),
        Text(
          title,
          style: AppTypography.heading(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          subtitle,
          style: AppTypography.subtitle(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
