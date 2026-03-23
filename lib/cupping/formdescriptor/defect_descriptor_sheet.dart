// lib/cupping/widgets/defect_descriptor_sheet.dart

import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class DefectDescriptorData {
  static const List<Map<String, dynamic>> defects = [
    {
      'label': 'Sweaty', 'color': Color(0xFFCED689),
      'subDescriptors': [{'label': 'Butyric acid'}, {'label': 'Soapy'}, {'label': 'Lactic'}],
    },
    {
      'label': 'Hidy', 'color': Color(0xFF66BB6A),
      'subDescriptors': [{'label': 'Tallowy'}, {'label': 'Leather like'}, {'label': 'Wet wool'}],
    },
    {
      'label': 'Horsey', 'color': Color(0xFF01A59C),
      'subDescriptors': [{'label': 'Hircine'}, {'label': 'Cooked beef'}, {'label': 'Gamey'}],
    },
    {
      'label': 'Fermented', 'color': Color(0xFF2DABA4),
      'subDescriptors': [{'label': 'Coffee pulp'}, {'label': 'Acerbic'}, {'label': 'Leesy'}],
    },
    {
      'label': 'Riovy', 'color': Color(0xFF029DDF),
      'subDescriptors': [{'label': 'lodine'}, {'label': 'Carbolic'}, {'label': 'Acrid'}],
    },
    {
      'label': 'Tipped', 'color': Color(0xFFE79472),
      'subDescriptors': [{'label': 'Cereal like'}, {'label': 'Biscuity'}, {'label': 'Skunky'}],
    },
    {
      'label': 'Grassy', 'color': Color(0xFF9C8AB4),
      'subDescriptors': [{'label': 'Green'}, {'label': 'Hay'}, {'label': 'Strawy'}],
    },
    {
      'label': 'Aged', 'color': Color(0xFFB181AB),
      'subDescriptors': [{'label': 'Full'}, {'label': 'Rounded'}, {'label': 'Smooth'}],
    },
    {
      'label': 'Woody', 'color': Color(0xFF9E6F9D),
      'subDescriptors': [{'label': 'Wet paper'}, {'label': 'Wet cardboard'}, {'label': 'Filter pad'}],
    },
    {
      'label': 'Baked', 'color': Color(0xFFB02964),
      'subDescriptors': [{'label': 'Dull'}, {'label': 'Flat'}, {'label': 'Bakey'}],
    },
    {
      'label': 'Scorched', 'color': Color(0xFFB02964),
      'subDescriptors': [{'label': 'Cooked'}, {'label': 'Charred'}, {'label': 'Empyreumatic'}],
    },
    {
      'label': 'Rubbery', 'color': Color(0xFF0193CF),
      'subDescriptors': [{'label': 'Butyl phenol'}, {'label': 'Kerosene'}, {'label': 'Ethanol'}],
    },
    {
      'label': 'Baggy', 'color': Color(0xFFEDB383),
      'subDescriptors': [{'label': 'Carvacrol'}, {'label': 'Fatty'}, {'label': 'Mineral oil'}],
    },
    {
      'label': 'Moldy', 'color': Color(0xFFEFC27E),
      'subDescriptors': [{'label': 'Yeasty'}, {'label': 'Starchy'}, {'label': 'Cappy'}],
    },
    {
      'label': 'Musty', 'color': Color(0xFFF5D87C),
      'subDescriptors': [{'label': 'Concrete'}, {'label': 'Mildewy'}, {'label': 'Mulch like'}, {'label': 'Petrichor'}],
    },
    {
      'label': 'Dirty', 'color': Color(0xFFF5D87C),
      'subDescriptors': [{'label': 'Dusty'}, {'label': 'Grady'}, {'label': 'Barny'}],
    },
    {
      'label': 'Groundy', 'color': Color(0xFFFFDF46),
      'subDescriptors': [{'label': 'Mushroom'}, {'label': 'Raw potato'}, {'label': 'Erpsig'}],
    },
    {
      'label': 'Earthy', 'color': Color(0xFFF1E47C),
      'subDescriptors': [{'label': 'Fresh earth'}, {'label': 'Wet soil'}, {'label': 'Hummus'}],
    },
  ];
}

class DefectDescriptorSheet extends StatefulWidget {
  final List<String> initialSelected;
  final ValueChanged<List<String>> onApply;

  const DefectDescriptorSheet({
    super.key,
    required this.initialSelected,
    required this.onApply,
  });

  static Map<String, dynamic> resolveStyle(String label) {
    for (final d in DefectDescriptorData.defects) {
      if (d['label'] == label) return {'color': d['color'] as Color};
      if (d.containsKey('subDescriptors')) {
        for (final sub in d['subDescriptors'] as List<dynamic>) {
          if ((sub as Map<String, dynamic>)['label'] == label) return {'color': d['color'] as Color};
        }
      }
    }
    return {'color': Colors.grey};
  }

  @override
  State<DefectDescriptorSheet> createState() => _DefectDescriptorSheetState();
}

class _DefectDescriptorSheetState extends State<DefectDescriptorSheet> {
  // ── ของเก่าจาก combinedResult (แสดงตลอด ลบไม่ได้ในหน้านี้) ──
  late List<String> _savedFromParent;

  // ── ของที่กำลังเลือกใหม่ในรอบนี้ ──
  String? _selectedMain;
  List<String> _selectedSubs = [];

