// lib/cupping/widgets/flavor_descriptor_sheet.dart

import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

class FlavorDescriptorData {
  static const List<Map<String, dynamic>> mainDescriptors = [
    {
      'label': 'Floral', 'image': 'assets/floral/floral.png', 'color': Color(0xFFFFCC00),
      'subDescriptors': [
        {'label': 'Hibiscus', 'image': 'assets/floral/hibiscus.png'},
        {'label': 'Roses', 'image': 'assets/floral/Roses.png'},
        {'label': 'Lavender', 'image': 'assets/floral/lavender.png'},
        {'label': 'Magnolia', 'image': 'assets/floral/magnolia.png'},
        {'label': 'Jasmine honeysuckle', 'image': 'assets/floral/jasminehoneysuckle.png'},
        {'label': 'Orange blossom', 'image': 'assets/floral/Orange blossom.png'},
        {'label': 'Lemongrass', 'image': 'assets/floral/Lemongrass.png'},
      ],
    },
    {
      'label': 'Fruit', 'image': 'assets/fruit_f/Grapes.png', 'color': Color(0xFF9C1A5E),
      'subDescriptors': [
        {
          'label': 'Citrus', 'image': 'assets/fruit_f/Citrus.png', 'color': Color(0xFFFDD835),
          'level3': [
            {'label': 'Lemon', 'image': 'assets/fruit_f/Lemon.png'},
            {'label': 'Lime', 'image': 'assets/fruit_f/Lime.png'},
            {'label': 'Grapefruit', 'image': 'assets/fruit_f/Grapefruit.png'},
            {'label': 'Clementine', 'image': 'assets/fruit_f/Clementine.png'},
            {'label': 'Tangerine', 'image': 'assets/fruit_f/Tangerine.png'},
            {'label': 'Mandarin', 'image': 'assets/fruit_f/mandarin.png'},
            {'label': 'Orange', 'image': 'assets/fruit_f/Orange.png'},
          ],
        },
        {
          'label': 'Apple/pear', 'image': 'assets/fruit_f/apple.png', 'color': Color(0xFFB3CD31),
          'level3': [
            {'label': 'Green apple', 'image': 'assets/fruit_f/greenapple.png'},
            {'label': 'Red apple', 'image': 'assets/fruit_f/redapple.png'},
          ],
        },
        {
          'label': 'Melon', 'image': 'assets/fruit_f/melon.png', 'color': Color(0xFF6EC140),
          'level3': [
            {'label': 'Watermelon', 'image': 'assets/fruit_f/watermelon.png'},
            {'label': 'Honeydew', 'image': 'assets/fruit_f/honeydew.png'},
            {'label': 'Cantaloupe', 'image': 'assets/fruit_f/cantaloupe.png'},
          ],
        },
        {
          'label': 'Grape', 'image': 'assets/fruit_f/Grapes.png', 'color': Color(0xFF3C2048),
          'level3': [
            {'label': 'White grape', 'image': 'assets/fruit_f/whitegrape.png'},
            {'label': 'Green grape', 'image': 'assets/fruit_f/greengrape.png'},
            {'label': 'Concord grape', 'image': 'assets/fruit_f/Grapes.png'},
            {'label': 'Red grape', 'image': 'assets/fruit_f/redgrape.png'},
          ],
        },
        {
          'label': 'Tropical Fruit', 'image': 'assets/fruit_f/tropical.png', 'color': Color(0xFFF7F26C),
          'level3': [
            {'label': 'Lychee fruit', 'image': 'assets/fruit_f/lychee.png'},
            {'label': 'Star Fruit', 'image': 'assets/fruit_f/starfruit.png'},
            {'label': 'Tamarind', 'image': 'assets/fruit_f/tamarind.png'},
            {'label': 'Passion fruit', 'image': 'assets/fruit_f/passionfruit.png'},
            {'label': 'Mango', 'image': 'assets/fruit_f/mango.png'},
            {'label': 'Papaya', 'image': 'assets/fruit_f/papaya.png'},
            {'label': 'Kiwi', 'image': 'assets/fruit_f/kiwi.png'},
            {'label': 'Banana', 'image': 'assets/fruit_f/banana.png'},
            {'label': 'Coconut', 'image': 'assets/fruit_f/coconut.png'},
            {'label': 'Pineapple', 'image': 'assets/fruit_f/pineapple.png'},
          ],
        },
        {
          'label': 'Stone Fruit', 'image': 'assets/fruit_f/stonefruit.png', 'color': Color(0xFFF79769),
          'level3': [
            {'label': 'Peach', 'image': 'assets/fruit_f/peach.png'},
            {'label': 'Nectarine', 'image': 'assets/fruit_f/nectarine.png'},
            {'label': 'Apricot', 'image': 'assets/fruit_f/apricot.png'},
            {'label': 'Plum', 'image': 'assets/fruit_f/plum.png'},
            {'label': 'Cherry', 'image': 'assets/fruit_f/cherry.png'},
            {'label': 'Black cherry', 'image': 'assets/fruit_f/blackcherry.png'},
          ],
        },
        {
          'label': 'Berry', 'image': 'assets/fruit_f/berry.png', 'color': Color(0xFF362F5A),
          'level3': [
            {'label': 'Cranberry', 'image': 'assets/fruit_f/cranberry.png'},
            {'label': 'Rashberry', 'image': 'assets/fruit_f/rashberry.png'},
            {'label': 'Strawberry', 'image': 'assets/fruit_f/strawberry.png'},
            {'label': 'Blueberry', 'image': 'assets/fruit_f/blueberry.png'},
            {'label': 'Red currant', 'image': 'assets/fruit_f/redcurrant.png'},
            {'label': 'Black currant', 'image': 'assets/fruit_f/blackcurrant.png'},
          ],
        },
        {
          'label': 'Dry fruit', 'image': 'assets/fruit_f/dry.png', 'color': Color(0xFF3952A1),
          'level3': [
            {'label': 'Golden raisin', 'image': 'assets/fruit_f/goldenraisin.png'},
            {'label': 'Raisin', 'image': 'assets/fruit_f/raisin.png'},
            {'label': 'Dried fig', 'image': 'assets/fruit_f/driedfig.png'},
            {'label': 'Dried dates', 'image': 'assets/fruit_f/drieddates.png'},
            {'label': 'Prune', 'image': 'assets/fruit_f/prune.png'},
          ],
        },
      ],
    },
    {
      'label': 'Chocolate', 'image': 'assets/chocolate_f/Chocolate Bar.png', 'color': Color(0xFF5C3317),
      'subDescriptors': [
        {'label': 'Cacao nibs', 'image': 'assets/chocolate_f/Cocoa.png'},
        {'label': 'Dark chocolate', 'image': 'assets/chocolate_f/darkchocolate.png'},
        {'label': 'Bakers chocolate', 'image': 'assets/chocolate_f/bakerschocolate.png'},
        {'label': 'Bittersweet chocolate', 'image': 'assets/chocolate_f/bittersweet.png'},
        {'label': 'Cocoa powder', 'image': 'assets/chocolate_f/cocoa-powder.png'},
        {'label': 'Milk Chocolate', 'image': 'assets/chocolate_f/milchocolate.png'},
      ],
    },
    {
      'label': 'Sweet', 'image': 'assets/sweet_f/Honey.png', 'color': Color(0xFFFAF8A9),
      'subDescriptors': [
        {'label': 'Vanilla', 'image': 'assets/sweet_f/vanilla.png'},
        {'label': 'Nougat', 'image': 'assets/sweet_f/nougat.png'},
        {'label': 'Honey', 'image': 'assets/sweet_f/honeyv2.png'},
        {'label': 'Butter', 'image': 'assets/sweet_f/Butter.png'},
        {'label': 'Cream', 'image': 'assets/sweet_f/Whipped Cream.png'},
        {'label': 'Marshmallow', 'image': 'assets/sweet_f/Marshmallow.png'},
        {'label': 'Sugar cane', 'image': 'assets/sweet_f/Sugarcane.png'},
        {'label': 'Brown sugar', 'image': 'assets/sweet_f/brownsugar.png'},
        {'label': 'Caramel', 'image': 'assets/sweet_f/caramel.png'},
        {'label': 'Maple syrup', 'image': 'assets/sweet_f/maple.png'},
      ],
    },
    {
      'label': 'Nut', 'image': 'assets/nut_f/nuts.png', 'color': Color(0xFFFF8D28),
      'subDescriptors': [
        {'label': 'Walnut', 'image': 'assets/nut_f/walnut.png'},
        {'label': 'Peanut', 'image': 'assets/nut_f/peanut.png'},
        {'label': 'Cashew', 'image': 'assets/nut_f/cashew.png'},
        {'label': 'Pecan', 'image': 'assets/nut_f/pecan.png'},
        {'label': 'Hazelnut', 'image': 'assets/nut_f/hazelnut.png'},
        {'label': 'Almond', 'image': 'assets/nut_f/almond.png'},
      ],
    },
    {
      'label': 'Grain/cereal', 'image': 'assets/grain_f/grain_cereal.png', 'color': Color(0xFFAB9566),
      'subDescriptors': [
        {'label': 'Sweet bread pastry', 'image': 'assets/grain_f/sweetbreadpastry.png'},
        {'label': 'Granola', 'image': 'assets/grain_f/granola.png'},
        {'label': 'Graham cracker', 'image': 'assets/grain_f/graham cracker.png'},
        {'label': 'Rye', 'image': 'assets/grain_f/rye.png'},
        {'label': 'Wheat', 'image': 'assets/grain_f/wheat.png'},
        {'label': 'Fresh bread', 'image': 'assets/grain_f/freashbread.png'},
        {'label': 'Barley', 'image': 'assets/grain_f/barley.png'},
        {'label': 'Malt', 'image': 'assets/grain_f/malt.png'},
      ],
    },
    {
      'label': 'Roast', 'image': 'assets/roas_f/roasts.png', 'color': Color(0xFF616161),
      'subDescriptors': [
        {'label': 'Toast', 'image': 'assets/roas_f/toast.png'},
        {'label': 'Burnt sugar', 'image': 'assets/roas_f/burnt sugar.png'},
        {'label': 'Smokey', 'image': 'assets/roas_f/smokey.png'},
        {'label': 'Carbon', 'image': 'assets/roas_f/carbon.png'},
      ],
    },
    {
      'label': 'Spice', 'image': 'assets/spice_f/Spice.png', 'color': Color(0xFFBF4141),
      'subDescriptors': [
        {'label': 'Black pepper', 'image': 'assets/spice_f/black pepper.png'},
        {'label': 'White pepper', 'image': 'assets/spice_f/white pepper.png'},
        {'label': 'Cinnamon', 'image': 'assets/spice_f/Cinnamon Sticks.png'},
        {'label': 'Coriander', 'image': 'assets/spice_f/coriander.png'},
        {'label': 'Ginger', 'image': 'assets/spice_f/ginger.png'},
        {'label': 'Nutmeg', 'image': 'assets/spice_f/Nutmeg.png'},
        {'label': 'Licorice/anise', 'image': 'assets/spice_f/anise.png'},
        {'label': 'Clove', 'image': 'assets/spice_f/clove.png'},
        {'label': 'Curry', 'image': 'assets/spice_f/curry.png'},
      ],
    },
    {
      'label': 'Savory', 'image': 'assets/savory_f/savory.png', 'color': Color(0xFF9B2E2B),
      'subDescriptors': [
        {'label': 'Leathery', 'image': 'assets/savory_f/leathery.png'},
        {'label': 'Meat-like', 'image': 'assets/savory_f/meat.png'},
        {'label': 'Soy sauce', 'image': 'assets/savory_f/Soy Sauce.png'},
        {'label': 'Sundried tomato', 'image': 'assets/savory_f/sundried.png'},
        {'label': 'Tomato', 'image': 'assets/savory_f/Tomatov2.png'},
      ],
    },
    {
      'label': 'Herb', 'image': 'assets/herb_f/herb.png', 'color': Color(0xFF919F42),
      'subDescriptors': [
        {'label': 'Cedar', 'image': 'assets/herb_f/cedar.png'},
        {'label': 'Olive', 'image': 'assets/herb_f/Olive.png'},
        {'label': 'Dill', 'image': 'assets/herb_f/dill.png'},
        {'label': 'Sage', 'image': 'assets/herb_f/sage.png'},
        {'label': 'Mint', 'image': 'assets/herb_f/Mint.png'},
        {'label': 'Green tea', 'image': 'assets/herb_f/greentea.png'},
        {'label': 'Black tea', 'image': 'assets/herb_f/blacktea.png'},
        {'label': 'Hops', 'image': 'assets/herb_f/Hops.png'},
        {'label': 'Bergamot', 'image': 'assets/herb_f/bergamot.png'},
      ],
    },
    {
      'label': 'Earthy', 'image': 'assets/earthy_f/earthy.png', 'color': Color(0xFF463B34),
      'subDescriptors': [
        {'label': 'Soil', 'image': 'assets/earthy_f/soil.png'},
        {'label': 'Fresh wood', 'image': 'assets/earthy_f/freshwood.png'},
        {'label': 'Tobacco', 'image': 'assets/earthy_f/tobacco.png'},
        {'label': 'Hay/straw', 'image': 'assets/earthy_f/Hay.png'},
        {'label': 'Mushroom', 'image': 'assets/earthy_f/Mushroom.png'},
      ],
    },
    {
      'label': 'Vegetal', 'image': 'assets/vegetal_f/vegetal.png', 'color': Color(0xFF2E7D32),
      'subDescriptors': [
        {'label': 'Leafy greens', 'image': 'assets/vegetal_f/leafygreen.png'},
        {'label': 'Squash', 'image': 'assets/vegetal_f/Squash.png'},
        {'label': 'Sweet pea', 'image': 'assets/vegetal_f/sweetpea.png'},
        {'label': 'Snow pea', 'image': 'assets/vegetal_f/snowpea.png'},
        {'label': 'Green pepper', 'image': 'assets/vegetal_f/greenpepper.png'},
        {'label': 'Grassy', 'image': 'assets/vegetal_f/grassy.png'},
      ],
    },
  ];
}

