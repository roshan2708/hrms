import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_controller.dart';
import 'package:intl/intl.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.attendanceList.isEmpty) {
          return const Center(child: Text('No attendance records found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.attendanceList.length,
          itemBuilder: (context, index) {
            final record = controller.attendanceList[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: record.status == 'Present' 
                    ? Colors.green.withOpacity(0.1) 
                    : Colors.red.withOpacity(0.1),
                  child: Icon(
                    record.status == 'Present' ? Icons.check_circle : Icons.cancel,
                    color: record.status == 'Present' ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(
                  DateFormat('EEEE, MMM d, yyyy').format(record.date),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${record.status}'),
                    if (record.checkInTime != null)
                      Text('In: ${DateFormat('hh:mm a').format(record.checkInTime!)}'),
                    if (record.checkOutTime != null)
                      Text('Out: ${DateFormat('hh:mm a').format(record.checkOutTime!)}'),
                  ],
                ),
                isThreeLine: record.checkInTime != null,
              ),
            );
          },
        );
      }),
    );
  }
}
