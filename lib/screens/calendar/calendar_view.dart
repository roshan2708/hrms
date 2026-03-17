import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/calendar_controller.dart';
import '../../core/theme/app_colors.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline_rounded),
            style: IconButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          _buildSidebar(),
          const VerticalDivider(width: 1),
          Expanded(child: _buildMainCalendar()),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMiniCalendar(),
          const SizedBox(height: 24),
          const Text('Top Highlights', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Expanded(child: _buildEventHighlights()),
        ],
      ),
    );
  }

  Widget _buildMiniCalendar() {
    return Obx(() {
      final date = controller.selectedDate.value;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('MMMM yyyy').format(date), style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left, size: 18), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right, size: 18), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 4, crossAxisSpacing: 4),
            itemCount: 35, // Mocking simple grid
            itemBuilder: (context, index) {
              final day = index - 3; // Mocking start of month
              if (day < 1 || day > 31) return const SizedBox();
              final isSelected = day == date.day;
              return GestureDetector(
                onTap: () => controller.onDateSelected(DateTime(date.year, date.month, day)),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      day.toString(),
                      style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildEventHighlights() {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.events.length,
        itemBuilder: (context, index) {
          final event = controller.events[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Container(width: 4, height: 32, decoration: BoxDecoration(color: _getTypeColor(event['type']), borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(event['time'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildMainCalendar() {
    return Column(
      children: [
        _buildCalendarHeader(),
        _buildCalendarDaysHeader(),
        Expanded(child: _buildCalendarGrid()),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Obx(() => Text(DateFormat('MMMM yyyy').format(controller.selectedDate.value), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                _buildTab('Month', true),
                _buildTab('Week', false),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(color: active ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(20), boxShadow: active ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)] : null),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: active ? FontWeight.bold : FontWeight.normal, color: active ? Colors.black : Colors.grey)),
    );
  }

  Widget _buildCalendarDaysHeader() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: Row(
        children: days.map((day) => Expanded(child: Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(day, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)))))).toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1.0),
      itemCount: 35,
      itemBuilder: (context, index) {
        final day = index - 3;
        if (day < 1 || day > 31) return Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey[100]!), color: Colors.grey[50]));
        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey[100]!)),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(day.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const Spacer(),
              if (day == DateTime.now().day)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(color: Colors.indigo.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                  child: const Text('Meeting', style: TextStyle(fontSize: 9, color: Colors.indigo, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                ),
            ],
          ),
        );
      },
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'work': return Colors.indigo;
      case 'important': return Colors.red;
      case 'personal': return Colors.green;
      default: return Colors.blue;
    }
  }
}
