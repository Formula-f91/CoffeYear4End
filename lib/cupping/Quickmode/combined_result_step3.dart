import 'package:coffee/constants.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:coffee/distributor_firstPage.dart';
import 'package:coffee/farm/farm_first_page.dart';
import 'package:coffee/firstPage.dart';
import 'package:coffee/roaster_firstPage.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

// Import สำหรับการทำ PDF
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CombinedResultStep3 extends StatefulWidget {
  const CombinedResultStep3({super.key});

  @override
  State<CombinedResultStep3> createState() => _CombinedResultStateStep3();
}

class _CombinedResultStateStep3 extends State<CombinedResultStep3> {
  final Color activeOrange = const Color(0xFFFF8D28);

  // --- ฟังก์ชันหลักสำหรับ Export PDF ---
  Future<void> _exportToPdf(CuppingProvider provider) async {
    final pdf = pw.Document();

    // ดึงข้อมูลรายการ Cup ทั้งหมดจาก Provider (สมมติว่าวนลูปตามจำนวนถ้วยที่มี)
    // ในตัวอย่างนี้จะวาด 3 รายการต่อหน้าตามภาพที่คุณส่งมา
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return [
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 20),
              child: pw.Text(
                "Individual Report",
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            // วาด Card แต่ละใบ (วนลูปข้อมูลจาก provider ได้ตรงนี้)
            _buildPdfCupCard(1, "66", [
              "Floral (1)",
              "Fruity (1)",
              "Citrus Fruit (1)",
            ]),
            _buildPdfCupCard(2, "66", [
              "Floral (1)",
              "Fruity (1)",
              "Citrus Fruit (1)",
            ]),
            _buildPdfCupCard(3, "66", [
              "Floral (1)",
              "Fruity (1)",
              "Citrus Fruit (1)",
            ]),
          ];
        },
      ),
    );

    // แสดงหน้า Preview สำหรับพิมพ์หรือบันทึก
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // Widget สำหรับวาด Card ในหน้า PDF
  pw.Widget _buildPdfCupCard(int num, String score, List<String> tags) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 15),
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(15)),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // ส่วนข้อมูลตัวเลข (ซ้าย)
          pw.Expanded(
            flex: 2,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "$num(TS-01219595)",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.grey500,
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Center(
                  child: pw.Column(
                    children: [
                      pw.Text(
                        "Total Score",
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.Text(
                        score,
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromInt(0xFF4A69FF),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    _pdfTag(tags[0], PdfColors.pink),
                    pw.SizedBox(width: 4),
                    _pdfTag(tags[1], PdfColors.red),
                    pw.SizedBox(width: 4),
                    _pdfTag(tags[2], PdfColors.orange),
                  ],
                ),
                pw.SizedBox(height: 15),
                pw.Text(
                  "Note : ",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          // ส่วนกราฟจำลอง (ขวา)
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              height: 120,
              alignment: pw.Alignment.center,
              child: pw.Stack(
                alignment: pw.Alignment.center,
                children: [
                  _pdfCircleGraph(90, PdfColors.orange400, "Citrus Fruit"),
                  _pdfCircleGraph(70, PdfColors.red400, "Fruity"),
                  _pdfCircleGraph(50, PdfColors.pink400, "Floral"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _pdfCircleGraph(double size, PdfColor color, String label) {
    return pw.Container(
      width: size,
      height: size,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        border: pw.Border.all(color: color, width: 8),
      ),
    );
  }

  pw.Widget _pdfTag(String text, PdfColor color) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: pw.BoxDecoration(
        color: color,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      child: pw.Text(
        text,
        style: const pw.TextStyle(color: PdfColors.white, fontSize: 7),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CuppingProvider>(
      builder: (context, provider, child) {
        final cupData = provider.currentCupData;
        final currentCupNum = provider.currentCupNumber;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false, // ✅ ซ่อนปุ่ม arrow back
            title: const Text(
              "Quick Mode",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          // ✅ เพิ่ม bottomNavigationBar
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _exportToPdf(provider),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: secondaryColor2,
                        side: BorderSide(color: primaryColor2, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Export PDF",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Widget destination;
                        switch (provider.currentRole) {
                          case UserRole.producer:
                            destination = const FarmFirstPage();
                            break;
                          case UserRole.distributor:
                            destination = const DistributorFirstPage();
                            break;
                          // เพิ่มเงื่อนไขสำหรับ Roaster ตรงนี้
                          case UserRole.roaster:
                            destination = const RoasterFirstpage();
                            break;
                          case UserRole.consumer:
                          default:
                            destination = const FirstPage();
                            break;
                        }

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => destination),
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: secondaryColor2, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "Back",
                        style: TextStyle(
                          color: secondaryColor2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildHeaderCard(),
                      const SizedBox(height: 16),
                      _buildCoffeeInfoCard(provider, cupData, currentCupNum),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   borderRadius: BorderRadius.circular(24),
                        //   border: Border.all(color: Colors.grey.shade200),
                        // ),
                        child: Column(
                          children: [
                            _buildChartSummaryBox(cupData),
                            _buildFinalScoreRow(
                              "Note",
                              cupData.fragrance.toStringAsFixed(1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- ส่วนประกอบ UI ต่างๆ ---

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryColor2,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/photo/coffepro.png'),
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Quick Mode",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Name : xxxxxxx  |  Date : 26.01.23",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoffeeInfoCard(
    CuppingProvider provider,
    dynamic cupData,
    int currentCupNum,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: const Color(0xFFA2A2A2), // ปรับเป็นสีเทาเข้มปานกลาง
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coffee Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    "Roast level",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              _buildVerticalDivider(),
              const Column(
                children: [
                  Text("Total Cup", style: TextStyle(fontSize: 13)),
                  Text(
                    "5",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              _buildVerticalDivider(),
              Column(
                children: [
                  const Text("Total Score", style: TextStyle(fontSize: 13)),
                  Text(
                    cupData.totalScore.toStringAsFixed(2),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Select coffee",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              int cupNum = index + 1;
              bool isSelected = currentCupNum == cupNum;
              return GestureDetector(
                onTap: () => provider.selectCup(cupNum),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? secondaryColor2 : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? secondaryColor2
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "$cupNum",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/shopping.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Place an order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSummaryBox(dynamic cupData) {
    return Column(
      children: [
        const Text(
          'Total Score',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          cupData.totalScore.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: primaryColor2,
          ),
        ),
        const SizedBox(height: 25),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFlavorTag("Floral (2)", Colors.pinkAccent),
            _buildFlavorTag("Sour (0)", const Color(0xFFC6D53F)),
            _buildFlavorTag("Citrus Fruit (1)", const Color(0xFFFBB03B)),
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 60,
              sections: [
                PieChartSectionData(
                  color: const Color(0xFFFBB03B),
                  value: cupData.flavor,
                  title: 'Flavor',
                  radius: 30,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.pinkAccent,
                  value: cupData.acidity,
                  title: 'Acidity',
                  radius: 30,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  color: const Color(0xFFC6D53F),
                  value: cupData.sweetness,
                  title: 'Sweet',
                  radius: 30,
                  titleStyle: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() =>
      Container(height: 30, width: 1, color: primaryColor2);

  Widget _buildFlavorTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFinalScoreRow(String title, String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            score,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
