import 'package:flutter/material.dart';

class PeopleBusinessCard extends StatelessWidget {
  const PeopleBusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {"name": "Aman", "color": Colors.blue},
      {"name": "Priya", "color": Colors.pink},
      {"name": "Rahul", "color": Colors.orange},
      {"name": "Neha", "color": Colors.green},
      {"name": "Shubham", "color": Colors.purple},
      {"name": "Riya", "color": Colors.red},
      {"name": "More", "color": Colors.grey},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pay Friends & Businesses",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          SizedBox(
            height: 95,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: contacts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, index) {
                final item = contacts[index];

                return InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 70,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: (item["color"] as Color).withOpacity(
                            .15,
                          ),
                          child: Text(
                            (item["name"] as String)[0],
                            style: TextStyle(
                              color: item["color"] as Color,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item["name"] as String,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
