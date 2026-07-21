import 'package:flutter/material.dart';

class SecurityCenterScreen extends StatefulWidget {
  const SecurityCenterScreen({super.key});

  @override
  State<SecurityCenterScreen> createState() => _SecurityCenterScreenState();
}

class _SecurityCenterScreenState extends State<SecurityCenterScreen> {
  bool fingerprint = true;
  bool faceId = false;
  bool twoFactor = true;
  bool appLock = true;

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
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

  Widget _deviceCard(
    String device,
    String location,
    String status,
    bool current,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: const Icon(Icons.devices, color: Colors.green),
        ),
        title: Text(
          device,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(location),
        trailing: current
            ? const Chip(label: Text("Current"))
            : TextButton(onPressed: () {}, child: const Text("Remove")),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text(
          "Security Center",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                Icon(Icons.security, color: Colors.white, size: 60),
                SizedBox(height: 14),
                Text("Security Score", style: TextStyle(color: Colors.white70)),
                SizedBox(height: 8),
                Text(
                  "92%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Authentication",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(height: 15),

          _settingTile(
            icon: Icons.fingerprint,
            title: "Fingerprint",
            subtitle: "Unlock using fingerprint",
            trailing: Switch(
              value: fingerprint,
              onChanged: (value) {
                setState(() {
                  fingerprint = value;
                });
              },
            ),
          ),

          _settingTile(
            icon: Icons.face,
            title: "Face ID",
            subtitle: "Unlock using Face ID",
            trailing: Switch(
              value: faceId,
              onChanged: (value) {
                setState(() {
                  faceId = value;
                });
              },
            ),
          ),

          _settingTile(
            icon: Icons.lock_outline,
            title: "App Lock",
            subtitle: "Require authentication every launch",
            trailing: Switch(
              value: appLock,
              onChanged: (value) {
                setState(() {
                  appLock = value;
                });
              },
            ),
          ),

          _settingTile(
            icon: Icons.verified_user,
            title: "Two-Factor Authentication",
            subtitle: "Extra account protection",
            trailing: Switch(
              value: twoFactor,
              onChanged: (value) {
                setState(() {
                  twoFactor = value;
                });
              },
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Trusted Devices",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(height: 15),

          _deviceCard("Samsung Galaxy S24", "Delhi, India", "Online", true),

          _deviceCard("MacBook Pro", "Delhi, India", "Offline", false),

          _deviceCard("Windows Laptop", "Mumbai, India", "Offline", false),

          const SizedBox(height: 30),

          const Text(
            "Security Actions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(height: 15),

          _settingTile(
            icon: Icons.pin,
            title: "Change PIN",
            subtitle: "Update your PayFlow PIN",
          ),

          _settingTile(
            icon: Icons.history,
            title: "Login History",
            subtitle: "View recent login activity",
          ),

          _settingTile(
            icon: Icons.password,
            title: "Change Password",
            subtitle: "Update your account password",
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text(
                "Logout From All Devices",
                style: TextStyle(fontSize: 18),
              ),
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
