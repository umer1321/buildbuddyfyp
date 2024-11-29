import 'package:flutter/material.dart';

class SettingsDashboard extends StatelessWidget {
  const SettingsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFFF44336),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SettingsOption(
            icon: Icons.account_circle,
            title: 'Account Settings',
            onTap: () {
              // Navigate to account settings
            },
          ),
          SettingsOption(
            icon: Icons.notifications,
            title: 'Notification Preferences',
            onTap: () {
              // Navigate to notification settings
            },
          ),
          SettingsOption(
            icon: Icons.security,
            title: 'Privacy and Security',
            onTap: () {
              // Navigate to privacy settings
            },
          ),
        ],
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsOption({required this.icon, required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        onTap: onTap,
      ),
    );
  }
}
