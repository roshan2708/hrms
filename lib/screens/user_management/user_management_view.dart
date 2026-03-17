import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_management_controller.dart';
import '../../core/theme/app_colors.dart';

class UserManagementView extends GetView<UserManagementController> {
  const UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Access Control & Users', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Manage users, roles, and granular permissions', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
          Obx(() => Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(controller.activeTab.value == 'users' ? 'Add User' : 'Create Role'),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          )),
        ],
      ),
      body: Column(
        children: [
          _buildTabSwitcher(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return controller.activeTab.value == 'users' 
                  ? _buildUsersTab() 
                  : _buildRolesTab();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabButton('Users', 'users')),
          Expanded(child: _buildTabButton('Roles & Permissions', 'roles')),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, String tab) {
    return Obx(() {
      final isSelected = controller.activeTab.value == tab;
      return GestureDetector(
        onTap: () => controller.toggleTab(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: isSelected ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ] : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildUsersTab() {
    return Obx(() => ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredUsers.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final user = controller.filteredUsers[index];
        return ListTile(
          title: Text(user['name'] ?? 'No Name', style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(user['email'] ?? 'No Email'),
          trailing: _buildStatusAndActions(user),
        );
      },
    ));
  }

  Widget _buildStatusAndActions(dynamic user) {
    final status = user['status'] ?? 'Active';
    final isActive = status == 'Active';
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'status', child: Text(isActive ? 'Deactivate' : 'Activate')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
          onSelected: (val) {
            if (val == 'status') controller.toggleUserStatus(user['id']);
          },
        ),
      ],
    );
  }

  Widget _buildRolesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: controller.roles.length,
      itemBuilder: (context, index) {
        final role = controller.roles[index];
        return _buildRoleCard(role);
      },
    );
  }

  Widget _buildRoleCard(dynamic role) {
    IconData icon;
    Color color;
    
    switch (role['name']) {
      case 'Super Admin':
        icon = Icons.workspace_premium_rounded;
        color = Colors.amber;
        break;
      case 'HR':
        icon = Icons.people_rounded;
        color = Colors.green;
        break;
      case 'Manager':
        icon = Icons.badge_rounded;
        color = Colors.blue;
        break;
      case 'Accountant':
        icon = Icons.calculate_rounded;
        color = Colors.red;
        break;
      default:
        icon = Icons.person_rounded;
        color = Colors.grey;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              role['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              role['description'],
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Edit Permissions', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
