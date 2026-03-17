import 'package:get/get.dart';
import '../../core/services/operations_service.dart';

class CalendarController extends GetxController {
  final events = <dynamic>[].obs;
  final isLoading = false.obs;
  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;
      final fetched = await OperationsService.getCalendarEvents();
      events.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
  }
}
