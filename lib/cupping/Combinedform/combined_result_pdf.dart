import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';

class CombinedResultPdfGenerator {
  static Future<void> generateAndPreview(CupData cupData) async {
    final pdf = pw.Document();

    final primaryBlue = PdfColor.fromHex("1A3A8F");
    final lightBlue = PdfColor.fromHex("D9E2F3");

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4, // ใช้แนวตั้งตามภาพ
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // ── Header ──
              pw.Text("Session Result", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              pw.Text("Coffee Name", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text("Cupping Protocol SCA CVA Combined", style: pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 24),

              // ── Top Section: Radar Chart & Total Score ──
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Radar Chart
                  pw.Expanded(
                    flex: 7,
                    child: pw.Center(child: _buildPdfRadarChart(cupData)),
                  ),
                  pw.SizedBox(width: 24),
                  // Total Score Box
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                      children: [
                        _buildSmallDescriptiveTable(cupData),
                        pw.SizedBox(height: 16),
                        pw.Text("Total Score", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 8),
                        pw.Container(
                          width: double.infinity,
                          padding: const pw.EdgeInsets.symmetric(vertical: 12),
                          decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey300)),
                          child: pw.Column(
                            children: [
                              pw.Text("Affective", style: pw.TextStyle(fontSize: 12)),
                              pw.SizedBox(height: 4),
                              pw.Text(cupData.totalScore.toStringAsFixed(0), style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // ── Bottom Section: Two Tables (Descriptive & Affective) ──
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildDescriptiveTableFull(cupData, primaryBlue, lightBlue)),
                  pw.SizedBox(width: 16),
                  pw.Expanded(child: _buildAffectiveTableFull(cupData, primaryBlue, lightBlue)),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'Combined_Result.pdf',
    );
  }

  // --- Sub Widgets ---

  static pw.Widget _buildSmallDescriptiveTable(CupData data) {
    return pw.Column(
      children: [
        pw.Text("Descriptive", style: const pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 4),
        _smallRow("Fragrance", data.fragrance),
        _smallRow("Aroma", data.aroma),
        _smallRow("Flavor", data.flavor),
        _smallRow("Acidity", data.acidity),
        _smallRow("Aftertaste", data.aftertaste),
        _smallRow("Sweetness", data.sweetness),
        _smallRow("Mouthfeel", data.mouthfeel),
      ],
    );
  }

  static pw.Widget _smallRow(String title, double score) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title, style: const pw.TextStyle(fontSize: 10)),
          pw.Text(score.toStringAsFixed(0), style: const pw.TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  static pw.Widget _buildDescriptiveTableFull(CupData cupData, PdfColor borderBlue, PdfColor headerLightBlue) {
    final tableData = [
      ['Category', 'Score'],
      ['Fragrance/Aroma', ((cupData.fragrance + cupData.aroma) / 2).toStringAsFixed(0)], // ตัวอย่างการคำนวณรวม
      ['Acidity', cupData.acidity.toStringAsFixed(0)],
      ['Body', "0"], // ใส่ค่าจำลองไปก่อน หรือเชื่อมตัวแปรจริง
      ['Flavor', cupData.flavor.toStringAsFixed(0)],
      ['Aftertaste', cupData.aftertaste.toStringAsFixed(0)],
      ['Balance', cupData.balance.toStringAsFixed(0)],
      ['Overall', cupData.overall.toStringAsFixed(0)],
      ['Uniformity', (cupData.uniformCups.where((e) => e).length * 2).toString()],
      ['Clean Cup', (cupData.cleanCups.where((e) => e).length * 2).toString()],
      ['Sweetness', cupData.sweetness.toStringAsFixed(0)],
      ['Defect', (cupData.cleanCups.where((e) => !e).length * 4).toString()], // penalty
      ['Total Score', cupData.totalScore.toStringAsFixed(0)],
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("Descriptive", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
          data: tableData,
          border: pw.TableBorder.all(color: borderBlue),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          headerDecoration: pw.BoxDecoration(color: headerLightBlue),
          cellStyle: const pw.TextStyle(fontSize: 12),
          cellAlignment: pw.Alignment.center,
        ),
      ],
    );
  }

  static pw.Widget _buildAffectiveTableFull(CupData cupData, PdfColor borderBlue, PdfColor headerLightBlue) {
    // ดึงคะแนนตัวเลขมาจาก String ("5 Neither high nor low" -> 5)
    int getScore(String val) => int.tryParse(val.isNotEmpty ? val[0] : "0") ?? 0;

    final tableData = [
      ['Category', 'Score'],
      ['Fragrance', getScore(cupData.affFragrance).toString()],
      ['Aroma', getScore(cupData.affAroma).toString()],
      ['Flavor', getScore(cupData.affFlavor).toString()],
      ['Aftertaste', getScore(cupData.affAftertaste).toString()],
      ['Acidity', getScore(cupData.affAcidity).toString()],
      ['Sweetness', getScore(cupData.affSweetness).toString()],
      ['Mouthfeel', getScore(cupData.affMouthfeel).toString()],
      ['Overall', getScore(cupData.affOverall).toString()],
      ['Non Uniform Cups', cupData.uniformCups.where((e) => !e).length.toString()],
      ['Defective Cups', cupData.cleanCups.where((e) => !e).length.toString()],
      ['Total Score', cupData.totalScore.toStringAsFixed(0)],
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("Affective", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
          data: tableData,
          border: pw.TableBorder.all(color: borderBlue),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          headerDecoration: pw.BoxDecoration(color: headerLightBlue),
          cellStyle: const pw.TextStyle(fontSize: 12),
          cellAlignment: pw.Alignment.center,
        ),
      ],
    );
  }

  // สร้างกราฟ Radar บน PDF
  static pw.Widget _buildPdfRadarChart(CupData data) {
    const double size = 200;
    const double cx = size / 2;
    const double cy = size / 2;
    const double radius = 80;

    final values = [
      data.fragrance / 10,
      data.aroma / 10,
      data.flavor / 10,
      data.aftertaste / 10,
      data.acidity / 10,
      data.sweetness / 10,
      data.mouthfeel / 10,
    ];
    
    final labels = ["Fragrance Aroma", "Aroma", "Flavor", "Aftertaste", "Acidity", "Sweetness", "Mouthfeel"];
    final int count = labels.length;
    final double angleStep = (2 * pi) / count;

    double angleFor(int i) => -pi / 2 + i * angleStep;

    return pw.SizedBox(
      width: size + 80, // เผื่อที่ให้ text
      height: size + 60,
      child: pw.Stack(
        children: [
          pw.Positioned(
            left: 40, top: 30, // ขยับลงมาตรงกลาง
            child: pw.CustomPaint(
              size: const PdfPoint(size, size),
              painter: (PdfGraphics g, PdfPoint s) {
                double gCx = s.x / 2;
                double gCy = s.y / 2;
                double gAngleFor(int i) => pi / 2 - i * angleStep;

                // วาด Grid
                for (int level = 1; level <= 5; level++) {
                  double r = radius * level / 5;
                  for (int i = 0; i < count; i++) {
                    double x = gCx + r * cos(gAngleFor(i));
                    double y = gCy + r * sin(gAngleFor(i));
                    if (i == 0) g.moveTo(x, y);
                    else g.lineTo(x, y);
                  }
                  g.closePath();
                  g.setStrokeColor(PdfColors.grey600);
                  g.setLineWidth(2);
                  g.strokePath();
                }

                // วาดแกน
                for (int i = 0; i < count; i++) {
                  g.moveTo(gCx, gCy);
                  g.lineTo(gCx + radius * cos(gAngleFor(i)), gCy + radius * sin(gAngleFor(i)));
                  g.setStrokeColor(PdfColors.grey600);
                  g.setLineWidth(2);
                  g.strokePath();
                }

                // ระบายสี Data
                for (int i = 0; i < count; i++) {
                  double val = values[i].clamp(0.0, 1.0);
                  double r = radius * val;
                  double x = gCx + r * cos(gAngleFor(i));
                  double y = gCy + r * sin(gAngleFor(i));
                  if (i == 0) g.moveTo(x, y);
                  else g.lineTo(x, y);
                }
                g.closePath();
                g.setFillColor(PdfColor.fromHex("B4C6E7"));
                g.fillPath();

                // เส้นขอบ Data
                for (int i = 0; i < count; i++) {
                  double val = values[i].clamp(0.0, 1.0);
                  double r = radius * val;
                  double x = gCx + r * cos(gAngleFor(i));
                  double y = gCy + r * sin(gAngleFor(i));
                  if (i == 0) g.moveTo(x, y);
                  else g.lineTo(x, y);
                }
                g.closePath();
                g.setStrokeColor(PdfColor.fromHex("003399"));
                g.setLineWidth(3);
                g.strokePath();
              },
            ),
          ),
          
          // Label Texts
          ...List.generate(count, (i) {
            double labelR = radius + 25;
            double lx = cx + 40 + labelR * cos(angleFor(i));
            double ly = cy + 30 + labelR * sin(angleFor(i));

            return pw.Positioned(
              left: lx - 40,
              top: ly - 8,
              child: pw.Container(
                width: 80,
                alignment: pw.Alignment.center,
                child: pw.Text(labels[i], style: const pw.TextStyle(fontSize: 10), textAlign: pw.TextAlign.center),
              ),
            );
          }),
        ],
      ),
    );
  }
}