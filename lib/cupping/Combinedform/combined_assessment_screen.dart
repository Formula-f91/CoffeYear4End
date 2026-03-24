// lib/cupping/Combinedform/combined_assessment_screen.dart
//
// Combined Form — 6 step + Chart ในไฟล์เดียว
// ใช้ Inner Navigator pattern เหมือน Affective/Descriptive
//
import 'dart:math';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Combinedform/combined_provider.dart';
import 'package:coffee/cupping/formdescriptor/FragranceAromaDescriptorData.dart';
import 'package:coffee/cupping/formdescriptor/main_tastes_descriptor_sheet.dart';
import 'package:coffee/cupping/formdescriptor/mouthfeel_descriptor_sheet.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ── Entry point ───────────────────────────────────────────────────────────────
class CombinedAssessmentScreen extends StatelessWidget {
  final SessionModel? session;
  const CombinedAssessmentScreen({super.key, this.session});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final p = CombinedProvider();
        if (session != null) p.init(session!);
        return p;
      },
      child: const _CombinedNavigator(),
    );
  }
}

class _CombinedNavigator extends StatelessWidget {
  const _CombinedNavigator();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (s) => MaterialPageRoute(
        settings: s,
        builder: (_) => const _Step1(),
      ),
    );
  }
}

// ── Shared helpers ─────────────────────────────────────────────────────────────

AppBar _cAppBar(String title, {VoidCallback? onBack}) => AppBar(
  backgroundColor: Colors.white, elevation: 0, scrolledUnderElevation: 0,
  centerTitle: true, automaticallyImplyLeading: false,
  leading: onBack != null
      ? IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20), onPressed: onBack)
      : null,
  title: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
);

Widget _cProgressBar(int step) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  child: Row(children: List.generate(6, (i) => Expanded(
    child: Container(height: 10, margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: i < step ? secondaryColor2 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5))),
  ))),
);

Widget _cHeaderCard(CombinedProvider p) {
  final session = p.session;
  final now = DateTime.now();
  final date = "${now.day.toString().padLeft(2,'0')}.${now.month.toString().padLeft(2,'0')}.${now.year}";
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: secondaryColor2, borderRadius: BorderRadius.circular(0)),
    child: Row(children: [
      ClipOval(child: Image.asset('assets/photo/coffepro.png', width: 46, height: 46, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(width: 46, height: 46, color: Colors.white24,
              child: const Icon(Icons.coffee, color: Colors.white, size: 26)))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(session?.cuppingName ?? "Combined Assessment",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
            overflow: TextOverflow.ellipsis, maxLines: 1),
        const SizedBox(height: 4),
        Text("Date : $date  •  ${p.totalSamples} samples",
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            overflow: TextOverflow.ellipsis, maxLines: 1),
      ])),
    ]),
  );
}

Widget _cSampleCard(CombinedProvider p) {
  final sample = p.currentSample;
  final d = p.currentData;
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0),
        border: Border.all(color: const Color(0xFFA2A2A2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(sample?.name ?? "Coffee Name", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 4),
          Text(sample?.roastLevel ?? "", style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ])),
        Container(height: 40, width: 1, color: primaryColor2, margin: const EdgeInsets.symmetric(horizontal: 12)),
        Expanded(flex: 2, child: Column(children: [
          const Text("Total Cup", style: TextStyle(fontSize: 12)),
          Text("${p.totalSamples}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ])),
        Container(height: 40, width: 1, color: primaryColor2, margin: const EdgeInsets.symmetric(horizontal: 12)),
        Expanded(flex: 2, child: Column(children: [
          const Text("D.Score", style: TextStyle(fontSize: 11)),
          Text(d.descriptiveTotal.toStringAsFixed(0),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: secondaryColor2)),
        ])),
      ]),
      const SizedBox(height: 16),
      const Text("Select coffee", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8,
        children: List.generate(p.totalSamples, (i) {
          final sel = p.currentSampleIndex == i;
          return GestureDetector(
            onTap: () => p.selectSample(i),
            child: Container(width: 44, height: 44,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  color: sel ? secondaryColor2 : Colors.white,
                  border: Border.all(color: sel ? secondaryColor2 : Colors.grey.shade300)),
              child: Center(child: Text("${i + 1}",
                  style: TextStyle(color: sel ? Colors.white : Colors.black, fontWeight: FontWeight.bold))),
            ),
          );
        }),
      ),
    ]),
  );
}

