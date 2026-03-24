// lib/cupping/Affective/affective_form_data.dart
// Model เก็บข้อมูลทั้ง 7 step ของ Affective Form

class AffectiveStepData {
  int? score;
  String note;
  AffectiveStepData({this.score, this.note = ''});
}

class AffectiveFormData {
  // Step 1 — Fragrance / Aroma
  int? fragrance;
  int? aroma;
  String step1Note;

  // Step 2 — Flavor / Aftertaste
  int? flavor;
  int? aftertaste;
  String step2Note;

  // Step 3 — Acidity
  int? acidity;
  String step3Note;

  // Step 4 — Sweetness
  int? sweetness;
  String step4Note;

  // Step 5 — Mouthfeel
  int? mouthfeel;
  String step5Note;

  // Step 6 — Overall
  int? overall;
  String step6Note;

  // Step 7 — Uniformity / Clean Cup / Defects
  List<bool> uniformCups;
  List<bool> cleanCups;
  Map<String, bool> defects;
  String step7Note;

  AffectiveFormData()
      : step1Note = '',
        step2Note = '',
        step3Note = '',
        step4Note = '',
        step5Note = '',
        step6Note = '',
        step7Note = '',
        uniformCups = List.filled(5, false),
        cleanCups = List.filled(5, false),
        defects = {
          'Sour': false,
          'Musty / Earthy': false,
          'Phenolic': false,
          'Ferment': false,
          'Foreign': false,
          'Rubber': false,
        };

  // คำนวณ total score
  double get totalScore {
    final scores = [
      fragrance ?? 0,
      aroma ?? 0,
      flavor ?? 0,
      aftertaste ?? 0,
      acidity ?? 0,
      sweetness ?? 0,
      mouthfeel ?? 0,
      overall ?? 0,
    ];
    return scores.fold(0, (a, b) => a + b).toDouble();
  }

  // uniformity = จำนวนถ้วย true × 2
  int get uniformityScore => uniformCups.where((v) => v).length * 2;

  // clean cup = จำนวนถ้วย true × 2
  int get cleanCupScore => cleanCups.where((v) => v).length * 2;

  // defect penalty
  int get defectPenalty => defects.values.where((v) => v).length * 4;

  double get finalScore =>
      totalScore + uniformityScore + cleanCupScore - defectPenalty;
}