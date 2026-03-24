// lib/cupping/Affective/affective_provider.dart
import 'package:flutter/material.dart';
import 'package:coffee/cupping/Affective/affective_form_data.dart';
import 'package:coffee/model/session_model.dart';

class AffectiveProvider extends ChangeNotifier {
  // ── Session data (รับมาจาก CoffeeDetailScreen) ────────────────────────────
  SessionModel? session;
  int _currentSampleIndex = 0; // sample ที่กำลังประเมิน

  // ── Form data แยกต่อ sample ────────────────────────────────────────────────
  // key = sample index, value = AffectiveFormData
  final Map<int, AffectiveFormData> _allData = {};

  // ── Init ────────────────────────────────────────────────────────────────────
  void init(SessionModel s) {
    session = s;
    _currentSampleIndex = 0;
    _allData.clear();
    for (int i = 0; i < s.samples.length; i++) {
      _allData[i] = AffectiveFormData();
    }
    notifyListeners();
  }

  // ── Getters ─────────────────────────────────────────────────────────────────
  int get currentSampleIndex => _currentSampleIndex;
  int get totalSamples => session?.samples.length ?? 0;

  SampleModel? get currentSample =>
      session != null && session!.samples.isNotEmpty
          ? session!.samples[_currentSampleIndex]
          : null;

  AffectiveFormData get currentData =>
      _allData[_currentSampleIndex] ?? AffectiveFormData();

  // ── Select sample ────────────────────────────────────────────────────────────
  void selectSample(int index) {
    if (index >= 0 && index < totalSamples) {
      _currentSampleIndex = index;
      notifyListeners();
    }
  }

  // ── Step 1: Fragrance / Aroma ─────────────────────────────────────────────
  void setFragrance(int val) {
    currentData.fragrance = val;
    notifyListeners();
  }

  void setAroma(int val) {
    currentData.aroma = val;
    notifyListeners();
  }

  void setStep1Note(String val) {
    currentData.step1Note = val;
    notifyListeners();
  }

  // ── Step 2: Flavor / Aftertaste ───────────────────────────────────────────
  void setFlavor(int val) {
    currentData.flavor = val;
    notifyListeners();
  }

  void setAftertaste(int val) {
    currentData.aftertaste = val;
    notifyListeners();
  }

  void setStep2Note(String val) {
    currentData.step2Note = val;
    notifyListeners();
  }

  // ── Step 3: Acidity ───────────────────────────────────────────────────────
  void setAcidity(int val) {
    currentData.acidity = val;
    notifyListeners();
  }

  void setStep3Note(String val) {
    currentData.step3Note = val;
    notifyListeners();
  }

  // ── Step 4: Sweetness ─────────────────────────────────────────────────────
  void setSweetness(int val) {
    currentData.sweetness = val;
    notifyListeners();
  }

  void setStep4Note(String val) {
    currentData.step4Note = val;
    notifyListeners();
  }

  // ── Step 5: Mouthfeel ─────────────────────────────────────────────────────
  void setMouthfeel(int val) {
    currentData.mouthfeel = val;
    notifyListeners();
  }

  void setStep5Note(String val) {
    currentData.step5Note = val;
    notifyListeners();
  }

  // ── Step 6: Overall ───────────────────────────────────────────────────────
  void setOverall(int val) {
    currentData.overall = val;
    notifyListeners();
  }

  void setStep6Note(String val) {
    currentData.step6Note = val;
    notifyListeners();
  }

  // ── Step 7: Uniformity / Clean Cup / Defects ──────────────────────────────
  void toggleUniformCup(int index) {
    currentData.uniformCups[index] = !currentData.uniformCups[index];
    notifyListeners();
  }

  void toggleCleanCup(int index) {
    currentData.cleanCups[index] = !currentData.cleanCups[index];
    notifyListeners();
  }

  void toggleDefect(String key) {
    currentData.defects[key] = !(currentData.defects[key] ?? false);
    notifyListeners();
  }

  void setStep7Note(String val) {
    currentData.step7Note = val;
    notifyListeners();
  }

  // ── Public data access ────────────────────────────────────────────────────
  AffectiveFormData? allDataForIndex(int index) => _allData[index];

  // ── Submit ────────────────────────────────────────────────────────────────
  // รวบรวมข้อมูลทุก sample พร้อม submit
  Map<String, dynamic> buildSubmitPayload() {
    final results = <String, dynamic>{};
    _allData.forEach((index, data) {
      final sample = session!.samples[index];
      results[sample.name] = {
        'fragrance': data.fragrance,
        'aroma': data.aroma,
        'flavor': data.flavor,
        'aftertaste': data.aftertaste,
        'acidity': data.acidity,
        'sweetness': data.sweetness,
        'mouthfeel': data.mouthfeel,
        'overall': data.overall,
        'uniformityScore': data.uniformityScore,
        'cleanCupScore': data.cleanCupScore,
        'defectPenalty': data.defectPenalty,
        'finalScore': data.finalScore,
        'defects': data.defects.entries
            .where((e) => e.value)
            .map((e) => e.key)
            .toList(),
      };
    });
    return {
      'sessionName': session?.cuppingName,
      'submittedAt': DateTime.now().toIso8601String(),
      'results': results,
    };
  }
}