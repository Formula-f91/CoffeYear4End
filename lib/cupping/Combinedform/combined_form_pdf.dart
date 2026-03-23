import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';

class CombinedFormPdfGenerator {
  static Future<void> generateAndPreview(CupData cupData) async {
    final pdf = pw.Document();

    final primaryBlue = PdfColor.fromHex("003399");
    final darkGrey = PdfColor.fromHex("4D5359");
    final borderGrey = PdfColor.fromHex("999999");
    final headerBgDark = PdfColor.fromHex("333D47");

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
              pw.SizedBox(height: 12),

              // ── Main Body (2 Columns: Descriptive | Affective) ──
              pw.Expanded(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Column 1: Descriptive Assessment
                    pw.Expanded(
                      flex: 12,
                      child: _buildDescriptiveCol(cupData, borderGrey, primaryBlue, darkGrey, headerBgDark),
                    ),
                    pw.SizedBox(width: 8),

                    // Column 2: Affective Assessment
                    pw.Expanded(
                      flex: 10,
                      child: _buildAffectiveCol(cupData, borderGrey, primaryBlue, headerBgDark),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 8),
              // ── Footer ──
              pw.Text(
                "SCA Version 2 (June 2024). ©2024 the Specialty Coffee Association.",
                style: pw.TextStyle(fontSize: 6, color: PdfColors.grey600),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'Combined_Form.pdf',
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
              pw.Text("SCA Coffee Value Assessment", style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
              pw.Text("Combined Form", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 12),
              _buildDotRow("Name"),
              pw.SizedBox(height: 8),
              _buildDotRow("Purpose"),
            ],
          ),
        ),
        pw.SizedBox(width: 16),
        pw.Expanded(
          flex: 4,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: 20),
              _buildDotRow("Date"),
              pw.SizedBox(height: 8),
              _buildDotRow("Sample No."),
            ],
          ),
        ),
        pw.SizedBox(width: 16),
        pw.Container(
          width: 45, height: 45,
          decoration: pw.BoxDecoration(border: pw.Border.all(), shape: pw.BoxShape.circle),
          child: pw.Center(child: pw.Text("LOGO", style: pw.TextStyle(fontSize: 9))),
        ),
      ],
    );
  }

  static pw.Widget _buildDotRow(String label) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text("$label ", style: pw.TextStyle(fontSize: 10)),
        pw.Expanded(child: pw.Container(decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey600, style: pw.BorderStyle.dotted))), height: 10)),
      ],
    );
  }

  // ==============================================================
  // COLUMN 1: DESCRIPTIVE
  // ==============================================================
  static pw.Widget _buildDescriptiveCol(CupData cup, PdfColor border, PdfColor blue, PdfColor grey, PdfColor bgDark) {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(color: border)),
      child: pw.Column(
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(4), color: bgDark,
            child: pw.Row(
              children: [
                pw.Expanded(child: pw.Text("PART 1: DESCRIPTIVE ASSESSMENT", style: pw.TextStyle(color: PdfColors.white, fontSize: 7, fontWeight: pw.FontWeight.bold))),
                pw.Text("ROAST LEVEL ", style: pw.TextStyle(color: PdfColors.white, fontSize: 7, fontWeight: pw.FontWeight.bold)),
                pw.Container(width: 40, height: 10, decoration: const pw.BoxDecoration(gradient: pw.LinearGradient(colors: [PdfColors.grey300, PdfColors.grey900]))),
              ]
            ),
          ),
          _box(pw.Column(children: [
            _intensityRow("Fragrance", cup.fragrance, blue, grey), pw.SizedBox(height: 4),
            _intensityRow("Aroma", cup.aroma, blue, grey),
          ]), border),
          _box(pw.Row(children: [
            pw.Expanded(flex: 7, child: pw.Container(height: 80, child: pw.Text("Checkboxes here...", style: pw.TextStyle(fontSize: 6, color: PdfColors.grey)))), // ละไว้เพื่อความกระชับ
            pw.Container(width: 1, height: 80, color: border),
            pw.Expanded(flex: 3, child: pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold)))),
          ]), border),
          
          _box(pw.Column(children: [
            _intensityRow("Flavor", cup.flavor, blue, grey), pw.SizedBox(height: 4),
            _intensityRow("Aftertaste", cup.aftertaste, blue, grey),
          ]), border),
          _box(pw.Row(children: [
            pw.Expanded(flex: 7, child: pw.Container(height: 80, child: pw.Text("Checkboxes here...", style: pw.TextStyle(fontSize: 6, color: PdfColors.grey)))),
            pw.Container(width: 1, height: 80, color: border),
            pw.Expanded(flex: 3, child: pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold)))),
          ]), border),

          _box(_intensityRow("Acidity", cup.acidity, blue, grey), border),
          _box(pw.Container(height: 30, width: double.infinity, child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold))), border),

          _box(_intensityRow("Sweetness", cup.sweetness, blue, grey), border),
          _box(pw.Container(height: 30, width: double.infinity, child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold))), border),

          _box(_intensityRow("Mouthfeel", cup.mouthfeel, blue, grey), border),
          pw.Container(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Row(children: [
               pw.Expanded(flex: 7, child: pw.Text("Mouthfeel Checkboxes", style: pw.TextStyle(fontSize: 6, color: PdfColors.grey))),
               pw.Container(width: 1, height: 30, color: border),
               pw.Expanded(flex: 3, child: pw.Padding(padding: const pw.EdgeInsets.only(left: 4), child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold)))),
            ]),
          )
        ],
      ),
    );
  }

  static pw.Widget _box(pw.Widget child, PdfColor border) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: border, width: 0.5))),
      child: child,
    );
  }

  static pw.Widget _intensityRow(String title, double value, PdfColor blue, PdfColor grey) {
    return pw.Row(
      children: [
        pw.SizedBox(width: 45, child: pw.Text(title, style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold))),
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [pw.Text("LOW", style: pw.TextStyle(fontSize: 5)), pw.Text("HIGH", style: pw.TextStyle(fontSize: 5))]),
              pw.Container(height: 8, color: blue), // แบบย่อ
            ]
          )
        )
      ]
    );
  }

  // ==============================================================
  // COLUMN 2: AFFECTIVE
  // ==============================================================
  static pw.Widget _buildAffectiveCol(CupData cup, PdfColor border, PdfColor blue, PdfColor bgDark) {
    int getScore(String val) => int.tryParse(val.isNotEmpty ? val[0] : "0") ?? 0;

    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(color: border)),
      child: pw.Column(
        children: [
          pw.Container(
            width: double.infinity, padding: const pw.EdgeInsets.all(4), color: bgDark,
            child: pw.Text("PART 2: AFFECTIVE ASSESSMENT", style: pw.TextStyle(color: PdfColors.white, fontSize: 7, fontWeight: pw.FontWeight.bold)),
          ),
          _box(pw.Column(children: [
            _circleRow("Fragrance", getScore(cup.affFragrance), blue), pw.SizedBox(height: 4),
            _circleRow("Aroma", getScore(cup.affAroma), blue),
          ]), border),
          _box(pw.Container(height: 80, width: double.infinity, child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold))), border),
          
          _box(pw.Column(children: [
            _circleRow("Flavor", getScore(cup.affFlavor), blue), pw.SizedBox(height: 4),
            _circleRow("Aftertaste", getScore(cup.affAftertaste), blue),
          ]), border),
          _box(pw.Container(height: 80, width: double.infinity, child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold))), border),

          _box(_circleRow("Acidity", getScore(cup.affAcidity), blue), border),
          _box(pw.Container(height: 30, width: double.infinity, child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold))), border),

          _box(_circleRow("Sweetness", getScore(cup.affSweetness), blue), border),
          _box(pw.Container(height: 30, width: double.infinity, child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold))), border),

          _box(_circleRow("Mouthfeel", getScore(cup.affMouthfeel), blue), border),
          _box(pw.Container(height: 30, width: double.infinity, child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold))), border),

          _box(_circleRow("Overall", getScore(cup.affOverall), blue), border),
          _box(pw.Container(height: 30, width: double.infinity, child: pw.Text("Notes", style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold))), border),

          // Defect Area
          pw.Container(
            padding: const pw.EdgeInsets.all(6),
            child: pw.Row(
              children: [
                pw.Expanded(child: pw.Text("NON-UNIFORM CUPS\nDEFECTIVE CUPS", style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold))),
                pw.Expanded(child: pw.Text("DEFECT (IF ANY)\n- MOLDY\n- PHENOLIC\n- POTATO", style: pw.TextStyle(fontSize: 6))),
              ]
            ),
          )
        ],
      ),
    );
  }

  static pw.Widget _circleRow(String title, int score, PdfColor blue) {
    return pw.Row(
      children: [
        pw.SizedBox(width: 45, child: pw.Text(title, style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold))),
        pw.Row(
          children: List.generate(9, (i) => pw.Container(
            width: 10, height: 10, margin: const pw.EdgeInsets.symmetric(horizontal: 1),
            decoration: pw.BoxDecoration(shape: pw.BoxShape.circle, color: score == i+1 ? blue : PdfColors.white, border: pw.Border.all(color: PdfColors.grey, width: 0.5)),
            child: pw.Center(child: pw.Text("${i+1}", style: pw.TextStyle(fontSize: 6, color: score == i+1 ? PdfColors.white : PdfColors.black)))
          ))
        ),
      ]
    );
  }
}