Widget _cBottomNav(BuildContext ctx, {required VoidCallback onBack, required VoidCallback onNext, String nextLabel = "Next"}) =>
    SafeArea(child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1))),
      child: Row(children: [
        Expanded(child: OutlinedButton(onPressed: onBack,
          style: OutlinedButton.styleFrom(side: BorderSide(color: secondaryColor2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              padding: const EdgeInsets.symmetric(vertical: 16)),
          child: Text("Back", style: TextStyle(color: secondaryColor2, fontSize: 18)))),
        const SizedBox(width: 16),
        Expanded(flex: 2, child: ElevatedButton(onPressed: onNext,
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColor2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              padding: const EdgeInsets.symmetric(vertical: 16)),
          child: Text(nextLabel, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))),
      ]),
    ));

// Tab switcher (Descriptive | Affective)
Widget _cTabSwitcher(bool isDescriptive, void Function(bool) onToggle) =>
    Row(children: [
      Expanded(child: GestureDetector(
        onTap: () => onToggle(true),
        child: Container(padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: Colors.transparent, border: Border(
              bottom: BorderSide(color: isDescriptive ? primaryColor2 : Colors.transparent, width: 2))),
          child: Text("Descriptive", textAlign: TextAlign.center,
              style: TextStyle(color: isDescriptive ? primaryColor2 : Colors.grey.shade600,
                  fontWeight: FontWeight.w600, fontSize: 16))),
      )),
      Expanded(child: GestureDetector(
        onTap: () => onToggle(false),
        child: Container(padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: Colors.transparent, border: Border(
              bottom: BorderSide(color: !isDescriptive ? primaryColor2 : Colors.transparent, width: 2))),
          child: Text("Affective", textAlign: TextAlign.center,
              style: TextStyle(color: !isDescriptive ? primaryColor2 : Colors.grey.shade600,
                  fontWeight: FontWeight.w600, fontSize: 16))),
      )),
    ]);

// Descriptor chip box
Widget _cDescriptorBox(List<String> items, void Function(String) onRemove) {
  const c = Color(0xFF1E52C6);
  return Container(
    width: double.infinity, constraints: const BoxConstraints(minHeight: 80),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8)),
    child: items.isEmpty
        ? const Center(child: Text('No descriptors added yet. Tap Add.',
            style: TextStyle(color: Colors.black54, fontSize: 13), textAlign: TextAlign.center))
        : Wrap(spacing: 8, runSpacing: 8, children: items.map((d) => GestureDetector(
            onTap: () => onRemove(d),
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: c.withOpacity(0.12),
                  border: Border.all(color: c, width: 0.5), borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(d, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                const SizedBox(width: 4),
                Container(width: 16, height: 16,
                    decoration: const BoxDecoration(color: c, shape: BoxShape.circle),
                    child: const Icon(Icons.close, size: 10, color: Colors.white)),
              ])))).toList()),
  );
}

Widget _cAddRow(String label, VoidCallback onTap) =>
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
      const SizedBox(width: 12),
      ElevatedButton(onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: secondaryColor2,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), elevation: 0),
        child: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 13))),
    ]);

Widget _cNote(TextEditingController c, void Function(String) onChange) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      const SizedBox(height: 8),
      TextField(controller: c, maxLines: 4, onChanged: onChange,
        decoration: InputDecoration(hintText: 'Add notes...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: secondaryColor2, width: 1.5)),
          contentPadding: const EdgeInsets.all(12))),
    ]);

// Number selector 1-9
Widget _cNumbers(BuildContext ctx, String label, int? val, void Function(int) onSelect) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(9, (i) {
          final n = i + 1; final sel = val == n;
          return GestureDetector(onTap: () => onSelect(n),
            child: Container(width: 34, height: 34,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  color: sel ? primaryColor2 : Colors.white,
                  border: Border.all(color: sel ? primaryColor2 : Colors.grey.shade400, width: 1.5)),
              child: Center(child: Text("$n", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                  color: sel ? Colors.white : Colors.black87)))));
        })),
    ]);

