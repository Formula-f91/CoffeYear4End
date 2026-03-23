import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';

class AffectivePdfGenerator {
  static Future<void> generateAndPreview(CuppingProvider provider) async {
    final pdf = pw.Document();

    final primaryBlue = PdfColor.fromHex("003399");
    final borderGrey = PdfColor.fromHex("999999");
    final headerBgDark = PdfColor.fromHex("333D47");

    // ดึงข้อมูลแก้วทั้งหมดมาแสดง (ตามรูปจะแสดงทีละ 2 คอลัมน์)
    // ในที่นี้เราจะแสดง Cup 1 และ Cup 2 เป็นตัวอย่างในหน้าแรก
    final cups = provider.allCups;

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
              pw.SizedBox(height: 8),

              // ── Legend (1-9 Scale) ──
              _buildScaleLegend(),
              pw.SizedBox(height: 8),

              // ── Main Body (2 Columns for Samples) ──
              pw.Expanded(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Column 1 (Cup 1)
                    pw.Expanded(
                      child: _buildSampleCard(
                        cup: cups[0],
                        cupIndex: 1,
                        blue: primaryBlue,
                        grey: borderGrey,
                        bgDark: headerBgDark,
                      ),
                    ),
                    pw.SizedBox(width: 8),
                    // Column 2 (Cup 2)
                    pw.Expanded(
                      child: _buildSampleCard(
                        cup: cups[1],
                        cupIndex: 2,
                        blue: primaryBlue,
                        grey: borderGrey,
                        bgDark: headerBgDark,
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

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'SCA_Affective_Form.pdf',
    );
  }

  // ── Header ──
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
                "Affective\nForm",
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
            child: pw.Text("LOGO", style: pw.TextStyle(fontSize: 10)),
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

  // ── Legend ──
  static pw.Widget _buildScaleLegend() {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: PdfColor.fromHex("F2A900"),
          width: 1,
        ), // ขอบสีส้ม
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "IMPRESSION OF QUALITY",
            style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 2),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _legendItem("1", "EXTREMELY LOW"),
              _legendItem("2", "VERY LOW"),
              _legendItem("3", "MODERATELY LOW"),
              _legendItem("4", "SLIGHTLY LOW"),
              _legendItem("5", "NEITHER HIGH NOR LOW"),
              _legendItem("6", "SLIGHTLY HIGH"),
              _legendItem("7", "MODERATELY HIGH"),
              _legendItem("8", "VERY HIGH"),
              _legendItem("9", "EXTREMELY HIGH"),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _legendItem(String num, String text) {
    return pw.Row(
      children: [
        pw.Container(
          width: 8,
          height: 8,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(color: PdfColors.grey600, width: 0.5),
          ),
          child: pw.Center(
            child: pw.Text(
              num,
              style: pw.TextStyle(fontSize: 5, color: PdfColors.grey700),
            ),
          ),
        ),
        pw.SizedBox(width: 2),
        pw.Text(
          text,
          style: pw.TextStyle(fontSize: 5, color: PdfColors.grey700),
        ),
      ],
    );
  }

  // ── Sample Card ──
  static pw.Widget _buildSampleCard({
    required CupData cup,
    required int cupIndex,
    required PdfColor blue,
    required PdfColor grey,
    required PdfColor bgDark,
  }) {
    // ดึงตัวเลขจาก String (เช่น "5 Neither high nor low" -> 5)
    int getScore(String val) =>
        int.tryParse(val.isNotEmpty ? val[0] : "0") ?? 0;

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: grey, width: 1),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // Header ของ Card
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: bgDark,
            child: pw.Row(
              children: [
                pw.Text(
                  "SAMPLE NO.",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Container(width: 60, height: 12, color: PdfColors.white),
              ],
            ),
          ),

          // Attributes Groups
          _buildAttributeGroup(
            ["Fragrance", "Aroma"],
            [getScore(cup.affFragrance), getScore(cup.affAroma)],
            blue,
            grey,
          ),
          _buildAttributeGroup(
            ["Flavor", "Aftertaste"],
            [getScore(cup.affFlavor), getScore(cup.affAftertaste)],
            blue,
            grey,
          ),
          _buildAttributeGroup(
            ["Acidity"],
            [getScore(cup.affAcidity)],
            blue,
            grey,
          ),
          _buildAttributeGroup(
            ["Sweetness"],
            [getScore(cup.affSweetness)],
            blue,
            grey,
          ),
          _buildAttributeGroup(
            ["Mouthfeel"],
            [getScore(cup.affMouthfeel)],
            blue,
            grey,
          ),
          _buildAttributeGroup(
            ["Overall"],
            [getScore(cup.affOverall)],
            blue,
            grey,
            hasBottomBorder: false,
          ),

