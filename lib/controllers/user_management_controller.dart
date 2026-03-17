import 'package:get/get.dart';
import '../../core/services/core_service.dart';

class UserManagementController extends GetxController {
  final activeTab = 'users'.obs;
  final users = <dynamic>[].obs;
  final filteredUsers = <dynamic>[].obs;
  final roles = <dynamic>[].obs;
  
  final isLoading = false.obs;
  final searchTerm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
    
    debounce(searchTerm, (_) => filterUsers(), time: 500.milliseconds);
  }

  Future<void> fetchInitialData() async {
    try {
      isLoading.value = true;
      // Fetching users (mapped from employees for now)
      final fetchedUsers = await CoreService.getUsers();
      users.assignAll(fetchedUsers);
      filteredUsers.assignAll(fetchedUsers);

      final fetchedRoles = await CoreService.getRoles();
      roles.assignAll(fetchedRoles);
    } finally {
      isLoading.value = false;
    }
  }

  void filterUsers() {
    if (searchTerm.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      filteredUsers.assignAll(users.where((u) {
        final name = u['name']?.toString().toLowerCase() ?? '';
        final email = u['email']?.toString().toLowerCase() ?? '';
        return name.contains(searchTerm.value.toLowerCase()) || 
               email.contains(searchTerm.value.toLowerCase());
      }).toList());
    }
  }

  void toggleTab(String tab) {
    activeTab.value = tab;
  }

  void toggleUserStatus(int id) {
    // Local state update for simulation
    final index = users.indexWhere((u) => u['id'] == id);
    if (index != -1) {
      final user = users[index];
      user['status'] = user['status'] == 'Active' ? 'Inactive' : 'Active';
      users[index] = user;
      users.refresh();
      filterUsers();
    }
  }
}
