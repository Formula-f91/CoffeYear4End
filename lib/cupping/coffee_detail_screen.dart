import 'dart:io';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Affective/affective_chart.dart';
import 'package:coffee/cupping/Affective/affective_provider.dart';
import 'package:coffee/cupping/Affective/affective_step1.dart';
import 'package:coffee/cupping/Combinedform/combined_assessment_screen.dart';
import 'package:coffee/cupping/Combinedform/combined_provider.dart';
import 'package:coffee/cupping/Descriptive/DescriptiveStep1.dart';
import 'package:coffee/cupping/Descriptive/descriptive_provider.dart';
import 'package:coffee/cupping/Quickmode/combined_result_step1.dart';
import 'package:coffee/cupping/select_form_screen.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeDetailScreen extends StatefulWidget {
  final bool isAvailable;
  final SessionModel? session; // รับ SessionModel (optional เพื่อ backward compat)

  const CoffeeDetailScreen({
    super.key,
    required this.isAvailable,
    this.session,
  });

  @override
  State<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  int _selectedIndex = 0;

  // ถ้าไม่มีรูปจาก session ใช้ default asset
  List<String> get _thumbnails {
    if (widget.session?.imagePath != null) return [widget.session!.imagePath!];
    return ['assets/Image.png'];
  }

  bool get _hasRealImage => widget.session?.imagePath != null;

  @override
  Widget build(BuildContext context) {
    final session = widget.session;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Main Image ────────────────────────────────────────────
                  _buildMainImage(),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Thumbnails ────────────────────────────────────
                        Row(
                          children: List.generate(_thumbnails.length, (index) {
                            return _buildThumbnail(
                              _thumbnails[index],
                              _selectedIndex == index,
                              index,
                            );
                          }),
                        ),
                        const SizedBox(height: 24),

                        // ── Title + Share button ───────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                session?.cuppingName ?? "Cupping Event",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (widget.isAvailable)
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Image.asset(
                                    'assets/icon/shareicon.png',
                                    width: 20,
                                    height: 22,
                                  ),
                                  onPressed: () => _showSharePopup(context),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // ── Status badge ──────────────────────────────────
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: widget.session?.isCompleted == true
                                ? const Color(0xFFE8F5E9)
                                : widget.isAvailable
                                    ? const Color(0xFFE5F9EA)
                                    : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.session?.isCompleted == true) ...[
                                const Icon(Icons.check_circle,
                                    size: 12, color: Color(0xFF2E7D32)),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                widget.session?.isCompleted == true
                                    ? "Completed"
                                    : widget.isAvailable
                                        ? "Open for Evaluation"
                                        : "Not yet available",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: widget.session?.isCompleted == true
                                      ? const Color(0xFF2E7D32)
                                      : widget.isAvailable
                                          ? const Color(0xFF4CAF50)
                                          : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Cupping Mode ──────────────────────────────────
                        if (session != null) ...[
                          _buildInfoRow(
                            icon: Icons.coffee_outlined,
                            label: "Cupping Mode",
                            value: session.cuppingMode,
                          ),
                          const SizedBox(height: 8),
                        ],

                        // ── Created Date ──────────────────────────────────
                        if (session != null) ...[
                          _buildInfoRow(
                            icon: Icons.calendar_today_outlined,
                            label: "Created",
                            value: _formatDate(session.createdAt),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // ── Description ───────────────────────────────────
                        if (session?.description.isNotEmpty == true) ...[
                          const Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            session!.description,
                            style: TextStyle(
                              color: Colors.grey[500],
                              height: 1.6,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ] else if (session == null) ...[
                          Text(
                            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                            style: TextStyle(
                              color: Colors.grey[500],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // ── All Coffee Samples ────────────────────────────
                        const Text(
                          "All Coffee Samples",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        if (session != null && session.samples.isNotEmpty)
                          ...session.samples.asMap().entries.map(
                            (entry) => _buildSampleCard(
                              entry.key + 1,
                              entry.value,
                            ),
                          )
                        else ...[
                          _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                          _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                          _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                        ],

                        const SizedBox(height: 20),

                        // ── Organizer (placeholder) ───────────────────────
                        const Text(
                          "Organizer",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                        _buildBulletPoint("xxxxxxxxxxxxxxxxxxxx"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom button ──────────────────────────────────────────────
          if (widget.session?.isCompleted == true)
            _buildCompletedButton()
          else if (widget.isAvailable)
            _buildAvailableButton()
          else
            _buildNotAvailableButton(),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _formatDate(DateTime dt) {
    return "${dt.day.toString().padLeft(2, '0')}/"
        "${dt.month.toString().padLeft(2, '0')}/${dt.year}";
  }

  Widget _buildMainImage() {
    if (_hasRealImage) {
      return Image.file(
        File(_thumbnails[_selectedIndex]),
        width: double.infinity,
        height: 280,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      _thumbnails[_selectedIndex],
      width: double.infinity,
      height: 280,
      fit: BoxFit.cover,
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: secondaryColor2),
        const SizedBox(width: 8),
        Text(
          "$label:  ",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  // ── Sample Card ───────────────────────────────────────────────────────────
  Widget _buildSampleCard(int number, SampleModel sample) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#$number  ${sample.name}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _roastColor(sample.roastLevel).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  sample.roastLevel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _roastColor(sample.roastLevel),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 8),

          // Details grid
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: [
              if (sample.type.isNotEmpty)
                _buildDetailChip("Type", sample.type),
              if (sample.species.isNotEmpty)
                _buildDetailChip("Species", sample.species),
              if (sample.country.isNotEmpty)
                _buildDetailChip("Country", sample.country),
              if (sample.cropYear != null && sample.cropYear!.isNotEmpty)
                _buildDetailChip("Crop Year", sample.cropYear!),
              if (sample.processing.isNotEmpty)
                _buildDetailChip("Processing", sample.processing),
              if (sample.moisture.isNotEmpty)
                _buildDetailChip("Moisture", "${sample.moisture}%"),
              if (sample.density.isNotEmpty)
                _buildDetailChip("Density", "${sample.density} g/L"),
              if (sample.agtronNumber.isNotEmpty)
                _buildDetailChip("Agtron", sample.agtronNumber),
            ],
          ),
        ],
      ),
    );
  }

  Color _roastColor(String level) {
    switch (level) {
      case 'Light':
        return const Color(0xFFC67C4E);
      case 'Medium':
        return const Color(0xFF8B5E3C);
      case 'Dark':
        return const Color(0xFF4A2C17);
      default:
        return Colors.grey;
    }
  }

  Widget _buildDetailChip(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$label: ",
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[800],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ── Buttons ───────────────────────────────────────────────────────────────

  Future<void> _navigateByMode(BuildContext context) async {
    final mode = widget.session?.cuppingMode ?? '';
    dynamic completedProvider;

    switch (mode) {
      case 'Descriptive':
        completedProvider = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DescriptiveStep1(session: widget.session),
          ),
        );
        break;
      case 'Affective':
        // รับ provider กลับมาเมื่อ Done จาก AffectiveChartScreen
        completedProvider = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AffectiveStep1(session: widget.session!),
          ),
        );
        break;
      case 'Combined':
        completedProvider = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CombinedAssessmentScreen(session: widget.session),
          ),
        );
        break;
      case 'Quick Mode':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CombinedResult()),
        );
        break;
      default:
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SelectFormScreen(session: widget.session),
          ),
        );
    }

    // ถ้าได้ completedProvider กลับมา → pop กลับพร้อมส่ง completed session
    if (completedProvider != null && widget.session != null) {
      if (context.mounted) {
        Navigator.pop(
          context,
          widget.session!.copyWithCompleted(completedProvider),
        );
      }
    }
  }

  Widget _buildAvailableButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: ElevatedButton(
        onPressed: () => _navigateByMode(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor2,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 54),
        ),
        child: const Text(
          "Join Evaluation",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ปุ่ม View Results — แสดงเมื่อประเมินเสร็จแล้ว
  Widget _buildCompletedButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: ElevatedButton(
        onPressed: () {
          final cp = widget.session?.completedProvider;
          if (cp == null) return;

          if (cp is AffectiveProvider) {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => AffectiveChartScreen(provider: cp),
            ));
          } else if (cp is DescriptiveProvider) {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => _DescriptiveResultView(provider: cp),
            ));
          } else if (cp is CombinedProvider) {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => _CombinedResultView(provider: cp),
            ));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 54),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart_rounded, size: 20),
            SizedBox(width: 8),
            Text(
              "View Results",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotAvailableButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFAAAAAA),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 54),
        ),
        child: const Text(
          "Not yet available",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ── Thumbnail ─────────────────────────────────────────────────────────────

  Widget _buildThumbnail(String asset, bool isSelected, int index) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF2EEFF),
          border: isSelected
              ? Border.all(color: primaryColor2, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _hasRealImage
                ? Image.file(
                    File(asset),
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    asset,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }

  // ── Share popup ───────────────────────────────────────────────────────────

  void _showSharePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 450,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Share Cupping Event",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 200,
                color: Colors.grey[200],
                child: Image.asset(
                  'assets/icon/qrsharev2.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.qr_code_2, size: 100, color: Colors.grey),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Download QR",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 8),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.grey),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
    );
  }
}

// ── Wrapper เพื่อแสดง Descriptive chart จาก completedProvider ─────────────────
class _DescriptiveResultView extends StatelessWidget {
  final DescriptiveProvider provider;
  const _DescriptiveResultView({required this.provider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: DescriptiveStep1(session: provider.session),
    );
  }
}

// ── Wrapper เพื่อแสดง Combined chart จาก completedProvider ──────────────────
class _CombinedResultView extends StatelessWidget {
  final CombinedProvider provider;
  const _CombinedResultView({required this.provider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: CombinedAssessmentScreen(session: provider.session),
    );
  }
}