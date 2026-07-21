import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool biometric = true;
  bool darkMode = false;
  bool transactionAlerts = true;

  Widget settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "General",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 12),

          settingTile(
            icon: Icons.person,
            title: "Account",
            subtitle: "Profile, Email & Phone",
          ),

          settingTile(
            icon: Icons.language,
            title: "Language",
            subtitle: "English (India)",
          ),

          settingTile(
            icon: Icons.palette,
            title: "Theme",
            subtitle: darkMode ? "Dark Mode" : "Light Mode",
            trailing: Switch(
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Notifications",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 12),

          settingTile(
            icon: Icons.notifications,
            title: "Push Notifications",
            subtitle: "Receive app notifications",
            trailing: Switch(
              value: notifications,
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),
          ),

          settingTile(
            icon: Icons.receipt_long,
            title: "Transaction Alerts",
            subtitle: "Receive payment updates",
            trailing: Switch(
              value: transactionAlerts,
              onChanged: (value) {
                setState(() {
                  transactionAlerts = value;
                });
              },
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Security",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 12),

          settingTile(
            icon: Icons.fingerprint,
            title: "Biometric Login",
            subtitle: "Fingerprint / Face ID",
            trailing: Switch(
              value: biometric,
              onChanged: (value) {
                setState(() {
                  biometric = value;
                });
              },
            ),
          ),

          settingTile(
            icon: Icons.lock,
            title: "Change PIN",
            subtitle: "Update your security PIN",
          ),

          settingTile(
            icon: Icons.privacy_tip,
            title: "Privacy",
            subtitle: "Manage permissions",
          ),

          const SizedBox(height: 25),

          const Text(
            "Support",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 12),

          settingTile(
            icon: Icons.help,
            title: "Help Center",
            subtitle: "FAQs & Contact Support",
          ),

          settingTile(
            icon: Icons.info,
            title: "About PayFlow",
            subtitle: "Version 1.0.0",
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text("Logout", style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
