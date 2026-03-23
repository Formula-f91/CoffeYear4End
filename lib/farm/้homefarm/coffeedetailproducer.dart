import 'package:coffee/home/branchDetailPage.dart';
import 'package:coffee/home/coffee_event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:coffee/home/checkOutPage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:coffee/constants.dart';

final List<Map<String, dynamic>> _recommendedListProducer = [
  {
    "image": "assets/images/coffee1.png",
    "name": "Arabica Dark",
    "rating": "4.8",
    "desc": "Strong body"
  },
  {
    "image": "assets/images/coffee4.png",
    "name": "Robusta Gold",
    "rating": "4.5",
    "desc": "Nutty flavor"
  },
  {
    "image": "assets/images/coffee5.png",
    "name": "House Blend",
    "rating": "4.9",
    "desc": "Perfect mix"
  },
  {
    "image": "assets/images/coffee6.png",
    "name": "Peaberry",
    "rating": "4.7",
    "desc": "Rare beans"
  },
];

class CoffeeDetailsProducer extends StatelessWidget {
  const CoffeeDetailsProducer({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Coffee Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/coffee2.png',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: index == 0
                        ? Border.all(color: secondaryColor2, width: 2)
                        : null,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/coffee2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coffee Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Price",
                        style: TextStyle(
                          color: Color(0xFF444444),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow("Variety", "Quantity (kg)"),
                  _buildDetailRow("Processing Method", ""),
                  _buildDetailRow("Harvest Season", ""),
                  const SizedBox(height: 15),
                  const Text(
                    "CoffeeDescriptionxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                    style: TextStyle(color: Color(0xFF444444), height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Coffee Lot",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Lot code",
                    style: TextStyle(color: Color(0xFF444444)),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Harvest Date",
                    style: TextStyle(color: Color(0xFF444444)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sample Information",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D2A4D),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(height: 300, child: _buildRadarChart()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Cupping",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  
                ],
              ),
            ),
            SizedBox(
              height: 330,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: _buildCuppingCard(context),
                  );
                },
              ),
            ),
            
                        // View All ด้านล่าง
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("View All",
                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 12, color: primaryColor2),
                    ],
                  ),
                ),
              ),
            ),
           
            _buildSectionDivider("More Recommendations"),
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
                itemCount: _recommendedListProducer.length,
                itemBuilder: (context, index) {
                  final item = _recommendedListProducer[index];
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
            const SizedBox(height: 100),
          ],
        ),
      ),
     
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.black87, fontSize: 14)),
          Text(value, style: const TextStyle(color: Color(0xFF444444), fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSectionDivider(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
    );
  }

  Widget _buildCuppingCard(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 340,
        margin: const EdgeInsets.only(left: 5, right: 15, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
              child: Image.asset(
                'assets/images/coffee.png',
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Cupping Session",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset('assets/icons/calendar.png', width: 18, height: 18, color: secondaryColor2),
                      const SizedBox(width: 8),
                      const Text(
                        "Start / End Date & Time",
                        style: TextStyle(color: Color(0xFF083584), fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/location.png', width: 18, height: 18, color: secondaryColor2),
                          const SizedBox(width: 8),
                          const Text("Location", style: TextStyle(color: Color(0xFF083584), fontSize: 12)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CoffeeEventDetailScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor2,
                          minimumSize: const Size(80, 32),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Text("Read More", style: TextStyle(color: Colors.white, fontSize: 12)),
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

 Widget _buildProductCard(BuildContext context, String imagePath, String name, String rating, String desc) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CoffeeDetailsProducer()),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // รูปภาพ
        AspectRatio(
          aspectRatio: 1,
          child: Image.asset(imagePath, width: double.infinity, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Text(name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        Text("Recommended",
            style: TextStyle(color: primaryColor2, fontSize: 12, fontWeight: FontWeight.bold)),
        Text(desc,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
      ],
    ),
  );
}
}

Widget _buildRadarChart() {
  return RadarChart(
    RadarChartData(
      radarShape: RadarShape.polygon,
      tickCount: 4,
      dataSets: [
        RadarDataSet(
          fillColor: const Color(0xFF874DB0).withOpacity(0.2),
          borderColor: const Color(0xFF874DB0),
          borderWidth: 3,
          entryRadius: 0,
          dataEntries: [
            const RadarEntry(value: 8.0),
            const RadarEntry(value: 8.0),
            const RadarEntry(value: 8.0),
            const RadarEntry(value: 8.0),
            const RadarEntry(value: 8.0),
            const RadarEntry(value: 8.0),
            const RadarEntry(value: 8.0),
          ],
        ),
        RadarDataSet(
          fillColor: Colors.transparent,
          borderColor: Colors.transparent,
          entryRadius: 0,
          dataEntries: List.generate(7, (index) => const RadarEntry(value: 9.0)),
        ),
        RadarDataSet(
          fillColor: Colors.transparent,
          borderColor: Colors.transparent,
          entryRadius: 0,
          dataEntries: List.generate(7, (index) => const RadarEntry(value: 7.5)),
        ),
      ],
      ticksTextStyle: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
      gridBorderData: const BorderSide(color: Color(0xFF333333), width: 2),
      radarBorderData: const BorderSide(color: Color(0xFF333333), width: 2),
      getTitle: (index, angle) {
        final titles = ['Fragrance Aroma', 'Aroma', 'Flavor', 'Aftertaste', 'Acidity', 'Sweetness', 'Mouthfeel'];
        return RadarChartTitle(text: titles[index]);
      },
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
    ),
  );
}

class OrderNowContentProducer extends StatefulWidget {
  const OrderNowContentProducer({super.key});

  @override
  State<OrderNowContentProducer> createState() => _OrderNowContentProducerState();
}

class _OrderNowContentProducerState extends State<OrderNowContentProducer> {
  String selectedSize = "20 kg";
  final List<String> sizes = ["10 kg", "20 kg", "30 kg"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Order Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 28)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset('assets/images/coffee2.png', width: 60, height: 60, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              const Text(
                "Coffee Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1A2E4D)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text("Size", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: sizes.map((size) => _buildSizeOption(size)).toList(),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                elevation: 0,
              ),
              child: const Text("Confirm", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = size),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8EEE9) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFFC07E58) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFFC07E58) : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}