import 'package:flutter/material.dart';

import '../widgets/filter_chip_widget.dart';
import '../widgets/popular_service_card.dart';
import '../widgets/recent_search_card.dart';
import '../widgets/search_bar_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<String> recentSearches = [
    "Electricity Bill",
    "Rahul Sharma",
    "Amazon",
    "Netflix",
    "Recharge",
  ];

  final List<Map<String, dynamic>> popularServices = [
    {
      "title": "Mobile Recharge",
      "icon": Icons.phone_android,
      "color": Colors.green,
    },
    {
      "title": "Electricity",
      "icon": Icons.electric_bolt,
      "color": Colors.amber,
    },
    {
      "title": "Gas Bill",
      "icon": Icons.local_fire_department,
      "color": Colors.deepOrange,
    },
    {"title": "Water Bill", "icon": Icons.water_drop, "color": Colors.blue},
    {
      "title": "Insurance",
      "icon": Icons.health_and_safety,
      "color": Colors.red,
    },
    {"title": "Fastag", "icon": Icons.directions_car, "color": Colors.purple},
  ];

  String selectedFilter = "All";

  final List<String> filters = [
    "All",
    "Transactions",
    "Contacts",
    "Bills",
    "Services",
  ];

  @override
  Widget build(BuildContext context) {
    final query = _controller.text.toLowerCase();

    final filteredRecent = recentSearches
        .where((item) => item.toLowerCase().contains(query))
        .toList();

    final filteredServices = popularServices.where((service) {
      return service["title"].toString().toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SearchBarWidget(
            controller: _controller,
            onChanged: (_) {
              setState(() {});
            },
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return FilterChipWidget(
                  title: filters[index],
                  selected: selectedFilter == filters[index],
                  onTap: () {
                    setState(() {
                      selectedFilter = filters[index];
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "Recent Searches",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          if (filteredRecent.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "No recent searches found.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...filteredRecent.map(
              (item) => RecentSearchCard(
                title: item,
                onTap: () {
                  _controller.text = item;
                  setState(() {});
                },
              ),
            ),

          const SizedBox(height: 30),

          const Text(
            "Popular Services",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          if (filteredServices.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  "No services found.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredServices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                final item = filteredServices[index];

                return PopularServiceCard(
                  title: item["title"],
                  icon: item["icon"],
                  color: item["color"],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item["title"]} selected")),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
