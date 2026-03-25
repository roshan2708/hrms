import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/finance_controller.dart';


class FinanceDashboardView extends GetView<FinanceController> {
  const FinanceDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finance & Payroll'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Salary'),
              Tab(text: 'Pay Slips'),
              Tab(text: 'Expenses'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSalaryTab(),
            _buildPaySlipsTab(),
            _buildExpensesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryTab() {
    return Obx(() {
      if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.salaryAssignments.length,
        itemBuilder: (context, index) {
          final salary = controller.salaryAssignments[index];
          return Card(
            child: ListTile(
              title: Text(salary.employeeName),
              subtitle: Text('Base: \$${salary.baseSalary}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      );
    });
  }

  Widget _buildPaySlipsTab() {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.paySlips.length,
        itemBuilder: (context, index) {
          final slip = controller.paySlips[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text('${slip.month} ${slip.year}'),
              subtitle: Text('Net: \$${slip.netSalary}'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  Get.snackbar('Download', 'Downloading payslip...');
                },
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildExpensesTab() {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.expenses.length,
        itemBuilder: (context, index) {
          final expense = controller.expenses[index];
          return Card(
            child: ListTile(
              title: Text(expense.category),
              subtitle: Text('\$${expense.amount} • ${expense.status}'),
              trailing: Text(expense.date.toString().split(' ')[0]),
            ),
          );
        },
      );
    });
  }
}
