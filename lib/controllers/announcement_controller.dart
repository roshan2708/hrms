import 'package:get/get.dart';
import '../models/announcement_model.dart';

class AnnouncementController extends GetxController {
  final isLoading = false.obs;
  final announcements = <Announcement>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAnnouncements();
  }

  void loadAnnouncements() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    announcements.assignAll(Announcement.dummyAnnouncements);
    isLoading.value = false;
  }
}
