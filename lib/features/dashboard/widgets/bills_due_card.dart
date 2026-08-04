import 'package:flutter/material.dart';

class BillsDueCard extends StatelessWidget {
  const BillsDueCard({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        "title": "Mobile",
        "icon": Icons.phone_android_rounded,
        "color": Colors.blue,
      },
      {
        "title": "Electricity",
        "icon": Icons.bolt_rounded,
        "color": Colors.amber,
      },
      {"title": "DTH", "icon": Icons.tv_rounded, "color": Colors.deepPurple},
      {"title": "Broadband", "icon": Icons.wifi_rounded, "color": Colors.green},
      {
        "title": "Water",
        "icon": Icons.water_drop_rounded,
        "color": Colors.lightBlue,
      },
      {
        "title": "Gas",
        "icon": Icons.local_fire_department_rounded,
        "color": Colors.orange,
      },
      {
        "title": "FASTag",
        "icon": Icons.directions_car_rounded,
        "color": Colors.red,
      },
      {
        "title": "Credit Card",
        "icon": Icons.credit_card_rounded,
        "color": Colors.indigo,
      },
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Recharge & Bills",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(55, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text("View All"),
              ),
            ],
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 82,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (_, index) {
              final item = services[index];

              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (item["color"] as Color).withOpacity(.10),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item["icon"] as IconData,
                        color: item["color"] as Color,
                        size: 24,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      item["title"] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        height: 1.15,
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
