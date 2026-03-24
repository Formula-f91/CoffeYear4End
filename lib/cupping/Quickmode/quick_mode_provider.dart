// lib/cupping/Quickmode/quick_mode_provider.dart
import 'package:flutter/material.dart';
import 'package:coffee/model/session_model.dart';

class QuickModeSampleData {
  List<String> flavorDescriptors = [];
  List<String> defectDescriptors = [];
  double score = 0;
  bool reRoastRequested = false;
  String note = '';
}

class QuickModeProvider extends ChangeNotifier {
  SessionModel? session;
  int _currentSampleIndex = 0;
  final Map<int, QuickModeSampleData> _allData = {};

  void init(SessionModel s) {
    session = s;
    _currentSampleIndex = 0;
    _allData.clear();
    for (int i = 0; i < s.samples.length; i++) {
      _allData[i] = QuickModeSampleData();
    }
    notifyListeners();
  }

  int get currentSampleIndex => _currentSampleIndex;
  int get totalSamples => session?.samples.length ?? 0;
  SampleModel? get currentSample =>
      (session != null && session!.samples.isNotEmpty)
          ? session!.samples[_currentSampleIndex]
          : null;
  QuickModeSampleData get currentData =>
      _allData[_currentSampleIndex] ?? QuickModeSampleData();
  QuickModeSampleData? allDataForIndex(int i) => _allData[i];

  void selectSample(int i) {
    if (i >= 0 && i < totalSamples) {
      _currentSampleIndex = i;
      notifyListeners();
    }
  }

  void setFlavorDescriptors(List<String> v) {
    currentData.flavorDescriptors = v;
    notifyListeners();
  }

  void setDefectDescriptors(List<String> v) {
    currentData.defectDescriptors = v;
    notifyListeners();
  }

  void setScore(double v) {
    currentData.score = v;
    notifyListeners();
  }

  void setReRoast(bool v) {
    currentData.reRoastRequested = v;
    notifyListeners();
  }

  void setNote(String v) {
    currentData.note = v;
    notifyListeners();
  }

  // คะแนนเฉลี่ยทุก sample
  double get averageScore {
    if (_allData.isEmpty) return 0;
    final total = _allData.values.fold(0.0, (sum, d) => sum + d.score);
    return total / _allData.length;
  }

  // รวม descriptors ทุก sample (นับ frequency)
  Map<String, int> get allFlavorCounts {
    final map = <String, int>{};
    for (final d in _allData.values) {
      for (final f in d.flavorDescriptors) {
        map[f] = (map[f] ?? 0) + 1;
      }
    }
    return map;
  }

  Map<String, int> get allDefectCounts {
    final map = <String, int>{};
    for (final d in _allData.values) {
      for (final f in d.defectDescriptors) {
        map[f] = (map[f] ?? 0) + 1;
      }
    }
    return map;
  }

  Map<String, dynamic> buildSubmitPayload() {
    final results = <String, dynamic>{};
    _allData.forEach((i, d) {
      results[session!.samples[i].name] = {
        'score': d.score,
        'flavorDescriptors': d.flavorDescriptors,
        'defectDescriptors': d.defectDescriptors,
        'reRoastRequested': d.reRoastRequested,
        'note': d.note,
      };
    });
    return {
      'sessionName': session?.cuppingName,
      'averageScore': averageScore,
      'results': results,
    };
  }
}