import 'package:flutter/material.dart';
import '../core/theme/app_typography.dart';
import '../core/theme/app_colors.dart';

class DashboardSection extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onActionTap;
  final String? actionLabel;

  const DashboardSection({
    super.key,
    required this.title,
    required this.child,
    this.onActionTap,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.subtitle(context).copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.primary,
              ),
            ),
            if (onActionTap != null)
              TextButton(
                onPressed: onActionTap,
                child: Text(actionLabel ?? 'See All'),
              ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
