import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final String? badgeStat;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.badgeStat,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: size.width * 0.08, color: AppColors.primary),
              SizedBox(height: size.height * 0.01),
              Text(
                title,
                style: AppTypography.body(context)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              if (badgeStat != null) ...[
                SizedBox(height: size.height * 0.005),
                Text(
                  badgeStat!,
                  style: AppTypography.caption(context)
                      .copyWith(color: AppColors.error),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
