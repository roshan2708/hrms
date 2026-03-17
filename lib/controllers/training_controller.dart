import 'package:get/get.dart';
import '../../core/services/hr_service.dart';

class TrainingController extends GetxController {
  final trainings = <dynamic>[].obs;
  final filteredTrainings = <dynamic>[].obs;
  final isLoading = false.obs;
  final searchTerm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTrainings();
    
    debounce(searchTerm, (_) => filterTrainings(), time: 500.milliseconds);
  }

  Future<void> fetchTrainings() async {
    try {
      isLoading.value = true;
      final fetched = await HRService.getTrainings();
      trainings.assignAll(fetched);
      filteredTrainings.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }

  void filterTrainings() {
    filteredTrainings.assignAll(trainings.where((t) {
      final title = t['title']?.toString().toLowerCase() ?? '';
      final trainer = t['trainer']?.toString().toLowerCase() ?? '';
      return title.contains(searchTerm.value.toLowerCase()) || 
             trainer.contains(searchTerm.value.toLowerCase());
    }).toList());
  }
}
