import 'package:flutter/material.dart';

class RecentContactCard extends StatelessWidget {
  final String name;
  final String phone;
  final String? image;
  final VoidCallback onTap;

  const RecentContactCard({
    super.key,
    required this.name,
    required this.phone,
    required this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff00B4FF), Color(0xff2563EB)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff2563EB).withValues(alpha: 0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(3),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: image != null && image!.isNotEmpty
                      ? NetworkImage(image!)
                      : null,
                  child: image == null || image!.isEmpty
                      ? Text(
                          _initials(name),
                          style: const TextStyle(
                            color: Color(0xff2563EB),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
              ),

              const SizedBox(height: 9),

              Text(
                _firstName(name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                _shortPhone(phone),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _initials(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return "?";
    }

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return "${parts[0][0]}${parts[1][0]}".toUpperCase();
  }

  String _firstName(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return "User";
    }

    return trimmed.split(RegExp(r'\s+')).first;
  }

  String _shortPhone(String value) {
    final phone = value.trim();

    if (phone.length <= 4) {
      return phone;
    }

    return "••••${phone.substring(phone.length - 4)}";
  }
}
