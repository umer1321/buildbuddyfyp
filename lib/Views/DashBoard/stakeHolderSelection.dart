
import 'package:flutter/material.dart';

class StakeholderSelection extends StatelessWidget {
  const StakeholderSelection({super.key});

  final List<Map<String, dynamic>> stakeholders = const [
    {
      'id': 'homeowner',
      'title': 'Homeowner',
      'icon': Icons.home,
      'description': 'Manage and oversee your home construction project',
    },
    {
      'id': 'contractor',
      'title': 'Contractor',
      'icon': Icons.construction,
      'description': 'Execute and manage construction work',
    },
    {
      'id': 'architect',
      'title': 'Architect',
      'icon': Icons.architecture,
      'description': 'Provide plans and design consultation',
    },
    {
      'id': 'vendor',
      'title': 'Vendor',
      'icon': Icons.local_shipping,
      'description': 'Supply construction materials and resources',
    },
    {
      'id': 'admin',
      'title': 'Admin',
      'icon': Icons.admin_panel_settings,
      'description': 'Manage platform and maintain system operations',
    },
  ];

  void _handleStakeholderTap(BuildContext context, String stakeholderId) {
    Navigator.pushNamed(context, '/get-started');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Welcome to Build Buddy',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your role to continue',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: stakeholders.length,
                  itemBuilder: (context, index) {
                    final stakeholder = stakeholders[index];
                    return _StakeholderCard(
                      icon: stakeholder['icon'] as IconData,
                      title: stakeholder['title'] as String,
                      description: stakeholder['description'] as String,
                      onTap: () => _handleStakeholderTap(
                        context,
                        stakeholder['id'] as String,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StakeholderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _StakeholderCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
