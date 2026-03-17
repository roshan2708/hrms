import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/audit_controller.dart';
import '../../core/theme/app_colors.dart';

class AuditLogView extends GetView<AuditController> {
  const AuditLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchLogs,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.auditLogs.isEmpty) {
          return const Center(child: Text('No audit logs found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.auditLogs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final log = controller.auditLogs[index];
            return ListTile(
              leading: Icon(
                _getLogIcon(log.action),
                color: _getLogColor(log.action),
              ),
              title: Text(log.action, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${log.user} • ${log.timestamp.toString().split('.')[0]}'),
              trailing: const Icon(Icons.info_outline, size: 20),
              onTap: () {
                Get.defaultDialog(
                  title: 'Log Details',
                  middleText: log.details,
                  confirm: TextButton(onPressed: () => Get.back(), child: const Text('Close')),
                );
              },
            );
          },
        );
      }),
    );
  }

  IconData _getLogIcon(String action) {
    if (action.contains('Login')) return Icons.login;
    if (action.contains('Delete')) return Icons.delete_forever;
    if (action.contains('Update')) return Icons.edit;
    if (action.contains('Create')) return Icons.add_circle;
    return Icons.history;
  }

  Color _getLogColor(String action) {
    if (action.contains('Delete')) return Colors.red;
    if (action.contains('Create')) return Colors.green;
    if (action.contains('Update')) return Colors.orange;
    return AppColors.primary;
  }
}
