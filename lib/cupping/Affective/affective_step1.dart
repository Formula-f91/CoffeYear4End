// lib/cupping/Affective/affective_step1.dart
//
// รวมทุก step (1-7) + Success ไว้ในไฟล์เดียว
// ใช้ Navigator ภายในครอบทุก route ให้อยู่ใต้ ChangeNotifierProvider เดียวกัน
// แก้ปัญหา "Lost connection" / provider ถูก dispose เมื่อ push route ใหม่
//
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Affective/affective_chart.dart';
import 'package:coffee/cupping/Affective/affective_provider.dart';
import 'package:coffee/cupping/Affective/affective_widgets.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ── Entry point ───────────────────────────────────────────────────────────────
class AffectiveStep1 extends StatelessWidget {
  final SessionModel session;
  const AffectiveStep1({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AffectiveProvider()..init(session),
      child: const _AffectiveFormNavigator(),
    );
  }
}

// Navigator ภายใน — ทุก route อยู่ใต้ provider เดียวกัน ไม่ถูก dispose
class _AffectiveFormNavigator extends StatelessWidget {
  const _AffectiveFormNavigator();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (_) => const _Step1(),
      ),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────
AppBar _buildAppBar(String title, {VoidCallback? onBack}) => AppBar(
  backgroundColor: Colors.white, elevation: 0, scrolledUnderElevation: 0,
  centerTitle: true, automaticallyImplyLeading: false,
  leading: onBack != null
      ? IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: onBack)
      : null,
  title: Text(title, style: const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
);

const Widget _kAssessmentHeader = Text(
  "INITIAL ASSESSMENT (1–9)",
  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,
      color: Colors.black54, letterSpacing: 0.3),
);

