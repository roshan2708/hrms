import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/notification_model.dart';
import 'dashboard_controller.dart';
import '../data/dummy_data.dart';

class NotificationController extends GetxController {
  final isLoading = false.obs;
  final notifications = <AppNotification>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    notifications.assignAll(DummyData.notifications);
    isLoading.value = false;
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final old = notifications[index];
      notifications[index] = AppNotification(
        id: old.id,
        title: old.title,
        message: old.message,
        timestamp: old.timestamp,
        isRead: true,
        type: old.type,
      );
      
      // Update unread count in dashboard if available
      try {
        final dashboardCtrl = Get.find<DashboardController>();
        final unreadCount = notifications.where((n) => !n.isRead).length;
        dashboardCtrl.unreadNotifications.value = unreadCount;
      } catch (e) {
        debugPrint('Dashboard controller not initialized: $e');
      }
    }
  }

  void markAllAsRead() {
    final updatedList = notifications.map((n) {
      return AppNotification(
        id: n.id,
        title: n.title,
        message: n.message,
        timestamp: n.timestamp,
        isRead: true,
        type: n.type,
      );
    }).toList();
    
    notifications.assignAll(updatedList);
    
    try {
      final dashboardCtrl = Get.find<DashboardController>();
      dashboardCtrl.unreadNotifications.value = 0;
    } catch (e) {
      debugPrint('Error updating unread count: $e');
    }
  }
}