// Slider
Widget _cSlider(BuildContext context, String label, double val, void Function(double) onChange) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      const SizedBox(height: 10),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: secondaryColor2, inactiveTrackColor: const Color(0xFFF0E5DE),
          trackHeight: 14.0, trackShape: const RoundedRectSliderTrackShape(),
          thumbShape: _CBalloon(thumbRadius: 10, thumbValue: val.toInt(), color: secondaryColor2),
          overlayColor: secondaryColor2.withOpacity(0.1),
          tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0)),
        child: Slider(value: val, min: 0, max: 15, divisions: 15, onChanged: onChange)),
      LayoutBuilder(builder: (ctx, cons) {
        const pad = 24.0;
        final tw = cons.maxWidth - pad * 2;
        double pos(double v) => pad + (v / 10 * tw);
        return SizedBox(height: 36, child: Stack(clipBehavior: Clip.none, children: [
          Positioned(left: pos(3.0), top: -12, child: Container(width: 1.5, height: 20, color: primaryColor2)),
          Positioned(left: pos(7.0), top: -12, child: Container(width: 1.5, height: 20, color: primaryColor2)),
          Positioned(left: pos(1.5) - 20, top: 8, width: 40, child: const Text("Low", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
          Positioned(left: pos(5.0) - 25, top: 8, width: 50, child: const Text("Medium", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
          Positioned(left: pos(8.5) - 20, top: 8, width: 40, child: const Text("High", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
        ]));
      }),
    ]);

// ─────────────────────────────────────────────────────────────────────────────
// STEP 1 — Fragrance / Aroma (Descriptive) + Fragrance/Aroma (Affective 1-9)
// ─────────────────────────────────────────────────────────────────────────────
class _Step1 extends StatefulWidget {
  const _Step1();
  @override State<_Step1> createState() => _Step1State();
}
class _Step1State extends State<_Step1> {
  bool _isDesc = true;
  final _note = TextEditingController();

  void _showSheet(CombinedProvider p) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => FragranceAromaDescriptorSheet(
        initialSelected: List.from(p.currentData.fragranceAromaDescriptors),
        onApply: (s) { p.setFragranceAromaDescriptors(s); Navigator.pop(context); }));
  }

  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<CombinedProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step1Note) _note.text = d.step1Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _cAppBar("Combined Form", onBack: () => Navigator.of(context, rootNavigator: true).pop()),
        bottomNavigationBar: _cBottomNav(context,
          onBack: () => Navigator.of(context, rootNavigator: true).pop(),
          onNext: () { p.setStep1Note(_note.text); Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step2())); }),
        body: Column(children: [
          _cProgressBar(1),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _cHeaderCard(p), const SizedBox(height: 22),
              _cSampleCard(p), const SizedBox(height: 20),
              _cTabSwitcher(_isDesc, (v) => setState(() => _isDesc = v)),
              const SizedBox(height: 20),
              if (_isDesc) ...[
                _cSlider(context, "Fragrance", d.fragrance, p.setFragrance),
                const SizedBox(height: 28),
                _cSlider(context, "Aroma", d.aroma, p.setAroma),
                const SizedBox(height: 28),
                _cAddRow("Fragrance / Aroma Descriptors", () => _showSheet(p)),
                const SizedBox(height: 12),
                _cDescriptorBox(d.fragranceAromaDescriptors,
                    (x) => p.setFragranceAromaDescriptors(List.from(d.fragranceAromaDescriptors)..remove(x))),
              ] else ...[
                const Text("INITIAL ASSESSMENT (1–9)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
                const SizedBox(height: 16),
                _cNumbers(context, "Fragrance", d.affFragrance, p.setAffFragrance),
                const SizedBox(height: 20),
                _cNumbers(context, "Aroma", d.affAroma, p.setAffAroma),
              ],
              const SizedBox(height: 24),
              _cNote(_note, p.setStep1Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 2 — Flavor / Aftertaste
// ─────────────────────────────────────────────────────────────────────────────
class _Step2 extends StatefulWidget {
  const _Step2();
  @override State<_Step2> createState() => _Step2State();
}
class _Step2State extends State<_Step2> {
  bool _isDesc = true;
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  void _showFlavorSheet(CombinedProvider p) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => FragranceAromaDescriptorSheet(
        subtitle: 'Flavor / Aftertaste Descriptors',
        initialSelected: List.from(p.currentData.flavorAftertasteDescriptors),
        onApply: (s) { p.setFlavorAftertasteDescriptors(s); Navigator.pop(context); }));
  }

  void _showMainSheet(CombinedProvider p) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => MainTastesDescriptorSheet(
        initialSelected: List.from(p.currentData.mainTastes),
        onApply: (s) { p.setMainTastes(s); Navigator.pop(context); }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CombinedProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step2Note) _note.text = d.step2Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _cAppBar("Combined Form"),
        bottomNavigationBar: _cBottomNav(context,
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep2Note(_note.text); Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step3())); }),
        body: Column(children: [
          _cProgressBar(2),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _cHeaderCard(p), const SizedBox(height: 22),
              _cSampleCard(p), const SizedBox(height: 20),
              _cTabSwitcher(_isDesc, (v) => setState(() => _isDesc = v)),
              const SizedBox(height: 20),
              if (_isDesc) ...[
                _cSlider(context, "Flavor", d.flavor, p.setFlavor),
                const SizedBox(height: 28),
                _cSlider(context, "Aftertaste", d.aftertaste, p.setAftertaste),
                const SizedBox(height: 28),
                _cAddRow("Flavor / Aftertaste Descriptors", () => _showFlavorSheet(p)),
                const SizedBox(height: 12),
                _cDescriptorBox(d.flavorAftertasteDescriptors,
                    (x) => p.setFlavorAftertasteDescriptors(List.from(d.flavorAftertasteDescriptors)..remove(x))),
                const SizedBox(height: 20),
                _cAddRow("Main Tastes (up to 2)", () => _showMainSheet(p)),
                const SizedBox(height: 12),
                _cDescriptorBox(d.mainTastes, (x) => p.setMainTastes(List.from(d.mainTastes)..remove(x))),
              ] else ...[
                const Text("INITIAL ASSESSMENT (1–9)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
                const SizedBox(height: 16),
                _cNumbers(context, "Flavor", d.affFlavor, p.setAffFlavor),
                const SizedBox(height: 20),
                _cNumbers(context, "Aftertaste", d.affAftertaste, p.setAffAftertaste),
              ],
              const SizedBox(height: 24),
              _cNote(_note, p.setStep2Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 3 — Acidity
// ─────────────────────────────────────────────────────────────────────────────
class _Step3 extends StatefulWidget {
  const _Step3();
  @override State<_Step3> createState() => _Step3State();
}
class _Step3State extends State<_Step3> {
  bool _isDesc = true;
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<CombinedProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step3Note) _note.text = d.step3Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _cAppBar("Combined Form"),
        bottomNavigationBar: _cBottomNav(context,
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep3Note(_note.text); Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step4())); }),
        body: Column(children: [
          _cProgressBar(3),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _cHeaderCard(p), const SizedBox(height: 22),
              _cSampleCard(p), const SizedBox(height: 20),
              _cTabSwitcher(_isDesc, (v) => setState(() => _isDesc = v)),
              const SizedBox(height: 20),
              if (_isDesc)
                _cSlider(context, "Acidity", d.acidity, p.setAcidity)
              else ...[
                const Text("INITIAL ASSESSMENT (1–9)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
                const SizedBox(height: 16),
                _cNumbers(context, "Acidity", d.affAcidity, p.setAffAcidity),
              ],
              const SizedBox(height: 24),
              _cNote(_note, p.setStep3Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 4 — Sweetness
// ─────────────────────────────────────────────────────────────────────────────
class _Step4 extends StatefulWidget {
  const _Step4();
  @override State<_Step4> createState() => _Step4State();
}
class _Step4State extends State<_Step4> {
  bool _isDesc = true;
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<CombinedProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step4Note) _note.text = d.step4Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _cAppBar("Combined Form"),
        bottomNavigationBar: _cBottomNav(context,
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep4Note(_note.text); Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step5())); }),
        body: Column(children: [
          _cProgressBar(4),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _cHeaderCard(p), const SizedBox(height: 22),
              _cSampleCard(p), const SizedBox(height: 20),
              _cTabSwitcher(_isDesc, (v) => setState(() => _isDesc = v)),
              const SizedBox(height: 20),
              if (_isDesc)
                _cSlider(context, "Sweetness", d.sweetness, p.setSweetness)
              else ...[
                const Text("INITIAL ASSESSMENT (1–9)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
                const SizedBox(height: 16),
                _cNumbers(context, "Sweetness", d.affSweetness, p.setAffSweetness),
              ],
              const SizedBox(height: 24),
              _cNote(_note, p.setStep4Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 5 — Mouthfeel
// ─────────────────────────────────────────────────────────────────────────────
class _Step5 extends StatefulWidget {
  const _Step5();
  @override State<_Step5> createState() => _Step5State();
}
class _Step5State extends State<_Step5> {
  bool _isDesc = true;
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  void _showMouthfeelSheet(CombinedProvider p) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => MouthfeelDescriptorSheet(
        initialSelected: List.from(p.currentData.mouthfeelDescriptors),
        onApply: (s) { p.setMouthfeelDescriptors(s); Navigator.pop(context); }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CombinedProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step5Note) _note.text = d.step5Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _cAppBar("Combined Form"),
        bottomNavigationBar: _cBottomNav(context,
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep5Note(_note.text); Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step6())); }),
        body: Column(children: [
          _cProgressBar(5),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _cHeaderCard(p), const SizedBox(height: 22),
              _cSampleCard(p), const SizedBox(height: 20),
              _cTabSwitcher(_isDesc, (v) => setState(() => _isDesc = v)),
              const SizedBox(height: 20),
              if (_isDesc) ...[
                _cSlider(context, "Mouthfeel", d.mouthfeel, p.setMouthfeel),
                const SizedBox(height: 28),
                _cAddRow("Mouthfeel Descriptors", () => _showMouthfeelSheet(p)),
                const SizedBox(height: 12),
                _cDescriptorBox(d.mouthfeelDescriptors,
                    (x) => p.setMouthfeelDescriptors(List.from(d.mouthfeelDescriptors)..remove(x))),
              ] else ...[
                const Text("INITIAL ASSESSMENT (1–9)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
                const SizedBox(height: 16),
                _cNumbers(context, "Mouthfeel", d.affMouthfeel, p.setAffMouthfeel),
              ],
              const SizedBox(height: 24),
              _cNote(_note, p.setStep5Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 6 — Extrinsic / Overall / Uniformity / Defects
// ─────────────────────────────────────────────────────────────────────────────
class _Step6 extends StatefulWidget {
  const _Step6();
  @override State<_Step6> createState() => _Step6State();
}
class _Step6State extends State<_Step6> {
  bool _isDesc = true;
  final _note = TextEditingController();
  static const _orange = Color(0xFFFF8D28);
  static const _red    = Color(0xFFB3261E);
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<CombinedProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step6Note) _note.text = d.step6Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _cAppBar("Combined Form"),
        bottomNavigationBar: _cBottomNav(context,
          nextLabel: "Submit",
          onBack: () => Navigator.pop(context),
          onNext: () {
            p.setStep6Note(_note.text);
            debugPrint("Submit: ${p.buildSubmitPayload()}");
            Navigator.push(context, MaterialPageRoute(builder: (_) => _CombinedChart(provider: p)));
          }),
        body: Column(children: [
          _cProgressBar(6),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _cHeaderCard(p), const SizedBox(height: 22),
              _cSampleCard(p), const SizedBox(height: 20),
              _cTabSwitcher(_isDesc, (v) => setState(() => _isDesc = v)),
              const SizedBox(height: 20),
              if (_isDesc) ...[
                const Text("Extrinsic Assessment", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 8),
                TextField(maxLines: 4, onChanged: p.setExtrinsicNote,
                  decoration: InputDecoration(hintText: 'Add notes...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                    contentPadding: const EdgeInsets.all(12))),
              ] else ...[
                const Text("INITIAL ASSESSMENT (1–9)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
                const SizedBox(height: 16),
                _cNumbers(context, "Overall", d.affOverall, p.setAffOverall),
                const SizedBox(height: 24),
                const Text("Uniformity Cups", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (i) {
                    final on = d.uniformCups[i];
                    return GestureDetector(onTap: () => p.toggleUniformCup(i),
                      child: Container(width: 50, height: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            color: on ? _orange : Colors.white,
                            border: Border.all(color: on ? _orange : Colors.grey.shade300)),
                        child: Icon(Icons.local_cafe_outlined, color: on ? Colors.white : Colors.grey.shade400, size: 24)));
                  })),
                const SizedBox(height: 20),
                const Text("Defective Cups (Clean Cup)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (i) {
                    final on = d.cleanCups[i];
                    return GestureDetector(onTap: () => p.toggleCleanCup(i),
                      child: Container(width: 50, height: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            color: on ? _red : Colors.white,
                            border: Border.all(color: on ? _red : Colors.grey.shade300)),
                        child: Icon(Icons.local_cafe_outlined, color: on ? Colors.white : Colors.grey.shade400, size: 24)));
                  })),
                const SizedBox(height: 24),
                const Text("Defect Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                ...d.defects.entries.map((e) => _defectItem(e.key, e.value, () => p.toggleDefect(e.key))),
              ],
              const SizedBox(height: 24),
              _cNote(_note, p.setStep6Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }

  Widget _defectItem(String title, bool checked, VoidCallback onTap) =>
      Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: checked ? primaryColor2 : Colors.grey.shade300, width: 1.5)),
        child: InkWell(onTap: onTap, child: Row(children: [
          Container(width: 24, height: 24, padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(color: Colors.white,
                border: Border.all(color: checked ? primaryColor2 : Colors.grey.shade400, width: 2),
                borderRadius: BorderRadius.circular(4)),
            child: checked ? Container(decoration: BoxDecoration(color: primaryColor2, borderRadius: BorderRadius.circular(2)),
                child: const Icon(Icons.check, size: 14, color: Colors.white)) : null),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ])));
}

// ─────────────────────────────────────────────────────────────────────────────
// CHART — แสดงผลหลัง submit
// ─────────────────────────────────────────────────────────────────────────────
class _CombinedChart extends StatefulWidget {
  final CombinedProvider provider;
  const _CombinedChart({required this.provider});
  @override State<_CombinedChart> createState() => _CombinedChartState();
}

class _CombinedChartState extends State<_CombinedChart> {
  int _selectedSampleIndex = 0;
  static const _barBlue = Color(0xFF1A3A8F);
  static const _orange = Color(0xFFFF8D28);
  static const _red = Color(0xFFB3261E);

  CombinedSampleData? get _data => widget.provider.allDataForIndex(_selectedSampleIndex);
  SampleModel? get _sample => widget.provider.session?.samples[_selectedSampleIndex];

  @override
  Widget build(BuildContext context) {
    final session = widget.provider.session;
    final d = _data;
    if (d == null) return Scaffold(backgroundColor: Colors.white, body: const Center(child: Text("No data")));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _cAppBar("Combined Form"),
      bottomNavigationBar: SafeArea(child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade300))),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(widget.provider),
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColor2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              padding: const EdgeInsets.symmetric(vertical: 16)),
          child: const Text("Done", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))))),
      body: SingleChildScrollView(padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _cHeaderCard(widget.provider),
          const SizedBox(height: 16),
          _buildSampleSelector(session),
          const SizedBox(height: 24),

          // ── Descriptive Section ────────────────────────────────────────
          const Text("Descriptive Form", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _bar("Fragrance",  d.fragrance),
          _bar("Aroma",      d.aroma),
          _bar("Flavor",     d.flavor),
          _bar("Aftertaste", d.aftertaste),
          _bar("Acidity",    d.acidity),
          _bar("Sweetness",  d.sweetness),
          _bar("Mouthfeel",  d.mouthfeel),

          if (d.fragranceAromaDescriptors.isNotEmpty) ...[
            const SizedBox(height: 12),
            _chipSection("Fragrance / Aroma", d.fragranceAromaDescriptors),
          ],
          if (d.flavorAftertasteDescriptors.isNotEmpty) ...[
            const SizedBox(height: 12),
            _chipSection("Flavor / Aftertaste", d.flavorAftertasteDescriptors),
          ],
          if (d.mainTastes.isNotEmpty) ...[
            const SizedBox(height: 12),
            _chipSection("Main Tastes", d.mainTastes),
          ],
          if (d.mouthfeelDescriptors.isNotEmpty) ...[
            const SizedBox(height: 12),
            _chipSection("Mouthfeel", d.mouthfeelDescriptors),
          ],
          const SizedBox(height: 20),

          // Radar Descriptive
          const Text("Descriptive Result", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(height: 280, child: CustomPaint(
            painter: _RadarPainter(values: [
              d.fragrance/15, d.aroma/15, d.flavor/15, d.aftertaste/15,
              d.acidity/15, d.sweetness/15, d.mouthfeel/15,
            ], labels: const ["Fragrance","Aroma","Flavor","Aftertaste","Acidity","Sweetness","Mouthfeel"],
               color: secondaryColor2),
            child: Container())),
          const SizedBox(height: 32),

          // ── Affective Section ──────────────────────────────────────────
          const Text("Affective Form", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _affBar("Fragrance",  d.affFragrance),
          _affBar("Aroma",      d.affAroma),
          _affBar("Flavor",     d.affFlavor),
          _affBar("Aftertaste", d.affAftertaste),
          _affBar("Acidity",    d.affAcidity),
          _affBar("Sweetness",  d.affSweetness),
          _affBar("Mouthfeel",  d.affMouthfeel),
          _affBar("Overall",    d.affOverall),
          const SizedBox(height: 16),

          // Uniformity + Clean Cup
          _cupRow("Non Uniform Cups", d.uniformCups, _orange),
          const SizedBox(height: 16),
          _cupRow("Defective Cups", d.cleanCups, _red),
          const SizedBox(height: 16),

          if (d.defects.values.any((v) => v)) ...[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Defect Type", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(d.defects.entries.where((e) => e.value).map((e) => e.key).join(", "),
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            ]),
            const SizedBox(height: 16),
          ],

          // Score summary
          _scoreSummary(d),
          const SizedBox(height: 24),

          // Radar Affective
          const Text("Affective Result", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(height: 280, child: CustomPaint(
            painter: _RadarPainter(values: [
              (d.affFragrance??0)/9, (d.affAroma??0)/9, (d.affFlavor??0)/9,
              (d.affAftertaste??0)/9, (d.affAcidity??0)/9, (d.affSweetness??0)/9,
              (d.affMouthfeel??0)/9,
            ], labels: const ["Fragrance","Aroma","Flavor","Aftertaste","Acidity","Sweetness","Mouthfeel"],
               color: const Color(0xFF1A3A8F)),
            child: Container())),
          const SizedBox(height: 32),
        ])),
    );
  }

  Widget _buildSampleSelector(SessionModel? session) {
    final count = session?.samples.length ?? 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(_sample?.name ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(_sample?.roastLevel ?? "", style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: List.generate(count, (i) {
          final sel = _selectedSampleIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedSampleIndex = i),
            child: Container(width: 44, height: 44,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  color: sel ? secondaryColor2 : Colors.white,
                  border: Border.all(color: sel ? secondaryColor2 : Colors.grey.shade300)),
              child: Center(child: Text("${i+1}", style: TextStyle(
                  color: sel ? Colors.white : Colors.black, fontWeight: FontWeight.bold)))));
        })),
      ]),
    );
  }

  Widget _bar(String label, double score) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        Text("${score.toStringAsFixed(0)}/15", style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13,
            color: score > 0 ? _barBlue : Colors.grey.shade400)),
      ]),
      const SizedBox(height: 5),
      ClipRRect(borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(value: score/15, minHeight: 8,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(score > 0 ? _barBlue : Colors.grey.shade300))),
    ]));

  Widget _affBar(String label, int? score) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        Text("${score ?? '—'}/9", style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13,
            color: (score ?? 0) > 0 ? _barBlue : Colors.grey.shade400)),
      ]),
      const SizedBox(height: 5),
      ClipRRect(borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(value: (score ?? 0)/9, minHeight: 8,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>((score ?? 0) > 0 ? _barBlue : Colors.grey.shade300))),
    ]));

  Widget _chipSection(String title, List<String> items) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 6),
        Wrap(spacing: 8, runSpacing: 4, children: items.map((d) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFF1E52C6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1E52C6).withOpacity(0.3))),
          child: Text(d, style: const TextStyle(fontSize: 12, color: Color(0xFF1E52C6))))).toList()),
      ]);

  Widget _cupRow(String label, List<bool> cups, Color activeColor) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Text("${cups.where((v)=>v).length}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (i) => Container(width: 46, height: 46,
            decoration: BoxDecoration(shape: BoxShape.circle,
                color: cups[i] ? activeColor : Colors.white,
                border: Border.all(color: cups[i] ? activeColor : Colors.grey.shade300)),
            child: Icon(Icons.local_cafe_outlined,
                color: cups[i] ? Colors.white : Colors.grey.shade400, size: 22)))),
      ]);

  Widget _scoreSummary(CombinedSampleData d) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: secondaryColor2.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: secondaryColor2.withOpacity(0.2))),
    child: Column(children: [
      _sumRow("Descriptive Total", d.descriptiveTotal.toStringAsFixed(1), null),
      const Divider(height: 16),
      _sumRow("Affective Total", d.affectiveTotal.toStringAsFixed(1), null),
      const SizedBox(height: 4),
      _sumRow("Uniformity", "+${d.uniformCups.where((v)=>v).length * 2}", Colors.green),
      const SizedBox(height: 4),
      _sumRow("Clean Cup", "+${d.cleanCups.where((v)=>v).length * 2}", Colors.green),
      if (d.defects.values.any((v)=>v)) ...[
        const SizedBox(height: 4),
        _sumRow("Defect Penalty", "-${d.defects.values.where((v)=>v).length * 4}", Colors.red),
      ],
    ]));

  Widget _sumRow(String label, String val, Color? color) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        Text(val, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color ?? Colors.black87)),
      ]);
}

