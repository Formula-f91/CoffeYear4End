import 'package:flutter/material.dart';

// --- 1. สร้าง Enum สำหรับระบุบทบาท (Role) ไว้ด้านบนสุด ---
enum UserRole { consumer, producer, distributor, roaster }

// 1. Model: เก็บข้อมูลของกาแฟ "1 แก้ว"
class CupData {
  // --- ส่วน Descriptive (คะแนน 0-10) ---
  double fragrance = 8.0;
  double aroma = 8.0;
  double flavor = 8.0;
  double aftertaste = 8.0;
  double acidity = 8.0;
  double sweetness = 8.0;
  double mouthfeel = 8.0;
  double balance = 8.0;
  double overall = 8.0;

  // --- ส่วน Affective (เก็บค่า String จาก Dropdown) ---
  String affFragrance = "5  Neither high nor low";
  String affAroma = "5  Neither high nor low";
  String affFlavor = "5  Neither high nor low";
  String affAftertaste = "5  Neither high nor low";
  String affAcidity = "5  Neither high nor low";
  String affSweetness = "5  Neither high nor low";
  String affMouthfeel = "5  Neither high nor low";
  String affOverall = "5  Neither high nor low";

  // -------------------------------------------------------------
  // 🌟 เพิ่มใหม่: ตัวแปร List สำหรับเก็บค่า Checkbox ของรสชาติต่างๆ 
  // -------------------------------------------------------------
  List<String> selectedFragranceAroma = [];
  List<String> selectedFlavorAftertaste = [];
  List<String> selectedMouthfeel = [];

  // --- เพิ่มข้อมูลสำหรับ Step 7 ---
  List<bool> uniformCups = [true, true, true, true, true]; // แถวส้ม
  List<bool> cleanCups = [true, true, true, true, true]; // แถวแดง

  Map<String, bool> defectsList = {
    "Moldy / Musty": false,
    "Phenolic": false,
    "Potato": false,
  };

  int defectType = 0;
  List<String> selectedDescriptors = [];

  // --- การคำนวณคะแนนรวม (Total Score) ---
  double get totalScore {
    double uniformityScore = uniformCups.where((c) => c).length * 2.0;
    double cleanCupScore = cleanCups.where((c) => c).length * 2.0;

    double sum =
        fragrance +
        aroma +
        flavor +
        aftertaste +
        acidity +
        sweetness +
        mouthfeel +
        balance +
        overall +
        uniformityScore +
        cleanCupScore;

    int defectCupCount = cleanCups.where((c) => !c).length;
    double penalty = defectCupCount * 4.0;

    return sum - penalty;
  }
}

// 2. Provider
class CuppingProvider extends ChangeNotifier {
  List<CupData> _cups = List.generate(5, (index) => CupData());
  int _currentCupIndex = 0;

  // --- 2. เพิ่มตัวแปรเก็บ Role และ Getter ---
  UserRole _currentRole = UserRole.consumer; // ค่าเริ่มต้นเป็น General User
  UserRole get currentRole => _currentRole;

  int get currentCupNumber => _currentCupIndex + 1;
  CupData get currentCupData => _cups[_currentCupIndex];
  List<CupData> get allCups => _cups;

  // --- 3. ฟังก์ชันสำหรับตั้งค่าบทบาท (setUserRole) ---
  void setUserRole(UserRole role) {
    _currentRole = role;
    notifyListeners();
  }

  void selectCup(int cupNumber) {
    if (cupNumber >= 1 && cupNumber <= 5) {
      _currentCupIndex = cupNumber - 1;
      notifyListeners();
    }
  }

  // -------------------------------------------------------------
  // 🌟 เพิ่มใหม่: ฟังก์ชันสำหรับเวลาผู้ใช้กดติ๊ก Checkbox (เพิ่ม/ลบ ค่าใน List)
  // -------------------------------------------------------------
  void toggleFragranceAroma(String flavor) {
    if (currentCupData.selectedFragranceAroma.contains(flavor)) {
      currentCupData.selectedFragranceAroma.remove(flavor);
    } else {
      currentCupData.selectedFragranceAroma.add(flavor);
    }
    notifyListeners();
  }

  void toggleFlavorAftertaste(String flavor) {
    if (currentCupData.selectedFlavorAftertaste.contains(flavor)) {
      currentCupData.selectedFlavorAftertaste.remove(flavor);
    } else {
      currentCupData.selectedFlavorAftertaste.add(flavor);
    }
    notifyListeners();
  }

  void toggleMouthfeel(String feel) {
    if (currentCupData.selectedMouthfeel.contains(feel)) {
      currentCupData.selectedMouthfeel.remove(feel);
    } else {
      currentCupData.selectedMouthfeel.add(feel);
    }
    notifyListeners();
  }

  // --- ฟังก์ชันอัปเดตสำหรับ Step 7 ---
  void updateUniformCup(int index) {
    currentCupData.uniformCups[index] = !currentCupData.uniformCups[index];
    notifyListeners();
  }

  void updateCleanCup(int index) {
    currentCupData.cleanCups[index] = !currentCupData.cleanCups[index];
    notifyListeners();
  }

  void updateDefectListItem(String key) {
    bool currentValue = currentCupData.defectsList[key] ?? false;
    currentCupData.defectsList[key] = !currentValue;
    notifyListeners();
  }

  // ==================================================
  //          ฟังก์ชันอัปเดต (Slider & Dropdown)
  // ==================================================
  void updateFragrance(double val) {
    currentCupData.fragrance = val;
    notifyListeners();
  }

  void updateAroma(double val) {
    currentCupData.aroma = val;
    notifyListeners();
  }

  void updateFlavor(double val) {
    currentCupData.flavor = val;
    notifyListeners();
  }

  void updateAftertaste(double val) {
    currentCupData.aftertaste = val;
    notifyListeners();
  }

  void updateAcidity(double val) {
    currentCupData.acidity = val;
    notifyListeners();
  }

  void updateSweetness(double val) {
    currentCupData.sweetness = val;
    notifyListeners();
  }

  void updateMouthfeel(double val) {
    currentCupData.mouthfeel = val;
    notifyListeners();
  }

  void updateBalance(double val) {
    currentCupData.balance = val;
    notifyListeners();
  }

  void updateOverall(double val) {
    currentCupData.overall = val;
    notifyListeners();
  }

  void updateDefectType(int val) {
    currentCupData.defectType = val;
    notifyListeners();
  }

  void updateAffFragrance(String val) {
    currentCupData.affFragrance = val;
    notifyListeners();
  }

  void updateAffAroma(String val) {
    currentCupData.affAroma = val;
    notifyListeners();
  }

  void updateAffFlavor(String val) {
    currentCupData.affFlavor = val;
    notifyListeners();
  }

  void updateAffAftertaste(String val) {
    currentCupData.affAftertaste = val;
    notifyListeners();
  }

  void updateAffAcidity(String val) {
    currentCupData.affAcidity = val;
    notifyListeners();
  }

  void updateAffSweetness(String val) {
    currentCupData.affSweetness = val;
    notifyListeners();
  }

  void updateAffMouthfeel(String val) {
    currentCupData.affMouthfeel = val;
    notifyListeners();
  }

  void updateAffOverall(String val) {
    currentCupData.affOverall = val;
    notifyListeners();
  }
}