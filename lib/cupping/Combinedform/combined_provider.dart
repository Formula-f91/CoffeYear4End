// lib/cupping/Combinedform/combined_provider.dart
import 'package:flutter/material.dart';
import 'package:coffee/model/session_model.dart';

class CombinedSampleData {
  // ── Descriptive ────────────────────────────────────────────────────────────
  // Step 1 — Fragrance / Aroma
  double fragrance = 0;
  double aroma = 0;
  List<String> fragranceAromaDescriptors = [];
  String step1Note = '';

  // Step 2 — Flavor / Aftertaste
  double flavor = 0;
  double aftertaste = 0;
  List<String> flavorAftertasteDescriptors = [];
  List<String> mainTastes = [];
  String step2Note = '';

  // Step 3 — Acidity
  double acidity = 0;
  String step3Note = '';

  // Step 4 — Sweetness
  double sweetness = 0;
  String step4Note = '';

  // Step 5 — Mouthfeel
  double mouthfeel = 0;
  List<String> mouthfeelDescriptors = [];
  String step5Note = '';

  // Step 6 — Extrinsic / Uniformity / Defects
  String extrinsicNote = '';
  List<bool> uniformCups = List.filled(5, false);
  List<bool> cleanCups = List.filled(5, false);
  Map<String, bool> defects = {
    'Sour': false,
    'Musty / Earthy': false,
    'Phenolic': false,
    'Ferment': false,
    'Foreign': false,
    'Rubber': false,
  };
  String step6Note = '';

  // ── Affective (1-9 circles, per step) ─────────────────────────────────────
  int? affFragrance;
  int? affAroma;
  int? affFlavor;
  int? affAftertaste;
  int? affAcidity;
  int? affSweetness;
  int? affMouthfeel;
  int? affOverall;

  double get descriptiveTotal =>
      fragrance + aroma + flavor + aftertaste + acidity + sweetness + mouthfeel;

  double get affectiveTotal =>
      ((affFragrance ?? 0) +
      (affAroma ?? 0) +
      (affFlavor ?? 0) +
      (affAftertaste ?? 0) +
      (affAcidity ?? 0) +
      (affSweetness ?? 0) +
      (affMouthfeel ?? 0) +
      (affOverall ?? 0)).toDouble();
}

class CombinedProvider extends ChangeNotifier {
  SessionModel? session;
  int _currentSampleIndex = 0;
  final Map<int, CombinedSampleData> _allData = {};

  void init(SessionModel s) {
    session = s;
    _currentSampleIndex = 0;
    _allData.clear();
    for (int i = 0; i < s.samples.length; i++) {
      _allData[i] = CombinedSampleData();
    }
    notifyListeners();
  }

  int get currentSampleIndex => _currentSampleIndex;
  int get totalSamples => session?.samples.length ?? 0;
  SampleModel? get currentSample =>
      (session != null && session!.samples.isNotEmpty)
          ? session!.samples[_currentSampleIndex]
          : null;
  CombinedSampleData get currentData =>
      _allData[_currentSampleIndex] ?? CombinedSampleData();
  CombinedSampleData? allDataForIndex(int i) => _allData[i];

  void selectSample(int i) {
    if (i >= 0 && i < totalSamples) { _currentSampleIndex = i; notifyListeners(); }
  }

  // ── Descriptive setters ───────────────────────────────────────────────────
  void setFragrance(double v) { currentData.fragrance = v; notifyListeners(); }
  void setAroma(double v) { currentData.aroma = v; notifyListeners(); }
  void setFragranceAromaDescriptors(List<String> v) { currentData.fragranceAromaDescriptors = v; notifyListeners(); }
  void setStep1Note(String v) { currentData.step1Note = v; notifyListeners(); }

  void setFlavor(double v) { currentData.flavor = v; notifyListeners(); }
  void setAftertaste(double v) { currentData.aftertaste = v; notifyListeners(); }
  void setFlavorAftertasteDescriptors(List<String> v) { currentData.flavorAftertasteDescriptors = v; notifyListeners(); }
  void setMainTastes(List<String> v) { currentData.mainTastes = v; notifyListeners(); }
  void setStep2Note(String v) { currentData.step2Note = v; notifyListeners(); }

  void setAcidity(double v) { currentData.acidity = v; notifyListeners(); }
  void setStep3Note(String v) { currentData.step3Note = v; notifyListeners(); }

  void setSweetness(double v) { currentData.sweetness = v; notifyListeners(); }
  void setStep4Note(String v) { currentData.step4Note = v; notifyListeners(); }

  void setMouthfeel(double v) { currentData.mouthfeel = v; notifyListeners(); }
  void setMouthfeelDescriptors(List<String> v) { currentData.mouthfeelDescriptors = v; notifyListeners(); }
  void setStep5Note(String v) { currentData.step5Note = v; notifyListeners(); }

  void setExtrinsicNote(String v) { currentData.extrinsicNote = v; notifyListeners(); }
  void toggleUniformCup(int i) { currentData.uniformCups[i] = !currentData.uniformCups[i]; notifyListeners(); }
  void toggleCleanCup(int i) { currentData.cleanCups[i] = !currentData.cleanCups[i]; notifyListeners(); }
  void toggleDefect(String k) { currentData.defects[k] = !(currentData.defects[k] ?? false); notifyListeners(); }
  void setStep6Note(String v) { currentData.step6Note = v; notifyListeners(); }

  // ── Affective setters ─────────────────────────────────────────────────────
  void setAffFragrance(int v) { currentData.affFragrance = v; notifyListeners(); }
  void setAffAroma(int v) { currentData.affAroma = v; notifyListeners(); }
  void setAffFlavor(int v) { currentData.affFlavor = v; notifyListeners(); }
  void setAffAftertaste(int v) { currentData.affAftertaste = v; notifyListeners(); }
  void setAffAcidity(int v) { currentData.affAcidity = v; notifyListeners(); }
  void setAffSweetness(int v) { currentData.affSweetness = v; notifyListeners(); }
  void setAffMouthfeel(int v) { currentData.affMouthfeel = v; notifyListeners(); }
  void setAffOverall(int v) { currentData.affOverall = v; notifyListeners(); }

  Map<String, dynamic> buildSubmitPayload() {
    final results = <String, dynamic>{};
    _allData.forEach((i, d) {
      results[session!.samples[i].name] = {
        'fragrance': d.fragrance, 'aroma': d.aroma,
        'flavor': d.flavor, 'aftertaste': d.aftertaste,
        'acidity': d.acidity, 'sweetness': d.sweetness, 'mouthfeel': d.mouthfeel,
        'descriptiveTotal': d.descriptiveTotal,
        'affFragrance': d.affFragrance, 'affAroma': d.affAroma,
        'affFlavor': d.affFlavor, 'affAftertaste': d.affAftertaste,
        'affAcidity': d.affAcidity, 'affSweetness': d.affSweetness,
        'affMouthfeel': d.affMouthfeel, 'affOverall': d.affOverall,
        'affectiveTotal': d.affectiveTotal,
        'uniformityScore': d.uniformCups.where((v) => v).length * 2,
        'cleanCupScore': d.cleanCups.where((v) => v).length * 2,
        'defects': d.defects.entries.where((e) => e.value).map((e) => e.key).toList(),
      };
    });
    return {'sessionName': session?.cuppingName, 'results': results};
  }
}