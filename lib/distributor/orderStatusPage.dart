import 'package:coffee/distributor/shipProductPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coffee/constants.dart'; // เรียกใช้ primaryColor2

class OrderStatusPage extends StatefulWidget {
  final int initialStep;
  const OrderStatusPage({super.key, this.initialStep = 0});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  late int _currentStep;

  String? _selectedCourier;
  String? _trackingNumber;

  final Map<String, String> shippingIcons = {
    "Flash Express": "assets/icons/FLASH.png",
    "ไปรษณีไทย": "assets/icons/THAI.png",
    "KEX Express": "assets/icons/KEX.png",
    "DHL Express": "assets/icons/DHL.png",
    "SPX Express": "assets/icons/SPX.png",
  };

  @override
  void initState() {
    super.initState();
    _currentStep = widget.initialStep;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildCustomerCard(),
                  const SizedBox(height: 20),
                  _buildOrderInfoCard(),
                  const SizedBox(height: 20),
                  _buildTimelineSection(),

                  // แสดงกล่อง Review เมื่อถึง Step 3
                  if (_currentStep == 3) ...[
                    const SizedBox(height: 30),
                    _buildReviewSection(),
                  ]
                ],
              ),
            ),
          ),

          // ปุ่มด้านล่างจะโชว์แค่ Step 0 และ 1
          if (_currentStep < 2)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_currentStep == 0) {
                      final result = await showModalBottomSheet<bool>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const PaymentConfirmationSheet(),
                      );

                      if (result == true) {
                        setState(() {
                          _currentStep = 1;
                        });
                      }
                    } else if (_currentStep == 1) {
                      final result =
                          await showModalBottomSheet<Map<String, String>>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const EnterTrackingSheet(),
                      );

                      if (result != null) {
                        setState(() {
                          _currentStep = 2;
                          _selectedCourier = result['courier'];
                          _trackingNumber = result['tracking'];
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor2, // ใช้สีน้ำเงิน
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // ขอบเหลี่ยม
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _getButtonText(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getButtonText() {
    if (_currentStep == 0) return "Confirm payment.";
    if (_currentStep == 1) return "Enter Tracking Number";
    return "";
  }

  Widget _buildCustomerCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: primaryColor2, // ใช้สีน้ำเงิน
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.black, size: 30),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name xxxxxxxxxxxx",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "phone : 000- 0000- 000",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/coffee2.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coffee Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "฿100",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF1D2A4D),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 10),
          _buildInfoRow("Order Date & Time", "28 Jul 2026  11:09"),
          const SizedBox(height: 8),
          _buildInfoRow("Payment Date & Time", "28 Jul 2026  13:00"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Method",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const PaymentProofSheet(),
                  );
                },
                child: const Text(
                  "xxxxxxx",
                  style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.cyan,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF606060), fontWeight: FontWeight.w400 ,fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTimelineSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          if (_currentStep >= 2) ...[
            _buildShippingHeader(),
            Divider(color: Colors.grey.shade200, thickness: 1),
            const SizedBox(height: 20),
          ],
          _buildTimelineItem(
            date: "3 Aug 26",
            time: "12:34",
            title: "Review",
            subtitle: "Review & Rating",
            iconPath: 'assets/icons/star.png',
            isActive: _currentStep == 3,
            isLast: false,
          ),
          _buildTimelineItem(
            date: "1 Aug 26",
            time: "09:34",
            title: "Ship Product",
            subtitle: "In Transit",
            iconPath: 'assets/icons/delivery.png',
            isActive: _currentStep == 2,
            isLast: false,
            isSubtitleLink: _currentStep == 2,
            onSubtitleTap: () {
              if (_currentStep == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShipProductPage(),
                  ),
                );
              }
            },
          ),
          _buildTimelineItem(
            date: "1 Aug 26",
            time: "09:34",
            title: "Preparing for Shipment",
            subtitle: "The product is being prepared\nfor shipment",
            iconPath: 'assets/icons/box.png',
            isActive: _currentStep == 1,
            isLast: false,
          ),
          _buildTimelineItem(
            date: "31 Jul 26",
            time: "15:34",
            title: "Pending",
            subtitle: _currentStep == 0 ? "Payment" : "Payment in Progress",
            iconPath: 'assets/icons/wallet.png',
            isActive: _currentStep == 0,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Review",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(Icons.star, color: Colors.orange, size: 24),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                style: TextStyle(
                  color: Color(0xFF1D2A4D),
                  fontSize: 13,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShippingHeader() {
    final courierName = _selectedCourier ?? "Flash Express";
    final trackNum = _trackingNumber ?? "TH12345678910";
    final iconPath = shippingIcons[courierName] ?? 'assets/icons/FLASH.png';

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(iconPath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            courierName,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          const Spacer(),
          Text(
            trackNum,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: trackNum)).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Tracking number copied!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              });
            },
            child: const Text(
              "Copy",
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String time,
    required String title,
    required String subtitle,
    required String iconPath,
    required bool isActive,
    required bool isLast,
    bool isSubtitleLink = false,
    VoidCallback? onSubtitleTap,
  }) {
    final Color activeBgColor = primaryColor2; // ใช้สีน้ำเงิน
    final Color inactiveBgColor = Colors.grey.shade300;
    final Color activeIconColor = Colors.white;
    final Color inactiveIconColor = Colors.grey.shade600;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isActive ? activeBgColor : inactiveBgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    color: isActive ? activeIconColor : inactiveIconColor,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: primaryColor2, // ใช้สีน้ำเงิน
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isActive ? Colors.black : Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: isSubtitleLink ? onSubtitleTap : null,
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSubtitleLink
                            ? Colors.blue
                            : Colors.grey.shade500,
                        decoration: isSubtitleLink
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: Colors.blue,
                      ),
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
}

