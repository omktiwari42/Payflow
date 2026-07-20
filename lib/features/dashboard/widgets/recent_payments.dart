import 'package:flutter/material.dart';

class RecentPayments extends StatelessWidget {
  const RecentPayments({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {
        "name": "Aman",
        "color": const Color(0xff2563EB),
        "icon": Icons.person,
        "online": true,
      },
      {
        "name": "Priya",
        "color": const Color(0xffEC4899),
        "icon": Icons.person,
        "online": true,
      },
      {
        "name": "Rahul",
        "color": const Color(0xff10B981),
        "icon": Icons.person,
        "online": false,
      },
      {
        "name": "Neha",
        "color": const Color(0xffF59E0B),
        "icon": Icons.person,
        "online": true,
      },
      {
        "name": "Arjun",
        "color": const Color(0xff8B5CF6),
        "icon": Icons.person,
        "online": false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Recent Payments",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text("See All"),
            ),
          ],
        ),

        const SizedBox(height: 18),

        SizedBox(
          height: 118,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: contacts.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (index == contacts.length) {
                return InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xff2563EB),
                          size: 34,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Add",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final person = contacts[index];
                            return InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: SizedBox(
                  width: 76,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 72,
                            width: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (person["color"] as Color)
                                  .withValues(alpha: 0.12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Icon(
                              person["icon"] as IconData,
                              color: person["color"] as Color,
                              size: 34,
                            ),
                          ),

                          if (person["online"] as bool)
                            Positioned(
                              right: 4,
                              bottom: 4,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        person["name"] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}