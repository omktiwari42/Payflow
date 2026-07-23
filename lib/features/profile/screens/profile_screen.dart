import 'package:flutter/material.dart';
import '../../help_support/screens/help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _tile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text(
          "Profile",
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue, size: 50),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Om Kumar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "om@payflow.com",
                  style: TextStyle(color: Colors.white.withValues(alpha: .9)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          _tile(Icons.verified_user, "KYC Verification", "Verified", () {}),

          _tile(
            Icons.account_balance,
            "Linked Bank Accounts",
            "2 Accounts Linked",
            () {},
          ),

          _tile(
            Icons.credit_card,
            "Cards",
            "Manage Debit & Credit Cards",
            () {},
          ),

          _tile(
            Icons.security,
            "Security",
            "PIN • Fingerprint • Face ID",
            () {},
          ),

          _tile(
            Icons.notifications,
            "Notifications",
            "Manage notification settings",
            () {},
          ),

          _tile(
            Icons.settings,
            "Settings",
            "Theme • Language • Privacy",
            () {},
          ),

          _tile(
            Icons.support_agent,
            "Help & Support",
            "FAQs • Live Chat • Support Tickets",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              );
            },
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement Logout
              },
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
        ],
      ),
    );
  }
}
