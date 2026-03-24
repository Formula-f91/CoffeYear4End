// lib/cupping/Descriptive/descriptive_provider.dart
import 'package:flutter/material.dart';
import 'package:coffee/model/session_model.dart';

// ── Data model สำหรับแต่ละ sample ──────────────────────────────────────────
class DescriptiveFormData {
  // Step 1 — Fragrance / Aroma
  double fragrance;
  double aroma;
  List<String> fragranceAromaDescriptors;
  String step1Note;

  // Step 2 — Flavor / Aftertaste
  double flavor;
  double aftertaste;
  List<String> flavorAftertasteDescriptors;
  List<String> mainTastes;
  String step2Note;

  // Step 3 — Acidity
  double acidity;
  String step3Note;

  // Step 4 — Sweetness
  double sweetness;
  String step4Note;

  // Step 5 — Mouthfeel
  double mouthfeel;
  List<String> mouthfeelDescriptors;
  String step5Note;

  DescriptiveFormData()
      : fragrance = 0,
        aroma = 0,
        flavor = 0,
        aftertaste = 0,
        acidity = 0,
        sweetness = 0,
        mouthfeel = 0,
        fragranceAromaDescriptors = [],
        flavorAftertasteDescriptors = [],
        mainTastes = [],
        mouthfeelDescriptors = [],
        step1Note = '',
        step2Note = '',
        step3Note = '',
        step4Note = '',
        step5Note = '';

  double get totalScore =>
      fragrance + aroma + flavor + aftertaste + acidity + sweetness + mouthfeel;
}

// ── Provider ────────────────────────────────────────────────────────────────
class DescriptiveProvider extends ChangeNotifier {
  SessionModel? session;
  int _currentSampleIndex = 0;
  final Map<int, DescriptiveFormData> _allData = {};

  void init(SessionModel s) {
    session = s;
    _currentSampleIndex = 0;
    _allData.clear();
    for (int i = 0; i < s.samples.length; i++) {
      _allData[i] = DescriptiveFormData();
    }
    notifyListeners();
  }

  int get currentSampleIndex => _currentSampleIndex;
  int get totalSamples => session?.samples.length ?? 0;

  SampleModel? get currentSample =>
      session != null && session!.samples.isNotEmpty
          ? session!.samples[_currentSampleIndex]
          : null;

  DescriptiveFormData get currentData =>
      _allData[_currentSampleIndex] ?? DescriptiveFormData();

  DescriptiveFormData? allDataForIndex(int i) => _allData[i];

  void selectSample(int index) {
    if (index >= 0 && index < totalSamples) {
      _currentSampleIndex = index;
      notifyListeners();
    }
  }

  // ── Step 1 ─────────────────────────────────────────────────────────────────
  void setFragrance(double v) { currentData.fragrance = v; notifyListeners(); }
  void setAroma(double v) { currentData.aroma = v; notifyListeners(); }
  void setFragranceAromaDescriptors(List<String> v) {
    currentData.fragranceAromaDescriptors = v; notifyListeners();
  }
  void setStep1Note(String v) { currentData.step1Note = v; notifyListeners(); }

  // ── Step 2 ─────────────────────────────────────────────────────────────────
  void setFlavor(double v) { currentData.flavor = v; notifyListeners(); }
  void setAftertaste(double v) { currentData.aftertaste = v; notifyListeners(); }
  void setFlavorAftertasteDescriptors(List<String> v) {
    currentData.flavorAftertasteDescriptors = v; notifyListeners();
  }
  void setMainTastes(List<String> v) {
    currentData.mainTastes = v; notifyListeners();
  }
  void setStep2Note(String v) { currentData.step2Note = v; notifyListeners(); }

  // ── Step 3 ─────────────────────────────────────────────────────────────────
  void setAcidity(double v) { currentData.acidity = v; notifyListeners(); }
  void setStep3Note(String v) { currentData.step3Note = v; notifyListeners(); }

  // ── Step 4 ─────────────────────────────────────────────────────────────────
  void setSweetness(double v) { currentData.sweetness = v; notifyListeners(); }
  void setStep4Note(String v) { currentData.step4Note = v; notifyListeners(); }

  // ── Step 5 ─────────────────────────────────────────────────────────────────
  void setMouthfeel(double v) { currentData.mouthfeel = v; notifyListeners(); }
  void setMouthfeelDescriptors(List<String> v) {
    currentData.mouthfeelDescriptors = v; notifyListeners();
  }
  void setStep5Note(String v) { currentData.step5Note = v; notifyListeners(); }

  Map<String, dynamic> buildSubmitPayload() {
    final results = <String, dynamic>{};
    _allData.forEach((i, d) {
      final sample = session!.samples[i];
      results[sample.name] = {
        'fragrance': d.fragrance,
        'aroma': d.aroma,
        'flavor': d.flavor,
        'aftertaste': d.aftertaste,
        'acidity': d.acidity,
        'sweetness': d.sweetness,
        'mouthfeel': d.mouthfeel,
        'totalScore': d.totalScore,
        'fragranceAromaDescriptors': d.fragranceAromaDescriptors,
        'flavorAftertasteDescriptors': d.flavorAftertasteDescriptors,
        'mainTastes': d.mainTastes,
        'mouthfeelDescriptors': d.mouthfeelDescriptors,
      };
    });
    return {
      'sessionName': session?.cuppingName,
      'submittedAt': DateTime.now().toIso8601String(),
      'results': results,
    };
  }
}