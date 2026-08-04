import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String name;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSearchTap;
  final String? profileImage;

  const DashboardHeader({
    super.key,
    required this.name,
    this.onNotificationTap,
    this.onSearchTap,
    this.profileImage,
  });

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: profileImage != null
              ? NetworkImage(profileImage!)
              : null,
          child: profileImage == null
              ? const Icon(Icons.person, size: 32, color: Colors.black87)
              : null,
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreeting(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onSearchTap,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.search, size: 28),
          ),
        ),

        const SizedBox(width: 6),

        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.notifications_none_rounded, size: 28),
              ),
              Positioned(
                right: 7,
                top: 7,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.white, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