// ---------------------------------------------------------
// Component: PaymentConfirmationSheet
// ---------------------------------------------------------
class PaymentConfirmationSheet extends StatelessWidget {
  const PaymentConfirmationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Payment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 15),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/kbank_logo.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 15),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kasikornbank",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Account Name",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "0000000000000",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/slip_example.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const CancelPaymentSheet(),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // ขอบเหลี่ยม
                      ),
                    ),
                    child: const Text(
                      "Cancel payment",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor2, // ใช้สีน้ำเงิน
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // ขอบเหลี่ยม
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// Component: CancelPaymentSheet
// ---------------------------------------------------------
class CancelPaymentSheet extends StatelessWidget {
  const CancelPaymentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Cancel payment.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade200, thickness: 1),
          const SizedBox(height: 15),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Reason for payment cancellation.....",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryColor2), // ใช้สีน้ำเงิน
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2, // ใช้สีน้ำเงิน
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // ขอบเหลี่ยม
                ),
                elevation: 0,
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// Component: EnterTrackingSheet
// ---------------------------------------------------------
class EnterTrackingSheet extends StatefulWidget {
  const EnterTrackingSheet({super.key});

  @override
  State<EnterTrackingSheet> createState() => _EnterTrackingSheetState();
}

class _EnterTrackingSheetState extends State<EnterTrackingSheet> {
  String? selectedShipping;
  final TextEditingController _trackingController = TextEditingController();

  final List<String> shippingOptions = [
    "Flash Express",
    "ไปรษณีไทย",
    "KEX Express",
    "DHL Express",
    "SPX Express",
  ];

  final Map<String, String> shippingIcons = {
    "Flash Express": "assets/icons/FLASH.png",
    "ไปรษณีไทย": "assets/icons/THAI.png",
    "KEX Express": "assets/icons/KEX.png",
    "DHL Express": "assets/icons/DHL.png",
    "SPX Express": "assets/icons/SPX.png",
  };

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Enter Tracking Number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade200, thickness: 1),
          const SizedBox(height: 20),
          const Text(
            "Select shipping",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: const Text(
                  "Select...",
                  style: TextStyle(color: Colors.grey),
                ),
                value: selectedShipping,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                items: shippingOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Image.asset(
                          shippingIcons[value]!,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 12),
                        Text(value),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedShipping = newValue;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _trackingController,
            decoration: InputDecoration(
              hintText: "TH12345678910",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryColor2), // ใช้สีน้ำเงิน
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'courier': selectedShipping ?? "Flash Express",
                  'tracking': _trackingController.text.isNotEmpty
                      ? _trackingController.text
                      : "TH12345678910"
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2, // ใช้สีน้ำเงิน
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // ขอบเหลี่ยม
                ),
                elevation: 0,
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// Component: PaymentProofSheet
// ---------------------------------------------------------
class PaymentProofSheet extends StatelessWidget {
  const PaymentProofSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Payment",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset('assets/icons/kbank_logo.png', width: 45, height: 45),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kasikornbank",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Account Name",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text("0000000000000",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/slip_example.png',
                height: 350,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}