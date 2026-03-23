import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:coffee/home/addAddressPage.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({super.key});

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  int _activeTab = 0;
  int _selectedAddress = 0;

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
          "Select Address",
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
          // --- 1. Tab Switcher (Shipping vs Tax) ---
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildTabItem(0, "Shipping Address"),
                  _buildTabItem(1, "Tax Invoice Address"),
                ],
              ),
            ),
          ),

          // --- 2. รายการที่อยู่ ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildAddressCard(
                  index: 0,
                  icon: Icons.location_on_outlined,
                  title: "Home",
                  address: "xxxxxxxxxxxxxxxxxxxxxx",
                  isDefault: true,
                ),
                _buildAddressCard(
                  index: 1,
                  icon: Icons.work_outline,
                  title: "Office",
                  address: "xxxxxxxxxxxxxxxxxxxxxx",
                  isDefault: false,
                ),
                const SizedBox(height: 10),

                // --- 3. ปุ่ม Add New Address ---
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddAddressPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                  label: const Text(
                    "Add New Address",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- 4. ปุ่ม Confirm ---
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2, // สีน้ำตาลธีมหลัก
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับสร้าง Tab ด้านบน
  Widget _buildTabItem(int index, String title) {
    bool isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                    ),
                  ]
                : [],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // Widget สำหรับ Card รายละเอียดที่อยู่
  Widget _buildAddressCard({
    required int index,
    required IconData icon,
    required String title,
    required String address,
    required bool isDefault,
  }) {
    bool isSelected = _selectedAddress == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedAddress = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? primaryColor2 : Colors.grey.shade100,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 28),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (isDefault) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor2.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Default",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Radio<int>(
              value: index,
              groupValue: _selectedAddress,
              activeColor: Colors.black,
              onChanged: (int? value) =>
                  setState(() => _selectedAddress = value!),
            ),
          ],
        ),
      ),
    );
  }
}
