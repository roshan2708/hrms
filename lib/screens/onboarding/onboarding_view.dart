import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding_controller.dart';
import '../../core/theme/app_colors.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Onboarding & Documents', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Manage new hires and certificates', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildTabSwitcher(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return controller.activeTab.value == 'onboarding' 
                  ? _buildOnboardingTab() 
                  : _buildCertificatesTab();
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabButton('Onboarding', 'onboarding')),
          Expanded(child: _buildTabButton('Certificates', 'certificates')),
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey[600],
              fontSize: 13,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildOnboardingTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.candidates.length,
      itemBuilder: (context, index) {
        final cand = controller.candidates[index];
        return _buildCandidateCard(cand);
      },
    );
  }

  Widget _buildCandidateCard(dynamic cand) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(cand['name'][0], style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cand['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(cand['role'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                _buildStatusBadge(cand['status']),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Joining: ${cand['date']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text('${cand['progress']}% Complete', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (cand['progress'] as int) / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('Verify Docs')),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[50],
                    foregroundColor: Colors.indigo,
                    elevation: 0,
                  ),
                  child: const Text('Send Offer Letter'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String label) {
    Color color = Colors.blue;
    if (label == 'In Progress') color = Colors.orange;
    if (label == 'Document Verification') color = Colors.indigo;
    if (label == 'Completed') color = Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCertificatesTab() {
    return Column(
      children: [
        _buildCertTemplatesGrid(),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Issued History', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${controller.issuedCerts.length} total', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.issuedCerts.length,
            itemBuilder: (context, index) {
              final cert = controller.issuedCerts[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.workspace_premium_rounded, color: Colors.amber),
                ),
                title: Text(cert['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('${cert['type']} • ${cert['date']}', style: const TextStyle(fontSize: 11)),
                trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.download_rounded, size: 20)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCertTemplatesGrid() {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildCertTemplate('Experience', Icons.work_history_rounded, Colors.blue),
          _buildCertTemplate('Internship', Icons.school_rounded, Colors.purple),
          _buildCertTemplate('Appreciation', Icons.star_rounded, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildCertTemplate(String title, IconData icon, Color color) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 4),
          const Text('Issue →', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}
