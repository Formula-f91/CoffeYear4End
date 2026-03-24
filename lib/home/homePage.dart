// lib/home/coffee_home_page.dart
import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class CoffeeHomePageNew extends StatefulWidget {
  const CoffeeHomePageNew({super.key});

  @override
  State<CoffeeHomePageNew> createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePageNew> {
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();
  int _currentTipIndex = 0;
  final PageController _tipController = PageController();

  // ── Banner images (เหมือนของเก่า) ──────────────────────────────────────
  final List<String> _bannerImages = [
    "assets/images/Banner_1.png",
    "assets/images/Banner_2.jpg",
    "assets/images/Banner - 1.png",
  ];

  final List<Map<String, dynamic>> _recentSessions = [
    {
      "name": "Morning Cupping #12",
      "mode": "Affective",
      "samples": 4,
      "date": "24 Mar 2026",
      "isCompleted": true,
      "score": "82.5",
    },
    {
      "name": "Ethiopia Blend Test",
      "mode": "Descriptive",
      "samples": 3,
      "date": "22 Mar 2026",
      "isCompleted": true,
      "score": "78.0",
    },
    {
      "name": "Roast Profile A",
      "mode": "Combined",
      "samples": 5,
      "date": "20 Mar 2026",
      "isCompleted": false,
      "score": null,
    },
  ];

  final List<String> _bannerTips = [
    "Tip: Allow coffee to cool to 70°C before slurping for best flavor perception.",
    "Did you know? Arabica beans have ~60% more lipids than Robusta.",
    "Tip: Rinse your palate with water between each sample.",
  ];

  @override
  void dispose() {
    _bannerController.dispose();
    _tipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── 1. Header ─────────────────────────────────────────────────
              _buildHeader(),
              const SizedBox(height: 32),
              _buildImageBanner(),

              // ── 2. Quick Stats ────────────────────────────────────────────
              _buildQuickStats(),

              // ── 3. Quick Actions ──────────────────────────────────────────
              // _buildQuickActions(context),

              // ── 4. Image Banner (slide) ───────────────────────────────────
              // _buildSectionTitle("Highlights"),
              

              // ── 5. Recent Sessions ────────────────────────────────────────
              _buildSectionTitle("Recent Sessions"),
              _buildRecentSessions(),

              // ── 6. Tips Banner ────────────────────────────────────────────
              // _buildSectionTitle("Cupping Tips"),
              // _buildTipsBanner(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── 1. Header ──────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: secondaryColor2,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Good morning ☕",
                style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13)),
            const SizedBox(height: 4),
            const Text("Cupper",
                style: TextStyle(color: Colors.white, fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ]),
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.white.withOpacity(0.2),
            ),
            child: ClipOval(
              child: Image.asset('assets/photo/coffepro.png', fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, color: Colors.white, size: 28))),
          ),
        ]),
        const SizedBox(height: 20),
        Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search sessions or samples...",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
              prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7), size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 13),
            ),
          ),
        ),
      ]),
    );
  }

  // ── 2. Quick Stats ─────────────────────────────────────────────────────────
  Widget _buildQuickStats() {
    final stats = [
      {"label": "Total\nSessions", "value": "24", "icon": Icons.coffee_outlined,       "color": secondaryColor2},
      {"label": "Completed",       "value": "18", "icon": Icons.check_circle_outline,  "color": const Color(0xFF4CAF50)},
      {"label": "This Week",       "value": "3",  "icon": Icons.today_outlined,        "color": const Color(0xFF1A3A8F)},
      {"label": "Avg Score",       "value": "81.2","icon": Icons.bar_chart_rounded,    "color": const Color(0xFFE91E8C)},
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06),
            blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(children: stats.map((s) {
        return Expanded(child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          child: Column(children: [
            Icon(s["icon"] as IconData, color: s["color"] as Color, size: 22),
            const SizedBox(height: 6),
            Text(s["value"] as String,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                    color: s["color"] as Color)),
            const SizedBox(height: 3),
            Text(s["label"] as String,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500, height: 1.3)),
          ]),
        ));
      }).toList()),
    );
  }

  // ── 3. Quick Actions ───────────────────────────────────────────────────────
  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {"label": "New\nSession", "icon": Icons.add_circle_outline,     "color": secondaryColor2},
      {"label": "Scan\nQR",    "icon": Icons.qr_code_scanner,        "color": const Color(0xFF1A3A8F)},
      {"label": "My\nResults", "icon": Icons.insert_chart_outlined,  "color": const Color(0xFF4CAF50)},
      {"label": "Compare",     "icon": Icons.compare_arrows_rounded, "color": const Color(0xFFE91E8C)},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(children: actions.map((a) {
        final color = a["color"] as Color;
        return Expanded(child: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Column(children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
                child: Icon(a["icon"] as IconData, color: color, size: 22),
              ),
              const SizedBox(height: 8),
              Text(a["label"] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                      color: color, height: 1.3)),
            ]),
          ),
        ));
      }).toList()),
    );
  }

  // ── 4. Image Banner (เลื่อนได้ เหมือนของเก่า) ────────────────────────────
  Widget _buildImageBanner() {
    return Column(children: [
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
                  child: Center(child: Icon(Icons.image_outlined,
                      size: 48, color: secondaryColor2.withOpacity(0.4))),
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      // Dot indicators
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_bannerImages.length, (i) =>
          AnimatedContainer(duration: const Duration(milliseconds: 250),
            width: _currentBannerIndex == i ? 20 : 8,
            height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: _currentBannerIndex == i ? secondaryColor2 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(3))))),
    ]);
  }

  // ── 5. Recent Sessions ────────────────────────────────────────────────────
  Widget _buildRecentSessions() {
    return Column(
      children: _recentSessions.map((s) {
        final isCompleted = s["isCompleted"] as bool;
        final modeColor = _modeColor(s["mode"] as String);

        return Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
                blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Row(children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: modeColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(_modeIcon(s["mode"] as String), color: modeColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: Text(s["name"] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    overflow: TextOverflow.ellipsis)),
                _statusBadge(isCompleted),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                _tag(s["mode"] as String, modeColor),
                const SizedBox(width: 6),
                _tag("${s["samples"]} samples", Colors.grey.shade500),
              ]),
              const SizedBox(height: 4),
              Text(s["date"] as String,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
            ])),
            const SizedBox(width: 10),
            if (isCompleted)
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(s["score"] as String,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                        color: secondaryColor2)),
                Text("score", style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
              ])
            else
              Icon(Icons.chevron_right, color: Colors.grey.shade300),
          ]),
        );
      }).toList(),
    );
  }

  // ── 6. Tips Banner ────────────────────────────────────────────────────────
  Widget _buildTipsBanner() {
    return Column(children: [
      SizedBox(
        height: 110,
        child: PageView.builder(
          controller: _tipController,
          onPageChanged: (i) => setState(() => _currentTipIndex = i),
          itemCount: _bannerTips.length,
          itemBuilder: (_, i) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [secondaryColor2, secondaryColor2.withOpacity(0.75)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(children: [
              const Icon(Icons.lightbulb_outline, color: Colors.white, size: 32),
              const SizedBox(width: 14),
              Expanded(child: Text(_bannerTips[i],
                  style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.5))),
            ]),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_bannerTips.length, (i) =>
          AnimatedContainer(duration: const Duration(milliseconds: 250),
            width: _currentTipIndex == i ? 20 : 6,
            height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: _currentTipIndex == i ? secondaryColor2 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(3))))),
    ]);
  }

  // ── Section title ──────────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title, {bool showAll = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        if (showAll)
          GestureDetector(onTap: () {},
            child: Text("View all", style: TextStyle(fontSize: 13,
                color: secondaryColor2, fontWeight: FontWeight.w500))),
      ]),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  Widget _statusBadge(bool completed) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: completed ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(completed ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 10,
          color: completed ? const Color(0xFF2E7D32) : Colors.orange.shade700),
      const SizedBox(width: 3),
      Text(completed ? "Done" : "Open",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,
              color: completed ? const Color(0xFF2E7D32) : Colors.orange.shade700)),
    ]),
  );

  Widget _tag(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
  );

  Color _modeColor(String mode) {
    switch (mode) {
      case 'Affective':   return secondaryColor2;
      case 'Descriptive': return const Color(0xFF1A3A8F);
      case 'Combined':    return const Color(0xFF4CAF50);
      case 'Quick Mode':  return const Color(0xFFE91E8C);
      default:            return Colors.grey;
    }
  }

  IconData _modeIcon(String mode) {
    switch (mode) {
      case 'Affective':   return Icons.favorite_border;
      case 'Descriptive': return Icons.description_outlined;
      case 'Combined':    return Icons.layers_outlined;
      case 'Quick Mode':  return Icons.flash_on_outlined;
      default:            return Icons.coffee_outlined;
    }
  }
}