import 'package:flutter/material.dart';

import '../../send_money/screens/send_money_screen.dart';
import '../models/beneficiary_model.dart';
import '../services/beneficiary_api_service.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<BeneficiaryModel> beneficiaries = [];
  List<BeneficiaryModel> filtered = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBeneficiaries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBeneficiaries() async {
    try {
      final data = await BeneficiaryApiService.instance.getBeneficiaries();

      if (!mounted) return;

      setState(() {
        beneficiaries = data;
        filtered = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  void _search(String value) {
    final query = value.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filtered = beneficiaries;
      } else {
        filtered = beneficiaries.where((b) {
          return b.fullName.toLowerCase().contains(query) ||
              b.phone.toLowerCase().contains(query) ||
              (b.upiId ?? "").toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> _delete(BeneficiaryModel b) async {
    try {
      await BeneficiaryApiService.instance.deleteBeneficiary(b.id);

      await _loadBeneficiaries();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Beneficiary deleted.")));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beneficiaries"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Add Beneficiary screen coming next."),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: "Search beneficiary...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _loadBeneficiaries,
                    child: filtered.isEmpty
                        ? const Center(child: Text("No Beneficiaries"))
                        : ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (_, index) {
                              final b = filtered[index];

                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      b.fullName.isEmpty ? "?" : b.fullName[0],
                                    ),
                                  ),

                                  title: Text(b.fullName),

                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(b.phone),
                                      if (b.upiId != null &&
                                          b.upiId!.isNotEmpty)
                                        Text(b.upiId!),
                                    ],
                                  ),

                                  trailing: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == "delete") {
                                        _delete(b);
                                      }
                                    },
                                    itemBuilder: (_) => const [
                                      PopupMenuItem(
                                        value: "delete",
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  ),

                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SendMoneyScreen(
                                          recipientName: b.fullName,
                                          phone: b.phone,
                                          upiId: b.upiId,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