class FlavorDescriptorSheet extends StatefulWidget {
  final List<String> initialSelected;
  final ValueChanged<List<String>> onApply;

  const FlavorDescriptorSheet({
    super.key,
    required this.initialSelected,
    required this.onApply,
  });

  static Map<String, dynamic> resolveStyle(String label) {
    for (final main in FlavorDescriptorData.mainDescriptors) {
      if (main['label'] == label) {
        return {'emoji': main['emoji'] as String? ?? '•', 'image': main['image'] as String?, 'color': main['color'] as Color};
      }
      final subs = main['subDescriptors'] as List<dynamic>;
      for (final sub in subs) {
        final subMap = sub as Map<String, dynamic>;
        if (subMap['label'] == label) {
          return {
            'emoji': subMap['emoji'] as String? ?? '•',
            'image': subMap['image'] as String?,
            'color': subMap.containsKey('color') ? subMap['color'] as Color : main['color'] as Color,
          };
        }
        if (subMap.containsKey('level3')) {
          for (final item in subMap['level3'] as List<dynamic>) {
            final itemMap = item as Map<String, dynamic>;
            if (itemMap['label'] == label) {
              return {
                'emoji': itemMap['emoji'] as String? ?? '•',
                'image': itemMap['image'] as String?,
                'color': subMap.containsKey('color') ? subMap['color'] as Color : main['color'] as Color,
              };
            }
          }
        }
      }
    }
    return {'emoji': '•', 'image': null, 'color': Colors.grey};
  }

