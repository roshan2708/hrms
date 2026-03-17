import 'package:get/get.dart';
import '../../core/services/administration_service.dart';

class DeskController extends GetxController {
  final desks = <dynamic>[].obs;
  final bookings = <dynamic>[].obs;
  final isLoading = false.obs;
  final activeTab = 'occupancy'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final fetchedDesks = await AdministrationService.getDesks();
      final fetchedBookings = await AdministrationService.getDeskBookings();
      desks.assignAll(fetchedDesks);
      bookings.assignAll(fetchedBookings);
    } finally {
      isLoading.value = false;
    }
  }

  void bookDesk(String deskId) {
    Get.snackbar('Success', 'Desk $deskId booked successfully');
  }
}
