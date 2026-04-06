// lib/cupping/coffee_event_screen.dart
import 'dart:io';
import 'package:coffee/constants.dart';
import 'package:coffee/cupping/createcupping/add_cupping_session_screen.dart'
    hide secondaryColor2;
import 'package:coffee/cupping/coffee_detail_screen.dart';
import 'package:coffee/cupping/edit_cupping_screen.dart';
import 'package:coffee/cupping/qr_scanner_screen.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';

class CoffeeEventScreen extends StatelessWidget {
  final List<SessionModel> sessions;
  final void Function(SessionModel) onAdd;
  final void Function(int index, SessionModel updated) onUpdate;
  final void Function(int index) onRemove;

  const CoffeeEventScreen({
    super.key,
    required this.sessions,
    required this.onAdd,
    required this.onUpdate,
    required this.onRemove,
  });

  String _formatDate(DateTime dt) {
    return "${dt.day.toString().padLeft(2, '0')}/"
        "${dt.month.toString().padLeft(2, '0')}/${dt.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        width: 59,
        height: 59,
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push<SessionModel>(
              context,
              MaterialPageRoute(builder: (_) => const AddCoffeeInfoPage()),
            );
            if (result != null) onAdd(result);
          },
          backgroundColor: secondaryColor2,
          shape: const CircleBorder(),
          elevation: 4,
          child: Image.asset(
            'assets/icon/plusname.png',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(context),
              const SizedBox(height: 16),
              _buildHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: sessions.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        itemCount: sessions.length,
                        itemBuilder: (context, index) =>
                            _buildSessionCard(context, sessions[index], index),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF4E2C0E), secondaryColor2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: secondaryColor2.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('☕', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Start a Cupping Session",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "Score, compare & record your coffee tasting",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.78),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push<SessionModel>(
                context,
                MaterialPageRoute(builder: (_) => const AddCoffeeInfoPage()),
              );
              if (result != null) onAdd(result);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "Create",
                style: TextStyle(
                  color: secondaryColor2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.coffee_outlined, size: 72, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          Text(
            "No sessions yet",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Tap + to create your first cupping session",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(0),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/Search.png',
                    width: 17,
                    height: 17,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const QrScannerScreen()),
          ),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset(
                'assets/qrcode.png',
                width: 28,
                height: 28,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionCard(
    BuildContext context,
    SessionModel session,
    int index,
  ) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push<SessionModel>(
          context,
          MaterialPageRoute(
            builder: (_) => CoffeeDetailScreen(
              isAvailable: !session.isCompleted,
              session: session,
            ),
          ),
        );
        if (result != null) onUpdate(index, result);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          // ── เงาที่มองเห็นชัดบนพื้นขาว ────────────────────────────────
          boxShadow: [
            // เงาหลัก: สีน้ำตาลกาแฟ ไม่กลืนกับพื้นขาว
            BoxShadow(
              color: const Color(0xFF6B3A1F).withOpacity(0.13),
              spreadRadius: 0,
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
            // เงาขอบบาง: ให้ความรู้สึก lift
            BoxShadow(
              color: const Color(0xFF6B3A1F).withOpacity(0.07),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
          // ขอบสีครีมน้ำตาลอ่อน แทน grey.shade100 ที่กลืนกับพื้นขาว
          border: Border.all(color: const Color(0xFFE3D5C8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail ─────────────────────────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(0),
              ),
              child: session.imagePath != null
                  ? Image.file(
                      File(session.imagePath!),
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/Image.png',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Title + Status badge ──────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          session.cuppingName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: session.isCompleted
                              ? const Color(0xFFE8F5E9)
                              : const Color(0xFFE5F9EA),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (session.isCompleted) ...[
                              const Icon(
                                Icons.check_circle,
                                size: 10,
                                color: Color(0xFF2E7D32),
                              ),
                              const SizedBox(width: 3),
                            ],
                            Text(
                              session.isCompleted ? "Completed" : "Open",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: session.isCompleted
                                    ? const Color(0xFF2E7D32)
                                    : const Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "Mode: ${session.cuppingMode}  •  ${session.samples.length} sample${session.samples.length != 1 ? 's' : ''}",
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),

                  if (session.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      session.description,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  // ── Date ──────────────────────────────────────────────────
                  Row(
                    children: [
                      Image.asset(
                        'assets/fi_calendar.png',
                        width: 20,
                        height: 20,
                        color: secondaryColor2,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: secondaryColor2,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Created: ${_formatDate(session.createdAt)}",
                        style: TextStyle(fontSize: 12, color: secondaryColor2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ── Sample chips ──────────────────────────────────────────
                  if (session.samples.isNotEmpty)
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        ...session.samples
                            .take(3)
                            .map(
                              (s) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor2.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  s.name,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: secondaryColor2,
                                  ),
                                ),
                              ),
                            ),
                        if (session.samples.length > 3)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "+${session.samples.length - 3} more",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                      ],
                    ),

                  const SizedBox(height: 2),

                  // ── Action buttons ────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditCuppingScreen(session: session),
                            ),
                          );
                          if (result == 'deleted') {
                            onRemove(index);
                          } else if (result is SessionModel) {
                            onUpdate(index, result);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: secondaryColor2,
                          side: BorderSide(color: secondaryColor2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(25, 32),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push<SessionModel>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CoffeeDetailScreen(
                                isAvailable: !session.isCompleted,
                                session: session,
                              ),
                            ),
                          );
                          if (result != null) onUpdate(index, result);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor2,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(80, 32),
                        ),
                        child: const Text(
                          "Read More",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