// ── Balloon Slider ───────────────────────────────────────────────────────────
class _CBalloon extends SliderComponentShape {
  final double thumbRadius; final int thumbValue; final Color color;
  const _CBalloon({required this.thumbRadius, required this.thumbValue, required this.color});
  @override Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.fromRadius(thumbRadius);
  @override
  void paint(PaintingContext context, Offset center, {
    required Animation<double> activationAnimation, required Animation<double> enableAnimation,
    required bool isDiscrete, required TextPainter labelPainter, required RenderBox parentBox,
    required SliderThemeData sliderTheme, TextDirection? textDirection,
    double? value, double? textScaleFactor, Size? sizeWithOverflow}) {
    final canvas = context.canvas;
    final paint = Paint()..color = color;
    canvas.drawCircle(center, thumbRadius, paint);
    canvas.drawCircle(center, thumbRadius, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 3);
    const bW = 64.0; const bH = 40.0; const tH = 8.0;
    final bC = center + const Offset(0, -(bH + tH - 10));
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: bC, width: bW, height: bH), const Radius.circular(20)), paint);
    canvas.drawPath(Path()..moveTo(center.dx-5, bC.dy+bH/2)..lineTo(center.dx, bC.dy+bH/2+tH)..lineTo(center.dx+5, bC.dy+bH/2)..close(), paint);
    final tp = TextPainter(text: TextSpan(text: thumbValue.toString(),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
        textDirection: TextDirection.ltr)..layout();
    tp.paint(canvas, Offset(bC.dx - tp.width/2, bC.dy - tp.height/2));
  }
}

