import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms and conditions",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20),
              const Text('1.Introduction: This document contains the terms and conditions ("Terms") for the use of the Helping Hand Mobile App. By accessing or using the Helping Hand Mobile App, you agree to be bound by these Terms. If you do not agree to these Terms, you are not authorized to use the Helping Hand Mobile App.'),
              const SizedBox(height: 20),
              const Text('2.No Monetary Transactions: The Helping Hand Mobile App does not involve any monetary transactions and no exchange of money or any other financial instruments will take place through the Helping Hand Mobile App.'),
              const SizedBox(height: 20),
              const Text('3.User Representations and Warranties: You represent and warrant that you are at least 18 years of age, have the right, authority, and capacity to enter into these Terms and to use the Helping Hand Mobile App in accordance with these Terms. You further represent and warrant that all information you submit to the Helping Hand Mobile App is true, accurate, and complete.'),
              const SizedBox(height: 20),
              const Text('4.Proprietary Rights: The Helping Hand Mobile App, including but not limited to its software, content, design, text, images, and any other material available through the Helping Hand Mobile App, are protected by proprietary rights, including but not limited to copyrights, trademarks, service marks, trade secrets, and patents. You may not use the Helping Hand Mobile App or its contents for any commercial purpose without the express written consent of the Company.'),
              const SizedBox(height: 20),
              const Text('5.Limitation of Liability: The Company shall not be liable for any damages of any kind arising from the use of the Helping Hand Mobile App, including but not limited to direct, indirect, incidental, punitive, and consequential damages.'),
              const SizedBox(height: 20),
              const Text("6.Indemnification: You agree to indemnify, defend, and hold the Company, its affiliates, and their respective directors, officers, employees, and agents harmless from any and all claims, damages, losses, liabilities, costs, and expenses (including but not limited to attorneys' fees) arising from or in connection with your use of the Helping Hand Mobile App or violation of these Terms."),
              const SizedBox(height: 20),
              const Text('7.Modification of Terms: The Company reserves the right to modify these Terms at any time, without prior notice. Your continued use of the Helping Hand Mobile App after any such modification constitutes your agreement to be bound by the modified Terms.'),
              const SizedBox(height: 20),
              const Text('8.Termination: The Company may, in its sole discretion, at any time terminate or suspend all or a portion of the Helping Hand Mobile App, or your use thereof, with or without notice and with or without cause.'),
              const SizedBox(height: 20),
              const Text('9.Legal Actions for False Information and Violation of Rules: If you provide false information or violate any of these Terms, the Company reserves the right to take legal action against you.'),
              const SizedBox(height: 20),
              const Text('10.Governing Law: These Terms shall be governed by and construed in accordance with the laws of [Governing Law], without giving effect to any principles of conflicts of law.'),
              const SizedBox(height: 20),
              const Text('11.Entire Agreement: These Terms constitute the entire agreement between you and the Company relating to the use of the Helping Hand Mobile App and supersede all prior understandings and agreements, whether written or oral, relating to the subject matter of these Terms.'),
              const SizedBox(height: 20),
              const Text('12.Contact Information: If you have any questions about these Terms, please contact us at [Contact Information provided in About Us section].'),

            ],
          ),
        ),
      ),
    );
  }
}
