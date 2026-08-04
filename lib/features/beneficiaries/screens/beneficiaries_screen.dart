import 'package:flutter/material.dart';

import '../../send_money/screens/send_money_screen.dart';
import '../models/beneficiary_model.dart';
import '../services/beneficiary_api_service.dart';
import 'add_beneficiary_screen.dart';

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

  Future<void> _delete(BeneficiaryModel beneficiary) async {
    try {
      await BeneficiaryApiService.instance.deleteBeneficiary(beneficiary.id);

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

  Future<void> _openAddBeneficiary() async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddBeneficiaryScreen()),
    );

    if (updated == true) {
      await _loadBeneficiaries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beneficiaries"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        onPressed: _openAddBeneficiary,
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
                        ? const Center(child: Text("No Beneficiaries Found"))
                        : ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (_, index) {
                              final beneficiary = filtered[index];

                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      beneficiary.fullName.isEmpty
                                          ? "?"
                                          : beneficiary.fullName[0]
                                                .toUpperCase(),
                                    ),
                                  ),

                                  title: Text(beneficiary.fullName),

                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(beneficiary.phone),
                                      if (beneficiary.upiId != null &&
                                          beneficiary.upiId!.isNotEmpty)
                                        Text(beneficiary.upiId!),
                                    ],
                                  ),

                                  trailing: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == "delete") {
                                        _delete(beneficiary);
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
                                          recipientName: beneficiary.fullName,
                                          phone: beneficiary.phone,
                                          upiId: beneficiary.upiId,
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
