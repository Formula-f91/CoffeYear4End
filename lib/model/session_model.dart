// lib/cupping/models/session_model.dart

class SampleModel {
  final String name;
  final String type;
  final String species;
  final String country;
  final String roastLevel;
  final String harvest;
  final String moisture;
  final String waterActivity;
  final String density;
  final String processing;
  final String agtronNumber;
  final String? cropYear;

  SampleModel({
    required this.name,
    required this.type,
    this.species = '',
    this.country = '',
    this.roastLevel = 'Light',
    this.harvest = '',
    this.moisture = '',
    this.waterActivity = '',
    this.density = '',
    this.processing = '',
    this.agtronNumber = '',
    this.cropYear,
  });
}

class SessionModel {
  final String cuppingName;
  final String description;
  final String cuppingMode;
  final String? imagePath;
  final List<SampleModel> samples;
  final DateTime createdAt;

  // ── Evaluation result state ────────────────────────────────────────────────
  // true = ประเมินเสร็จแล้ว ห้ามประเมินซ้ำ
  final bool isCompleted;
  // เก็บ AffectiveProvider ที่ submit แล้วไว้แสดง chart
  final dynamic completedProvider; // AffectiveProvider (dynamic เพื่อหลีกเลี่ยง circular import)

  SessionModel({
    required this.cuppingName,
    required this.description,
    required this.cuppingMode,
    this.imagePath,
    required this.samples,
    required this.createdAt,
    this.isCompleted = false,
    this.completedProvider,
  });

  // สร้าง copy ที่ mark ว่า completed พร้อมเก็บ provider
  SessionModel copyWithCompleted(dynamic provider) => SessionModel(
    cuppingName: cuppingName,
    description: description,
    cuppingMode: cuppingMode,
    imagePath: imagePath,
    samples: samples,
    createdAt: createdAt,
    isCompleted: true,
    completedProvider: provider,
  );
}