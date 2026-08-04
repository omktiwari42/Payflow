import 'package:flutter/material.dart';

class TravelBookingCard extends StatelessWidget {
  const TravelBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Flights",
        "icon": Icons.flight_takeoff_rounded,
        "color": Colors.blue,
      },
      {"title": "Train", "icon": Icons.train_rounded, "color": Colors.green},
      {
        "title": "Bus",
        "icon": Icons.directions_bus_rounded,
        "color": Colors.orange,
      },
      {"title": "Hotels", "icon": Icons.hotel_rounded, "color": Colors.purple},
      {"title": "Cab", "icon": Icons.local_taxi_rounded, "color": Colors.red},
      {"title": "Metro", "icon": Icons.subway_rounded, "color": Colors.teal},
      {
        "title": "Movie",
        "icon": Icons.movie_creation_outlined,
        "color": Colors.indigo,
      },
      {
        "title": "Events",
        "icon": Icons.event_available_rounded,
        "color": Colors.pink,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Travel & Bookings",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 82,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (_, index) {
              final item = items[index];

              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: (item["color"] as Color).withValues(
                        alpha: .12,
                      ),
                      child: Icon(
                        item["icon"] as IconData,
                        color: item["color"] as Color,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item["title"] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
