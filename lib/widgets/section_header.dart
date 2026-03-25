import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: isDark ? Colors.white : AppColors.primary,
        letterSpacing: -0.5,
      ),
    );
  }
}
