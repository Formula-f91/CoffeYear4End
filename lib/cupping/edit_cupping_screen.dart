import 'package:coffee/constants.dart';
import 'package:flutter/material.dart';

const Color buttonColor = Color(0xFFC67C4E);
const Color deleteColor = Color(0xFFFF5252);

class EditCuppingScreen extends StatefulWidget {
  const EditCuppingScreen({super.key});

  @override
  State<EditCuppingScreen> createState() => _EditCuppingScreenState();
}

class _EditCuppingScreenState extends State<EditCuppingScreen> {
  final TextEditingController _cuppingNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String startDate = "31/3/2026";
  String startTime = "00:00";
  String endDate = "31/3/2026";
  String endTime = "00:00";

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Delete",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, thickness: 1, color: Colors.black12),
                const SizedBox(height: 30),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: deleteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/deletevec.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Are you sure you want to delete",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: deleteColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text("Cancel", style: TextStyle(color: deleteColor, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: deleteColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: const Text("Confirm", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Cupping",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      // ย้ายปุ่มมาไว้ที่ bottomNavigationBar
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 1)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: _showDeleteDialog,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    ),
                    child: const Text("Delete", style: TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: secondaryColor2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      elevation: 0,
                    ),
                    child: const Text("Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cupping Name
            _buildLabel("Cupping Name"),
            const SizedBox(height: 8),
            _buildTextField(_cuppingNameController, hint: ""),

            const SizedBox(height: 20),

            // 2. Image Section
            _buildLabel("Image"),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.add_circle_outline, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(4, (index) {
                        return GestureDetector(
                          onTap: _showImageOptionsSheet,
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage('assets/Image.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            // 3. Cupping Event Header
            const Text("Cupping Event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            // 4. Location
            _buildLabel("Location"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _locationController,
                    maxLines: 3,
                    minLines: 3,
                    decoration: const InputDecoration.collapsed(hintText: ""),
                  ),
                  const SizedBox(height: 8),
                  Text("51/200", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 5. Start Date & Time
            _buildLabel("Start Date & Time"),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildDateTimePicker(startDate, 'assets/icon/calendar.png')),
                const SizedBox(width: 12),
                Expanded(child: _buildDateTimePicker(startTime, 'assets/icon/time.png')),
              ],
            ),

            const SizedBox(height: 16),

            // 6. End Date & Time
            _buildLabel("End Date & Time"),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildDateTimePicker(endDate, 'assets/icon/calendar.png')),
                const SizedBox(width: 12),
                Expanded(child: _buildDateTimePicker(endTime, 'assets/icon/time.png')),
              ],
            ),

            const SizedBox(height: 20),

            // 7. Description
            _buildLabel("Cupping Activity Description"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    minLines: 3,
                    decoration: const InputDecoration.collapsed(hintText: ""),
                  ),
                  const SizedBox(height: 8),
                  Text("51/200", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 8. Coffee Sample List
            _buildLabel("Coffee Sample"),
            const SizedBox(height: 8),
            _buildCoffeeSampleItem("Coffee Name"),
            const SizedBox(height: 12),

            // Add Button
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: primaryColor2,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {},
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
    );
  }

  Widget _buildTextField(TextEditingController controller, {String hint = ""}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: primaryColor2, width: 2),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(String value, String iconAssetPath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: TextStyle(color: Colors.grey.shade600)),
          Image.asset(iconAssetPath, width: 20, height: 20, fit: BoxFit.contain),
        ],
      ),
    );
  }

  Widget _buildCoffeeSampleItem(String name) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFFF5252),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Center(
            child: Image.asset(
              'assets/icon/fi_trash.png',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        )
      ],
    );
  }

  void _showImageOptionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "xxxxxxxxxxxx",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 28, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              _buildSheetItem(
                imagePath: 'assets/icon/Eye.png',
                label: "View image",
                onTap: () => Navigator.pop(context),
              ),
              _buildSheetItem(
                imagePath: 'assets/icon/Available Updates.png',
                label: "Change image",
                onTap: () => Navigator.pop(context),
              ),
              _buildSheetItem(
                imagePath: 'assets/icon/Trash.png',
                label: "Delete",
                labelColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSheetItem({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
    Color labelColor = Colors.black,
  }) {
    return ListTile(
      leading: Image.asset(imagePath, width: 24, height: 24, fit: BoxFit.contain),
      title: Text(
        label,
        style: TextStyle(color: labelColor, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}