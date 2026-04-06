// lib/cupping/Descriptive/DescriptiveStep1.dart
import 'dart:math';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Descriptive/descriptive_provider.dart';
import 'package:coffee/cupping/formdescriptor/FragranceAromaDescriptorData.dart';
import 'package:coffee/cupping/formdescriptor/main_tastes_descriptor_sheet.dart';
import 'package:coffee/cupping/formdescriptor/mouthfeel_descriptor_sheet.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ── Entry point ───────────────────────────────────────────────────────────────
class DescriptiveStep1 extends StatelessWidget {
  final SessionModel? session;
  const DescriptiveStep1({super.key, this.session});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final p = DescriptiveProvider();
        if (session != null) p.init(session!);
        return p;
      },
      child: const _DescriptiveNavigator(),
    );
  }
}

class _DescriptiveNavigator extends StatelessWidget {
  const _DescriptiveNavigator();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(settings: settings, builder: (_) => const _Step1()),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────

AppBar _dAppBar(String title, {VoidCallback? onBack}) => AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  scrolledUnderElevation: 0,
  centerTitle: true,
  automaticallyImplyLeading: false,
  leading: onBack != null
      ? IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: onBack,
        )
      : null,
  title: Text(
    title,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
);

Widget _dProgressBar(int step) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  child: Row(
    children: List.generate(
      5,
      (i) => Expanded(
        child: Container(
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: i < step ? secondaryColor2 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    ),
  ),
);

Widget _dHeaderCard(DescriptiveProvider p) {
  final session = p.session;
  final now = DateTime.now();
  final date =
      "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: secondaryColor2,
      borderRadius: BorderRadius.circular(0),
    ),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Image.asset(
              'assets/photo/coffepro.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.white24,
                child: const Icon(Icons.coffee, color: Colors.white, size: 26),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session?.cuppingName ?? "Descriptive Assessment",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 4),
              Text(
                "Date : $date  •  ${p.totalSamples} samples",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dSampleCard(DescriptiveProvider p) {
  final sample = p.currentSample;
  final data = p.currentData;
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
      border: Border.all(color: const Color(0xFFA2A2A2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sample?.name ?? "Coffee Name",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sample?.roastLevel ?? "",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 1,
              color: primaryColor2,
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Text("Total Cup", style: TextStyle(fontSize: 12)),
                  Text(
                    "${p.totalSamples}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 1,
              color: primaryColor2,
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Text("Total Score", style: TextStyle(fontSize: 12)),
                  Text(
                    data.totalScore.toStringAsFixed(0),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: secondaryColor2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Select coffee",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(p.totalSamples, (i) {
            final sel = p.currentSampleIndex == i;
            return GestureDetector(
              onTap: () => p.selectSample(i),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: sel ? secondaryColor2 : Colors.white,
                  border: Border.all(
                    color: sel ? secondaryColor2 : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    "${i + 1}",
                    style: TextStyle(
                      color: sel ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget _dBottomNav(
  BuildContext context, {
  required VoidCallback onBack,
  required VoidCallback onNext,
  String nextLabel = "Next",
}) => SafeArea(
  child: Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
    ),
    child: Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onBack,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: secondaryColor2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              "Back",
              style: TextStyle(color: secondaryColor2, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor2,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              nextLabel,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget _dDescriptorBox(List<String> items, void Function(String) onRemove) {
  const Color blue = Color(0xFF1E52C6);
  return Container(
    width: double.infinity,
    constraints: const BoxConstraints(minHeight: 100),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: items.isEmpty
        ? const Center(
            child: Text(
              'No descriptors added yet.\nTap Add to select.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          )
        : Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items
                .map(
                  (d) => GestureDetector(
                    onTap: () => onRemove(d),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: blue.withOpacity(0.12),
                        border: Border.all(color: blue, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            d,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
  );
}

Widget _dNoteField(TextEditingController c, void Function(String) onChanged) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Note',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: c,
          maxLines: 4,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Add notes...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: secondaryColor2, width: 1.5),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );

Widget _dAddDescriptorRow(String label, VoidCallback onTap) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    ),
    const SizedBox(width: 12),
    ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor2,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 0,
      ),
      child: const Text('Add', style: TextStyle(fontSize: 13)),
    ),
  ],
);

Widget _dSlider(
  BuildContext context,
  String label,
  double value,
  void Function(double) onChanged,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      const SizedBox(height: 10),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: secondaryColor2,
          inactiveTrackColor: const Color(0xFFF0E5DE),
          trackHeight: 14.0,
          trackShape: const RoundedRectSliderTrackShape(),
          thumbShape: _BalloonSlider(
            thumbRadius: 10,
            thumbValue: value.toInt(),
            color: secondaryColor2,
          ),
          overlayColor: secondaryColor2.withOpacity(0.1),
          tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
        ),
        child: Slider(
          value: value,
          min: 0,
          max: 15,
          divisions: 15,
          onChanged: onChanged,
        ),
      ),
      LayoutBuilder(
        builder: (ctx, constraints) {
          final w = constraints.maxWidth;
          const pad = 24.0;
          final tw = w - pad * 2;
          double pos(double v) => pad + (v / 10 * tw);
          return SizedBox(
            height: 36,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: pos(3.0),
                  top: -12,
                  child: Container(
                    width: 1.5,
                    height: 20,
                    color: primaryColor2,
                  ),
                ),
                Positioned(
                  left: pos(7.0),
                  top: -12,
                  child: Container(
                    width: 1.5,
                    height: 20,
                    color: primaryColor2,
                  ),
                ),
                Positioned(
                  left: pos(1.5) - 20,
                  top: 8,
                  width: 40,
                  child: const Text(
                    "Low",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  left: pos(5.0) - 25,
                  top: 8,
                  width: 50,
                  child: const Text(
                    "Medium",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  left: pos(8.5) - 20,
                  top: 8,
                  width: 40,
                  child: const Text(
                    "High",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 1-5
// ─────────────────────────────────────────────────────────────────────────────
class _Step1 extends StatefulWidget {
  const _Step1();
  @override
  State<_Step1> createState() => _Step1State();
}

class _Step1State extends State<_Step1> {
  final _note = TextEditingController();
  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  void _showDescriptorSheet(DescriptiveProvider p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FragranceAromaDescriptorSheet(
        initialSelected: List.from(p.currentData.fragranceAromaDescriptors),
        onApply: (selected) {
          p.setFragranceAromaDescriptors(selected);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DescriptiveProvider>(
      builder: (_, p, __) {
        final d = p.currentData;
        if (_note.text != d.step1Note) _note.text = d.step1Note;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _dAppBar(
            "Descriptive Form",
            onBack: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          bottomNavigationBar: _dBottomNav(
            context,
            onBack: () => Navigator.of(context, rootNavigator: true).pop(),
            onNext: () {
              p.setStep1Note(_note.text);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _Step2()),
              );
            },
          ),
          body: Column(
            children: [
              _dProgressBar(1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dHeaderCard(p),
                      const SizedBox(height: 22),
                      _dSampleCard(p),
                      const SizedBox(height: 24),
                      _dSlider(
                        context,
                        "Fragrance",
                        d.fragrance,
                        p.setFragrance,
                      ),
                      const SizedBox(height: 30),
                      _dSlider(context, "Aroma", d.aroma, p.setAroma),
                      const SizedBox(height: 32),
                      _dAddDescriptorRow(
                        "Fragrance / Aroma Descriptors",
                        () => _showDescriptorSheet(p),
                      ),
                      const SizedBox(height: 12),
                      _dDescriptorBox(
                        d.fragranceAromaDescriptors,
                        (x) => p.setFragranceAromaDescriptors(
                          List.from(d.fragranceAromaDescriptors)..remove(x),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _dNoteField(_note, p.setStep1Note),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Step2 extends StatefulWidget {
  const _Step2();
  @override
  State<_Step2> createState() => _Step2State();
}

class _Step2State extends State<_Step2> {
  final _note = TextEditingController();
  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  void _showFlavorSheet(DescriptiveProvider p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FragranceAromaDescriptorSheet(
        subtitle: 'Flavor / Aftertaste Descriptors',
        initialSelected: List.from(p.currentData.flavorAftertasteDescriptors),
        onApply: (selected) {
          p.setFlavorAftertasteDescriptors(selected);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showMainTastesSheet(DescriptiveProvider p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MainTastesDescriptorSheet(
        initialSelected: List.from(p.currentData.mainTastes),
        onApply: (selected) {
          p.setMainTastes(selected);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DescriptiveProvider>(
      builder: (_, p, __) {
        final d = p.currentData;
        if (_note.text != d.step2Note) _note.text = d.step2Note;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _dAppBar("Descriptive Form"),
          bottomNavigationBar: _dBottomNav(
            context,
            onBack: () => Navigator.pop(context),
            onNext: () {
              p.setStep2Note(_note.text);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _Step3()),
              );
            },
          ),
          body: Column(
            children: [
              _dProgressBar(2),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dHeaderCard(p),
                      const SizedBox(height: 22),
                      _dSampleCard(p),
                      const SizedBox(height: 24),
                      _dSlider(context, "Flavor", d.flavor, p.setFlavor),
                      const SizedBox(height: 30),
                      _dSlider(
                        context,
                        "Aftertaste",
                        d.aftertaste,
                        p.setAftertaste,
                      ),
                      const SizedBox(height: 32),
                      _dAddDescriptorRow(
                        "Flavor / Aftertaste Descriptors",
                        () => _showFlavorSheet(p),
                      ),
                      const SizedBox(height: 12),
                      _dDescriptorBox(
                        d.flavorAftertasteDescriptors,
                        (x) => p.setFlavorAftertasteDescriptors(
                          List.from(d.flavorAftertasteDescriptors)..remove(x),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _dAddDescriptorRow(
                        "Main Tastes (select up to 2)",
                        () => _showMainTastesSheet(p),
                      ),
                      const SizedBox(height: 12),
                      _dDescriptorBox(
                        d.mainTastes,
                        (x) =>
                            p.setMainTastes(List.from(d.mainTastes)..remove(x)),
                      ),
                      const SizedBox(height: 24),
                      _dNoteField(_note, p.setStep2Note),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Step3 extends StatefulWidget {
  const _Step3();
  @override
  State<_Step3> createState() => _Step3State();
}

class _Step3State extends State<_Step3> {
  final _note = TextEditingController();
  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DescriptiveProvider>(
      builder: (_, p, __) {
        final d = p.currentData;
        if (_note.text != d.step3Note) _note.text = d.step3Note;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _dAppBar("Descriptive Form"),
          bottomNavigationBar: _dBottomNav(
            context,
            onBack: () => Navigator.pop(context),
            onNext: () {
              p.setStep3Note(_note.text);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _Step4()),
              );
            },
          ),
          body: Column(
            children: [
              _dProgressBar(3),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dHeaderCard(p),
                      const SizedBox(height: 22),
                      _dSampleCard(p),
                      const SizedBox(height: 24),
                      _dSlider(context, "Acidity", d.acidity, p.setAcidity),
                      const SizedBox(height: 28),
                      _dNoteField(_note, p.setStep3Note),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Step4 extends StatefulWidget {
  const _Step4();
  @override
  State<_Step4> createState() => _Step4State();
}

class _Step4State extends State<_Step4> {
  final _note = TextEditingController();
  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DescriptiveProvider>(
      builder: (_, p, __) {
        final d = p.currentData;
        if (_note.text != d.step4Note) _note.text = d.step4Note;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _dAppBar("Descriptive Form"),
          bottomNavigationBar: _dBottomNav(
            context,
            onBack: () => Navigator.pop(context),
            onNext: () {
              p.setStep4Note(_note.text);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _Step5()),
              );
            },
          ),
          body: Column(
            children: [
              _dProgressBar(4),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dHeaderCard(p),
                      const SizedBox(height: 22),
                      _dSampleCard(p),
                      const SizedBox(height: 24),
                      _dSlider(
                        context,
                        "Sweetness",
                        d.sweetness,
                        p.setSweetness,
                      ),
                      const SizedBox(height: 28),
                      _dNoteField(_note, p.setStep4Note),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Step5 extends StatefulWidget {
  const _Step5();
  @override
  State<_Step5> createState() => _Step5State();
}

class _Step5State extends State<_Step5> {
  final _note = TextEditingController();
  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  void _showMouthfeelSheet(DescriptiveProvider p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MouthfeelDescriptorSheet(
        initialSelected: List.from(p.currentData.mouthfeelDescriptors),
        onApply: (selected) {
          p.setMouthfeelDescriptors(selected);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DescriptiveProvider>(
      builder: (_, p, __) {
        final d = p.currentData;
        if (_note.text != d.step5Note) _note.text = d.step5Note;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _dAppBar("Descriptive Form"),
          bottomNavigationBar: _dBottomNav(
            context,
            onBack: () => Navigator.pop(context),
            nextLabel: "Submit",
            onNext: () {
              p.setStep5Note(_note.text);
              debugPrint("Submit: ${p.buildSubmitPayload()}");
              // ── navigate ไป chart โดยตรง ──────────────────────────────
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DescriptiveChartResult(provider: p),
                ),
              );
            },
          ),
          body: Column(
            children: [
              _dProgressBar(5),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dHeaderCard(p),
                      const SizedBox(height: 22),
                      _dSampleCard(p),
                      const SizedBox(height: 24),
                      _dSlider(
                        context,
                        "Mouthfeel",
                        d.mouthfeel,
                        p.setMouthfeel,
                      ),
                      const SizedBox(height: 32),
                      _dAddDescriptorRow(
                        "Mouthfeel Descriptors",
                        () => _showMouthfeelSheet(p),
                      ),
                      const SizedBox(height: 12),
                      _dDescriptorBox(
                        d.mouthfeelDescriptors,
                        (x) => p.setMouthfeelDescriptors(
                          List.from(d.mouthfeelDescriptors)..remove(x),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _dNoteField(_note, p.setStep5Note),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CHART — public class ให้ coffee_detail_screen.dart เรียกได้โดยตรง
// ─────────────────────────────────────────────────────────────────────────────
class DescriptiveChartResult extends StatefulWidget {
  final DescriptiveProvider provider;
  const DescriptiveChartResult({super.key, required this.provider});
  @override
  State<DescriptiveChartResult> createState() => _DescriptiveChartResultState();
}

class _DescriptiveChartResultState extends State<DescriptiveChartResult> {
  int _selectedSampleIndex = 0;
  static const Color _barBlue = Color(0xFF1A3A8F);

  DescriptiveFormData? get _data =>
      widget.provider.allDataForIndex(_selectedSampleIndex);

  @override
  Widget build(BuildContext context) {
    final session = widget.provider.session;
    final data = _data;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _dAppBar("Descriptive Form"),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pop(widget.provider),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: data == null
          ? const Center(child: Text("No data"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dHeaderCard(widget.provider),
                  const SizedBox(height: 16),
                  _buildSampleCard(session, data),
                  const SizedBox(height: 24),
                  const Text(
                    "Descriptive Assessment",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _bar("Fragrance", data.fragrance),
                  _bar("Aroma", data.aroma),
                  _bar("Flavor", data.flavor),
                  _bar("Aftertaste", data.aftertaste),
                  _bar("Acidity", data.acidity),
                  _bar("Sweetness", data.sweetness),
                  _bar("Mouthfeel", data.mouthfeel),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: secondaryColor2.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: secondaryColor2.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Score",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          data.totalScore.toStringAsFixed(1),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: secondaryColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (data.fragranceAromaDescriptors.isNotEmpty) ...[
                    _descriptorSection(
                      "Fragrance / Aroma",
                      data.fragranceAromaDescriptors,
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (data.flavorAftertasteDescriptors.isNotEmpty) ...[
                    _descriptorSection(
                      "Flavor / Aftertaste",
                      data.flavorAftertasteDescriptors,
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (data.mainTastes.isNotEmpty) ...[
                    _descriptorSection("Main Tastes", data.mainTastes),
                    const SizedBox(height: 16),
                  ],
                  if (data.mouthfeelDescriptors.isNotEmpty) ...[
                    _descriptorSection("Mouthfeel", data.mouthfeelDescriptors),
                    const SizedBox(height: 16),
                  ],
                  const Text(
                    "Session Result",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 300,
                    child: CustomPaint(
                      painter: _RadarPainter(
                        values: [
                          data.fragrance / 15,
                          data.aroma / 15,
                          data.flavor / 15,
                          data.aftertaste / 15,
                          data.acidity / 15,
                          data.sweetness / 15,
                          data.mouthfeel / 15,
                        ],
                        labels: const [
                          "Fragrance",
                          "Aroma",
                          "Flavor",
                          "Aftertaste",
                          "Acidity",
                          "Sweetness",
                          "Mouthfeel",
                        ],
                      ),
                      child: Container(),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildSampleCard(SessionModel? session, DescriptiveFormData data) {
    final count = session?.samples.length ?? 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session?.samples[_selectedSampleIndex].name ?? "Coffee",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      session?.samples[_selectedSampleIndex].roastLevel ?? "",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 36,
                width: 1,
                color: primaryColor2,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Text("Samples", style: TextStyle(fontSize: 12)),
                    Text(
                      "$count",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 36,
                width: 1,
                color: primaryColor2,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Text("Total", style: TextStyle(fontSize: 12)),
                    Text(
                      data.totalScore.toStringAsFixed(0),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: secondaryColor2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Select coffee",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(count, (i) {
              final sel = _selectedSampleIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedSampleIndex = i),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: sel ? secondaryColor2 : Colors.white,
                    border: Border.all(
                      color: sel ? secondaryColor2 : Colors.grey.shade300,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${i + 1}",
                      style: TextStyle(
                        color: sel ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _bar(String label, double score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${score.toStringAsFixed(0)} / 15",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: score > 0 ? _barBlue : Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score / 15,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                score > 0 ? _barBlue : Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptorSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: items
              .map(
                (d) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E52C6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF1E52C6).withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    d,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1E52C6),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Balloon Slider Shape
// ─────────────────────────────────────────────────────────────────────────────
class _BalloonSlider extends SliderComponentShape {
  final double thumbRadius;
  final int thumbValue;
  final Color color;
  const _BalloonSlider({
    required this.thumbRadius,
    required this.thumbValue,
    required this.color,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(thumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final paint = Paint()..color = color;
    canvas.drawCircle(center, thumbRadius, paint);
    canvas.drawCircle(
      center,
      thumbRadius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    const bW = 64.0;
    const bH = 40.0;
    const tH = 8.0;
    final bC = center + const Offset(0, -(bH + tH - 10));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: bC, width: bW, height: bH),
        const Radius.circular(20),
      ),
      paint,
    );
    final path = Path()
      ..moveTo(center.dx - 5, bC.dy + bH / 2)
      ..lineTo(center.dx, bC.dy + bH / 2 + tH)
      ..lineTo(center.dx + 5, bC.dy + bH / 2)
      ..close();
    canvas.drawPath(path, paint);
    final tp = TextPainter(
      text: TextSpan(
        text: thumbValue.toString(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(bC.dx - tp.width / 2, bC.dy - tp.height / 2));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Radar Chart
// ─────────────────────────────────────────────────────────────────────────────
class _RadarPainter extends CustomPainter {
  final List<double> values;
  final List<String> labels;
  const _RadarPainter({required this.values, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 48;
    final count = values.length;
    final step = (2 * pi) / count;

    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (int lvl = 1; lvl <= 5; lvl++) {
      final r = radius * lvl / 5;
      final path = Path();
      for (int i = 0; i < count; i++) {
        final a = -pi / 2 + i * step;
        final p = Offset(center.dx + r * cos(a), center.dy + r * sin(a));
        i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }
    for (int i = 0; i < count; i++) {
      final a = -pi / 2 + i * step;
      canvas.drawLine(
        center,
        Offset(center.dx + radius * cos(a), center.dy + radius * sin(a)),
        gridPaint,
      );
    }

    final fillPaint = Paint()
      ..color = secondaryColor2.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = secondaryColor2
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final dotPaint = Paint()
      ..color = secondaryColor2
      ..style = PaintingStyle.fill;

    final dataPath = Path();
    for (int i = 0; i < count; i++) {
      final a = -pi / 2 + i * step;
      final r = radius * values[i].clamp(0.0, 1.0);
      final p = Offset(center.dx + r * cos(a), center.dy + r * sin(a));
      i == 0 ? dataPath.moveTo(p.dx, p.dy) : dataPath.lineTo(p.dx, p.dy);
    }
    dataPath.close();
    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);

    for (int i = 0; i < count; i++) {
      final a = -pi / 2 + i * step;
      final r = radius * values[i].clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(center.dx + r * cos(a), center.dy + r * sin(a)),
        4,
        dotPaint,
      );
    }

    for (int i = 0; i < count; i++) {
      final a = -pi / 2 + i * step;
      final lR = radius + 32;
      final x = center.dx + lR * cos(a);
      final y = center.dy + lR * sin(a);
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 72);
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => true;
}
