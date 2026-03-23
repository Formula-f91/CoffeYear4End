import 'package:flutter/material.dart';
import 'package:coffee/home/productDetailPage.dart';
import 'package:coffee/constants.dart';

class CoffeeHomePage extends StatefulWidget {
  const CoffeeHomePage({super.key});

  @override
  State<CoffeeHomePage> createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePage> {
  // --- 1. ข้อมูล Banner (3 รูป) ---
  int _currentBannerIndex = 0;
  final List<String> _bannerImages = [
    "assets/images/Banner_1.png",
    "assets/images/Banner_2.jpg", // เปลี่ยนเป็นชื่อไฟล์รูปอื่นถ้ามี (เช่น Banner - 2.png)
    "assets/images/Banner - 1.png", // เปลี่ยนเป็นชื่อไฟล์รูปอื่นถ้ามี
  ];

  final List<Map<String, String>> _originList = [
    {"image": "assets/images/Origin_1.png", "title": "Farm", "desc": "text"},
    {"image": "assets/images/Origin_2.jpg", "title": "Farm", "desc": "text"},
    {"image": "assets/images/coffee.png", "title": "Farm", "desc": "text"},
  ];

  final List<Map<String, dynamic>> _recommendedList = [
    {
      "image": "assets/images/coffee1.png",
      "name": "Arabica Dark",
      "rating": "4.8",
      "desc": "Strong body",
    },
    {
      "image": "assets/images/coffee4.png",
      "name": "Robusta Gold",
      "rating": "4.5",
      "desc": "Nutty flavor",
    },
    {
      "image": "assets/images/coffee5.png",
      "name": "House Blend",
      "rating": "4.9",
      "desc": "Perfect mix",
    },
    {
      "image": "assets/images/coffee6.png",
      "name": "Peaberry",
      "rating": "4.7",
      "desc": "Rare beans",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Search Bar & Filter (เหมือนเดิม) ---
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.zero,
                          border: Border.all(color: Colors.grey.shade300),
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
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => _showFilterSheet(context),
                      child: Container(
                        height: 52,
                        width: 52,
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          "assets/icons/filter.png",
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Banner Section (เลื่อนได้ 3 รูป) ---
              SizedBox(
                height: 160,
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                  itemCount: _bannerImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ClipRect(
                        child: Image.asset(
                          _bannerImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              // --- Indicators (จุดบอกตำแหน่ง Banner) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _bannerImages.length,
                  (index) => Container(
                    width: _currentBannerIndex == index ? 25 : 10,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: _currentBannerIndex == index
                          ? primaryColor2
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
                    ),
                  ),
                ),
              ),

              // --- Coffee Origin Section (ดึงข้อมูลจาก List) ---
              _buildHeaderWithViewAll("Coffee Origin"),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _originList.length,
                  itemBuilder: (context, index) {
                    final item = _originList[index];
                    return _buildOriginCard(
                      item["image"]!,
                      item["title"]!,
                      item["desc"]!,
                    );
                  },
                ),
              ),

              // --- Recommended Section (ดึงข้อมูลจาก List) ---
              _buildHeaderWithViewAll(
                "Recommended for You",
                showViewAll: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: _recommendedList.length,
                  itemBuilder: (context, index) {
                    final item = _recommendedList[index];
                    return _buildProductCard(
                      context,
                      item["image"],
                      item["name"],
                      item["rating"],
                      item["desc"],
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderWithViewAll(String title, {bool showViewAll = true}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          if (showViewAll)
            const Row(
              children: [
                Text(
                  "View all",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
              ],
            ),
        ],
      ),
    );
  }

  // --- การ์ด Origin รับค่ารูปและข้อความได้ ---
  Widget _buildOriginCard(String imagePath, String title, String desc) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            child: Image.asset(
              imagePath,
              height: 140,
              width: 280,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }

  // --- การ์ด Recommended รับค่ารูปและข้อความได้ ---
  Widget _buildProductCard(
    BuildContext context,
    String imagePath,
    String name,
    String rating,
    String desc,
  ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductDetailPage()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRect(
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          rating,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Recommended",
            style: TextStyle(
              color: primaryColor2,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            desc,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

void _showFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filter Options",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterSection("Country", [
                      "Thailand",
                      "Ethiopia",
                      "Brazil",
                    ]),
                    const SizedBox(height: 20),
                    _buildFilterSection("Province", [
                      "Bangkok",
                      "Chiang Mai",
                      "Nan",
                    ]),
                    const SizedBox(height: 20),
                    _buildFilterSection("Farm", [
                      "Bangkok",
                      "Chiang Mai",
                      "Nan",
                    ]),
                    const SizedBox(height: 20),
                    _buildFilterSection("Varietal", ["Arabica", "Robusta"]),
                    const SizedBox(height: 20),
                    _buildFilterSection("Process", [
                      "Washed",
                      "Natural",
                      "Honey",
                    ]),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                // เปลี่ยนเป็น OutlinedButton
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white, // พื้นหลังสีขาว
                  side: BorderSide(
                    color: primaryColor2,
                    width: 1.5,
                  ), // ขอบสีน้ำเงิน
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // ขอบเหลี่ยม
                  ),
                ),
                child: Text(
                  // เอา const ออกเพราะดึงค่า primaryColor2 มาใช้
                  "Processing",
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor2, // เปลี่ยนตัวหนังสือเป็นสีน้ำเงิน
                    fontWeight: FontWeight.bold,
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

Widget _buildFilterSection(String label, List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
      ),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.zero,
          ),
        ),
        hint: Text("Select $label"),
        items: items.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (val) {},
      ),
    ],
  );
}
