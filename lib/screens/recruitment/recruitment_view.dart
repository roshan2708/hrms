import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recruitment_controller.dart';
import '../../core/theme/app_colors.dart';

class RecruitmentView extends GetView<RecruitmentController> {
  const RecruitmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recruitment Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Manage jobs and track candidates', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          _buildStats(),
          _buildTabSwitcher(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return controller.activeTab.value == 'jobs' 
                  ? _buildJobsTab() 
                  : _buildCandidatesTab();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildStatCard('Open Positions', '4', Icons.work_outline_rounded, Colors.blue),
          _buildStatCard('Total Applicants', '87', Icons.people_outline_rounded, Colors.green),
          _buildStatCard('In Interview', '12', Icons.chat_bubble_outline_rounded, Colors.orange),
          _buildStatCard('Offers Made', '3', Icons.verified_outlined, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(label, style: TextStyle(fontSize: 9, color: Colors.grey[600], fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabButton('Job Openings', 'jobs')),
          Expanded(child: _buildTabButton('Candidates', 'candidates')),
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

  Widget _buildJobsTab() {
    return Obx(() => ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredJobs.length,
      itemBuilder: (context, index) {
        final job = controller.filteredJobs[index];
        return _buildJobCard(job);
      },
    ));
  }

  Widget _buildJobCard(dynamic job) {
    final bool isOpen = job['status'] == 'Open';
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
                Expanded(
                  child: Text(job['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isOpen ? Colors.green.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job['status'],
                    style: TextStyle(fontSize: 10, color: isOpen ? Colors.green : Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTag(job['department']),
                const SizedBox(width: 8),
                _buildTag(job['type']),
                const SizedBox(width: 8),
                Text('📍 ${job['location']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Icon(Icons.people_outline_rounded, size: 16, color: AppColors.primary),
                const SizedBox(width: 4),
                Text('${job['applicants']} Applicants', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                const Spacer(),
                Text('Posted: ${job['postedDate']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('Edit')),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    foregroundColor: Colors.black,
                    elevation: 0,
                  ),
                  child: const Text('View Applicants'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
    );
  }

  Widget _buildCandidatesTab() {
    return Obx(() => ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredCandidates.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final candidate = controller.filteredCandidates[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: const Icon(Icons.person_rounded, color: Colors.indigo),
          ),
          title: Text(candidate['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(candidate['role'], style: const TextStyle(fontSize: 12)),
              Text(candidate['email'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          trailing: _buildCandidateStage(candidate['stage']),
          onTap: () {},
        );
      },
    ));
  }

  Widget _buildCandidateStage(String stage) {
    Color color = Colors.grey;
    if (stage == 'Interview') color = Colors.orange;
    if (stage == 'Offer') color = Colors.green;
    if (stage == 'Screening') color = Colors.blue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        stage,
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
