import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/analytics_controller.dart';
import '../../core/theme/app_colors.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionText(context, 'Today\'s Attendance'),
              const SizedBox(height: 16),
              _buildMetricGrid(context),
              const SizedBox(height: 32),
              _buildSectionText(context, 'Department Distribution'),
              const SizedBox(height: 16),
              _buildDepartmentBars(context),
              const SizedBox(height: 32),
              _buildSectionText(context, 'Weekly Trend'),
              const SizedBox(height: 16),
              _buildTrendChart(context),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionText(BuildContext context, String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildMetricGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildMetricCard(context, 'Total Staff', controller.totalEmployees.value.toString(), Icons.groups_rounded, AppColors.primary),
        _buildMetricCard(context, 'Present', controller.presentToday.value.toString(), Icons.how_to_reg_rounded, AppColors.success),
        _buildMetricCard(context, 'On Leave', controller.onLeave.value.toString(), Icons.beach_access_rounded, AppColors.warning),
        _buildMetricCard(context, 'Absent', controller.absent.value.toString(), Icons.person_off_rounded, AppColors.error),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 0 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Simple visual representation using basic layout for Pie Chart alternative
  Widget _buildDepartmentBars(BuildContext context) {
    final total = controller.totalEmployees.value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: controller.departmentDistribution.entries.map((entry) {
            final percentage = entry.value / total;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                      Text('${entry.value} (${(percentage * 100).toStringAsFixed(1)}%)', 
                        style: TextStyle(color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 8,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Simple visual representation using basic layout for Bar Chart
  Widget _buildTrendChart(BuildContext context) {
    final maxVal = controller.attendanceTrend.values.reduce((a, b) => a > b ? a : b);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: controller.attendanceTrend.entries.map((entry) {
              final heightRatio = entry.value / maxVal;
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(entry.value.toString(), style: TextStyle(fontSize: 10, color: secondaryColor)),
                  const SizedBox(height: 4),
                  Container(
                    width: 24,
                    height: 100 * heightRatio, // Max height 100
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