  bool _showDescriptors = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // เก็บของเก่าทั้งหมดแยกไว้ — ไม่แตะ selection state
    _savedFromParent = List.from(widget.initialSelected);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered {
    if (_searchQuery.isEmpty) return DefectDescriptorData.defects;
    return DefectDescriptorData.defects
        .where((d) => (d['label'] as String).toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // รายการที่กำลังเลือกในรอบนี้
  List<String> get _newlySelected => [
    if (_selectedMain != null) _selectedMain!,
    ..._selectedSubs,
  ];

  // รวมทั้งหมด (เก่า + ใหม่) กัน duplicate
  List<String> get _allDisplayed =>
      {..._savedFromParent, ..._newlySelected}.toList();

  void _selectMain(String label) {
    setState(() {
      if (_selectedMain == label) { _selectedMain = null; _selectedSubs.clear(); }
      else { _selectedMain = label; _selectedSubs.clear(); }
    });
  }

  void _toggleSub(String subLabel) {
    setState(() {
      if (_selectedSubs.contains(subLabel)) _selectedSubs.remove(subLabel);
      else _selectedSubs.add(subLabel);
    });
  }

  Map<String, dynamic>? _getMainData(String label) {
    try { return DefectDescriptorData.defects.firstWhere((d) => d['label'] == label); }
    catch (_) { return null; }
  }

  // chip แสดงใน Selected Descriptors — กดลบได้เฉพาะของใหม่
  Widget _buildSelectedChip(String label) {
    final style = DefectDescriptorSheet.resolveStyle(label);
    final color = style['color'] as Color;
    final bool isSaved = _savedFromParent.contains(label); // ของเก่า = ลบไม่ได้

    return GestureDetector(
      onTap: isSaved ? null : () {
        setState(() {
          if (_selectedMain == label) { _selectedMain = null; _selectedSubs.clear(); }
          else { _selectedSubs.remove(label); }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          border: Border.all(color: color.withOpacity(0.5), width: 1.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black)),
          if (!isSaved) ...[
            const SizedBox(width: 4),
            Icon(Icons.cancel, size: 14, color: color),
          ],
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              const Text('Descriptor', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // ── Selected Descriptors: แสดงเสมอ รวมเก่า+ใหม่ ──
              const Text('Selected Descriptors', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 8),
              if (_allDisplayed.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _allDisplayed.map(_buildSelectedChip).toList(),
                ),
                const SizedBox(height: 20),
              ],

              // ── Select Descriptors ──
              const Text('Select Descriptors', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 10),

              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Find descriptor',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 14),

              Row(children: [
                Switch(value: _showDescriptors, onChanged: (v) => setState(() => _showDescriptors = v), activeColor: Colors.white, activeTrackColor: primaryColor2),
                const SizedBox(width: 8),
                const Text('Show descriptors', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ]),

              if (_showDescriptors) ...[
                const SizedBox(height: 14),
                Wrap(spacing: 8, runSpacing: 8, children: _filtered.map((d) {
                  final label = d['label'] as String;
                  final color = d['color'] as Color;
                  final isSelected = _selectedMain == label;
                  return GestureDetector(
                    onTap: () => _selectMain(label),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected ? color.withOpacity(0.15) : Colors.white,
                        border: Border.all(color: isSelected ? color: const Color(0xFF1E52C6), width: isSelected ? 0.5 : 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(label, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w600, color: Colors.black87)),
                        if (isSelected) ...[
                        const SizedBox(width: 4), 
                        Image.asset(
                          'assets/icon/plusicon.png', 
                          width: 14, 
                          height: 14, 
                          color: color
                        )
                      ],
                      ]),
                    ),
                  );
                }).toList()),

                if (_selectedMain != null)
                  Builder(builder: (_) {
                    final data = _getMainData(_selectedMain!);
                    if (data == null || !data.containsKey('subDescriptors')) return const SizedBox.shrink();
                    final color = data['color'] as Color;
                    final subs = data['subDescriptors'] as List<dynamic>;
                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const SizedBox(height: 16),
                      Row(children: [
                        Image.asset('assets/icon/downright.png', width: 20, height: 20, color: Colors.grey.shade500),
                        const Text('Descriptor of ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: color.withOpacity(0.15), border: Border.all(color: color, width: 0.5), borderRadius: BorderRadius.circular(15)),
                          child: Text(_selectedMain!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black)),
                        ),
                      ]),
                      const SizedBox(height: 10),
                      Wrap(spacing: 8, runSpacing: 8, children: subs.map((sub) {
                        final subMap = sub as Map<String, dynamic>;
                        final subLabel = subMap['label'] as String;
                        final isSubSelected = _selectedSubs.contains(subLabel);
                        return GestureDetector(
                          onTap: () => _toggleSub(subLabel),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              color: isSubSelected ? color.withOpacity(0.12) : Colors.white,
                              border: Border.all(color: isSubSelected ? color : const Color(0xFF1E52C6), width: isSubSelected ? 0.5 : 0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                            subLabel, 
                            style: TextStyle(
                              fontSize: 13, 
                              fontWeight: isSubSelected ? FontWeight.w600 : FontWeight.w600, 
                              color: isSubSelected ? Colors.black : Colors.black87 // เปลี่ยนให้เป็นสีดำ (Colors.black) เมื่อถูกเลือก
                            )
                          ),
                          ),
                        );
                      }).toList()),
                    ]);
                  }),
              ],

              const SizedBox(height: 24),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => widget.onApply(_allDisplayed),
                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor2, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0),
                    child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() { _selectedMain = null; _selectedSubs.clear(); }),
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.black87, side: BorderSide(color: Colors.grey.shade400), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: const Text('Reset', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}