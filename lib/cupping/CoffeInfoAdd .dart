import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class CoffeInfoAdd extends StatefulWidget {
  const CoffeInfoAdd({super.key});

  @override
  State<CoffeInfoAdd> createState() => _CoffeInfoAddState();
}

class _CoffeInfoAddState extends State<CoffeInfoAdd> {
  final List<String> typeItems = ["Sales Sample", "Pre-Shipment Sample", "Quality Evaluation Sample", "Calibration / Reference Sample", "Rejection Review Sample", "Stock Lot Coffee", "Others"];
  final List<String> varietyItems = ["Arabica", "Robusta", "Liberica", "Blend", "Others"];
  final List<String> methodItems = ["Washed", "Honey", "Natural", "Anaerobic", "Experimental"];

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildTextField({String? hint, int maxLines = 1, String? suffixIcon}) {
  return TextField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      suffixIcon: suffixIcon != null ? Padding(padding: const EdgeInsets.all(12), child: Image.asset(suffixIcon, width: 20)) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0), // ← เหมือน Dropdown
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0), // ← เหมือน Dropdown
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0), // ← เหมือน Dropdown
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),
  );
}

  Widget _buildDropdown(String hint, List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 14)),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) {},
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
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text("Add Coffee Information", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Coffee Code"), _buildTextField(),
            _buildLabel("Coffee Name"), _buildTextField(),
            _buildLabel("Type"), _buildDropdown("Select Type", typeItems),
            _buildLabel("Variety"), _buildDropdown("Select Variety", varietyItems),
            _buildLabel("Processing Method"), _buildDropdown("Select Method", methodItems),
            _buildLabel("Harvest Season"), _buildTextField(),
            _buildLabel("Coffee Description"), _buildTextField(maxLines: 4, hint: "51/200"),
            _buildLabel("Upload Coffee Image"),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.zero,
              ),
              child: Center(
                child: Image.asset(
                  'assets/icon/imageiconv3.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_outlined,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildLabel("Lot Code"), _buildTextField()])),
                const SizedBox(width: 15),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildLabel("Harvest Date"), _buildTextField(hint: "31/3/2569", suffixIcon: 'assets/icons/calendar2.png')])),
              ],
            ),
            Row(
              children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildLabel("Quantity (kg)"), _buildTextField()])),
                const SizedBox(width: 15),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildLabel("Price"), _buildTextField()])),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200)), color: Colors.white),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor2, padding: const EdgeInsets.symmetric(vertical: 15), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero), elevation: 0),
                child: const Text("Confirm", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}