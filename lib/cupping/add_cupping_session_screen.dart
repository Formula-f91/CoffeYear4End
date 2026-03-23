import 'package:coffee/constants.dart';
import 'package:coffee/cupping/coffee_from_farm_screen.dart';
import 'package:coffee/cupping/cupping_details_screen.dart'; // Import หน้า Detail ใหม่
import 'package:flutter/material.dart';

class AddCuppingSessionScreen extends StatefulWidget {
  const AddCuppingSessionScreen({super.key});

  @override
  State<AddCuppingSessionScreen> createState() =>
      _AddCuppingSessionScreenState();
}

class _AddCuppingSessionScreenState extends State<AddCuppingSessionScreen> {
  // Controllers สำหรับรับค่า (ตัวอย่าง)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // ตัวแปรสำหรับ Dropdown
  String? selectedForm;
  final List<String> forms = [
    "SCA CVA Descriptive",
    "SCA CVA Affective",
    "SCA CVA Combined",
  ];

  // รายการ Coffee Sample (เริ่มต้นมี 1 อัน)
  List<String> coffeeSamples = [""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Add Cupping Session",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // --- เพิ่ม bottomNavigationBar ---
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // --- ไปหน้า CuppingDetailsScreen ---
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CuppingDetailsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor2,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Cupping Name ---
                  _buildLabel("Cupping Name"),
                  _buildTextField(controller: _nameController),
                  const SizedBox(height: 16),

                  // --- Upload Cupping Activity ---
                  _buildLabel("Upload Cupping Activity"),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.grey.shade50,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Start Date & Time ---
                  _buildLabel("Start Date & Time"),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateTimeInput(
                          "31/3/2026",
                          'assets/icon/calendar.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDateTimeInput(
                          "00:00",
                          'assets/icon/time.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- End Date & Time ---
                  _buildLabel("End Date & Time"),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateTimeInput(
                          "31/3/2026",
                          'assets/icon/calendar.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDateTimeInput(
                          "00:00",
                          'assets/icon/time.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- Location ---
                  _buildLabel("Location"),
                  _buildTextArea(
                    controller: _locationController,
                    hint: "51/200",
                  ),
                  const SizedBox(height: 16),

                  // --- Cupping Activity Description ---
                  _buildLabel("Cupping Activity Description"),
                  _buildTextArea(
                    controller: _descriptionController,
                    hint: "51/200",
                  ),
                  const SizedBox(height: 16),

                  // --- Select Form / Standard ---
                  // _buildLabel("Select Form / Standard"),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey.shade300),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton<String>(
                  //       value: selectedForm,
                  //       isExpanded: true,
                  //       hint: const Text("Select Form"),
                  //       items: forms.map((String value) {
                  //         return DropdownMenuItem<String>(value: value, child: Text(value));
                  //       }).toList(),
                  //       onChanged: (newValue) {
                  //         setState(() {
                  //           selectedForm = newValue;
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 16),

                  // --- Coffee Sample List ---
                  _buildLabel("Coffee Sample"),
                  ...List.generate(coffeeSamples.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(child: _buildTextField(hint: "Coffee Name")),
                          const SizedBox(width: 12),
                          // ปุ่มลบ
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   coffeeSamples.removeAt(index);
                              // });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF5350), // สีแดง
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                // เพิ่ม Center ตรงนี้
                                child: Image.asset(
                                  'assets/icon/fi_trash.png',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  // --- ปุ่มเพิ่ม (+) ---
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CoffeeFromFarmScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: secondaryColor2, // สีน้ำตาลเข้ม
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildTextField({TextEditingController? controller, String? hint}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 19,
            vertical: 10,
          ),
          suffixIcon: hint == "Coffee Name"
              ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildDateTimeInput(String text, String iconPath) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: Colors.grey.shade600)),
          Image.asset(
            iconPath,
            width: 20,
            height: 20,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea({TextEditingController? controller, String? hint}) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Stack(
        children: [
          TextField(
            controller: controller,
            maxLines: null,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
          if (hint != null)
            Positioned(
              bottom: 12,
              right: 12,
              child: Text(
                hint,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
