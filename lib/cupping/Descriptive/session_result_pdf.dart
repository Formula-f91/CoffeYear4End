import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';

class SessionResultPdfGenerator {
  static Future<void> generateAndPreview(CupData cupData) async {
    final pdf = pw.Document();

    final primaryBlue = PdfColor.fromHex("1A3A8F");
    final lightBlue = PdfColor.fromHex("D9E2F3");
    final greyText = PdfColor.fromHex("4D5359");

    pdf.addPage(
      pw.Page(
        // ใช้แนวนอนเพื่อให้วางตารางกับกราฟคู่กันได้สวยงาม
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // ── หัวกระดาษ ──
              pw.Text(
                "Session Result",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "Coffee Name",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                "Cupping Protocol SCA CVA Descriptive",
                style: pw.TextStyle(fontSize: 16, color: greyText),
              ),
              pw.SizedBox(height: 24),

              // ── เนื้อหา (ตารางซ้าย - กราฟขวา) ──
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // ส่วนที่ 1: ตารางคะแนน (ฝั่งซ้าย)
                  pw.Expanded(
                    flex: 4,
                    child: _buildScoreTable(cupData, primaryBlue, lightBlue),
                  ),
                  pw.SizedBox(width: 48), // ระยะห่างระหว่างตารางกับกราฟ
                  // ส่วนที่ 2: กราฟเรดาร์ (ฝั่งขวา)
                  pw.Expanded(
                    flex: 6,
                    child: pw.Center(child: _buildPdfRadarChart(cupData)),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // เปิดหน้า Preview
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'Session_Result_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  // สร้างตารางข้อมูล
  static pw.Widget _buildScoreTable(
    CupData cupData,
    PdfColor borderBlue,
    PdfColor headerLightBlue,
  ) {
    // ข้อมูลที่จะใส่ในตาราง
    final tableData = [
      ['Category', 'Score'],
      ['Fragrance', cupData.fragrance.toStringAsFixed(0)],
      ['Aroma', cupData.aroma.toStringAsFixed(0)],
      ['Flavor', cupData.flavor.toStringAsFixed(0)],
      ['Aftertaste', cupData.aftertaste.toStringAsFixed(0)],
      ['Acidity', cupData.acidity.toStringAsFixed(0)],
      ['Sweetness', cupData.sweetness.toStringAsFixed(0)],
      ['Mouthfeel', cupData.mouthfeel.toStringAsFixed(0)],
      ['Total', cupData.totalScore.toStringAsFixed(0)],
    ];

    return pw.TableHelper.fromTextArray(
      data: tableData,
      border: pw.TableBorder.all(color: borderBlue, width: 1.5),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
      headerDecoration: pw.BoxDecoration(color: headerLightBlue),
      cellStyle: const pw.TextStyle(fontSize: 14),
      cellAlignment: pw.Alignment.center,
      cellPadding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    );
  }

  // สร้างกราฟ Radar บน PDF
  static pw.Widget _buildPdfRadarChart(CupData data) {
    const double size = 300;
    const double cx = size / 2;
    const double cy = size / 2;
    const double radius = 100;

    // ดึงค่ามาหาร 10 เพื่อให้อยู่ในสเกล 0.0 - 1.0 (ตามเรดาร์เดิมของคุณ)
    final values = [
      data.fragrance / 10,
      data.aroma / 10,
      data.flavor / 10,
      data.aftertaste / 10,
      data.acidity / 10,
      data.sweetness / 10,
      data.mouthfeel / 10,
    ];

    final labels = [
      "Fragrance Aroma",
      "Aroma",
      "Flavor",
      "Aftertaste",
      "Acidity",
      "Sweetness",
      "Mouthfeel",
    ];

    final int count = labels.length;
    final double angleStep = (2 * pi) / count;

    // ฟังก์ชันคำนวณองศา (PDF origin ด้านบนซ้าย)
    // สำหรับ PDF Stack top=0 คือด้านบน แกน y วิ่งลงล่าง
    // ดังนั้นเริ่มวงกลมด้านบนคือ -pi/2
    double angleFor(int i) => -pi / 2 + i * angleStep;

    return pw.SizedBox(
      width: size,
      height: size,
      child: pw.Stack(
        children: [
          // 1. เลเยอร์วาดเส้นเรดาร์และสีด้วย Canvas
          pw.Positioned.fill(
            child: pw.CustomPaint(
              painter: (PdfGraphics g, PdfPoint s) {
                // PDF Graphics 0,0 คือมุมล่างซ้าย (Bottom-Left) ของกล่อง!
                // แกน Y วิ่งขึ้นด้านบน
                double gCx = s.x / 2;
                double gCy = s.y / 2;

                // สำหรับ Graphics แกน Y ขึ้นบน มุมบนคือ +pi/2
                // แต่เพื่อความง่าย เราจะกลับแกน Y ให้ตรงกับ Stack
                double gAngleFor(int i) => pi / 2 - i * angleStep;

                // วาดใยแมงมุม (Grid)
                for (int level = 1; level <= 5; level++) {
                  double r = radius * level / 5;
                  for (int i = 0; i < count; i++) {
                    double x = gCx + r * cos(gAngleFor(i));
                    double y = gCy + r * sin(gAngleFor(i));
                    if (i == 0)
                      g.moveTo(x, y);
                    else
                      g.lineTo(x, y);
                  }
                  g.closePath();
                  g.setStrokeColor(PdfColors.grey600);
                  g.setLineWidth(3);
                  g.strokePath();
                }

                // วาดแกน
                for (int i = 0; i < count; i++) {
                  g.moveTo(gCx, gCy);
                  g.lineTo(
                    gCx + radius * cos(gAngleFor(i)),
                    gCy + radius * sin(gAngleFor(i)),
                  );
                  g.setStrokeColor(PdfColors.grey600);
                  g.setLineWidth(3);
                  g.strokePath();
                }

                // สร้าง Path สำหรับข้อมูล
                for (int i = 0; i < count; i++) {
                  double val = values[i].clamp(0.0, 1.0);
                  double r = radius * val;
                  double x = gCx + r * cos(gAngleFor(i));
                  double y = gCy + r * sin(gAngleFor(i));
                  if (i == 0)
                    g.moveTo(x, y);
                  else
                    g.lineTo(x, y);
                }
                g.closePath();

                // ระบายสีทึบด้านใน
                g.setFillColor(PdfColor.fromHex("B4C6E7")); // สีฟ้าอ่อน
                g.fillPath();

                // วาดเส้นขอบสีน้ำเงินเข้มทับอีกรอบ
                for (int i = 0; i < count; i++) {
                  double val = values[i].clamp(0.0, 1.0);
                  double r = radius * val;
                  double x = gCx + r * cos(gAngleFor(i));
                  double y = gCy + r * sin(gAngleFor(i));
                  if (i == 0)
                    g.moveTo(x, y);
                  else
                    g.lineTo(x, y);
                }
                g.closePath();
                g.setStrokeColor(PdfColor.fromHex("003399"));
                g.setLineWidth(3);
                g.strokePath();
              },
            ),
          ),

          // 2. เลเยอร์ข้อความ Label รอบๆ กราฟ (Stack top-left origin)
          ...List.generate(count, (i) {
            double labelR = radius + 35;
            double lx = cx + labelR * cos(angleFor(i));
            double ly = cy + labelR * sin(angleFor(i));

            return pw.Positioned(
              left: lx - 50, // ขยับข้อความให้อยู่ตรงกลาง
              top: ly - 8,
              child: pw.Container(
                width: 100,
                alignment: pw.Alignment.center,
                child: pw.Text(
                  labels[i],
                  style: const pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
