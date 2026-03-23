// lib/cupping/formdescriptor/main_tastes_descriptor_sheet.dart

import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class MainTastesDescriptorSheet extends StatefulWidget {
  final List<String> initialSelected;
  final ValueChanged<List<String>> onApply;

  const MainTastesDescriptorSheet({
    super.key,
    required this.initialSelected,
    required this.onApply,
  });

  static const int maxSelection = 2;

  static const List<String> tastes = [
    'Salty',
    'Sour',
    'Sweet',
    'Bitter',
    'Umami',
  ];

  static Map<String, dynamic> resolveStyle(String label) {
    return {'image': null, 'color': const Color(0xFF1E52C6)};
  }

  @override
  State<MainTastesDescriptorSheet> createState() =>
      _MainTastesDescriptorSheetState();
}

class _MainTastesDescriptorSheetState extends State<MainTastesDescriptorSheet> {
  late List<String> _selected;

  static const Color _blue = Color(0xFF1E52C6);
  

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.initialSelected);
  }

  void _toggleTaste(String label) {
    setState(() {
      if (_selected.contains(label)) {
        _selected.remove(label);
      } else {
        if (_selected.length < MainTastesDescriptorSheet.maxSelection) {
          _selected.add(label);
        }
        // ถ้าเลือกครบ 2 แล้วไม่ทำอะไร
      }
    });
  }

  void _removeSelected(String label) {
    setState(() => _selected.remove(label));
  }

  void _onApply() {
    widget.onApply(List.from(_selected));
  }

  void _onReset() {
    setState(() => _selected.clear());
  }

  // chip ด้านบน (active พร้อม ✕)
  Widget _buildActiveHeaderChip(String label) {
    final isSelected = _selected.contains(label);
    return GestureDetector(
      onTap: () => _removeSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _blue.withOpacity(0.12) : Colors.white,
          border: Border.all(color: _blue, width: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: _blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 10, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // chip ตัวเลือก
  Widget _buildTasteChip(String label) {
    final isSelected = _selected.contains(label);
    final isDisabled =
        !isSelected &&
        _selected.length >= MainTastesDescriptorSheet.maxSelection;

    return GestureDetector(
      onTap: isDisabled ? null : () => _toggleTaste(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? _blue.withOpacity(0.12) : Colors.white,
          border: Border.all(
            color: isDisabled
                ? Colors.grey.shade300
                : isSelected
                ? _blue
                : Colors.grey.shade400,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: isDisabled ? Colors.grey.shade400 : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Descriptors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),

              // Subtitle
              const Text(
                'Main Tastes (select up to 2)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Active header chips
              if (_selected.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selected.map(_buildActiveHeaderChip).toList(),
                ),
                const SizedBox(height: 10),
              ],

              const SizedBox(height: 10),

              // Selected Descriptors label
              const Text(
                'Selected Descriptors',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // Taste chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: MainTastesDescriptorSheet.tastes
                    .map(_buildTasteChip)
                    .toList(),
              ),

              const SizedBox(height: 28),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor2,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _onReset,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _blue,
                        side: const BorderSide(color: _blue),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
