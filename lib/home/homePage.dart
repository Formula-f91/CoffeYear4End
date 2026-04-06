// lib/home/coffee_home_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';
import 'package:coffee/model/session_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoffeeHomePageNew extends StatefulWidget {
  final List<SessionModel> sessions;
  final VoidCallback? onNewSession;

  const CoffeeHomePageNew({
    super.key,
    required this.sessions,
    this.onNewSession,
  });

  @override
  State<CoffeeHomePageNew> createState() => _CoffeeHomePageNewState();
}

class _CoffeeHomePageNewState extends State<CoffeeHomePageNew> {
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();

  final List<String> _bannerImages = [
    "assets/images/cupping.jpg",
    "assets/images/shocup.jpg",
    "assets/images/Banner - 1.png",
  ];

  int get _totalSessions => widget.sessions.length;

  int get _completedSessions =>
      widget.sessions.where((s) => s.isCompleted).length;

  int get _thisWeekSessions {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return widget.sessions
        .where(
          (s) =>
              s.createdAt.isAfter(weekStart.subtract(const Duration(days: 1))),
        )
        .length;
  }

  List<SessionModel> get _recentSessions {
    final sorted = [...widget.sessions]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(3).toList();
  }

  List<Map<String, dynamic>> get _topDescriptors {
    final counts = <String, int>{};
    for (final s in widget.sessions.where((s) => s.isCompleted)) {
      final cp = s.completedProvider;
      if (cp == null) continue;
      try {
        final d = cp.allDataForIndex(0);
        if (d == null) continue;
        void addAll(List<String>? list) {
          if (list == null) return;
          for (final item in list) {
            counts[item] = (counts[item] ?? 0) + 1;
          }
        }

        try {
          addAll(d.fragranceAromaDescriptors as List<String>?);
        } catch (_) {}
        try {
          addAll(d.flavorAftertasteDescriptors as List<String>?);
        } catch (_) {}
        try {
          addAll(d.mouthfeelDescriptors as List<String>?);
        } catch (_) {}
        try {
          addAll(d.mainTastes as List<String>?);
        } catch (_) {}
        try {
          addAll(d.flavorDescriptors as List<String>?);
        } catch (_) {}
      } catch (_) {}
    }

    if (counts.isEmpty) return [];

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    const colors = [
      Color(0xFFE91E8C),
      Color(0xFFE53935),
      Color(0xFFFBB03B),
      Color(0xFF795548),
      Color(0xFF4CAF50),
    ];

    return sorted
        .take(5)
        .toList()
        .asMap()
        .entries
        .map(
          (e) => {
            "label": e.value.key,
            "count": e.value.value,
            "color": colors[e.key % colors.length],
          },
        )
        .toList();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildImageBanner(),
              _buildQuickStats(),
              _buildSectionTitle(
                "Recent Sessions",
                showAll: _totalSessions > 3,
              ),
              _recentSessions.isEmpty
                  ? _buildEmptyRecent()
                  : _buildRecentSessions(),
              if (_topDescriptors.isNotEmpty) ...[
                _buildSectionTitle("Top Flavor Descriptors"),
                _buildTopDescriptors(),
              ],
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = (user?.displayName?.isNotEmpty == true)
        ? user!.displayName!
        : user?.email?.split('@').first ?? 'Cupper';
    final photoURL = user?.photoURL;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      color: secondaryColor2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cuptaste",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.white.withOpacity(0.2),
            ),
            child: ClipOval(
              child: photoURL != null
                  ? Image.network(
                      photoURL,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    )
                  : Image.asset(
                      'assets/photo/coffepro.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Image Banner ───────────────────────────────────────────────────────────
  Widget _buildImageBanner() {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (i) => setState(() => _currentBannerIndex = i),
            itemCount: _bannerImages.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  _bannerImages[i],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      color: secondaryColor2.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 48,
                        color: secondaryColor2.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerImages.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _currentBannerIndex == i ? 20 : 8,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: _currentBannerIndex == i
                    ? secondaryColor2
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Quick Stats ────────────────────────────────────────────────────────────
  // ✅ เพิ่ม border ชัดขึ้น + divider แบ่งระหว่าง stat แต่ละตัว
  Widget _buildQuickStats() {
    final stats = [
      {
        "label": "Total\nSessions",
        "value": "$_totalSessions",
        "icon": Icons.coffee_outlined,
        "color": secondaryColor2,
      },
      {
        "label": "Completed",
        "value": "$_completedSessions",
        "icon": Icons.check_circle_outline,
        "color": const Color(0xFF4CAF50),
      },
      {
        "label": "This Week",
        "value": "$_thisWeekSessions",
        "icon": Icons.today_outlined,
        "color": const Color(0xFF1A3A8F),
      },
      {
        "label": "Pending",
        "value": "${_totalSessions - _completedSessions}",
        "icon": Icons.hourglass_empty_outlined,
        "color": const Color(0xFFE91E8C),
      },
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // ✅ border ชัดขึ้น จาก opacity 0 → solid
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: stats.asMap().entries.map((entry) {
          final i = entry.key;
          final s = entry.value;
          return Expanded(
            child: Container(
              // ✅ divider แนวตั้งระหว่างแต่ละ stat
              decoration: BoxDecoration(
                border: i > 0
                    ? const Border(
                        left: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                      )
                    : null,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: Column(
                children: [
                  Icon(
                    s["icon"] as IconData,
                    color: s["color"] as Color,
                    size: 22,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    s["value"] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: s["color"] as Color,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    s["label"] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Empty recent state ─────────────────────────────────────────────────────
  Widget _buildEmptyRecent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(32),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.coffee_outlined, size: 48, color: Colors.grey.shade200),
          const SizedBox(height: 12),
          Text(
            "No sessions yet",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Tap New Session to get started",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  // ── Recent Sessions ────────────────────────────────────────────────────────
  // ✅ border ชัดขึ้น + left accent bar ตามสี mode
  Widget _buildRecentSessions() {
    return Column(
      children: _recentSessions.map((session) {
        final modeColor = _modeColor(session.cuppingMode);
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            // ✅ border ชัดขึ้น
            border: Border.all(color: Colors.grey.shade300, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ✅ accent bar ซ้าย สีตาม mode
                  Container(width: 5, color: modeColor),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          // Mode icon
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: modeColor.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _modeIcon(session.cuppingMode),
                              color: modeColor,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        session.cuppingName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    _statusBadge(session.isCompleted),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    _tag(session.cuppingMode, modeColor),
                                    const SizedBox(width: 6),
                                    _tag(
                                      "${session.samples.length} sample${session.samples.length != 1 ? 's' : ''}",
                                      Colors.grey.shade500,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                if (session.samples.isNotEmpty)
                                  Text(
                                    session.samples
                                            .take(2)
                                            .map((s) => s.name)
                                            .join(", ") +
                                        (session.samples.length > 2
                                            ? " +${session.samples.length - 2}"
                                            : ""),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDate(session.createdAt),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Thumbnail หรือ arrow
                          if (session.imagePath != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(session.imagePath!),
                                width: 52,
                                height: 52,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey.shade300,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Top Flavor Descriptors ─────────────────────────────────────────────────
  Widget _buildTopDescriptors() {
    final descriptors = _topDescriptors;
    if (descriptors.isEmpty) return const SizedBox.shrink();

    final maxCount = descriptors.first["count"] as int;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: descriptors.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final color = item["color"] as Color;
          final count = item["count"] as int;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  child: Text(
                    "${i + 1}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: i == 0 ? secondaryColor2 : Colors.grey.shade400,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 70,
                  child: Text(
                    item["label"] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: count / maxCount,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  child: Text(
                    "$count",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Section title ──────────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title, {bool showAll = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          if (showAll)
            GestureDetector(
              onTap: () {},
              child: Text(
                "View all",
                style: TextStyle(
                  fontSize: 13,
                  color: secondaryColor2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${dt.day} ${months[dt.month - 1]} ${dt.year}";
  }

  Widget _statusBadge(bool completed) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: completed ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(20),
      // ✅ border บน badge ด้วย
      border: Border.all(
        color: completed ? const Color(0xFF4CAF50) : Colors.orange.shade300,
        width: 0.8,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          completed ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 10,
          color: completed ? const Color(0xFF2E7D32) : Colors.orange.shade700,
        ),
        const SizedBox(width: 3),
        Text(
          completed ? "Done" : "Open",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: completed ? const Color(0xFF2E7D32) : Colors.orange.shade700,
          ),
        ),
      ],
    ),
  );

  Widget _tag(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(4),
      // ✅ border บน tag
      border: Border.all(color: color.withOpacity(0.4), width: 0.8),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500),
    ),
  );

  Color _modeColor(String mode) {
    switch (mode) {
      case 'Affective':
        return secondaryColor2;
      case 'Descriptive':
        return const Color(0xFF1A3A8F);
      case 'Combined':
        return const Color(0xFF4CAF50);
      case 'Quick Mode':
        return const Color(0xFFE91E8C);
      default:
        return Colors.grey;
    }
  }

  IconData _modeIcon(String mode) => Icons.coffee;
}
