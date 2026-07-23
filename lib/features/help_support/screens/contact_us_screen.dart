import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Widget _contactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(.12),
          child: Icon(icon, color: color),
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Contact Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.support_agent,
                    size: 40,
                    color: Color(0xFF2563EB),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "We're Here to Help",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Contact our support team anytime. We're available 24×7.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          _contactTile(
            icon: Icons.chat_bubble_outline,
            title: "Live Chat",
            subtitle: "Start chatting with our support team",
            color: Colors.blue,
            onTap: () {},
          ),

          _contactTile(
            icon: Icons.call,
            title: "Call Support",
            subtitle: "+91 1800-123-4567",
            color: Colors.green,
            onTap: () {},
          ),

          _contactTile(
            icon: Icons.email_outlined,
            title: "Email Support",
            subtitle: "support@payflow.com",
            color: Colors.orange,
            onTap: () {},
          ),

          _contactTile(
            icon: Icons.language,
            title: "Website",
            subtitle: "www.payflow.com",
            color: Colors.purple,
            onTap: () {},
          ),

          _contactTile(
            icon: Icons.location_on_outlined,
            title: "Head Office",
            subtitle: "Bengaluru, Karnataka, India",
            color: Colors.red,
            onTap: () {},
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Support Hours",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.blue),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "24 Hours • 7 Days a Week",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
