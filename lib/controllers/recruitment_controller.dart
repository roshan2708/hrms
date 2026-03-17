import 'package:get/get.dart';
import '../../core/services/hr_service.dart';

class RecruitmentController extends GetxController {
  final activeTab = 'jobs'.obs;
  final jobs = <dynamic>[].obs;
  final candidates = <dynamic>[].obs;
  final filteredJobs = <dynamic>[].obs;
  final filteredCandidates = <dynamic>[].obs;
  
  final isLoading = false.obs;
  final searchTerm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    
    debounce(searchTerm, (_) => filterData(), time: 500.milliseconds);
    ever(activeTab, (_) => filterData());
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final fetchedJobs = await HRService.getJobs();
      final fetchedCandidates = await HRService.getCandidates();
      
      jobs.assignAll(fetchedJobs);
      candidates.assignAll(fetchedCandidates);
      filterData();
    } finally {
      isLoading.value = false;
    }
  }

  void filterData() {
    if (activeTab.value == 'jobs') {
      filteredJobs.assignAll(jobs.where((j) {
        final title = j['title']?.toString().toLowerCase() ?? '';
        final dept = j['department']?.toString().toLowerCase() ?? '';
        return title.contains(searchTerm.value.toLowerCase()) || 
               dept.contains(searchTerm.value.toLowerCase());
      }).toList());
    } else {
      filteredCandidates.assignAll(candidates.where((c) {
        final name = c['name']?.toString().toLowerCase() ?? '';
        final email = c['email']?.toString().toLowerCase() ?? '';
        final role = c['role']?.toString().toLowerCase() ?? '';
        return name.contains(searchTerm.value.toLowerCase()) || 
               email.contains(searchTerm.value.toLowerCase()) ||
               role.contains(searchTerm.value.toLowerCase());
      }).toList());
    }
  }

  void toggleTab(String tab) {
    activeTab.value = tab;
  }
  
  void deleteJob(int id) {
    jobs.removeWhere((j) => j['id'] == id);
    filterData();
    Get.snackbar('Success', 'Job opening deleted');
  }
}
