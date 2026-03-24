// lib/cupping/Affective/affective_widgets.dart
// Shared widgets ใช้ร่วมกันทุก step เพื่อหลีกเลี่ยง code ซ้ำ
import 'dart:io';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Affective/affective_provider.dart';
import 'package:flutter/material.dart';

// ── Progress Bar ─────────────────────────────────────────────────────────────
class AffectiveProgressBar extends StatelessWidget {
  final int currentStep; // 1-based
  final int totalSteps;

  const AffectiveProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: List.generate(totalSteps, (index) {
          return Expanded(
            child: Container(
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index < currentStep
                    ? secondaryColor2
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Header Card — แสดงรูปและชื่อ session ─────────────────────────────────────
class AffectiveHeaderCard extends StatelessWidget {
  final AffectiveProvider provider;

  const AffectiveHeaderCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final session = provider.session;
    final now = DateTime.now();
    final dateStr =
        "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: secondaryColor2,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          // รูปภาพจาก session (ถ้ามี) หรือ default asset
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: session?.imagePath != null
                  ? Image.file(
                      File(session!.imagePath!),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _defaultImage(),
                    )
                  : _defaultImage(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session?.cuppingName ?? "Affective Assessment",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  "Date : $dateStr  •  ${provider.totalSamples} samples",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultImage() => Image.asset(
        'assets/photo/coffepro.png',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.white24,
          child: const Icon(Icons.coffee, color: Colors.white, size: 28),
        ),
      );
}

// ── Select Sample Card — แสดงตามจำนวน sample จริง ───────────────────────────
class AffectiveSampleCard extends StatelessWidget {
  final AffectiveProvider provider;

  const AffectiveSampleCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final sample = provider.currentSample;
    final data = provider.currentData;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: const Color(0xFFA2A2A2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Sample info row ───────────────────────────────────────────
          Row(
            children: [
              // ชื่อ sample + roast level จากข้อมูลจริง
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sample?.name ?? "—",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sample?.roastLevel ?? "",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              _divider(),
              // จำนวน cup = sample ทั้งหมด
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Text("Total Cup", style: TextStyle(fontSize: 12)),
                    Text(
                      "${provider.totalSamples}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              _divider(),
              // Total score ของ sample ปัจจุบัน
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Text("Score", style: TextStyle(fontSize: 12)),
                    Text(
                      data.totalScore > 0
                          ? data.totalScore.toStringAsFixed(0)
                          : "—",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Select coffee",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 10),

          // ── Sample selector — แสดงตามจำนวน sample จริง ───────────────
          _buildSampleSelector(),
        ],
      ),
    );
  }

  Widget _buildSampleSelector() {
    final count = provider.totalSamples;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(count, (index) {
        final isSelected = provider.currentSampleIndex == index;
        final sampleName = provider.session!.samples[index].name;
        return GestureDetector(
          onTap: () => provider.selectSample(index),
          child: Container(
            constraints: const BoxConstraints(minWidth: 48),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              shape: count <= 6 ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: count > 6 ? BorderRadius.circular(8) : null,
              color: isSelected ? secondaryColor2 : Colors.white,
              border: Border.all(
                color: isSelected ? secondaryColor2 : Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: Text(
                count <= 6
                    ? "${index + 1}"
                    : sampleName.length > 6
                        ? sampleName.substring(0, 6)
                        : sampleName,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _divider() => Container(
        height: 40,
        width: 1,
        color: primaryColor2,
        margin: const EdgeInsets.symmetric(horizontal: 12),
      );
}

// ── Number Selector (1–9 circles) ─────────────────────────────────────────────
class AffectiveNumberSelector extends StatelessWidget {
  final String label;
  final int? selectedValue;
  final ValueChanged<int> onSelect;

  const AffectiveNumberSelector({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(9, (index) {
            final int num = index + 1;
            final bool isSelected = selectedValue == num;
            return GestureDetector(
              onTap: () => onSelect(num),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? primaryColor2 : Colors.white,
                  border: Border.all(
                    color:
                        isSelected ? primaryColor2 : Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    "$num",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ── Note TextField ─────────────────────────────────────────────────────────────
class AffectiveNoteField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;

  const AffectiveNoteField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Note',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 4,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Add notes...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: secondaryColor2, width: 1.5),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}

// ── Bottom Nav Buttons (Back / Next) ──────────────────────────────────────────
class AffectiveBottomNav extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;
  final String nextLabel;

  const AffectiveBottomNav({
    super.key,
    required this.onBack,
    required this.onNext,
    this.nextLabel = "Next",
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: secondaryColor2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(color: secondaryColor2, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor2,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  nextLabel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}