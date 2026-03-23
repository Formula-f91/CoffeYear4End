import 'package:coffee/constants.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/coffeedetailproducer.dart';
import 'package:flutter/material.dart';

class AddCoffeeInfoPage extends StatefulWidget {
  const AddCoffeeInfoPage({super.key});

  @override
  State<AddCoffeeInfoPage> createState() => _AddCoffeeInfoPageState();
}

class _AddCoffeeInfoPageState extends State<AddCoffeeInfoPage> {
  final TextEditingController _descController = TextEditingController();

  // ตัวแปรเก็บค่าที่เลือกในแต่ละ Dropdown
  String? _selectedType;
  String? _selectedVariety;
  String? _selectedMethod;

  // 1. ข้อมูลจากภาพ type.png
  final List<String> _typeItems = [
    'Sales Sample',
    'Pre-Shipment Sample',
    'Quality Evaluation Sample',
    'Calibration / Reference Sample',
    'Rejection Review Sample',
    'Stock Lot Coffee',
    'Others',
  ];

  // 2. ข้อมูลจากภาพ variety.png
  final List<String> _varietyItems = [
    'Arabica',
    'Robusta',
    'Liberica',
    'Blend',
    'Others',
  ];

  // 3. ข้อมูลจากภาพ processing method.png
  final List<String> _methodItems = [
    'Washed',
    'Honey',
    'Natural',
    'Anaerobic',
    'Experimental',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Add Coffee Information",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Coffee Code"),
                  _buildTextField(hint: ""),
                  const SizedBox(height: 16),

                  _buildLabel("Coffee Name"),
                  _buildTextField(hint: ""),
                  const SizedBox(height: 16),

                  // Dropdown: Type
                  _buildLabel("Type"),
                  _buildDropdownField(
                    "Select Type",
                    _typeItems,
                    _selectedType,
                    (val) => setState(() => _selectedType = val),
                  ),
                  const SizedBox(height: 16),

                  // Dropdown: Variety
                  _buildLabel("Variety"),
                  _buildDropdownField(
                    "Select Variety",
                    _varietyItems,
                    _selectedVariety,
                    (val) => setState(() => _selectedVariety = val),
                  ),
                  const SizedBox(height: 16),

                  // Dropdown: Processing Method
                  _buildLabel("Processing Method"),
                  _buildDropdownField(
                    "Select Method",
                    _methodItems,
                    _selectedMethod,
                    (val) => setState(() => _selectedMethod = val),
                  ),
                  const SizedBox(height: 16),

                  _buildLabel("Harvest Season"),
                  _buildTextField(hint: ""),
                  const SizedBox(height: 16),

                  _buildLabel("Coffee Description"),
                  _buildDescriptionField(),
                  const SizedBox(height: 20),

                  _buildLabel("Upload Coffee Image"),
                  _buildUploadBox(),
                  const SizedBox(height: 24),

                  // ส่วนของ Lot Code และ Harvest Date
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Lot Code"),
                            _buildTextField(hint: ""),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Harvest Date"),
                            _buildDatePickerField(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ส่วนของ Quantity และ Price
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Quantity (kg)"),
                            _buildTextField(hint: ""),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Price"),
                            _buildTextField(hint: ""),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint}) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: const Color(0xFFA2A2A2), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: Color(0xFFC67C4E), width: 1.5),
        ),
      ),
    );
  }

  // ปรับปรุงฟังก์ชัน Dropdown ให้รับ List ข้อมูล
  Widget _buildDropdownField(
    String hint,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: const Color(0xFFA2A2A2), width: 0.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            hint,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Stack(
      children: [
        TextField(
          controller: _descController,
          maxLines: 4,
          maxLength: 200,
          onChanged: (text) => setState(() {}),
          decoration: InputDecoration(
            counterText: "",
            contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: const Color(0xFFA2A2A2),
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(
                color: Color(0xFFC67C4E),
                width: 1.5,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 12,
          child: Text(
            "${_descController.text.length}/200",
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFA2A2A2).withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: const Color(0xFFA2A2A2), width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("31/3/2569", style: TextStyle(fontSize: 14)),
          Image.asset("assets/icon/calendar.png", width: 20, height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 1)),
            ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CoffeeDetailsProducer(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0,
          ),
          child: const Text(
            "Confirm",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
