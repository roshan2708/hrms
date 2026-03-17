import 'dart:convert';
import 'package:get/get.dart';
import '../../models/salary_model.dart';
import '../../models/payslip_model.dart';
import '../../models/expense_model.dart';
import '../../services/finance_service.dart';

class FinanceController extends GetxController {
  final salaryAssignments = <SalaryAssignment>[].obs;
  final paySlips = <PaySlip>[].obs;
  final expenses = <Expense>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSalaryAssignments();
    fetchPaySlips();
    fetchExpenses();
  }

  Future<void> fetchSalaryAssignments() async {
    try {
      isLoading.value = true;
      final response = await FinanceService.getSalaryAssignments();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        salaryAssignments.assignAll(data.map((j) => SalaryAssignment.fromJson(j)).toList());
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPaySlips() async {
    try {
      final response = await FinanceService.getPaySlips();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        paySlips.assignAll(data.map((j) => PaySlip.fromJson(j)).toList());
      }
    } catch (e) {
    }
  }

  Future<void> fetchExpenses() async {
    try {
      final response = await FinanceService.getExpenses();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        expenses.assignAll(data.map((j) => Expense.fromJson(j)).toList());
      }
    } catch (e) {
    }
  }
}
