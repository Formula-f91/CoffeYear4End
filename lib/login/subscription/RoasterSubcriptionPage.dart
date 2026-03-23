import 'package:coffee/roaster_firstPage.dart';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class RoasterSubcriptionPage extends StatelessWidget {
  const RoasterSubcriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Roaster subscriptions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  _buildPlanCard(
                    context,
                    title: 'Professional',
                    price: '\$24.99',
                    period: '/month',
                    showDiscount: true,
                    features: [
                      'Unlimited tastings',
                      'Unlimited sessions',
                      'All CVA modes(Quick + Affective +\n Combined)',
                      'Basic PDF export',
                      'Cross-session comparison',
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          _buildBottomSection(context),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required String price,
    required String period,
    required List<String> features,
    bool showDiscount = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: primaryColor2,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                period,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          if (showDiscount) ...[
            const SizedBox(height: 6),
            Text(
              'Get 10% off automatically when you pay via web',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
          const SizedBox(height: 16),
          ...features.map((f) => _buildFeatureRow(f)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoasterFirstpage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                'Subscriptions',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check, size: 18, color: primaryColor2),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Looking for guidance?',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              const Text(
                'Browse our Knowledge Base',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F0),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: navigate to FAQs
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'FAQs',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}