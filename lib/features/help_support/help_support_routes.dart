import 'package:flutter/material.dart';

import 'screens/help_support_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/live_chat_screen.dart';
import 'screens/create_ticket_screen.dart';
import 'screens/ticket_details_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/report_fraud_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/support_success_screen.dart';

class HelpSupportRoutes {
  static const home = '/help-support';
  static const faq = '/faq';
  static const liveChat = '/live-chat';
  static const createTicket = '/create-ticket';
  static const ticketDetails = '/ticket-details';
  static const contactUs = '/contact-us';
  static const reportFraud = '/report-fraud';
  static const feedback = '/feedback';
  static const success = '/support-success';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HelpSupportScreen(),
    faq: (_) => const FAQScreen(),
    liveChat: (_) => const LiveChatScreen(),
    createTicket: (_) => const CreateTicketScreen(),
    ticketDetails: (_) => const TicketDetailsScreen(),
    contactUs: (_) => const ContactUsScreen(),
    reportFraud: (_) => const ReportFraudScreen(),
    feedback: (_) => const FeedbackScreen(),
    success: (_) => const SupportSuccessScreen(),
  };
}
