import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/leave_controller.dart';
import '../../models/leave_model.dart';
import '../../core/theme/app_colors.dart';
import 'package:intl/intl.dart';

class LeaveApplicationView extends StatefulWidget {
  const LeaveApplicationView({super.key});

  @override
  State<LeaveApplicationView> createState() => _LeaveApplicationViewState();
}

class _LeaveApplicationViewState extends State<LeaveApplicationView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<LeaveController>();
  
  String _leaveType = 'Sick Leave';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  final _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Leave'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionHeader('Leave Details'),
              const SizedBox(height: 20),
              _buildDropdownField(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildDatePicker('Start Date', _startDate, true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDatePicker('End Date', _endDate, false)),
                ],
              ),
              const SizedBox(height: 24),
              _buildReasonField(),
              const SizedBox(height: 48),
              Obx(() => ElevatedButton(
                onPressed: _controller.isLoading.value ? null : _submitForm,
                child: _controller.isLoading.value
                    ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('SUBMIT APPLICATION'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.primary,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave Type',
          style: TextStyle(
            fontSize: 13, 
            fontWeight: FontWeight.w600, 
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _leaveType,
          onChanged: (val) => setState(() => _leaveType = val!),
          items: ['Sick Leave', 'Casual Leave', 'Vacation', 'Other']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, DateTime date, bool isStart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13, 
            fontWeight: FontWeight.w600, 
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now().subtract(const Duration(days: 0)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              setState(() {
                if (isStart) {
                  _startDate = picked;
                  if (_endDate.isBefore(_startDate)) {
                    _endDate = _startDate.add(const Duration(days: 1));
                  }
                } else {
                  _endDate = picked;
                }
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).dividerTheme.color ?? Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded, 
                  size: 18, 
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.accent,
                ),
                const SizedBox(width: 12),
                Text(
                  DateFormat('dd MMM').format(date),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReasonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reason for Leave',
          style: TextStyle(
            fontSize: 13, 
            fontWeight: FontWeight.w600, 
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _reasonController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Describe your reason...',
          ),
          validator: (val) => val == null || val.isEmpty ? 'Reason is required' : null,
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final request = LeaveRequest(
        id: '',
        employeeId: 'EMP001',
        leaveType: _leaveType,
        startDate: _startDate,
        endDate: _endDate,
        status: 'Pending',
        reason: _reasonController.text,
      );
      _controller.applyLeave(request).then((_) => Get.back());
    }
  }
}
