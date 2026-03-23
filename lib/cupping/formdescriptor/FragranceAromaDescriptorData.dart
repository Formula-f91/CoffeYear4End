// lib/cupping/widgets/fragrance_aroma_descriptor_sheet.dart

import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class FragranceAromaDescriptorData {
  static const List<Map<String, dynamic>> descriptors = [
    {'label': 'Floral', 'subDescriptors': <String>[]},
    {
      'label': 'Fruity',
      'subDescriptors': ['Berry', 'Dried Fruit', 'Citrus Fruit'],
    },
    {
      'label': 'Roasted',
      'subDescriptors': ['Cereal', 'Burnt', 'Tobacco'],
    },
    {
      'label': 'Nutty/Cocoa',
      'subDescriptors': ['Nutty', 'Cocoa'],
    },
    {
      'label': 'Other',
      'subDescriptors': ['Chemical', 'Musty/Earthy', 'Woody'],
    },
    {
      'label': 'Sour/Fermented',
      'subDescriptors': ['Sour', 'Fermented'],
    },
    {'label': 'Spice', 'subDescriptors': <String>[]},
    {'label': 'Green/Vegetative', 'subDescriptors': <String>[]},
    {
      'label': 'Sweet',
      'subDescriptors': ['Vanilla/Vanillin', 'Brown Sugar'],
    },
  ];

  static List<String>? getSubDescriptors(String label) {
    for (final d in descriptors) {
      if (d['label'] == label) {
        return List<String>.from(d['subDescriptors'] as List);
      }
    }
    return null;
  }
}

class FragranceAromaDescriptorSheet extends StatefulWidget {
  final List<String> initialSelected;
  final ValueChanged<List<String>> onApply;
  final String subtitle;

  const FragranceAromaDescriptorSheet({
    super.key,
    required this.initialSelected,
    required this.onApply,
    this.subtitle = 'Fragrance / Aroma Descriptors',
  });

  static Map<String, dynamic> resolveStyle(String label) {
    return {'image': null, 'color': const Color(0xFF1E52C6)};
  }

  @override
  State<FragranceAromaDescriptorSheet> createState() =>
      _FragranceAromaDescriptorSheetState();
}

class _FragranceAromaDescriptorSheetState
    extends State<FragranceAromaDescriptorSheet> {
  // descriptors หลักที่ถูก active (แสดง header chip + ⊕ icon)
  late List<String> _selected;

  // descriptor ที่กำลัง expand เพื่อแสดง sub-descriptors
  String? _expandedDescriptor;

  // sub-descriptors ที่เลือก
  final List<String> _selectedSubs = [];

  static const Color _blue = Color(0xFF1E52C6);
  

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.initialSelected);
  }

  // กด chip ใน Selected Descriptors row
  void _tapMainDescriptor(String label) {
    setState(() {
      if (_expandedDescriptor == label) {
        // กดซ้ำ = collapse แต่ยังคงเลือกอยู่
        _expandedDescriptor = null;
      } else {
        _expandedDescriptor = label;
        // เพิ่มเข้า selected ถ้ายังไม่มี
        if (!_selected.contains(label)) {
          _selected.add(label);
        }
      }
    });
  }

  // ลบ active chip ด้านบน
  void _removeSelected(String label) {
    setState(() {
      _selected.remove(label);
      if (_expandedDescriptor == label) _expandedDescriptor = null;
    });
  }

  // toggle sub-descriptor
  void _toggleSub(String sub) {
    setState(() {
      if (_selectedSubs.contains(sub)) {
        _selectedSubs.remove(sub);
      } else {
        _selectedSubs.add(sub);
      }
    });
  }

  void _onApply() {
    final combined = [..._selected, ..._selectedSubs];
    widget.onApply(combined);
  }

  void _onReset() {
    setState(() {
      _selected.clear();
      _selectedSubs.clear();
      _expandedDescriptor = null;
    });
  }

  // ── chip ด้านบน (active พร้อมไอคอน ✕ วงกลมสีน้ำเงิน) ──
  Widget _buildActiveHeaderChip(String label) {
    final isActive = _expandedDescriptor == label;
    return GestureDetector(
      onTap: () => _removeSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? _blue.withOpacity(0.12) : Colors.white,
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

  // ── chip ใน "Selected Descriptors" row ──
  // - ถ้า active (expanded) → border น้ำเงิน + ไอคอน plus asset
  // - ถ้าไม่ active → border เทา ปกติ
  Widget _buildSelectedRowChip(String label) {
    final isActive = _expandedDescriptor == label;

    return GestureDetector(
      onTap: () => _tapMainDescriptor(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? _blue.withOpacity(0.12) : Colors.white,
          border: Border.all(
            color: isActive ? _blue : Colors.grey.shade400,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w400 : FontWeight.normal,
                color: Colors.black87,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 4),
              Image.asset(
                'assets/icon/plusicon.png',
                width: 14,
                height: 14,
                color: Color(0xFF1E52C6),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── sub-descriptor chip ──
  Widget _buildSubChip(String sub) {
    final isSelected = _selectedSubs.contains(sub);

    return GestureDetector(
      onTap: () => _toggleSub(sub),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? _blue.withOpacity(0.12) : Colors.white,
          border: Border.all(
            color: isSelected ? _blue : Colors.grey.shade400,
            width: isSelected ? 0.5 : 0.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          sub,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w400 : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subs = _expandedDescriptor != null
        ? FragranceAromaDescriptorData.getSubDescriptors(_expandedDescriptor!)
        : null;

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
              // ── Handle bar ──
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

              // ── Title ──
              const Text(
                'Descriptors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),

              // ── Subtitle ──
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // ── Active header chips ──
              if (_selected.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selected.map(_buildActiveHeaderChip).toList(),
                ),
                const SizedBox(height: 10),
              ],

              // ── Orange divider ──
              const SizedBox(height: 16),

              // ── Selected Descriptors label ──
              const Text(
                'Selected Descriptors',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // ── All descriptor chips ──
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: FragranceAromaDescriptorData.descriptors
                    .map((d) => _buildSelectedRowChip(d['label'] as String))
                    .toList(),
              ),

              // ── Descriptor of [X] sub-section ──
              if (_expandedDescriptor != null &&
                  subs != null &&
                  subs.isNotEmpty) ...[
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.subdirectory_arrow_right,
                      color: Colors.grey.shade400,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Descriptor of',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _blue.withOpacity(0.08),
                        border: Border.all(color: _blue.withOpacity(0.35)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _expandedDescriptor!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: subs.map(_buildSubChip).toList(),
                  ),
                ),
              ],

              const SizedBox(height: 28),

              // ── Buttons ──
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
