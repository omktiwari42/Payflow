import 'package:flutter/material.dart';

import '../models/bank_account_model.dart';

class BankAccountCard extends StatelessWidget {
  final BankAccountModel account;
  final VoidCallback? onTap;
  final VoidCallback? onSetPrimary;
  final VoidCallback? onDelete;

  const BankAccountCard({
    super.key,
    required this.account,
    this.onTap,
    this.onSetPrimary,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                child: Text(
                  account.bankName[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            account.bankName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        if (account.isPrimary)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "PRIMARY",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(account.accountHolderName),

                    const SizedBox(height: 4),

                    Text(
                      account.maskedAccountNumber,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "IFSC: ${account.ifscCode}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "primary") {
                    onSetPrimary?.call();
                  }

                  if (value == "delete") {
                    onDelete?.call();
                  }
                },
                itemBuilder: (_) => [
                  if (!account.isPrimary)
                    const PopupMenuItem(
                      value: "primary",
                      child: Text("Set as Primary"),
                    ),
                  const PopupMenuItem(value: "delete", child: Text("Delete")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
