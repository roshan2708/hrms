import 'package:get/get.dart';
import '../../core/services/support_service.dart';

class HelpdeskController extends GetxController {
  final tickets = <dynamic>[].obs;
  final isLoading = false.obs;
  final activeTab = 'dashboard'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    try {
      isLoading.value = true;
      final fetched = await SupportService.getTickets();
      tickets.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }

  void createTicket() {
    Get.snackbar('Support', 'Ticket submission feature coming soon');
  }
}
