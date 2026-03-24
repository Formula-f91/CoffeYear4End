// lib/cupping/Quickmode/combined_result_step1.dart
//
// Quick Mode — 2 step input + Result chart รวมในไฟล์เดียว
// ใช้ Inner Navigator pattern เหมือน Affective/Descriptive/Combined
//
import 'dart:math';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Quickmode/quick_mode_provider.dart';
import 'package:coffee/cupping/formdescriptor/defect_descriptor_sheet.dart';
import 'package:coffee/cupping/formdescriptor/flavor_descriptor_sheet.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ── Entry point ───────────────────────────────────────────────────────────────
class CombinedResult extends StatelessWidget {
  final SessionModel? session;
  const CombinedResult({super.key, this.session});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final p = QuickModeProvider();
        if (session != null) p.init(session!);
        return p;
      },
      child: const _QuickNavigator(),
    );
  }
}

class _QuickNavigator extends StatelessWidget {
  const _QuickNavigator();
  @override
  Widget build(BuildContext context) => Navigator(
    onGenerateRoute: (s) => MaterialPageRoute(
      settings: s, builder: (_) => const _Step1()),
  );
}

// ── Shared helpers ─────────────────────────────────────────────────────────────

AppBar _qAppBar(String title, {VoidCallback? onBack}) => AppBar(
  backgroundColor: Colors.white, elevation: 0, scrolledUnderElevation: 0,
  centerTitle: true, automaticallyImplyLeading: false,
  leading: onBack != null
      ? IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20), onPressed: onBack)
      : null,
  title: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
  bottom: PreferredSize(preferredSize: const Size.fromHeight(1),
      child: Container(color: Colors.grey.shade300, height: 1)),
);

Widget _qHeader(QuickModeProvider p) {
  final session = p.session;
  final now = DateTime.now();
  final date = "${now.day.toString().padLeft(2,'0')}.${now.month.toString().padLeft(2,'0')}.${now.year}";
  return Container(
    padding: const EdgeInsets.all(16),
    color: secondaryColor2,
    child: Row(children: [
      const CircleAvatar(radius: 25, backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/photo/coffepro.png')),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(session?.cuppingName ?? "Quick Mode",
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis, maxLines: 1),
        Text("Date : $date  •  ${p.totalSamples} samples",
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ])),
    ]),
  );
}

Widget _qSampleCard(QuickModeProvider p, {bool showScore = false}) {
  final sample = p.currentSample;
  final d = p.currentData;
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white,
        border: Border.all(color: const Color(0xFFA2A2A2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(sample?.name ?? "Coffee Name",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          Text(sample?.roastLevel ?? "",
              style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ])),
        Container(height: 40, width: 1, color: primaryColor2, margin: const EdgeInsets.symmetric(horizontal: 12)),
        Column(children: [
          const Text("Total Cup", style: TextStyle(fontSize: 13)),
          Text("${p.totalSamples}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ]),
        if (showScore) ...[
          Container(height: 40, width: 1, color: primaryColor2, margin: const EdgeInsets.symmetric(horizontal: 12)),
          Column(children: [
            const Text("Score", style: TextStyle(fontSize: 13)),
            Text(d.score.toStringAsFixed(0),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: secondaryColor2)),
          ]),
        ],
      ]),
      const SizedBox(height: 16),
      const Text("Select coffee", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8,
        children: List.generate(p.totalSamples, (i) {
          final sel = p.currentSampleIndex == i;
          return GestureDetector(
            onTap: () => p.selectSample(i),
            child: Container(width: 46, height: 46,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  color: sel ? secondaryColor2 : Colors.white,
                  border: Border.all(color: sel ? secondaryColor2 : Colors.grey.shade300)),
              child: Center(child: Text("${i+1}", style: TextStyle(
                  color: sel ? Colors.white : Colors.black, fontWeight: FontWeight.bold)))));
        })),
    ]),
  );
}

