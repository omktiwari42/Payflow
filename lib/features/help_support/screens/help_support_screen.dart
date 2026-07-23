import 'package:flutter/material.dart';
import 'contact_us_screen.dart';
import 'create_ticket_screen.dart';
import 'live_chat_screen.dart';
import '../widgets/contact_support_card.dart';
import '../widgets/emergency_support_card.dart';
import '../widgets/faq_preview_card.dart';
import '../widgets/help_category_card.dart';
import '../widgets/quick_support_card.dart';
import '../widgets/support_header.dart';
import '../widgets/ticket_card.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FC),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SupportHeader()),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search help articles...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Quick Support",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate([
                  QuickSupportCard(
                    title: "Live Chat",
                    icon: Icons.chat_bubble_outline,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LiveChatScreen(),
                        ),
                      );
                    },
                  ),
                  QuickSupportCard(
                    title: "Call",
                    icon: Icons.call,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ContactUsScreen(),
                        ),
                      );
                    },
                  ),
                  QuickSupportCard(
                    title: "Email",
                    icon: Icons.email_outlined,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ContactUsScreen(),
                        ),
                      );
                    },
                  ),
                  QuickSupportCard(
                    title: "Raise Ticket",
                    icon: Icons.support_agent,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateTicketScreen(),
                        ),
                      );
                    },
                  ),
                ]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.18,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Popular Topics",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 14)),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HelpCategoryCard(title: "Payments", icon: Icons.payments),
                    SizedBox(width: 14),
                    HelpCategoryCard(
                      title: "Wallet",
                      icon: Icons.account_balance_wallet,
                    ),
                    SizedBox(width: 14),
                    HelpCategoryCard(title: "Cards", icon: Icons.credit_card),
                    SizedBox(width: 14),
                    HelpCategoryCard(title: "Security", icon: Icons.shield),
                    SizedBox(width: 14),
                    HelpCategoryCard(title: "KYC", icon: Icons.verified_user),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TicketCard(),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: FAQPreviewCard(),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: EmergencySupportCard(),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: ContactSupportCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