// ─────────────────────────────────────────────────────────────────────────────
// STEP 1 — Fragrance / Aroma
// ─────────────────────────────────────────────────────────────────────────────
class _Step1 extends StatefulWidget {
  const _Step1();
  @override
  State<_Step1> createState() => _Step1State();
}
class _Step1State extends State<_Step1> {
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffectiveProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step1Note) _note.text = d.step1Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar("Affective Form",
            onBack: () => Navigator.of(context, rootNavigator: true).pop()),
        bottomNavigationBar: AffectiveBottomNav(
          onBack: () => Navigator.of(context, rootNavigator: true).pop(),
          onNext: () { p.setStep1Note(_note.text);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step2())); }),
        body: Column(children: [
          const AffectiveProgressBar(currentStep: 1),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AffectiveHeaderCard(provider: p), const SizedBox(height: 22),
              AffectiveSampleCard(provider: p), const SizedBox(height: 20),
              _kAssessmentHeader, const SizedBox(height: 20),
              AffectiveNumberSelector(label: "Fragrance", selectedValue: d.fragrance, onSelect: p.setFragrance),
              const SizedBox(height: 24),
              AffectiveNumberSelector(label: "Aroma", selectedValue: d.aroma, onSelect: p.setAroma),
              const SizedBox(height: 28),
              AffectiveNoteField(controller: _note, onChanged: p.setStep1Note),
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
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffectiveProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step2Note) _note.text = d.step2Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar("Affective Form"),
        bottomNavigationBar: AffectiveBottomNav(
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep2Note(_note.text);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step3())); }),
        body: Column(children: [
          const AffectiveProgressBar(currentStep: 2),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AffectiveHeaderCard(provider: p), const SizedBox(height: 22),
              AffectiveSampleCard(provider: p), const SizedBox(height: 20),
              _kAssessmentHeader, const SizedBox(height: 20),
              AffectiveNumberSelector(label: "Flavor", selectedValue: d.flavor, onSelect: p.setFlavor),
              const SizedBox(height: 24),
              AffectiveNumberSelector(label: "Aftertaste", selectedValue: d.aftertaste, onSelect: p.setAftertaste),
              const SizedBox(height: 28),
              AffectiveNoteField(controller: _note, onChanged: p.setStep2Note),
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
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffectiveProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step3Note) _note.text = d.step3Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar("Affective Form"),
        bottomNavigationBar: AffectiveBottomNav(
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep3Note(_note.text);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step4())); }),
        body: Column(children: [
          const AffectiveProgressBar(currentStep: 3),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AffectiveHeaderCard(provider: p), const SizedBox(height: 22),
              AffectiveSampleCard(provider: p), const SizedBox(height: 20),
              _kAssessmentHeader, const SizedBox(height: 20),
              AffectiveNumberSelector(label: "Acidity", selectedValue: d.acidity, onSelect: p.setAcidity),
              const SizedBox(height: 28),
              AffectiveNoteField(controller: _note, onChanged: p.setStep3Note),
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
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffectiveProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step4Note) _note.text = d.step4Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar("Affective Form"),
        bottomNavigationBar: AffectiveBottomNav(
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep4Note(_note.text);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step5())); }),
        body: Column(children: [
          const AffectiveProgressBar(currentStep: 4),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AffectiveHeaderCard(provider: p), const SizedBox(height: 22),
              AffectiveSampleCard(provider: p), const SizedBox(height: 20),
              _kAssessmentHeader, const SizedBox(height: 20),
              AffectiveNumberSelector(label: "Sweetness", selectedValue: d.sweetness, onSelect: p.setSweetness),
              const SizedBox(height: 28),
              AffectiveNoteField(controller: _note, onChanged: p.setStep4Note),
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
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffectiveProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step5Note) _note.text = d.step5Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar("Affective Form"),
        bottomNavigationBar: AffectiveBottomNav(
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep5Note(_note.text);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step6())); }),
        body: Column(children: [
          const AffectiveProgressBar(currentStep: 5),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AffectiveHeaderCard(provider: p), const SizedBox(height: 22),
              AffectiveSampleCard(provider: p), const SizedBox(height: 20),
              _kAssessmentHeader, const SizedBox(height: 20),
              AffectiveNumberSelector(label: "Mouthfeel", selectedValue: d.mouthfeel, onSelect: p.setMouthfeel),
              const SizedBox(height: 28),
              AffectiveNoteField(controller: _note, onChanged: p.setStep5Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 6 — Overall
// ─────────────────────────────────────────────────────────────────────────────
class _Step6 extends StatefulWidget {
  const _Step6();
  @override State<_Step6> createState() => _Step6State();
}
class _Step6State extends State<_Step6> {
  final _note = TextEditingController();
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffectiveProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step6Note) _note.text = d.step6Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar("Affective Form"),
        bottomNavigationBar: AffectiveBottomNav(
          onBack: () => Navigator.pop(context),
          onNext: () { p.setStep6Note(_note.text);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const _Step7())); }),
        body: Column(children: [
          const AffectiveProgressBar(currentStep: 6),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AffectiveHeaderCard(provider: p), const SizedBox(height: 22),
              AffectiveSampleCard(provider: p), const SizedBox(height: 20),
              _kAssessmentHeader, const SizedBox(height: 20),
              AffectiveNumberSelector(label: "Overall", selectedValue: d.overall, onSelect: p.setOverall),
              const SizedBox(height: 28),
              AffectiveNoteField(controller: _note, onChanged: p.setStep6Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 7 — Uniformity / Clean Cup / Defects
// ─────────────────────────────────────────────────────────────────────────────
class _Step7 extends StatefulWidget {
  const _Step7();
  @override State<_Step7> createState() => _Step7State();
}
class _Step7State extends State<_Step7> {
  final _note = TextEditingController();
  static const _orange = Color(0xFFFF8D28);
  static const _red    = Color(0xFFB3261E);
  @override void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<AffectiveProvider>(builder: (_, p, __) {
      final d = p.currentData;
      if (_note.text != d.step7Note) _note.text = d.step7Note;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar("Affective Form"),
        bottomNavigationBar: AffectiveBottomNav(
          nextLabel: "Submit",
          onBack: () => Navigator.pop(context),
          onNext: () {
            p.setStep7Note(_note.text);
            Navigator.push(context, MaterialPageRoute(
                builder: (_) => AffectiveChartScreen(provider: p)));
          }),
        body: Column(children: [
          const AffectiveProgressBar(currentStep: 7),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AffectiveHeaderCard(provider: p), const SizedBox(height: 22),
              AffectiveSampleCard(provider: p), const SizedBox(height: 20),

              const Text("Uniformity Cups",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (i) {
                  final on = d.uniformCups[i];
                  return GestureDetector(onTap: () => p.toggleUniformCup(i),
                    child: Container(width: 50, height: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle,
                        color: on ? _orange : Colors.white,
                        border: Border.all(color: on ? _orange : Colors.grey.shade300)),
                      child: Icon(Icons.local_cafe_outlined,
                          color: on ? Colors.white : Colors.grey.shade400, size: 24)));
                })),

              const SizedBox(height: 20),
              const Text("Defective Cups (Clean Cup)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (i) {
                  final on = d.cleanCups[i];
                  return GestureDetector(onTap: () => p.toggleCleanCup(i),
                    child: Container(width: 50, height: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle,
                        color: on ? _red : Colors.white,
                        border: Border.all(color: on ? _red : Colors.grey.shade300)),
                      child: Icon(Icons.local_cafe_outlined,
                          color: on ? Colors.white : Colors.grey.shade400, size: 24)));
                })),

              const SizedBox(height: 24),
              const Text("Defect Type",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              ...d.defects.entries.map((e) =>
                  _defectItem(e.key, e.value, () => p.toggleDefect(e.key))),
              const SizedBox(height: 24),
              AffectiveNoteField(controller: _note, onChanged: p.setStep7Note),
              const SizedBox(height: 40),
            ]))),
        ]),
      );
    });
  }

  Widget _defectItem(String title, bool checked, VoidCallback onTap) =>
    Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: checked ? primaryColor2 : Colors.grey.shade300, width: 1.5)),
      child: InkWell(onTap: onTap, child: Row(children: [
        Container(width: 24, height: 24, padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.white,
            border: Border.all(
                color: checked ? primaryColor2 : Colors.grey.shade400, width: 2),
            borderRadius: BorderRadius.circular(4)),
          child: checked ? Container(
            decoration: BoxDecoration(color: primaryColor2,
                borderRadius: BorderRadius.circular(2)),
            child: const Icon(Icons.check, size: 14, color: Colors.white)) : null),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ])),
    );
}