Widget _qBottomNav(BuildContext ctx, {required VoidCallback onBack, required VoidCallback onNext, String nextLabel = "Next"}) =>
    SafeArea(child: Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1))),
      child: Row(children: [
        Expanded(child: OutlinedButton(onPressed: onBack,
          style: OutlinedButton.styleFrom(side: BorderSide(color: secondaryColor2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          child: Text("Back", style: TextStyle(color: secondaryColor2, fontSize: 18)))),
        const SizedBox(width: 16),
        Expanded(flex: 2, child: ElevatedButton(onPressed: onNext,
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColor2,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          child: Text(nextLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
      ]),
    ));

Widget _qDescriptorBox(List<String> items, void Function(String) onRemove,
    {bool isDefect = false}) {
  return Container(
    width: double.infinity, constraints: const BoxConstraints(minHeight: 120),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8)),
    child: items.isEmpty
        ? const Center(child: Text('No descriptors added yet.\nTap Add descriptors.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 13)))
        : Wrap(spacing: 8, runSpacing: 8, children: items.map((d) {
            Color color;
            String emoji = '•';
            String? image;
            if (isDefect) {
              final s = DefectDescriptorSheet.resolveStyle(d);
              color = s['color'] as Color;
            } else {
              final s = FlavorDescriptorSheet.resolveStyle(d);
              color = s['color'] as Color;
              emoji = (s['emoji'] as String?) ?? '•';
              image = s['image'] as String?;
            }
            return GestureDetector(
              onTap: () => onRemove(d),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    color: isDefect ? color.withOpacity(0.12) : color.withOpacity(0.7),
                    border: Border.all(color: color.withOpacity(isDefect ? 0.5 : 0.6)),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  if (image != null) ...[
                    Image.asset(image, width: 16, height: 16, fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Text(emoji, style: const TextStyle(fontSize: 14))),
                    const SizedBox(width: 5),
                  ] else if (!isDefect) ...[
                    Text(emoji, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 5),
                  ],
                  Text(d, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,
                      color: isDefect ? Colors.black : Colors.white)),
                  const SizedBox(width: 4),
                  Icon(Icons.cancel, size: 14, color: isDefect ? color : Colors.black),
                ]),
              ));
          }).toList()),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 1 — Flavor + Defects + Score + Re-roast + Note
// ─────────────────────────────────────────────────────────────────────────────
class _Step1 extends StatefulWidget {
  const _Step1();
  @override State<_Step1> createState() => _Step1State();
}
class _Step1State extends State<_Step1> {
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  void _showFlavorSheet(QuickModeProvider p) {
    showModalBottomSheet(context: context, isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => FlavorDescriptorSheet(
        initialSelected: List.from(p.currentData.flavorDescriptors),
        onApply: (s) {
          final merged = {...p.currentData.flavorDescriptors, ...s}.toList();
          p.setFlavorDescriptors(merged);
          Navigator.pop(context);
        }));
  }

  void _showDefectSheet(QuickModeProvider p) {
    showModalBottomSheet(context: context, isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DefectDescriptorSheet(
        initialSelected: List.from(p.currentData.defectDescriptors),
        onApply: (s) {
          final merged = {...p.currentData.defectDescriptors, ...s}.toList();
          p.setDefectDescriptors(merged);
          Navigator.pop(context);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickModeProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.note) _note.text = d.note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _qAppBar("Quick Mode",
            onBack: () => Navigator.of(context, rootNavigator: true).pop()),
        bottomNavigationBar: _qBottomNav(context,
          onBack: () => Navigator.of(context, rootNavigator: true).pop(),
          onNext: () {
            p.setNote(_note.text);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step2()));
          }),
        body: SingleChildScrollView(padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _qHeader(p), const SizedBox(height: 22),
            _qSampleCard(p), const SizedBox(height: 20),

            // ── Flavor ──────────────────────────────────────────────────────
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Flavor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ElevatedButton(
                onPressed: () => _showFlavorSheet(p),
                style: ElevatedButton.styleFrom(backgroundColor: secondaryColor2,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0),
                child: const Text('Add descriptors', style: TextStyle(fontSize: 13))),
            ]),
            const SizedBox(height: 8),
            _qDescriptorBox(d.flavorDescriptors,
                (x) => p.setFlavorDescriptors(List.from(d.flavorDescriptors)..remove(x))),
            const SizedBox(height: 20),

            // ── Defects ──────────────────────────────────────────────────────
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Defects", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ElevatedButton(
                onPressed: () => _showDefectSheet(p),
                style: ElevatedButton.styleFrom(backgroundColor: secondaryColor2,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0),
                child: const Text('Add descriptors', style: TextStyle(fontSize: 13))),
            ]),
            const SizedBox(height: 8),
            _qDescriptorBox(d.defectDescriptors,
                (x) => p.setDefectDescriptors(List.from(d.defectDescriptors)..remove(x)),
                isDefect: true),
            const SizedBox(height: 20),

            // ── Score ────────────────────────────────────────────────────────
            Row(children: [
              const Text("Score", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const Spacer(),
              IconButton(
                onPressed: () { if (d.score > 0) p.setScore(d.score - 1); },
                icon: const Icon(Icons.remove), padding: EdgeInsets.zero,
                constraints: const BoxConstraints()),
              const SizedBox(width: 12),
              Text("${d.score.toInt()}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => p.setScore(d.score + 1),
                icon: const Icon(Icons.add), padding: EdgeInsets.zero,
                constraints: const BoxConstraints()),
            ]),
            const SizedBox(height: 24),

            // ── Re-roast ─────────────────────────────────────────────────────
            const Text("RE-ROAST REQUEST",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            const Text("Do you want to re-roast this sample?",
                style: TextStyle(color: Colors.black87, fontSize: 13)),
            const SizedBox(height: 10),
            _reRoastOption(true, d.reRoastRequested, p),
            _reRoastOption(false, d.reRoastRequested, p),
            const SizedBox(height: 20),

            // ── Note ─────────────────────────────────────────────────────────
            const Text("Note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            TextField(controller: _note, maxLines: 4, onChanged: p.setNote,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: secondaryColor2, width: 1.5)),
                contentPadding: const EdgeInsets.all(12))),
            const SizedBox(height: 40),
          ])),
      );
    });
  }

  Widget _reRoastOption(bool value, bool current, QuickModeProvider p) =>
      GestureDetector(
        onTap: () => p.setReRoast(value),
        child: Container(
          decoration: BoxDecoration(
              color: (current == value) ? primaryColor2.withOpacity(0.08) : null,
              borderRadius: BorderRadius.circular(8),
              border: (current == value) ? Border.all(color: primaryColor2.withOpacity(0.3)) : null),
          child: Row(children: [
            Radio<bool>(value: value, groupValue: current,
                activeColor: primaryColor2, onChanged: (_) => p.setReRoast(value)),
            Text(value ? "Yes" : "No", style: const TextStyle(fontSize: 15)),
          ])));
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 2 — Summary per sample (all samples overview before submit)
// ─────────────────────────────────────────────────────────────────────────────
class _Step2 extends StatelessWidget {
  const _Step2();

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickModeProvider>(builder: (_, p, __) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _qAppBar("Quick Mode"),
        bottomNavigationBar: _qBottomNav(context,
          onBack: () => Navigator.pop(context),
          nextLabel: "Submit",
          onNext: () {
            debugPrint("Quick Mode Submit: ${p.buildSubmitPayload()}");
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => _QuickChart(provider: p)));
          }),
        body: SingleChildScrollView(padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _qHeader(p), const SizedBox(height: 22),

            const Text("Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            ...List.generate(p.totalSamples, (i) {
              final d = p.allDataForIndex(i)!;
              final sample = p.session?.samples[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.06),
                        blurRadius: 6, offset: const Offset(0, 3))]),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(child: Text(sample?.name ?? "Sample ${i+1}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(color: secondaryColor2,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("${d.score.toInt()}",
                          style: const TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  ]),
                  const SizedBox(height: 4),
                  Text(sample?.roastLevel ?? "",
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  const SizedBox(height: 12),

                  if (d.flavorDescriptors.isNotEmpty) ...[
                    const Text("Flavor", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 6),
                    Wrap(spacing: 6, runSpacing: 4,
                      children: d.flavorDescriptors.map((fl) {
                        final s = FlavorDescriptorSheet.resolveStyle(fl);
                        final c = s['color'] as Color;
                        return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: c.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(fl, style: const TextStyle(color: Colors.white, fontSize: 12)));
                      }).toList()),
                    const SizedBox(height: 10),
                  ],

                  if (d.defectDescriptors.isNotEmpty) ...[
                    const Text("Defects", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 6),
                    Wrap(spacing: 6, runSpacing: 4,
                      children: d.defectDescriptors.map((df) {
                        final s = DefectDescriptorSheet.resolveStyle(df);
                        final c = s['color'] as Color;
                        return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: c.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: c.withOpacity(0.5))),
                          child: Text(df, style: TextStyle(color: c, fontSize: 12,
                              fontWeight: FontWeight.w500)));
                      }).toList()),
                    const SizedBox(height: 10),
                  ],

                  Row(children: [
                    Icon(d.reRoastRequested ? Icons.refresh : Icons.check_circle_outline,
                        size: 16, color: d.reRoastRequested ? Colors.orange : Colors.green),
                    const SizedBox(width: 6),
                    Text(d.reRoastRequested ? "Re-roast requested" : "No re-roast",
                        style: TextStyle(fontSize: 13,
                            color: d.reRoastRequested ? Colors.orange : Colors.green)),
                  ]),

                  if (d.note.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text("Note: ${d.note}",
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ]),
              );
            }),
            const SizedBox(height: 20),
          ])),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CHART — Result screen
