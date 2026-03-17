import 'package:get/get.dart';
import '../../core/services/hr_service.dart';

class WFHController extends GetxController {
  final requests = <dynamic>[].obs;
  final filteredRequests = <dynamic>[].obs;
  final isLoading = false.obs;
  final statusFilter = 'All'.obs;
  final searchTerm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
    
    debounce(searchTerm, (_) => filterRequests(), time: 500.milliseconds);
    ever(statusFilter, (_) => filterRequests());
  }

  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;
      final fetched = await HRService.getWFHRequests();
      requests.assignAll(fetched);
      filteredRequests.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }

  void filterRequests() {
    var result = requests.where((r) {
      final matchSearch = r['employee'].toString().toLowerCase().contains(searchTerm.value.toLowerCase()) ||
                          r['dept'].toString().toLowerCase().contains(searchTerm.value.toLowerCase());
      final matchStatus = statusFilter.value == 'All' || r['status'] == statusFilter.value;
      return matchSearch && matchStatus;
    }).toList();
    
    filteredRequests.assignAll(result);
  }

  Future<void> approveRequest(int id) async {
    final success = await HRService.updateWFHStatus(id, 'Approved');
    if (success) {
      final index = requests.indexWhere((r) => r['id'] == id);
      if (index != -1) {
        requests[index]['status'] = 'Approved';
        requests.refresh();
        filterRequests();
        Get.snackbar('Success', 'Request approved');
      }
    }
  }

  Future<void> rejectRequest(int id) async {
    final success = await HRService.updateWFHStatus(id, 'Rejected');
    if (success) {
      final index = requests.indexWhere((r) => r['id'] == id);
      if (index != -1) {
        requests[index]['status'] = 'Rejected';
        requests.refresh();
        filterRequests();
        Get.snackbar('Info', 'Request rejected');
      }
    }
  }
}
