import 'package:flutter/material.dart';
import 'package:coffee/profile/order/refundReturn.dart';
import 'package:coffee/constants.dart'; // เรียกใช้ primaryColor2

class RefundDetailsPage extends StatelessWidget {
  const RefundDetailsPage({super.key});

  // ฟังก์ชันสำหรับเรียกแสดง Bottom Sheet ยืนยันการยกเลิก
  void _showCancelConfirmationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const CancelConfirmationContent();
      },
    );
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
          "Refund details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18, // ปรับให้ขนาดเท่ากับหน้าอื่นๆ
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Stepper Status
            _buildRefundStepper(),
            const SizedBox(height: 30),

            // 2. Refund Method
            const Text(
              "Refund Method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              "We will issue the refund after your request is approved. The refund will be credited to your xxxxxxxxxxxx within a few minutes after approval.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 15),
            _buildBankInfoCard(),

            const SizedBox(height: 25),

            // 3. Refund Items Card
            _buildRefundItemsCard(),

            const SizedBox(height: 25),

            // 4. Reason
            _buildTextDetailRow(
              "Reason",
              "Received damaged goods or goods in poor condition",
            ),
            const Divider(),
            const SizedBox(height: 10),

            // 5. Images Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Images",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ClipRect( // เปลี่ยนเป็นขอบเหลี่ยม
                  child: Image.asset(
                    'assets/images/coffee2.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),

            const SizedBox(height: 10),

            // 6. Message Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Message",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Text(
                    "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
            const Divider(),

            const SizedBox(height: 25),

            // 7. Request Details
            const Text(
              "Request Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildRequestDetailsBox(),

            const SizedBox(height: 40),

            // 8. Action Buttons
            _buildActionButtons(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildRefundStepper() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Request",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              "Refund",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black38,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double fullWidth = constraints.maxWidth;
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300, // สีเทาสำหรับเส้นที่ยังไม่ถึง
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 0,
                    child: Container(
                      height: 4,
                      width: fullWidth / 2,
                      decoration: BoxDecoration(
                        color: primaryColor2, // สีน้ำเงินสำหรับเส้นที่ผ่านแล้ว
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStepCircle(true, "Submitted", isCurrent: false),
                      _buildStepCircle(true, "Under Review", isCurrent: true),
                      _buildStepCircle(false, "Reviewed", isCurrent: false),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStepCircle(
    bool isFinished,
    String label, {
    bool isCurrent = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isFinished ? primaryColor2 : Colors.grey.shade300, // เปลี่ยนเป็นสีน้ำเงิน
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isCurrent ? primaryColor2 : Colors.black87, // เน้นตัวหนังสือสเต็ปปัจจุบัน
          ),
        ),
      ],
    );
  }

  Widget _buildBankInfoCard() {
    return Row(
      children: [
        ClipRect(
          child: Image.asset('assets/icons/krungthai.png', width: 40, height: 40),
        ),
        const SizedBox(width: 15),
        const Expanded(
          child: Text(
            "123456xxxx",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        const Text(
          "฿100",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black, // เปลี่ยนเป็นดำล้วน
          ),
        ),
      ],
    );
  }

  Widget _buildRefundItemsCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Refund Items",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRect( // ขอบเหลี่ยม
                child: Image.asset(
                  'assets/images/coffee2.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Coffee Name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text("฿100", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          _buildSummaryRow("Order Time", "28 Jul 2026  11:09"),
          _buildSummaryRow("Payment Time", "28 Jul 2026  13:00"),
          _buildSummaryRow("Payment Method", "xxxxxxx"),
          const Divider(),
          _buildSummaryRow("Total Refund Amount", "฿100", isBold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isBold ? Colors.black : Colors.grey.shade600,
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : null,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestDetailsBox() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero, // กรอบเหลี่ยม
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _buildCopyableRow("Request ID", "123456789"),
          _buildCopyableRow("Request Submitted Date", "26/01/2026 4:53 PM"),
          _buildCopyableRow("Order ID", "123456789"),
        ],
      ),
    );
  }

  Widget _buildCopyableRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Row(
            children: [
              Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              Icon(Icons.copy, size: 14, color: primaryColor2), // ไอคอนก๊อปปี้สีน้ำเงิน
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor2), // ขอบสีน้ำเงิน
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // ปุ่มเหลี่ยม
              ),
            ),
            child: Text(
              "Edit Refund Request",
              style: TextStyle(color: primaryColor2, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () => _showCancelConfirmationSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor2, // พื้นสีน้ำเงิน
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // ปุ่มเหลี่ยม
              ),
              elevation: 0,
            ),
            child: const Text(
              "Cancel Refund Request",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

// --- คลาสสำหรับ Bottom Sheet ยืนยันการยกเลิก ---
class CancelConfirmationContent extends StatelessWidget {
  const CancelConfirmationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero, // ขอบเหลี่ยม
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Do you want to cancel this request?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            "If you want to keep this request, please select “Back” below. If you want to cancel, please select “Cancel”.",
            style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryColor2, width: 1.5), // ขอบสีน้ำเงิน
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // ปุ่มเหลี่ยม
                ),
              ),
              child: Text(
                "Back",
                style: TextStyle(
                  color: primaryColor2,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor2, // สีน้ำเงิน
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // ปุ่มเหลี่ยม
                ),
                elevation: 0,
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}