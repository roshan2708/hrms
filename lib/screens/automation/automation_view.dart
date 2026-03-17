import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/automation_controller.dart';
import '../../core/theme/app_colors.dart';

class AutomationCenterView extends GetView<AutomationController> {
  const AutomationCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Automation Hub', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Manage system-wide triggers and rules', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline_rounded),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          _buildAutomationStats(),
          _buildTabSwitcher(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return controller.activeTab.value == 'rules' 
                  ? _buildRulesList() 
                  : _buildAuditLogs();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationStats() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildStatCard('Rules', controller.rules.length.toString(), Icons.rule_rounded, Colors.indigo),
          _buildStatCard('Active', controller.rules.where((r) => r['status'] == 'Active').length.toString(), Icons.bolt_rounded, Colors.green),
          _buildStatCard('Events', '12', Icons.history_rounded, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 2)),
      ),
      child: Row(
        children: [
          _buildTabItem('Active Rules', 'rules'),
          const SizedBox(width: 24),
          _buildTabItem('Audit & Logs', 'logs'),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, String tab) {
    return Obx(() {
      final isSelected = controller.activeTab.value == tab;
      return GestureDetector(
        onTap: () => controller.activeTab.value = tab,
        child: Container(
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: isSelected ? Border(bottom: BorderSide(color: AppColors.primary, width: 3)) : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildRulesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.rules.length,
      itemBuilder: (context, index) {
        final rule = controller.rules[index];
        return _buildRuleCard(rule);
      },
    );
  }

  Widget _buildRuleCard(dynamic rule) {
    final isActive = rule['status'] == 'Active';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text('Leave', style: const TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                Switch.adaptive(
                  value: isActive,
                  onChanged: (val) => controller.toggleRule(rule['id']),
                  activeColor: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(rule['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text('Trigger: ${rule['trigger']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.account_tree_outlined, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${rule['steps']} Workflow Steps', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const Spacer(),
                Text(isActive ? 'Running' : 'Paused', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isActive ? Colors.green : Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAuditLogs() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.logs.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final log = controller.logs[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(log['action'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          subtitle: Text('${log['module']} • ${log['timestamp']}', style: const TextStyle(fontSize: 11)),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: const Text('SUCCESS', style: TextStyle(fontSize: 9, color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