// ── Radar Chart ──────────────────────────────────────────────────────────────
class _RadarPainter extends CustomPainter {
  final List<double> values; final List<String> labels; final Color color;
  const _RadarPainter({required this.values, required this.labels, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width/2, size.height/2);
    final radius = min(size.width, size.height)/2 - 48;
    final count = values.length;
    final step = (2*pi)/count;
    final grid = Paint()..color = Colors.grey.shade300..style = PaintingStyle.stroke..strokeWidth = 0.8;
    for (int lvl = 1; lvl <= 5; lvl++) {
      final r = radius*lvl/5; final path = Path();
      for (int i = 0; i < count; i++) {
        final a = -pi/2+i*step; final p = Offset(center.dx+r*cos(a), center.dy+r*sin(a));
        i==0?path.moveTo(p.dx,p.dy):path.lineTo(p.dx,p.dy); }
      path.close(); canvas.drawPath(path, grid); }
    for (int i = 0; i < count; i++) {
      final a = -pi/2+i*step;
      canvas.drawLine(center, Offset(center.dx+radius*cos(a), center.dy+radius*sin(a)), grid); }
    final fill = Paint()..color = color.withOpacity(0.2)..style = PaintingStyle.fill;
    final stroke = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2;
    final dot = Paint()..color = color..style = PaintingStyle.fill;
    final dataPath = Path();
    for (int i = 0; i < count; i++) {
      final a = -pi/2+i*step; final r = radius*values[i].clamp(0.0,1.0);
      final p = Offset(center.dx+r*cos(a), center.dy+r*sin(a));
      i==0?dataPath.moveTo(p.dx,p.dy):dataPath.lineTo(p.dx,p.dy); }
    dataPath.close(); canvas.drawPath(dataPath, fill); canvas.drawPath(dataPath, stroke);
    for (int i = 0; i < count; i++) {
      final a = -pi/2+i*step; final r = radius*values[i].clamp(0.0,1.0);
      canvas.drawCircle(Offset(center.dx+r*cos(a), center.dy+r*sin(a)), 4, dot); }
    for (int i = 0; i < count; i++) {
      final a = -pi/2+i*step; final lR = radius+32;
      final tp = TextPainter(text: TextSpan(text: labels[i],
          style: const TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.w500)),
          textDirection: TextDirection.ltr, textAlign: TextAlign.center)..layout(maxWidth: 72);
      tp.paint(canvas, Offset(center.dx+lR*cos(a)-tp.width/2, center.dy+lR*sin(a)-tp.height/2)); }
  }
  @override bool shouldRepaint(covariant CustomPainter _) => true;
}