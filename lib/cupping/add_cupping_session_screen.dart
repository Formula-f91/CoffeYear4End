// add_cupping_session_screen.dart
import 'dart:io';
import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddCoffeeInfoPage extends StatefulWidget {
  const AddCoffeeInfoPage({super.key});

  @override
  State<AddCoffeeInfoPage> createState() => _AddCoffeeInfoPageState();
}

class _AddCoffeeInfoPageState extends State<AddCoffeeInfoPage> {
  // ── Controllers ───────────────────────────────────────────────────────────
  final TextEditingController _cuppingNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _participantLimitController =
      TextEditingController();
  final TextEditingController _participationFeeController =
      TextEditingController();

  // ── State ─────────────────────────────────────────────────────────────────
  bool _hasParticipationFee = false;
  int _selectedSampleIdStructure = 0;
  int? _selectedCuppingModeId;
  bool _isSubmitting = false;

  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  File? _pickedImageFile;

  // ── Sample list (ชื่อ String ธรรมดา ไม่ผูก model) ─────────────────────────
  final List<String> _sampleNames = [];

  final List<Map<String, dynamic>> _mockModes = [
    {'id': 1, 'name': 'Descriptive'},
    {'id': 2, 'name': 'Affective'},
    {'id': 3, 'name': 'Combined'},
    {'id': 4, 'name': 'Quick Mode'},
    {'id': 5, 'name': 'Quick Mode 2'},
  ];

  @override
  void dispose() {
    _cuppingNameController.dispose();
    _locationController.dispose();
    _descController.dispose();
    _participantLimitController.dispose();
    _participationFeeController.dispose();
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
    if (picked != null)
      setState(() => isStart ? _startDate = picked : _endDate = picked);
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
        data: Theme.of(
          context,
        ).copyWith(colorScheme: ColorScheme.light(primary: secondaryColor2)),
        child: child!,
      ),
    );
    if (picked != null)
      setState(() => isStart ? _startTime = picked : _endTime = picked);
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) setState(() => _pickedImageFile = File(picked.path));
  }

  void _onConfirm() {
    if (_cuppingNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Cupping Name')),
      );
      return;
    }
    // TODO: เชื่อม Firebase ที่นี่
    Navigator.pop(context);
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
      // ── Bottom Button ──
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
            // ── Cupping Name ──
            _buildLabel("Cupping Name"),
            _buildTextField(controller: _cuppingNameController),
            const SizedBox(height: 16),

            // ── Participant Limit ──
            // _buildLabel("Participant Limit"),
            // _buildTextField(
            //   controller: _participantLimitController,
            //   keyboardType: TextInputType.number,
            //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            // ),
            // const SizedBox(height: 16),

            // // ── Participation Fee ──
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     _buildLabel("Participation Fee"),
            //     Switch(
            //       value: _hasParticipationFee,
            //       activeColor: secondaryColor2,
            //       onChanged: (v) => setState(() {
            //         _hasParticipationFee = v;
            //         if (!v) _participationFeeController.clear();
            //       }),
            //     ),
            //   ],
            // ),
            // if (_hasParticipationFee) ...[
            //   _buildTextField(
            //     controller: _participationFeeController,
            //     keyboardType: TextInputType.number,
            //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //   ),
            //   const SizedBox(height: 8),
            // ],
            const SizedBox(height: 8),

            // ── Upload ──
            _buildLabel("Upload Cupping Activity"),
            _buildUploadBox(),
            const SizedBox(height: 16),

            // // ── Start Date & Time ──
            // _buildLabel("Start Date & Time"),
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildDateTimeBox(
            //         _formatDate(_startDate),
            //         'assets/icon/calendar.png',
            //         onTap: () => _selectDate(context, isStart: true),
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _buildDateTimeBox(
            //         _formatTime(_startTime),
            //         'assets/icon/time.png',
            //         onTap: () => _selectTime(context, isStart: true),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 16),

            // // ── End Date & Time ──
            // _buildLabel("End Date & Time"),
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildDateTimeBox(
            //         _formatDate(_endDate),
            //         'assets/icon/calendar.png',
            //         onTap: () => _selectDate(context, isStart: false),
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _buildDateTimeBox(
            //         _formatTime(_endTime),
            //         'assets/icon/time.png',
            //         onTap: () => _selectTime(context, isStart: false),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 16),

            // // ── Location ──
            // _buildLabel("Location"),
            // _buildTextArea(controller: _locationController),
            // const SizedBox(height: 8),
            // _buildMapButton(),
            // const SizedBox(height: 16),

            // ── Description ──
            _buildLabel("Cupping Activity Description"),
            _buildTextArea(controller: _descController),
            const SizedBox(height: 16),

            // ── Cupping Mode ──
            _buildLabel("Choose cupping mode (set by host)"),
            _buildDropdown(),
            const SizedBox(height: 16),

            // ── Sample ID Structure ──
            _buildLabel("Sample Id Structure"),
            Row(
              children: [
                _buildSampleIdOption(0, "Number (1,2,3..)"),
                _buildSampleIdOption(1, "3 Digit (i.e. 257)"),
                _buildSampleIdOption(2, "Letter (i.e. A,B)"),
              ],
            ),
            const SizedBox(height: 16),

            // ── Coffee Sample ──
            _buildLabel("Coffee Sample"),
            ..._sampleNames.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            entry.value,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () =>
                          setState(() => _sampleNames.removeAt(entry.key)),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF5350),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Add Sample Button ──
            GestureDetector(
              onTap: () {
                // TODO: เปิดหน้า SampleInfoPage
                setState(
                  () => _sampleNames.add("Sample #${_sampleNames.length + 1}"),
                );
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
                child: Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
              ),
      ),
    );
  }

  Widget _buildMapButton() {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          /* TODO: MapLocationPicker */
        },
        icon: const Icon(Icons.location_on, size: 18, color: Colors.white),
        label: const Text("Select Location on Map"),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          side: BorderSide(color: secondaryColor2),
          foregroundColor: Colors.white,
          backgroundColor: secondaryColor2,
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
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
