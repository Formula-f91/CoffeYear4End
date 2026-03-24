import 'package:coffee/constants.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';

class EditSamplePage extends StatefulWidget {
  final String sampleNumber;
  final bool isAddMode;

  const EditSamplePage({
    super.key,
    required this.sampleNumber,
    this.isAddMode = true,
  });

  @override
  State<EditSamplePage> createState() => _EditSamplePageState();
}

class _EditSamplePageState extends State<EditSamplePage> {
  // ── Controllers ───────────────────────────────────────────────────────────
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _harvestController = TextEditingController();
  final TextEditingController _moistureController = TextEditingController();
  final TextEditingController _waterActivityController =
      TextEditingController();
  final TextEditingController _densityController = TextEditingController();
  final TextEditingController _processingController = TextEditingController();
  final TextEditingController _agtronController = TextEditingController();

  // ── State ─────────────────────────────────────────────────────────────────
  String _selectedRoastLevel = 'Light';
  String? _selectedSampleType;
  String? _selectedCropYear;
  String? _selectedSpecies;
  String? _selectedCountry;

  // ── Mock dropdown data ────────────────────────────────────────────────────
  final List<String> _sampleTypeItems = [
    'Green Bean',
    'Roasted Bean',
    'Ground Coffee',
  ];
  final List<String> _speciesItems = ['Arabica', 'Robusta', 'Liberica'];
  final List<String> _cropYearItems = ['2024', '2025', '2026'];
  final List<String> _countryItems = ['Thailand', 'Brazil', 'Ethiopia'];

  @override
  void dispose() {
    _nameController.dispose();
    _harvestController.dispose();
    _moistureController.dispose();
    _waterActivityController.dispose();
    _densityController.dispose();
    _processingController.dispose();
    _agtronController.dispose();
    super.dispose();
  }

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
        title: Text(
          widget.isAddMode ? "Add Sample" : "Edit Sample",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.sampleNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "Sample ID : -",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildRow(
                    left: _buildField(
                      "Sample Name *",
                      _buildTextField(_nameController),
                    ),
                    right: _buildField(
                      "Sample Type *",
                      _buildDropdown(
                        _sampleTypeItems,
                        _selectedSampleType,
                        (v) => setState(() => _selectedSampleType = v),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRow(
                    left: _buildField(
                      "Harvest",
                      _buildTextField(_harvestController),
                    ),
                    right: _buildField(
                      "Moisture",
                      _buildTextFieldSuffix(_moistureController, "%"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRow(
                    left: _buildField(
                      "Water Activity",
                      _buildTextField(_waterActivityController),
                    ),
                    right: _buildField(
                      "Density",
                      _buildTextFieldSuffix(_densityController, "g/L"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRow(
                    left: _buildField(
                      "Crop Year",
                      _buildDropdown(
                        _cropYearItems,
                        _selectedCropYear,
                        (v) => setState(() => _selectedCropYear = v),
                      ),
                    ),
                    right: _buildField(
                      "Species",
                      _buildDropdown(
                        _speciesItems,
                        _selectedSpecies,
                        (v) => setState(() => _selectedSpecies = v),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRow(
                    left: _buildField(
                      "Coffee Processing",
                      _buildTextField(_processingController),
                    ),
                    right: _buildField(
                      "Country",
                      _buildDropdown(
                        _countryItems,
                        _selectedCountry,
                        (v) => setState(() => _selectedCountry = v),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Roasting color",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    "Agtron Number",
                    _buildTextField(
                      _agtronController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Roasting Level",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildRoastLevelButton("Light")),
                      const SizedBox(width: 8),
                      Expanded(child: _buildRoastLevelButton("Medium")),
                      const SizedBox(width: 8),
                      Expanded(child: _buildRoastLevelButton("Dark")),
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

  // ── Reusable Layout Widgets ────────────────────────────────────────────────

  Widget _buildRow({required Widget left, required Widget right}) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }

  Widget _buildField(String label, Widget input) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
        input,
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: _inputDecoration(),
      ),
    );
  }

  Widget _buildTextFieldSuffix(
    TextEditingController controller,
    String suffix,
  ) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        decoration: _inputDecoration().copyWith(
          suffixIcon: Center(
            widthFactor: 1,
            child: Text(
              suffix,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items:
              items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildRoastLevelButton(String level) {
    final bool isSelected = _selectedRoastLevel == level;
    return GestureDetector(
      onTap: () => setState(() => _selectedRoastLevel = level),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor2 : Colors.white,
          border: Border.all(color: secondaryColor2),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            level,
            style: TextStyle(
              color:
                  isSelected ? Colors.white : secondaryColor2,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Color(0xFFC67C4E), width: 1.5),
      ),
    );
  }

  // ── Bottom Button — returns SampleModel ───────────────────────────────────
  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            // Validate required fields
            if (_nameController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter Sample Name')),
              );
              return;
            }
            if (_selectedSampleType == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select Sample Type')),
              );
              return;
            }

            // Build SampleModel and return it
            final result = SampleModel(
              name: _nameController.text.trim(),
              type: _selectedSampleType!,
              species: _selectedSpecies ?? '',
              country: _selectedCountry ?? '',
              roastLevel: _selectedRoastLevel,
              harvest: _harvestController.text.trim(),
              moisture: _moistureController.text.trim(),
              waterActivity: _waterActivityController.text.trim(),
              density: _densityController.text.trim(),
              processing: _processingController.text.trim(),
              agtronNumber: _agtronController.text.trim(),
              cropYear: _selectedCropYear,
            );

            Navigator.pop(context, result);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Text(
            "Save",
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