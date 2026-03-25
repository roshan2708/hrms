import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/leave_controller.dart';
import '../../models/leave_model.dart';
import '../../core/utils/validators.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/custom_dropdown_field.dart';
import '../../widgets/section_header.dart';

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
              const SectionHeader(title: 'Leave Details'),
              const SizedBox(height: 20),
              CustomDropdownField<String>(
                label: 'Leave Type',
                value: _leaveType,
                items: const ['Sick Leave', 'Casual Leave', 'Vacation', 'Other'],
                itemLabelBuilder: (e) => e,
                onChanged: (val) => setState(() => _leaveType = val!),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomDatePicker(
                      label: 'Start Date',
                      date: _startDate,
                      onDateSelected: (picked) {
                        setState(() {
                          _startDate = picked;
                          if (_endDate.isBefore(_startDate)) {
                            _endDate = _startDate.add(const Duration(days: 1));
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDatePicker(
                      label: 'End Date',
                      date: _endDate,
                      onDateSelected: (picked) => setState(() => _endDate = picked),
                      firstDate: _startDate,
                    ),
                  ),
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

  Widget _buildReasonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Reason for Leave'),
        const SizedBox(height: 8),
        TextFormField(
          controller: _reasonController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Describe your reason...',
          ),
          validator: (val) => Validators.validateRequired(val, 'Reason'),
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
