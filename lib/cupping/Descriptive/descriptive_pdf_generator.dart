import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';

class DescriptivePdfGenerator {
  static Future<void> generateAndPreview(CupData cupData) async {
    final pdf = pw.Document();

    // กำหนดสีหลักที่ใช้ในแบบฟอร์ม
    final primaryBlue = PdfColor.fromHex("003399");
    final darkGrey = PdfColor.fromHex("4D5359");
    final borderGrey = PdfColor.fromHex("999999");
    final headerBgDark = PdfColor.fromHex("333D47");

    // -------------------------------------------------------------
    // 📌 ข้อมูลเพื่อใช้ทดสอบ (Mock Data) ให้ตรงกับรูปภาพต้นฉบับ
    // ถ้าต้องการใช้ข้อมูลจริงในอนาคต ให้เปลี่ยนเป็น:
    // final List<String> checkedFragrance = cupData.selectedFragranceAroma;
    // -------------------------------------------------------------
    final List<String> checkedFragrance = ["Floral"];
    final List<String> checkedFlavor = ["Floral", "Salty"];
    final List<String> checkedMouthfeel = ["Rough"];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // ── Header ──
              _buildHeader(),
              pw.SizedBox(height: 16),

              // ── Sample No + Roast Level Bar ──
              _buildSampleAndRoastRow(headerBgDark),
              pw.SizedBox(height: 8),

              // ── Main Body (Left: Assessment, Right: Notes) ──
              pw.Expanded(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // ส่วนด้านซ้าย (การประเมินและ Checkbox)
                    pw.Expanded(
                      flex: 22,
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: borderGrey, width: 1),
                        ),
                        child: pw.Column(
                          children: [
                            // 1. Fragrance & Aroma + Checkboxes
                            _buildLeftSection(
                              height: 155,
                              borderGrey: borderGrey,
                              child: pw.Column(
                                children: [
                                  _buildIntensityRow(
                                    "Fragrance",
                                    "Intensity",
                                    cupData.fragrance,
                                    primaryBlue,
                                    darkGrey,
                                  ),
                                  pw.SizedBox(height: 6),
                                  _buildIntensityRow(
                                    "Aroma",
                                    "Intensity",
                                    cupData.aroma,
                                    primaryBlue,
                                    darkGrey,
                                  ),
                                  pw.Divider(
                                    color: borderGrey,
                                    thickness: 1,
                                    height: 16,
                                  ),
                                  _buildFragranceAromaCheckboxes(
                                    checkedFragrance,
                                  ),
                                ],
                              ),
                            ),
                            // 2. Flavor & Aftertaste + Checkboxes
                            _buildLeftSection(
                              height: 155,
                              borderGrey: borderGrey,
                              child: pw.Column(
                                children: [
                                  _buildIntensityRow(
                                    "Flavor",
                                    "Intensity",
                                    cupData.flavor,
                                    primaryBlue,
                                    darkGrey,
                                  ),
                                  pw.SizedBox(height: 6),
                                  _buildIntensityRow(
                                    "Aftertaste",
                                    "Intensity",
                                    cupData.aftertaste,
                                    primaryBlue,
                                    darkGrey,
                                  ),
                                  pw.Divider(
                                    color: borderGrey,
                                    thickness: 1,
                                    height: 16,
                                  ),
                                  _buildFlavorAftertasteCheckboxes(
                                    checkedFlavor,
                                  ),
                                ],
                              ),
                            ),
                            // 3. Acidity
                            _buildLeftSection(
                              height: 50,
                              borderGrey: borderGrey,
                              child: _buildIntensityRow(
                                "Acidity",
                                "Intensity",
                                cupData.acidity,
                                primaryBlue,
                                darkGrey,
                              ),
                            ),
                            // 4. Sweetness
                            _buildLeftSection(
                              height: 50,
                              borderGrey: borderGrey,
                              child: _buildIntensityRow(
                                "Sweetness",
                                "Intensity",
                                cupData.sweetness,
                                primaryBlue,
                                darkGrey,
                              ),
                            ),
                            // 5. Mouthfeel
                            _buildLeftSection(
                              height: 85,
                              borderGrey: borderGrey,
                              hasBottomBorder: false,
                              child: pw.Column(
                                children: [
                                  _buildIntensityRow(
                                    "Mouthfeel",
                                    "Intensity",
                                    cupData.mouthfeel,
                                    primaryBlue,
                                    darkGrey,
                                  ),
                                  pw.Divider(
                                    color: borderGrey,
                                    thickness: 1,
                                    height: 16,
                                  ),
                                  _buildMouthfeelCheckboxes(checkedMouthfeel),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 8),

                    // ส่วนด้านขวา (กล่อง Notes)
                    pw.Expanded(
                      flex: 12,
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: borderGrey, width: 1),
                        ),
                        child: pw.Column(
                          children: [
                            _buildNoteBox(155, borderGrey),
                            _buildNoteBox(155, borderGrey),
                            _buildNoteBox(50, borderGrey),
                            _buildNoteBox(50, borderGrey),
                            _buildNoteBox(
                              85,
                              borderGrey,
                              hasBottomBorder: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 8),

              // ── Footer ──
              pw.Text(
                "SCA Version 2 (June 2024). ©2024 the Specialty Coffee Association. All rights reserved, except this document may be reproduced and distributed without\nmodification. Learn more: sca.coffee/value-assessment Calculate total score: sca.coffee/cuppingscore",
                style: pw.TextStyle(fontSize: 6, color: PdfColors.grey600),
              ),
            ],
          );
        },
      ),
    );

    // เปิด Preview / Share
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'SCA_Descriptive_Form.pdf',
    );
  }

  // ── Header Widget ──
  static pw.Widget _buildHeader() {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 4,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "SCA Coffee Value Assessment",
                style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
              ),
              pw.Text(
                "Descriptive\nForm",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 4,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildDotRow("Name"),
              pw.SizedBox(height: 10),
              _buildDotRow("Date"),
              pw.SizedBox(height: 10),
              _buildDotRow("Purpose"),
            ],
          ),
        ),
        pw.SizedBox(width: 16),
        pw.Container(
          width: 56,
          height: 56,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 1),
            shape: pw.BoxShape.circle,
          ),
          child: pw.Center(
            child: pw.Text(
              "LOGO",
              style: pw.TextStyle(fontSize: 10, color: PdfColors.black),
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildDotRow(String label) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          "$label ",
          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        ),
        pw.Expanded(
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  color: PdfColors.grey600,
                  style: pw.BorderStyle.dotted,
                ),
              ),
            ),
            height: 12,
          ),
        ),
      ],
    );
  }

  // ── Sample & Roast Bar ──
  static pw.Widget _buildSampleAndRoastRow(PdfColor bgDark) {
    return pw.Row(
      children: [
        pw.Expanded(
          flex: 22,
          child: pw.Row(
            children: [
              pw.Container(
                height: 20,
                padding: const pw.EdgeInsets.symmetric(horizontal: 12),
                color: bgDark,
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "SAMPLE NO.",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 20,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: bgDark, width: 1),
                  ),
                ),
              ),
              pw.Container(
                height: 20,
                width: 100,
                color: bgDark,
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "ROAST LEVEL",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 8),
        pw.Expanded(
          flex: 12,
          child: pw.Container(
            height: 20,
            decoration: const pw.BoxDecoration(
              gradient: pw.LinearGradient(
                colors: [PdfColors.grey300, PdfColors.grey900],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Helper Box for Left Column ──
  static pw.Widget _buildLeftSection({
    required double height,
    required PdfColor borderGrey,
    required pw.Widget child,
    bool hasBottomBorder = true,
  }) {
    return pw.Container(
      height: height,
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: hasBottomBorder
            ? pw.Border(bottom: pw.BorderSide(color: borderGrey, width: 1))
            : null,
      ),
      child: child,
    );
  }

  // ── Helper Box for Right Column (Notes) ──
  static pw.Widget _buildNoteBox(
    double height,
    PdfColor borderGrey, {
    bool hasBottomBorder = true,
  }) {
    return pw.Container(
      height: height,
      width: double.infinity,
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(
        border: hasBottomBorder
            ? pw.Border(bottom: pw.BorderSide(color: borderGrey, width: 1))
            : null,
      ),
      child: pw.Text(
        "Notes",
        style: pw.TextStyle(
          fontSize: 8,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.grey800,
        ),
      ),
    );
  }

  // ── Intensity Bar Builder ──
  static pw.Widget _buildIntensityRow(
    String title,
    String subtitle,
    double value,
    PdfColor blue,
    PdfColor grey,
  ) {
    final fraction = (value / 15.0).clamp(0.0, 1.0);
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.SizedBox(
          width: 60,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                subtitle,
                style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 20),
                    child: pw.Text(
                      "LOW",
                      style: pw.TextStyle(
                        fontSize: 6,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ),
                  pw.Text(
                    "MEDIUM",
                    style: pw.TextStyle(fontSize: 6, color: PdfColors.grey600),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 20),
                    child: pw.Text(
                      "HIGH",
                      style: pw.TextStyle(
                        fontSize: 6,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                height: 10,
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      flex: (fraction * 1000).toInt(),
                      child: pw.Container(color: blue),
                    ),
                    pw.Expanded(
                      flex: ((1 - fraction) * 1000).toInt(),
                      child: pw.Container(color: grey),
                    ),
                  ],
                ),
              ),
              pw.Container(
                height: 4,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: List.generate(16, (i) {
                    bool isMajor = i % 5 == 0;
                    return pw.Container(
                      width: 1,
                      height: isMajor ? 4 : 2,
                      color: PdfColors.grey600,
                    );
                  }),
                ),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("0", style: pw.TextStyle(fontSize: 7)),
                  pw.Text("5", style: pw.TextStyle(fontSize: 7)),
                  pw.Text("10", style: pw.TextStyle(fontSize: 7)),
                  pw.Text("15", style: pw.TextStyle(fontSize: 7)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Custom Checkbox Builder ──
  static pw.Widget _buildCheckItem(
    String label, {
    bool isChecked = false,
    bool isBold = false,
  }) {
    // โลจิกสี: ถ้าหัวข้อหลักถูกเลือก ให้ข้อความเป็นสีน้ำเงินเหมือนในรูป
    final textColor = (isBold && isChecked)
        ? PdfColor.fromHex("003399")
        : PdfColors.black;

    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        // -------------------------------------------------------------
        // 📌 แก้ไขวิธีวาด Checkbox โดยใช้ pw.Container
        // แทนการวาดเองด้วย CustomPaint เพื่อลดปัญหาการแสดงผล
        // -------------------------------------------------------------
        pw.Container(
          width: 7,
          height: 7,
          decoration: pw.BoxDecoration(
            color: isChecked ? PdfColor.fromHex("003399") : PdfColors.white,
            border: pw.Border.all(
              color: isChecked ? PdfColor.fromHex("003399") : PdfColors.grey600,
              width: 0.5,
            ),
          ),
          child: isChecked
              ? pw.Center(
                  child: pw.Text(
                    "✓", // ใช้ตัวอักษรติ๊กถูกแทนการวาดเส้น
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 6,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                )
              : null,
        ),
        pw.SizedBox(width: 3),
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 7,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: textColor,
          ),
        ),
      ],
    );
  }

  // ── Section: Fragrance / Aroma Checkboxes ──
  static pw.Widget _buildFragranceAromaCheckboxes(List<String> selected) {
    bool has(String val) => selected.contains(val);

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildCheckItem("Floral", isChecked: has("Floral"), isBold: true),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Fruity",
                    isChecked: has("Fruity"),
                    isBold: true,
                  ),
                  _buildCheckItem("Berry", isChecked: has("Berry")),
                  _buildCheckItem("Dried Fruit", isChecked: has("Dried Fruit")),
                  _buildCheckItem(
                    "Citrus Fruit",
                    isChecked: has("Citrus Fruit"),
                  ),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Sour/Fermented",
                    isChecked: has("Sour/Fermented"),
                    isBold: true,
                  ),
                  _buildCheckItem("Sour", isChecked: has("Sour")),
                  _buildCheckItem("Fermented", isChecked: has("Fermented")),
                ],
              ),
              pw.SizedBox(height: 4),
              _buildCheckItem(
                "Green/Vegetative",
                isChecked: has("Green/Vegetative"),
                isBold: true,
              ),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Other",
                    isChecked: has("Other"),
                    isBold: true,
                  ),
                  _buildCheckItem("Chemical", isChecked: has("Chemical")),
                  _buildCheckItem(
                    "Musty/Earthy",
                    isChecked: has("Musty/Earthy"),
                  ),
                  _buildCheckItem("Woody", isChecked: has("Woody")),
                ],
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Roasted",
                    isChecked: has("Roasted"),
                    isBold: true,
                  ),
                  _buildCheckItem("Cereal", isChecked: has("Cereal")),
                  _buildCheckItem("Burnt", isChecked: has("Burnt")),
                  _buildCheckItem("Tobacco", isChecked: has("Tobacco")),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Nutty/Cocoa",
                    isChecked: has("Nutty/Cocoa"),
                    isBold: true,
                  ),
                  _buildCheckItem("Nutty", isChecked: has("Nutty")),
                  _buildCheckItem("Cocoa", isChecked: has("Cocoa")),
                ],
              ),
              pw.SizedBox(height: 4),
              _buildCheckItem("Spice", isChecked: has("Spice"), isBold: true),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Sweet",
                    isChecked: has("Sweet"),
                    isBold: true,
                  ),
                  _buildCheckItem(
                    "Vanilla/Vanillin",
                    isChecked: has("Vanilla/Vanillin"),
                  ),
                  _buildCheckItem("Brown Sugar", isChecked: has("Brown Sugar")),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Section: Flavor / Aftertaste Checkboxes ──
  static pw.Widget _buildFlavorAftertasteCheckboxes(List<String> selected) {
    bool has(String val) => selected.contains(val);

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 12,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildCheckItem("Floral", isChecked: has("Floral"), isBold: true),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Fruity",
                    isChecked: has("Fruity"),
                    isBold: true,
                  ),
                  _buildCheckItem("Berry", isChecked: has("Berry")),
                  _buildCheckItem("Dried Fruit", isChecked: has("Dried Fruit")),
                  _buildCheckItem(
                    "Citrus Fruit",
                    isChecked: has("Citrus Fruit"),
                  ),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Sour/Fermented",
                    isChecked: has("Sour/Fermented"),
                    isBold: true,
                  ),
                  _buildCheckItem("Sour", isChecked: has("Sour")),
                  _buildCheckItem("Fermented", isChecked: has("Fermented")),
                ],
              ),
              pw.SizedBox(height: 4),
              _buildCheckItem(
                "Green/Vegetative",
                isChecked: has("Green/Vegetative"),
                isBold: true,
              ),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Other",
                    isChecked: has("Other"),
                    isBold: true,
                  ),
                  _buildCheckItem("Chemical", isChecked: has("Chemical")),
                  _buildCheckItem(
                    "Musty/Earthy",
                    isChecked: has("Musty/Earthy"),
                  ),
                  _buildCheckItem("Woody", isChecked: has("Woody")),
                ],
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 9,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Roasted",
                    isChecked: has("Roasted"),
                    isBold: true,
                  ),
                  _buildCheckItem("Cereal", isChecked: has("Cereal")),
                  _buildCheckItem("Burnt", isChecked: has("Burnt")),
                  _buildCheckItem("Tobacco", isChecked: has("Tobacco")),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Nutty/Cocoa",
                    isChecked: has("Nutty/Cocoa"),
                    isBold: true,
                  ),
                  _buildCheckItem("Nutty", isChecked: has("Nutty")),
                  _buildCheckItem("Cocoa", isChecked: has("Cocoa")),
                ],
              ),
              pw.SizedBox(height: 4),
              _buildCheckItem("Spice", isChecked: has("Spice"), isBold: true),
              pw.SizedBox(height: 4),
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  _buildCheckItem(
                    "Sweet",
                    isChecked: has("Sweet"),
                    isBold: true,
                  ),
                  _buildCheckItem(
                    "Vanilla/Vanillin",
                    isChecked: has("Vanilla/Vanillin"),
                  ),
                  _buildCheckItem("Brown Sugar", isChecked: has("Brown Sugar")),
                ],
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 5,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Main Taste(2)",
                style: pw.TextStyle(
                  fontSize: 7,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Row(
                children: [
                  _buildCheckItem("Salty", isChecked: has("Salty")),
                  pw.SizedBox(width: 4),
                  _buildCheckItem("Bitter", isChecked: has("Bitter")),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Row(
                children: [
                  _buildCheckItem("Sour", isChecked: has("Sour")),
                  pw.SizedBox(width: 4),
                  _buildCheckItem("Umami", isChecked: has("Umami")),
                ],
              ),
              pw.SizedBox(height: 4),
              _buildCheckItem("Sweet", isChecked: has("Sweet_Taste")),
            ],
          ),
        ),
      ],
    );
  }

  // ── Section: Mouthfeel Checkboxes ──
  static pw.Widget _buildMouthfeelCheckboxes(List<String> selected) {
    bool has(String val) => selected.contains(val);

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 2,
                children: [
                  _buildCheckItem(
                    "Rough",
                    isChecked: has("Rough"),
                    isBold: true,
                  ),
                  pw.Text(
                    "(Gritty, Chalky, Sandy)",
                    style: pw.TextStyle(fontSize: 6, color: PdfColors.grey700),
                  ),
                ],
              ),
              pw.SizedBox(height: 4),
              _buildCheckItem("Oily", isChecked: has("Oily"), isBold: true),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Wrap(
                crossAxisAlignment: pw.WrapCrossAlignment.center,
                spacing: 2,
                children: [
                  _buildCheckItem(
                    "Smooth",
                    isChecked: has("Smooth"),
                    isBold: true,
                  ),
                  pw.Text(
                    "(Velvety, Silky, Syrupy)",
                    style: pw.TextStyle(fontSize: 6, color: PdfColors.grey700),
                  ),
                ],
              ),
              pw.SizedBox(height: 4),
              _buildCheckItem(
                "Mouth-Drying",
                isChecked: has("Mouth-Drying"),
                isBold: true,
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildCheckItem(
                "Metallic",
                isChecked: has("Metallic"),
                isBold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
