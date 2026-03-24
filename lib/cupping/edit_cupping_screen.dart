import 'dart:io';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/createcupping/sampleinfo.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const Color deleteColor = Color(0xFFFF5252);

class EditCuppingScreen extends StatefulWidget {
  final SessionModel session; // รับ session เดิมมาแก้ไข

  const EditCuppingScreen({super.key, required this.session});

  @override
  State<EditCuppingScreen> createState() => _EditCuppingScreenState();
}

class _EditCuppingScreenState extends State<EditCuppingScreen> {
  late final TextEditingController _cuppingNameController;
  late final TextEditingController _descriptionController;

  File? _pickedImageFile;

  // Samples list — เริ่มจากข้อมูลเดิม
  late List<SampleModel> _samples;

  final List<Map<String, dynamic>> _mockModes = [
    {'id': 1, 'name': 'Descriptive'},
    {'id': 2, 'name': 'Affective'},
    {'id': 3, 'name': 'Combined'},
    {'id': 4, 'name': 'Quick Mode'},
    {'id': 5, 'name': 'Quick Mode 2'},
  ];

  int? _selectedCuppingModeId;

  @override
  void initState() {
    super.initState();
    // โหลดข้อมูลเดิมจาก session
    _cuppingNameController =
        TextEditingController(text: widget.session.cuppingName);
    _descriptionController =
        TextEditingController(text: widget.session.description);
    _samples = List.from(widget.session.samples);

    // หา id ของ mode เดิม
    final existingMode = _mockModes.firstWhere(
      (m) => m['name'] == widget.session.cuppingMode,
      orElse: () => _mockModes.first,
    );
    _selectedCuppingModeId = existingMode['id'] as int;

    // โหลดรูปเดิม (ถ้ามี)
    if (widget.session.imagePath != null) {
      _pickedImageFile = File(widget.session.imagePath!);
    }
  }

  @override
  void dispose() {
    _cuppingNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ── Pick image ─────────────────────────────────────────────────────────────
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _pickedImageFile = File(picked.path));
    }
  }

  // ── Delete dialog ──────────────────────────────────────────────────────────
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Delete",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, thickness: 1, color: Colors.black12),
                const SizedBox(height: 30),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: deleteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/deletevec.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Are you sure you want to delete this session?",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: deleteColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text("Cancel",
                            style:
                                TextStyle(color: deleteColor, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // ปิด dialog
                          // ส่ง null กลับ = ลบ session นี้
                          Navigator.pop(context, 'deleted');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: deleteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: const Text("Confirm",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16)),
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

  // ── Confirm — build updated SessionModel and pop ───────────────────────────
  void _onConfirm() {
    if (_cuppingNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Cupping Name')),
      );
      return;
    }

    final modeName = _mockModes.firstWhere(
      (m) => m['id'] == _selectedCuppingModeId,
      orElse: () => {'name': 'N/A'},
    )['name'] as String;

    final updated = SessionModel(
      cuppingName: _cuppingNameController.text.trim(),
      description: _descriptionController.text.trim(),
      cuppingMode: modeName,
      imagePath:
          _pickedImageFile?.path ?? widget.session.imagePath,
      samples: List.unmodifiable(_samples),
      createdAt: widget.session.createdAt, // คงวันที่สร้างเดิมไว้
    );

    Navigator.pop(context, updated); // ส่ง SessionModel ที่แก้แล้วกลับ
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Cupping",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              border:
                  Border(top: BorderSide(color: Colors.grey, width: 1)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: _showDeleteDialog,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                    ),
                    child: const Text("Delete",
                        style:
                            TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _onConfirm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: secondaryColor2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
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
            const SizedBox(height: 8),
            _buildTextField(_cuppingNameController),
            const SizedBox(height: 20),

            // ── Image ────────────────────────────────────────────────────
            _buildLabel("Image"),
            const SizedBox(height: 8),
            _buildImageSection(),
            const SizedBox(height: 20),

            // ── Cupping Mode ─────────────────────────────────────────────
            _buildLabel("Choose cupping mode"),
            const SizedBox(height: 8),
            _buildDropdown(),
            const SizedBox(height: 20),

            // ── Description ──────────────────────────────────────────────
            _buildLabel("Cupping Activity Description"),
            const SizedBox(height: 8),
            _buildTextArea(_descriptionController),
            const SizedBox(height: 20),

            // ── Coffee Samples ────────────────────────────────────────────
            _buildLabel("Coffee Sample"),
            const SizedBox(height: 8),

            // แสดงรายการ sample ปัจจุบัน
            ..._samples.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildCoffeeSampleItem(
                    entry.key, entry.value),
              ),
            ),

            // ── Add / Edit samples button ─────────────────────────────────
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                // เปิด SampleInfoPage พร้อมข้อมูลเดิม
                final result =
                    await Navigator.push<List<SampleModel>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SampleInfoPage(
                      initialSamples: _samples,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() => _samples = result);
                }
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: secondaryColor2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),

            if (_samples.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "${_samples.length} sample${_samples.length != 1 ? 's' : ''}",
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey[500]),
                ),
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ── Image section ──────────────────────────────────────────────────────────
  Widget _buildImageSection() {
    return Row(
      children: [
        // ปุ่มเพิ่มรูปใหม่
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.add_circle_outline,
                color: Colors.grey.shade600),
          ),
        ),
        const SizedBox(width: 12),
        // รูปปัจจุบัน
        if (_pickedImageFile != null)
          GestureDetector(
            onTap: () => _showImageOptionsSheet(),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: secondaryColor2, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.file(
                  _pickedImageFile!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ── Sample item row ────────────────────────────────────────────────────────
  Widget _buildCoffeeSampleItem(int index, SampleModel sample) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}.  ${sample.name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text(
                        "${sample.type}  •  ${sample.roastLevel}",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        // ปุ่มลบ sample
        GestureDetector(
          onTap: () => setState(() => _samples.removeAt(index)),
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: deleteColor,
            ),
            child: Center(
              child: Image.asset(
                'assets/icon/fi_trash.png',
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Reusable widgets ───────────────────────────────────────────────────────

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black87),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: secondaryColor2, width: 2),
        ),
      ),
    );
  }

  Widget _buildTextArea(TextEditingController controller) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            maxLength: 200,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.fromLTRB(12, 12, 12, 28),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 12,
          child: Text(
            "${controller.text.length}/200",
            style: TextStyle(
                color: Colors.grey.shade400, fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedCuppingModeId,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Colors.grey),
          items: _mockModes
              .map(
                (item) => DropdownMenuItem<int>(
                  value: item['id'] as int,
                  child: Text(item['name'] as String,
                      style: const TextStyle(fontSize: 13)),
                ),
              )
              .toList(),
          onChanged: (val) =>
              setState(() => _selectedCuppingModeId = val),
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
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(20, 16, 12, 8),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Image options",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 28, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              _buildSheetItem(
                icon: Icons.visibility_outlined,
                label: "View image",
                onTap: () => Navigator.pop(context),
              ),
              _buildSheetItem(
                icon: Icons.upload_outlined,
                label: "Change image",
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              _buildSheetItem(
                icon: Icons.delete_outline,
                label: "Delete",
                labelColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _pickedImageFile = null);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSheetItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color labelColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24, color: labelColor),
      title: Text(
        label,
        style: TextStyle(
            color: labelColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}