// ─────────────────────────────────────────────────────────────────────────────
// SUCCESS
// ─────────────────────────────────────────────────────────────────────────────
class _Success extends StatelessWidget {
  final AffectiveProvider provider;
  const _Success({required this.provider});

  @override
  Widget build(BuildContext context) {
    final session = provider.session;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar("Assessment Complete"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 16),
          Container(width: 80, height: 80,
            decoration: BoxDecoration(
                color: secondaryColor2.withOpacity(0.12), shape: BoxShape.circle),
            child: Icon(Icons.check_circle_outline_rounded,
                size: 52, color: secondaryColor2)),
          const SizedBox(height: 16),
          const Text("Submitted!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          if (session != null) ...[
            const SizedBox(height: 4),
            Text(session.cuppingName,
                style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ],
          const SizedBox(height: 32),
          if (session != null)
            ...session.samples.asMap().entries.map((e) {
              final data = provider.allDataForIndex(e.key);
              if (data == null) return const SizedBox.shrink();
              return _scoreCard(e.key, e.value.name, e.value.roastLevel, data);
            }),
          const SizedBox(height: 32),
          SizedBox(width: double.infinity,
            child: ElevatedButton(
              // Done → กลับออกไปจาก AffectiveStep1 ทั้งหมด (rootNavigator)
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text("Done", style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))),
        ]),
      ),
    );
  }

  Widget _scoreCard(int i, String name, String roast, dynamic d) {
    final scores = <String, int?>{
      'Fragrance': d.fragrance, 'Aroma': d.aroma, 'Flavor': d.flavor,
      'Aftertaste': d.aftertaste, 'Acidity': d.acidity,
      'Sweetness': d.sweetness, 'Mouthfeel': d.mouthfeel, 'Overall': d.overall,
    };
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: secondaryColor2.withOpacity(0.08),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("#${i + 1}  $name",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(roast, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(d.finalScore.toStringAsFixed(1), style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: secondaryColor2)),
              const Text("Final Score",
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ]),
          ])),
        Padding(padding: const EdgeInsets.all(16), child: Column(children: [
          Wrap(spacing: 12, runSpacing: 8,
            children: scores.entries.map((e) => SizedBox(width: 130,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(e.key, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                Text(e.value != null ? "${e.value}" : "—",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ]))).toList()),
          const Divider(height: 20),
          _row("Uniformity",     "+${d.uniformityScore}", Colors.green),
          const SizedBox(height: 4),
          _row("Clean Cup",      "+${d.cleanCupScore}",   Colors.green),
          if (d.defectPenalty > 0) ...[
            const SizedBox(height: 4),
            _row("Defect Penalty", "-${d.defectPenalty}", Colors.red),
          ],
        ])),
      ]),
    );
  }

  Widget _row(String label, String value, Color color) =>
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
      Text(value, style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 13, color: color)),
    ]);
}