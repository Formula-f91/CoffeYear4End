// add_cupping_session_screen.dart
import 'dart:io';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/createcupping/sampleinfo.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// ignore: non_constant_identifier_names
final Color secondaryColor2 = const Color(0xFFC67C4E);

class AddCoffeeInfoPage extends StatefulWidget {
  const AddCoffeeInfoPage({super.key});

  @override
  State<AddCoffeeInfoPage> createState() => _AddCoffeeInfoPageState();
}

class _AddCoffeeInfoPageState extends State<AddCoffeeInfoPage> {
  // ── Controllers ───────────────────────────────────────────────────────────
  final TextEditingController _cuppingNameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // ── State ─────────────────────────────────────────────────────────────────
  int _selectedSampleIdStructure = 0;
  int? _selectedCuppingModeId;
  bool _isSubmitting = false;

  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  File? _pickedImageFile;

  // ── Samples ───────────────────────────────────────────────────────────────
  List<SampleModel> _samples = [];

  final List<Map<String, dynamic>> _mockModes = [
    {'id': 1, 'name': 'Descriptive'},
    {'id': 2, 'name': 'Affective'},
    {'id': 3, 'name': 'Combined'},
    {'id': 4, 'name': 'Quick Mode'},
  ];

  @override
  void dispose() {
    _cuppingNameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _formatDate(DateTime? date) {
    if (date == null) return "DD/MM/YYYY";
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return "HH:MM";
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _selectDate(
    BuildContext context, {
    required bool isStart,
  }) async {
    final initial = isStart
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: secondaryColor2,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => isStart ? _startDate = picked : _endDate = picked);
    }
  }

  Future<void> _selectTime(
    BuildContext context, {
    required bool isStart,
  }) async {
    final initial = isStart
        ? (_startTime ?? TimeOfDay.now())
        : (_endTime ?? TimeOfDay.now());
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: secondaryColor2),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => isStart ? _startTime = picked : _endTime = picked);
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) setState(() => _pickedImageFile = File(picked.path));
  }

  // ── Confirm — build SessionModel and pop ──────────────────────────────────
  void _onConfirm() {
    if (_cuppingNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Cupping Name')),
      );
      return;
    }
    if (_selectedCuppingModeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a Cupping Mode')),
      );
      return;
    }
    if (_samples.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least 1 sample')),
      );
      return;
    }

    final modeName = _mockModes.firstWhere(
      (m) => m['id'] == _selectedCuppingModeId,
    )['name'] as String;

    final session = SessionModel(
      cuppingName: _cuppingNameController.text.trim(),
      description: _descController.text.trim(),
      cuppingMode: modeName,
      imagePath: _pickedImageFile?.path,
      samples: List.unmodifiable(_samples),
      createdAt: DateTime.now(),
    );

    Navigator.pop(context, session);
  }

  // ── Build ─────────────────────────────────────────────────────────────────

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
          "Add Cupping Session",
          style: TextStyle(
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

      // ── Bottom Confirm Button ──────────────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cupping Name ────────────────────────────────────────────
            _buildLabel("Cupping Name"),
            _buildTextField(controller: _cuppingNameController),
            const SizedBox(height: 16),

            // ── Upload ──────────────────────────────────────────────────
            _buildLabel("Upload Cupping Activity"),
            _buildUploadBox(),
            const SizedBox(height: 16),

            // ── Description ─────────────────────────────────────────────
            _buildLabel("Cupping Activity Description"),
            _buildTextArea(controller: _descController),
            const SizedBox(height: 16),

            // ── Cupping Mode ─────────────────────────────────────────────
            _buildLabel("Choose cupping mode (set by host)"),
            _buildDropdown(),
            const SizedBox(height: 16),

            // ── Sample ID Structure ──────────────────────────────────────
            _buildLabel("Sample Id Structure"),
            Row(
              children: [
                _buildSampleIdOption(0, "Number (1,2,3..)"),
                _buildSampleIdOption(1, "3 Digit (i.e. 257)"),
                _buildSampleIdOption(2, "Letter (i.e. A,B)"),
              ],
            ),
            const SizedBox(height: 16),

            // ── Coffee Samples (read-only summary) ──────────────────────
            _buildLabel("Coffee Sample"),
            if (_samples.isNotEmpty) ...[
              ..._samples.asMap().entries.map(
                (entry) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade50,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${entry.key + 1}.  ${entry.value.name}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${entry.value.type}  •  ${entry.value.roastLevel}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            setState(() => _samples.removeAt(entry.key)),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red.shade300,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],

            // ── Add Sample Button ────────────────────────────────────────
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push<List<SampleModel>>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SampleInfoPage(),
                      ),
                    );
                    if (result != null && result.isNotEmpty) {
                      setState(() => _samples = result);
                    }
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: secondaryColor2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _samples.isEmpty
                      ? "Add samples"
                      : "${_samples.length} sample${_samples.length != 1 ? 's' : ''} added",
                  style: TextStyle(
                    fontSize: 13,
                    color: _samples.isEmpty ? Colors.grey[400] : secondaryColor2,
                    fontWeight: _samples.isEmpty
                        ? FontWeight.normal
                        : FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ── Reusable Widgets ──────────────────────────────────────────────────────

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
    ),
  );

  Widget _buildTextField({
    TextEditingController? controller,
    String? hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeBox(
    String text,
    String iconPath, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
              color: Colors.grey.shade600,
              errorBuilder: (_, __, ___) => Icon(
                iconPath.contains('calendar')
                    ? Icons.calendar_today
                    : Icons.access_time,
                size: 18,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextArea({required TextEditingController controller}) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            maxLength: 200,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 30),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 12,
          child: Text(
            "${controller.text.length}/200",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade50,
        ),
        child: _pickedImageFile != null
            ? Image.file(_pickedImageFile!, fit: BoxFit.cover)
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Tap to upload image",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedCuppingModeId,
          hint: Text(
            "Select mode",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: _mockModes
              .map(
                (item) => DropdownMenuItem<int>(
                  value: item['id'] as int,
                  child: Text(
                    item['name'] as String,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              )
              .toList(),
          onChanged: (val) => setState(() => _selectedCuppingModeId = val),
        ),
      ),
    );
  }

  Widget _buildSampleIdOption(int index, String text) {
    bool isSelected = _selectedSampleIdStructure == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedSampleIdStructure = index),
        child: Container(
          margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? secondaryColor2 : Colors.white,
            border: Border.all(
              color: isSelected ? secondaryColor2 : Colors.grey.shade400,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}