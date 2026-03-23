import 'package:coffee/login/subscription/ConsumerSubscriptionPage.dart';
import 'package:coffee/login/subscription/DistributorSubscriptionPage.dart';
import 'package:coffee/login/subscription/ProducerSubscriptionPage.dart';
import 'package:coffee/login/subscription/RoasterSubcriptionPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:coffee/constants.dart';

class SelectRolePage extends StatefulWidget {
  const SelectRolePage({super.key});

  @override
  State<SelectRolePage> createState() => _SelectRolePageState();
}

class _SelectRolePageState extends State<SelectRolePage> {
  String _selectedCategory = '';

  final List<Map<String, String>> _roles = [
    {
      'title': 'Roaster',
      'subtitle': 'Session Management, Team Cupping, Data Analysis',
    },
    {'title': 'Consumer', 'subtitle': 'Tasting & Coffee Library'},
    {'title': 'Distributor', 'subtitle': 'Session Comparison & Buyer Reports'},
    {'title': 'Producer', 'subtitle': 'Sample Management & Quality Tracking'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Role',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 8),
              itemCount: _roles.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.grey.shade200),
              itemBuilder: (context, index) {
                final role = _roles[index];
                return _buildRoleOption(role['title']!, role['subtitle']!);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton('Next'),
    );
  }

  Widget _buildRoleOption(String title, String subtitle) {
    final bool isSelected = _selectedCategory == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = title),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            // Radio circle (ขนาดคงที่)
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryColor2 : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: primaryColor2,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),

            // --- ส่วนที่แก้ไข: หุ้ม Column ด้วย Expanded ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min, // ให้ Column ใช้พื้นที่เท่าที่จำเป็น
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    softWrap: true, // อนุญาตให้ขึ้นบรรทัดใหม่
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            // -------------------------------------------
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(String text) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _selectedCategory.isEmpty
                  ? null
                  : () {
                      final cuppingProvider = Provider.of<CuppingProvider>(
                        context,
                        listen: false,
                      );

                      if (_selectedCategory == 'Consumer') {
                        cuppingProvider.setUserRole(UserRole.consumer);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ConsumerSubscriptionPage(),
                          ),
                        );
                      } else if (_selectedCategory == 'Producer') {
                        cuppingProvider.setUserRole(UserRole.producer);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ProducerSubscriptionPage(),
                          ),
                        );
                      } else if (_selectedCategory == 'Distributor') {
                        cuppingProvider.setUserRole(UserRole.distributor);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DistributorSubscriptionPage(),
                          ),
                        );
                      } else if (_selectedCategory == 'Roaster') {
                        cuppingProvider.setUserRole(UserRole.roaster);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RoasterSubcriptionPage(),
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                disabledBackgroundColor: secondaryColor2.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
