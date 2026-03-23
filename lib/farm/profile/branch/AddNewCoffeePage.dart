import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

String? selectedType;
  String? selectedVariety;
  String? selectedMethod;

  // รายการข้อมูลตามภาพ
  final List<String> typeItems = [
    "Sales Sample",
    "Pre-Shipment Sample",
    "Quality Evaluation Sample",
    "Calibration / Reference Sample",
    "Rejection Review Sample",
    "Stock Lot Coffee",
    "Others"
  ];

  final List<String> varietyItems = ["Arabica", "Robusta", "Liberica", "Blend", "Others"];

  final List<String> methodItems = ["Washed", "Honey", "Natural", "Anaerobic", "Experimental"];

class AddNewCoffeePage extends StatefulWidget {
  const AddNewCoffeePage({super.key});
  
  @override
  State<AddNewCoffeePage> createState() => _AddNewCoffeePageState();
}

class _AddNewCoffeePageState extends State<AddNewCoffeePage> {
   static const Color deleteColor = Color(0xFFFF5252);
 // ฟังก์ชันช่วยสร้าง TextField แบบมี Label
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  // ฟังก์ชันสร้าง TextField ทรงเหลี่ยม
  Widget _buildTextField({String? hint, int maxLines = 1, String? suffixIconAsset}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        suffixIcon: suffixIconAsset != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(suffixIconAsset, width: 20, height: 20),
              )
            : null,
        contentPadding: const EdgeInsets.all(12),
        border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้าง Dropdown (จำลองจากภาพ)
  Widget _buildDropdownField(String hint, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          value: selectedValue,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Coffee Information",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputLabel("Coffee Code"),
            _buildTextField(),

            _buildInputLabel("Coffee Name"),
            _buildTextField(),

            _buildInputLabel("Type"),
            _buildDropdownField("Select Type", typeItems, selectedType, (val) => setState(() => selectedType = val)),

            _buildInputLabel("Variety"),
            _buildDropdownField("Select Variety", varietyItems, selectedVariety, (val) => setState(() => selectedVariety = val)),

            _buildInputLabel("Processing Method"),
            _buildDropdownField("Select Method", methodItems, selectedMethod, (val) => setState(() => selectedMethod = val)),

            _buildInputLabel("Harvest Season"),
            _buildTextField(),

            _buildInputLabel("Coffee Description"),
            _buildTextField(maxLines: 4, hint: "51/200"),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabel("Lot Code"),
                      _buildTextField(),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabel("Harvest Date"),
                      _buildTextField(
                        hint: "31/3/2569",
                        suffixIconAsset: 'assets/icons/calendar2.png', // ไอคอนที่คุณระบุ
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabel("Quantity (kg)"),
                      _buildTextField(),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabel("Price"),
                      _buildTextField(),
                    ],
                  ),
                ),
              ],
            ),

            _buildInputLabel("Upload Coffee Image"),
                  Row(
                    children: [
                      // Add Button
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.add_circle_outline, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 12),
                      
                      // Mock Images List
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(4, (index) {
                              return GestureDetector(
                                onTap: _showImageOptionsSheet, // เพิ่มการกดตรงนี้
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8), 
                                    image: const DecorationImage(
                                      image: AssetImage('assets/Image.png'), 
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200, width: 0.5)),
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showDeleteDialog(), // เรียกฟังก์ชัน Pop-up ที่คุณมีอยู่แล้ว
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(color: deleteColor), // ใช้สีแดงที่คุณประกาศไว้
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    child: const Text("Delete Product", style: TextStyle(color: deleteColor)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor2,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    child: const Text("Confirm", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageOptionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "xxxxxxxxxxxx",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 28, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // 1. View image - ใช้ Eye.png
              _buildSheetItem(
                imagePath: 'assets/icon/Eye.png',
                label: "View image",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // 2. Change image - ใช้ Available Updates.png
              _buildSheetItem(
                imagePath: 'assets/icon/Available Updates.png',
                label: "Change image",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // 3. Delete - ใช้ Trash.png
              _buildSheetItem(
                imagePath: 'assets/icon/Trash.png',
                label: "Delete",
                labelColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

    Widget _buildSheetItem({
    required String imagePath, // เปลี่ยนจาก IconData เป็น String path
    required String label,
    required VoidCallback onTap,
    Color labelColor = Colors.black,
  }) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 24, // กำหนดขนาดให้เท่ากับ Icon มาตรฐาน
        height: 24,
        fit: BoxFit.contain,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: labelColor, 
          fontSize: 16, 
          fontWeight: FontWeight.w500
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Delete",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, thickness: 1, color: Colors.black12),
                const SizedBox(height: 30),
                
                // Red Icon (Circle X)
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: deleteColor, // สีแดง
                    shape: BoxShape.circle,
                  ),
                  child: Center( // เพิ่ม Center ตรงนี้
                    child: Image.asset(
                      'assets/icon/deletevec.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Text
                const Text(
                  "Are you sure you want to delete",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                
                // Buttons Row
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: deleteColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text("Cancel", style: TextStyle(color: deleteColor, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Confirm Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: ใส่ Logic ลบข้อมูลตรงนี้
                          Navigator.pop(context); // ปิด Dialog
                          Navigator.pop(context); // ปิดหน้า Edit (ถ้าต้องการ)
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: deleteColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: const Text("Confirm", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}