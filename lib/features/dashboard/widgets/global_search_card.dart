import 'package:flutter/material.dart';

class GlobalSearchCard extends StatelessWidget {
  const GlobalSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Global Search",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Search transactions, contacts, cards and more",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),

          TextField(
            decoration: InputDecoration(
              hintText: "Search anything...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _FilterChip(
                icon: Icons.receipt_long,
                label: "Transactions",
              ),
              _FilterChip(
                icon: Icons.person,
                label: "Contacts",
              ),
              _FilterChip(
                icon: Icons.credit_card,
                label: "Cards",
              ),
              _FilterChip(
                icon: Icons.account_balance_wallet,
                label: "Wallet",
              ),
              _FilterChip(
                icon: Icons.flag,
                label: "Goals",
              ),
              _FilterChip(
                icon: Icons.notifications,
                label: "Alerts",
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Text(
            "Recent Searches",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 18),

          const _RecentSearchTile(
            icon: Icons.history,
            title: "Rahul Payment",
          ),

          const SizedBox(height: 12),

          const _RecentSearchTile(
            icon: Icons.history,
            title: "Electricity Bill",
          ),

          const SizedBox(height: 12),

          const _RecentSearchTile(
            icon: Icons.history,
            title: "Netflix",
          ),
                    const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xffEEF6FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xff2563EB),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "AI Suggestion: You frequently pay Rahul, Electricity Bill, and Netflix. Add them to Favorites for faster payments.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FilterChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(
        icon,
        size: 18,
        color: const Color(0xff2563EB),
      ),
      label: Text(label),
      backgroundColor: const Color(0xffF8FAFC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      onPressed: () {},
    );
  }
}

class _RecentSearchTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _RecentSearchTile({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xff2563EB).withValues(alpha: 0.10),
            child: Icon(
              icon,
              color: const Color(0xff2563EB),
              size: 20,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.north_west,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}