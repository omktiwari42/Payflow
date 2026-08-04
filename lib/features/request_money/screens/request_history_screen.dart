import 'package:flutter/material.dart';

import '../models/request_money_model.dart';
import '../services/request_money_api_service.dart';
import 'request_details_screen.dart';

class RequestHistoryScreen extends StatefulWidget {
  const RequestHistoryScreen({super.key});

  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<RequestMoneyModel> requests = [];
  List<RequestMoneyModel> filtered = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRequests() async {
    try {
      final data = await RequestMoneyApiService.instance.getHistory();

      if (!mounted) return;

      setState(() {
        requests = data;
        filtered = data;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
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
        filtered = requests;
      } else {
        filtered = requests.where((r) {
          return r.senderName.toLowerCase().contains(query) ||
              r.senderPhone.toLowerCase().contains(query) ||
              r.note.toLowerCase().contains(query) ||
              r.receiverName.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Color statusColor(String status) {
    switch (status.toUpperCase()) {
      case "ACCEPTED":
        return Colors.green;
      case "REJECTED":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Future<void> _accept(RequestMoneyModel request) async {
    try {
      await RequestMoneyApiService.instance.acceptRequest(request.id);
      await _loadRequests();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _reject(RequestMoneyModel request) async {
    try {
      await RequestMoneyApiService.instance.rejectRequest(request.id);
      await _loadRequests();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _delete(RequestMoneyModel request) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Request"),
        content: const Text("Are you sure you want to delete this request?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await RequestMoneyApiService.instance.deleteRequest(request.id);

      await _loadRequests();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request deleted successfully.")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _showActions(RequestMoneyModel request) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            if (request.status.toUpperCase() == "PENDING")
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text("Accept Request"),
                onTap: () async {
                  Navigator.pop(context);
                  await _accept(request);
                },
              ),
            if (request.status.toUpperCase() == "PENDING")
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text("Reject Request"),
                onTap: () async {
                  Navigator.pop(context);
                  await _reject(request);
                },
              ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Delete Request"),
              onTap: () async {
                Navigator.pop(context);
                await _delete(request);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Request History"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: "Search requests...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _loadRequests,
                    child: filtered.isEmpty
                        ? const Center(child: Text("No Requests Found"))
                        : ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (_, index) {
                              final request = filtered[index];

                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    child: Icon(Icons.request_page),
                                  ),
                                  title: Text(request.senderName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(request.senderPhone),
                                      if (request.note.isNotEmpty)
                                        Text(request.note),
                                      Text(
                                        request.createdAt,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "₹${request.amount.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Chip(
                                        label: Text(request.status),
                                        backgroundColor: statusColor(
                                          request.status,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RequestDetailsScreen(
                                          request: request,
                                        ),
                                      ),
                                    );
                                  },
                                  onLongPress: () {
                                    _showActions(request);
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