  @override
  State<FlavorDescriptorSheet> createState() => _FlavorDescriptorSheetState();
}

class _FlavorDescriptorSheetState extends State<FlavorDescriptorSheet> {
  // ── ของเก่าจาก combinedResult (แสดงตลอด ลบไม่ได้ในหน้านี้) ──
  late List<String> _savedFromParent;

  // ── ของที่กำลังเลือกใหม่ในรอบนี้ ──
  String? _selectedMain;
  String? _selectedSub;
  List<String> _selectedSubs = [];
  List<String> _selectedLevel3 = [];

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

  List<Map<String, dynamic>> get _filteredDescriptors {
    if (_searchQuery.isEmpty) return FlavorDescriptorData.mainDescriptors;
    return FlavorDescriptorData.mainDescriptors
        .where((d) => (d['label'] as String).toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Map<String, dynamic>? _getMainData(String label) {
    try { return FlavorDescriptorData.mainDescriptors.firstWhere((d) => d['label'] == label); }
    catch (_) { return null; }
  }

  Map<String, dynamic>? _getSubData(String mainLabel, String subLabel) {
    final main = _getMainData(mainLabel);
    if (main == null) return null;
    try { return (main['subDescriptors'] as List<dynamic>).firstWhere((s) => s['label'] == subLabel) as Map<String, dynamic>; }
    catch (_) { return null; }
  }

  // รายการที่กำลังเลือกในรอบนี้
  List<String> get _newlySelected => [
    if (_selectedMain != null) _selectedMain!,
    ..._selectedSubs,
    ..._selectedLevel3,
  ];

  // รวมทั้งหมด (เก่า + ใหม่) กัน duplicate
  List<String> get _allDisplayed =>
      {..._savedFromParent, ..._newlySelected}.toList();

  void _onApply() {
    // ส่งกลับรายการรวม (เก่า + ใหม่)
    widget.onApply(_allDisplayed);
  }

  void _selectMain(String label) {
    setState(() {
      if (_selectedMain == label) {
        _selectedMain = null;
        _selectedSubs.clear();
        _selectedSub = null;
        _selectedLevel3.clear();
      } else {
        _selectedMain = label;
        _selectedSubs.clear();
        _selectedSub = null;
        _selectedLevel3.clear();
      }
    });
  }

  void _toggleSub(String subLabel) {
    setState(() {
      if (_selectedSubs.contains(subLabel)) {
        _selectedSubs.clear();
        _selectedSub = null;
        _selectedLevel3.clear();
      } else {
        _selectedSubs..clear()..add(subLabel);
        _selectedSub = subLabel;
        _selectedLevel3.clear();
      }
    });
  }

  Widget _buildIcon(Map<String, dynamic> data, double size) {
    if (data.containsKey('image') && data['image'] != null) {
      return Image.asset(data['image'] as String, width: size, height: size, fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Text(data['emoji'] as String? ?? '•', style: TextStyle(fontSize: size)));
    }
    return Text(data['emoji'] as String? ?? '•', style: TextStyle(fontSize: size));
  }

  Widget _mainChipFromData(Map<String, dynamic> data, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.7), border: Border.all(color: color, width: 0.5), borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _buildIcon(data, 16), const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
      ]),
    );
  }

  // chip แสดงใน Selected Descriptors — กดลบได้เฉพาะของใหม่
  Widget _buildSelectedChip(String label) {
    final style = FlavorDescriptorSheet.resolveStyle(label);
    final color = style['color'] as Color;
    final String emojiStr = style['emoji'] as String? ?? '•';
    final String? imageStr = style['image'] as String?;
    final bool isSaved = _savedFromParent.contains(label); // ของเก่า = ลบไม่ได้

    return GestureDetector(
      onTap: isSaved ? null : () {
        setState(() {
          if (_selectedMain == label) { _selectedMain = null; _selectedSubs.clear(); _selectedSub = null; _selectedLevel3.clear(); }
          else if (_selectedSubs.contains(label)) { _selectedSubs.remove(label); if (_selectedSub == label) _selectedSub = null; }
          else { _selectedLevel3.remove(label); }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          border: Border.all(color: color.withOpacity(0.6), width: 1.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          imageStr != null
              ? Image.asset(imageStr, width: 16, height: 16, fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Text(emojiStr, style: const TextStyle(fontSize: 14)))
              : Text(emojiStr, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
          if (!isSaved) ...[
            const SizedBox(width: 4),
            const Icon(Icons.cancel, size: 14, color: Colors.black),
          ],
        ]),
      ),
    );
  }

  Widget _buildLevel2Section(String mainLabel) {
    final data = _getMainData(mainLabel);
    if (data == null) return const SizedBox.shrink();
    final mainColor = data['color'] as Color;
    final subs = data['subDescriptors'] as List<dynamic>;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Image.asset('assets/icon/downright.png', width: 20, height: 20, color: Colors.grey.shade500),
        const SizedBox(width: 4),
        const Text('Descriptor of ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        _mainChipFromData(data, mainLabel, mainColor),
      ]),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8, children: subs.map((s) {
        final subMap = s as Map<String, dynamic>;
        final subLabel = subMap['label'] as String;
        final String? subImage = subMap['image'] as String?;
        final String subEmoji = subMap['emoji'] as String? ?? '•';
        final subColor = subMap.containsKey('color') && subMap['color'] != null ? subMap['color'] as Color : mainColor;
        final isSelected = _selectedSubs.contains(subLabel);

        return GestureDetector(
          onTap: () => _toggleSub(subLabel),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? subColor.withOpacity(0.7) : Colors.white,
              border: Border.all(color: isSelected ? subColor : const Color(0xFF1E52C6), width: isSelected ? 0 : 0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              if (subImage != null)
                Image.asset(subImage, width: 16, height: 16, fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Text(subEmoji, style: const TextStyle(fontSize: 14)))
              else Text(subEmoji, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 5),
              Text(subLabel, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal, color: isSelected ? Colors.white : Colors.black87)),
              if (isSelected) ...[const SizedBox(width: 4), const Icon(Icons.cancel, size: 15, color: Colors.black)],
            ]),
          ),
        );
      }).toList()),
    ]);
  }

  Widget _buildLevel3Section(String mainLabel, String subLabel) {
    final subData = _getSubData(mainLabel, subLabel);
    if (subData == null || !subData.containsKey('level3')) return const SizedBox.shrink();
    final level3Items = subData['level3'] as List<dynamic>;
    final subColor = subData['color'] as Color;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text('↳ ', style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
        const Text('Descriptor of ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        _mainChipFromData(subData, subLabel, subColor),
      ]),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8, children: level3Items.map((item) {
        final itemMap = item as Map<String, dynamic>;
        final itemLabel = itemMap['label'] as String;
        final String? itemImage = itemMap['image'] as String?;
        final String itemEmoji = itemMap['emoji'] as String? ?? '•';
        final isSelected = _selectedLevel3.contains(itemLabel);

        return GestureDetector(
          onTap: () => setState(() { if (isSelected) _selectedLevel3.remove(itemLabel); else _selectedLevel3.add(itemLabel); }),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? subColor.withOpacity(0.7) : Colors.white,
              border: Border.all(color: isSelected ? subColor : Colors.grey.shade300, width: isSelected ? 1.5 : 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              if (itemImage != null)
                Image.asset(itemImage, width: 16, height: 16, fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Text(itemEmoji, style: const TextStyle(fontSize: 14)))
              else Text(itemEmoji, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 5),
              Text(itemLabel, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal, color: isSelected ? Colors.white : Colors.black87)),
            ]),
          ),
        );
      }).toList()),
    ]);
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
                const Text('Main Descriptors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 10),
                Wrap(spacing: 8, runSpacing: 8, children: _filteredDescriptors.map((d) {
                  final label = d['label'] as String;
                  final color = d['color'] as Color;
                  final isSelected = _selectedMain == label;
                  return GestureDetector(
                    onTap: () => _selectMain(label),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected ? color.withOpacity(0.7) : Colors.white,
                        border: Border.all(color: isSelected ? color : const Color(0xFF1E52C6), width: isSelected ? 0 : 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        _buildIcon(d, 18), const SizedBox(width: 5),
                        Text(label, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal, color: isSelected ? Colors.white : Colors.black87)),
                        if (isSelected) ...[
                        const SizedBox(width: 4), 
                        Image.asset(
                          'assets/icon/plusicon.png', 
                          width: 14, 
                          height: 14, 
                          // color: Colors.black, // (ตัวเลือก) หากต้องการให้รูปถูกย้อมเป็นสีดำ สามารถเปิดคอมเมนต์บรรทัดนี้ได้
                        )
                      ],
                      ]),
                    ),
                  );
                }).toList()),
                if (_selectedMain != null) ...[const SizedBox(height: 16), _buildLevel2Section(_selectedMain!)],
                if (_selectedSub != null && _selectedMain != null) ...[const SizedBox(height: 16), _buildLevel3Section(_selectedMain!, _selectedSub!)],
              ],

              const SizedBox(height: 24),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onApply,
                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor2, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0),
                    child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() { _selectedMain = null; _selectedSub = null; _selectedSubs.clear(); _selectedLevel3.clear(); }),
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.black87, side: BorderSide(color: secondaryColor2), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: Text('Reset', style: TextStyle(fontSize: 16, color: secondaryColor2)),
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