          // Bottom Defect Section
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(color: PdfColor.fromHex("F2A900"), width: 1),
              ), // เส้นส้ม
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Uniform / Defective
                pw.Expanded(
                  flex: 3,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildCheckboxRow(
                          "NON-UNIFORM CUPS",
                          cup.uniformCups,
                          blue,
                        ),
                        pw.SizedBox(height: 4),
                        _buildCheckboxRow(
                          "DEFECTIVE CUPS",
                          cup.cleanCups.map((e) => !e).toList(),
                          blue,
                        ), // clean = true คือไม่ defect
                      ],
                    ),
                  ),
                ),
                pw.Container(width: 1, height: 40, color: grey),
                // Defect Type
                pw.Expanded(
                  flex: 2,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "DEFECT (IF ANY)",
                          style: pw.TextStyle(
                            fontSize: 6,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        _buildTextCheck(
                          "MOLDY",
                          cup.defectsList["Moldy / Musty"] ?? false,
                          blue,
                        ),
                        _buildTextCheck(
                          "PHENOLIC",
                          cup.defectsList["Phenolic"] ?? false,
                          blue,
                        ),
                        _buildTextCheck(
                          "POTATO",
                          cup.defectsList["Potato"] ?? false,
                          blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // กลุ่มของคะแนน (เช่น Fragrance + Aroma + Notes)
  static pw.Widget _buildAttributeGroup(
    List<String> titles,
    List<int> scores,
    PdfColor blue,
    PdfColor grey, {
    bool hasBottomBorder = true,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(
        border: hasBottomBorder
            ? pw.Border(bottom: pw.BorderSide(color: grey, width: 1))
            : null,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          ...List.generate(titles.length, (i) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 4),
              child: pw.Row(
                children: [
                  pw.SizedBox(
                    width: 50,
                    child: pw.Text(
                      titles[i],
                      style: pw.TextStyle(
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Row(
                    children: List.generate(
                      9,
                      (numIndex) => _buildNumberCircle(
                        numIndex + 1,
                        scores[i] == numIndex + 1,
                        blue,
                      ),
                    ),
                  ),
                  pw.Spacer(),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: grey, width: 0.5),
                      borderRadius: pw.BorderRadius.circular(6),
                    ),
                    child: pw.Text(
                      "FINAL",
                      style: pw.TextStyle(
                        fontSize: 6,
                        color: PdfColors.grey500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          pw.SizedBox(height: 2),
          pw.Text(
            "Notes",
            style: pw.TextStyle(fontSize: 6, color: PdfColors.black),
          ),
          pw.SizedBox(height: 20), // พื้นที่ว่างสำหรับเขียน
        ],
      ),
    );
  }

  // วงกลมตัวเลข 1-9
  // วงกลมตัวเลข 1-9
  static pw.Widget _buildNumberCircle(int num, bool isSelected, PdfColor blue) {
    return pw.Container(
      width: 12,
      height: 12,
      margin: const pw.EdgeInsets.symmetric(horizontal: 1.5),
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        color: isSelected ? blue : PdfColors.white,
        border: pw.Border.all(
          color: isSelected ? blue : PdfColors.grey400,
          width: 0.5,
        ), // ✅ เติม pw. แล้ว
      ),
      child: pw.Center(
        child: pw.Text(
          num.toString(),
          style: pw.TextStyle(
            fontSize: 7,
            color: isSelected ? PdfColors.white : PdfColors.grey600,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // แถว Checkbox 5 กล่อง
  static pw.Widget _buildCheckboxRow(
    String label,
    List<bool> values,
    PdfColor blue,
  ) {
    return pw.Row(
      children: [
        pw.SizedBox(
          width: 65,
          child: pw.Text(
            label,
            style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Row(
          children: values
              .map(
                (val) => pw.Container(
                  width: 8,
                  height: 8,
                  margin: const pw.EdgeInsets.only(right: 2),
                  decoration: pw.BoxDecoration(
                    color: val ? blue : PdfColors.white,
                    border: pw.Border.all(
                      color: val ? blue : PdfColors.grey500,
                      width: 0.5,
                    ),
                  ),
                  child: val
                      ? pw.Center(
                          child: pw.Text(
                            "✓",
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 6,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Checkbox แบบมีข้อความต่อท้าย
  static pw.Widget _buildTextCheck(
    String label,
    bool isChecked,
    PdfColor blue,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Row(
        children: [
          pw.Container(
            width: 8,
            height: 8,
            decoration: pw.BoxDecoration(
              color: isChecked ? blue : PdfColors.white,
              border: pw.Border.all(
                color: isChecked ? blue : PdfColors.grey500,
                width: 0.5,
              ),
            ),
            child: isChecked
                ? pw.Center(
                    child: pw.Text(
                      "✓",
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 6,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  )
                : null,
          ),
          pw.SizedBox(width: 4),
          pw.Text(
            label,
            style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
