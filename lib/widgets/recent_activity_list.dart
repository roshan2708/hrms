import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class RecentActivityList extends StatelessWidget {
  final RxList<String> activities;

  const RecentActivityList({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: AppTypography.subtitle(context)
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.01),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.history,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.primary,
                  size: size.width * 0.05,
                ),
                title: Text(
                  activities[index],
                  style: AppTypography.body(context),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