// ─────────────────────────────────────────────────────────────────────────────
class _QuickChart extends StatefulWidget {
  final QuickModeProvider provider;
  const _QuickChart({required this.provider});
  @override State<_QuickChart> createState() => _QuickChartState();
}

class _QuickChartState extends State<_QuickChart> {
  int _selectedSampleIndex = 0;

  QuickModeSampleData? get _data =>
      widget.provider.allDataForIndex(_selectedSampleIndex);
  SampleModel? get _sample =>
      widget.provider.session?.samples[_selectedSampleIndex];

  @override
  Widget build(BuildContext context) {
    final session = widget.provider.session;
    final d = _data;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _qAppBar("Quick Mode"),
      bottomNavigationBar: SafeArea(child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300))),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(widget.provider),
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColor2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              padding: const EdgeInsets.symmetric(vertical: 16)),
          child: const Text("Done", style: TextStyle(color: Colors.white,
              fontSize: 18, fontWeight: FontWeight.bold))))),
      body: d == null
          ? const Center(child: Text("No data"))
          : SingleChildScrollView(padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _qHeader(widget.provider),
                const SizedBox(height: 16),

                // ── Sample selector ──────────────────────────────────────────
                _buildSampleSelector(session),
                const SizedBox(height: 24),

                // ── Score display ────────────────────────────────────────────
                Container(
                  width: double.infinity, padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: secondaryColor2.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: secondaryColor2.withOpacity(0.2))),
                  child: Column(children: [
                    Text("${_sample?.name ?? 'Score'}",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text("${d.score.toInt()}",
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold,
                            color: secondaryColor2)),
                    const SizedBox(height: 4),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(d.reRoastRequested ? Icons.refresh : Icons.check_circle,
                          size: 18,
                          color: d.reRoastRequested ? Colors.orange : Colors.green),
                      const SizedBox(width: 6),
                      Text(d.reRoastRequested ? "Re-roast requested" : "Approved",
                          style: TextStyle(fontSize: 14,
                              color: d.reRoastRequested ? Colors.orange : Colors.green,
                              fontWeight: FontWeight.w500)),
                    ]),
                  ])),
                const SizedBox(height: 24),

                // ── Average across all samples ────────────────────────────────
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text("Session Average",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(widget.provider.averageScore.toStringAsFixed(1),
                      style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20, color: secondaryColor2)),
                ]),
                const SizedBox(height: 24),

                // ── Flavor descriptors ────────────────────────────────────────
                if (d.flavorDescriptors.isNotEmpty) ...[
                  const Text("Flavor Descriptors",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  Wrap(spacing: 8, runSpacing: 6,
                    children: d.flavorDescriptors.map((fl) {
                      final s = FlavorDescriptorSheet.resolveStyle(fl);
                      final c = s['color'] as Color;
                      final emoji = (s['emoji'] as String?) ?? '•';
                      final image = s['image'] as String?;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: c.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          if (image != null)
                            Image.asset(image, width: 16, height: 16, fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Text(emoji))
                          else Text(emoji, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 6),
                          Text(fl, style: const TextStyle(color: Colors.white,
                              fontSize: 13, fontWeight: FontWeight.w600)),
                        ]));
                    }).toList()),
                  const SizedBox(height: 20),
                ],

                // ── Defect descriptors ────────────────────────────────────────
                if (d.defectDescriptors.isNotEmpty) ...[
                  const Text("Defects",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  Wrap(spacing: 8, runSpacing: 6,
                    children: d.defectDescriptors.map((df) {
                      final s = DefectDescriptorSheet.resolveStyle(df);
                      final c = s['color'] as Color;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: c.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: c.withOpacity(0.5))),
                        child: Text(df, style: TextStyle(fontSize: 13,
                            color: c, fontWeight: FontWeight.w600)));
                    }).toList()),
                  const SizedBox(height: 20),
                ],

                // ── Note ─────────────────────────────────────────────────────
                if (d.note.isNotEmpty) ...[
                  const Text("Note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  Container(width: double.infinity, padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Text(d.note, style: const TextStyle(fontSize: 14))),
                  const SizedBox(height: 24),
                ],

                // ── All samples scores bar ────────────────────────────────────
                const Text("All Samples",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 12),
                ...List.generate(widget.provider.totalSamples, (i) {
                  final sd = widget.provider.allDataForIndex(i)!;
                  final sn = widget.provider.session?.samples[i].name ?? "Sample ${i+1}";
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(sn, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                        Text("${sd.score.toInt()}", style: TextStyle(
                            fontWeight: FontWeight.bold, color: secondaryColor2)),
                      ]),
                      const SizedBox(height: 4),
                      ClipRRect(borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(value: (sd.score / 100).clamp(0.0, 1.0),
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              _selectedSampleIndex == i ? secondaryColor2 : Colors.grey.shade400))),
                    ]));
                }),
                const SizedBox(height: 32),
              ])),
    );
  }

  Widget _buildSampleSelector(SessionModel? session) {
    final count = session?.samples.length ?? 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white,
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(_sample?.name ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: secondaryColor2,
                borderRadius: BorderRadius.circular(20)),
            child: Text("${_data?.score.toInt() ?? 0}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ]),
        Text(_sample?.roastLevel ?? "",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
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
                  color: sel ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold)))));
        })),
      ]),
    );
  }
}