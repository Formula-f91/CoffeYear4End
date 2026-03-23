import 'dart:convert';
import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  List _provinces = [];
  List _districts = [];
  List _subdistricts = [];

  List _filteredDistricts = [];
  List _filteredSubdistricts = [];
  
  // เพิ่มตัวแปรสำหรับจัดการรหัสไปรษณีย์
  List<String> _filteredPostalCodes = []; 
  String? _selectedPostalCode;

  String? _selectedProvinceCode;
  String? _selectedDistrictCode;
  String? _selectedSubdistrictCode;

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    try {
      final String provinceResponse = await rootBundle.loadString('assets/provice/provinces.json');
      final String districtResponse = await rootBundle.loadString('assets/provice/districts.json');
      final String subdistrictResponse = await rootBundle.loadString('assets/provice/subdistricts.json');

      setState(() {
        _provinces = json.decode(provinceResponse);
        _districts = json.decode(districtResponse);
        _subdistricts = json.decode(subdistrictResponse);
        _provinces.sort((a, b) => a['nameTH'].compareTo(b['nameTH']));
      });
    } catch (e) {
      debugPrint("Error loading JSON: $e");
    }
  }

  void _onProvinceChanged(String? provinceCode) {
    setState(() {
      _selectedProvinceCode = provinceCode;
      _selectedDistrictCode = null;
      _selectedSubdistrictCode = null;
      _selectedPostalCode = null; // ล้างค่ารหัสไปรษณีย์
      _filteredPostalCodes = [];
      _postalCodeController.clear();

      _filteredDistricts = _districts
          .where((item) => item['provinceCode'].toString() == provinceCode)
          .toList();
      _filteredDistricts.sort((a, b) => a['nameTH'].compareTo(b['nameTH']));
      _filteredSubdistricts = [];
    });
  }

  void _onDistrictChanged(String? districtCode) {
    setState(() {
      _selectedDistrictCode = districtCode;
      _selectedSubdistrictCode = null;
      _selectedPostalCode = null; // ล้างค่ารหัสไปรษณีย์
      _filteredPostalCodes = [];
      _postalCodeController.clear();

      _filteredSubdistricts = _subdistricts
          .where((item) => item['districtCode'].toString() == districtCode)
          .toList();
      _filteredSubdistricts.sort((a, b) => a['nameTH'].compareTo(b['nameTH']));
    });
  }

  void _onSubdistrictChanged(String? subdistrictCode) {
    setState(() {
      _selectedSubdistrictCode = subdistrictCode;
      _selectedPostalCode = null;
      _postalCodeController.clear();

      // กรองข้อมูลแขวง/ตำบลเพื่อหารหัสไปรษณีย์
      final subData = _filteredSubdistricts.where(
        (item) => item['subdistrictCode'].toString() == subdistrictCode
      ).toList();

      if (subData.isNotEmpty) {
        // ดึงรหัสไปรษณีย์ทั้งหมด (ใช้ toSet เพื่อตัดค่าซ้ำ)
        _filteredPostalCodes = subData
            .map((e) => e['postalCode'].toString())
            .toSet()
            .toList();

        // ถ้ามีรหัสเดียว ให้เลือกให้อัตโนมัติเลย
        if (_filteredPostalCodes.length == 1) {
          _selectedPostalCode = _filteredPostalCodes[0];
          _postalCodeController.text = _selectedPostalCode!;
        }
      }
    });
  }

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
        title: const Text("Add New Address", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Address Label"),
                  _buildTextField("", controller: _labelController),
                  const SizedBox(height: 20),

                  _buildLabel("Full Name"),
                  _buildTextField("", controller: _nameController),
                  const SizedBox(height: 20),

                  _buildLabel("Contact Number"),
                  _buildTextField("", controller: _phoneController, keyboardType: TextInputType.phone),
                  const SizedBox(height: 20),

                  _buildLabel("Address Details"),
                  _buildLargeTextField(_detailsController),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Province"),
                            _buildDropdownField(
                              hint: "",
                              value: _selectedProvinceCode,
                              items: _provinces,
                              onChanged: _onProvinceChanged,
                              itemKey: 'provinceCode',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("District"),
                            _buildDropdownField(
                              hint: "",
                              value: _selectedDistrictCode,
                              items: _filteredDistricts,
                              onChanged: _selectedProvinceCode == null ? null : _onDistrictChanged,
                              itemKey: 'districtCode',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Sub-district"),
                            _buildDropdownField(
                              hint: "",
                              value: _selectedSubdistrictCode,
                              items: _filteredSubdistricts,
                              onChanged: _selectedDistrictCode == null ? null : _onSubdistrictChanged,
                              itemKey: 'subdistrictCode',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Postal Code"),
                            // เปลี่ยนเป็น Dropdown สำหรับรหัสไปรษณีย์
                            _buildPostalDropdownField(
                              hint: "",
                              value: _selectedPostalCode,
                              items: _filteredPostalCodes,
                              onChanged: (val) {
                                setState(() {
                                  _selectedPostalCode = val;
                                  _postalCodeController.text = val ?? "";
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: ElevatedButton(
              onPressed: () {
                // ตัวอย่างตรวจสอบว่าเลือกครบหรือยัง
                if (_selectedSubdistrictCode == null || _selectedPostalCode == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please complete the address")));
                  return;
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                elevation: 0,
              ),
              child: const Text("Confirm", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
    );
  }

  Widget _buildTextField(String hint, {TextEditingController? controller, TextInputType? keyboardType, bool readOnly = false}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        filled: readOnly,
        fillColor: readOnly ? Colors.grey.shade50 : Colors.white,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC07651))),
      ),
    );
  }

  Widget _buildLargeTextField(TextEditingController controller) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            TextField(
              controller: controller,
              maxLines: 4,
              maxLength: 200,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                counterText: "",
                contentPadding: const EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC07651))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("${controller.text.length}/200", style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ),
          ],
        );
      },
    );
  }

  // Dropdown สำหรับข้อมูลที่ดึงจาก List ของ Object (JSON)
  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List items,
    required ValueChanged<String?>? onChanged,
    required String itemKey,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: onChanged == null ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(hint, style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item[itemKey].toString(),
              child: Text(item['nameTH'], style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // เพิ่ม Widget Dropdown พิเศษสำหรับรหัสไปรษณีย์ (รับ List ของ String)
  Widget _buildPostalDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: (onChanged == null || items.isEmpty) ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(hint, style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: items.map((String code) {
            return DropdownMenuItem<String>(
              value: code,
              child: Text(code, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: items.isEmpty ? null : onChanged,
        ),
      ),
    );
  }
}