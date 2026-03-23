import 'package:flutter/material.dart';

class AddCoffeeInfoPage extends StatefulWidget {
  // รับข้อมูลเดิมเข้ามา (ถ้าเป็น null = เพิ่มใหม่)
  final Map<String, dynamic>? existingData;

  const AddCoffeeInfoPage({super.key, this.existingData});

  @override
  State<AddCoffeeInfoPage> createState() => _AddCoffeeInfoPageState();
}

class _AddCoffeeInfoPageState extends State<AddCoffeeInfoPage> {
  // Controllers
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _harvestSeasonController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _lotCodeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // ตัวแปร Dropdown
  String? selectedType;
  String? selectedVariety;
  String? selectedProcessingMethod;

  // ตัวแปรวันที่
  String selectedDate = "Select Date";

  // เช็คว่ากำลัง Edit อยู่หรือไม่
  bool get isEditing => widget.existingData != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _loadExistingData();
    }
  }

  void _loadExistingData() {
    final data = widget.existingData!;
    _codeController.text = data['code'] ?? '';
    _nameController.text = data['name'] ?? '';
    _harvestSeasonController.text = data['harvest_season'] ?? '';
    _descriptionController.text = data['description'] ?? '';
    _lotCodeController.text = data['lot_code'] ?? '';
    _quantityController.text = data['quantity'] ?? '';
    _priceController.text = data['price'] ?? '';

    // เช็คค่า Dropdown ว่ามีอยู่ในรายการหรือไม่
    if (typeOptions.contains(data['type'])) selectedType = data['type'];
    if (varietyOptions.contains(data['variety']))
      selectedVariety = data['variety'];
    if (processingMethodOptions.contains(data['method']))
      selectedProcessingMethod = data['method'];

    selectedDate = data['harvest_date'] ?? "Select Date";
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _harvestSeasonController.dispose();
    _descriptionController.dispose();
    _lotCodeController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
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
        title: Text(
          isEditing ? "Edit Coffee Information" : "Add Coffee Information",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // SafeArea ช่วยป้องกันเนื้อหาโดนรอยบาก หรือ แถบ Home Indicator ด้านล่างบัง
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Coffee Code"),
                    _buildTextField("Enter code", _codeController),

                    _buildLabel("Coffee Name"),
                    _buildTextField("Enter name", _nameController),

                    _buildLabel("Type"),
                    _buildDropdownField(
                      hint: "Select type",
                      value: selectedType,
                      items: typeOptions,
                      onChanged: (val) => setState(() => selectedType = val),
                    ),

                    _buildLabel("Variety"),
                    _buildDropdownField(
                      hint: "Select variety",
                      value: selectedVariety,
                      items: varietyOptions,
                      onChanged: (val) => setState(() => selectedVariety = val),
                    ),

                    _buildLabel("Processing Method"),
                    _buildDropdownField(
                      hint: "Select method",
                      value: selectedProcessingMethod,
                      items: processingMethodOptions,
                      onChanged: (val) =>
                          setState(() => selectedProcessingMethod = val),
                    ),

                    _buildLabel("Harvest Season"),
                    _buildTextField("e.g. 2025/2026", _harvestSeasonController),

                    _buildLabel("Coffee Description"),
                    _buildTextField(
                      "",
                      _descriptionController,
                      isMultiLine: true,
                      maxLength: 500, // <--- เพิ่มตรงนี้
                    ),

                    _buildLabel("Upload Coffee Image"),
                    _buildImageUpload(),

                    const SizedBox(height: 20),

                    // การใช้ Row และ Expanded ช่วยให้การแสดงผลพอดีกับความกว้างหน้าจอเสมอ
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Lot Code"),
                              _buildTextField("Enter lot", _lotCodeController),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Harvest Date"),
                              _buildDatePickerField(selectedDate),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Quantity (kg)"),
                              _buildTextField("Enter qty", _quantityController),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Price"),
                              _buildTextField("Enter price", _priceController),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // --- ส่วนปุ่มกดด้านล่าง ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: isEditing
                  ? Row(
                      // กรณี Edit: แสดง 2 ปุ่มแบบ Responsive (สัดส่วน 1:2)
                      children: [
                        // ปุ่ม Delete
                        Expanded(
                          flex: 1, // สัดส่วน 1 ส่วน
                          child: SizedBox(
                            height: 55,
                            child: OutlinedButton(
                              onPressed: () =>
                                  _showDeleteConfirmationDialog(context),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // ปุ่ม Confirm
                        Expanded(
                          flex: 2, // สัดส่วน 2 ส่วน (กว้างกว่า)
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                print("Update Action");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFC07651),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Confirm",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      // กรณี Add: ปุ่มเดียวยาวเต็มจอ
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // ใส่ Logic บันทึกข้อมูลใหม่
                          print("Create Action");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC07651),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
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
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    bool isMultiLine = false,
    int? maxLength,
  }) {
    return Stack(
      children: [
        TextFormField(
          controller: controller,
          maxLines: isMultiLine ? 4 : 1,
          maxLength: maxLength, // รับค่าจำนวนสูงสุด
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            counterText: "", // ซ่อนตัวนับแบบมาตรฐานของ Flutter
            // เว้นขอบด้านขวาไว้ 60 ถ้ามีการนับคำ เพื่อไม่ให้ข้อความไปทับตัวเลข
            contentPadding: EdgeInsets.fromLTRB(
              15,
              12,
              maxLength != null ? 60 : 15,
              12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFC07651)),
            ),
          ),
        ),

        // แสดงตัวนับมุมขวาล่าง เฉพาะเมื่อมีการตั้งค่า maxLength ไว้
        if (maxLength != null)
          Positioned(
            right: 10,
            bottom: 10,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.9,
                    ), // พื้นหลังจางๆ กันข้อความซ้อน
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "${value.text.length}/$maxLength",
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // List ข้อมูลตัวเลือก
  final List<String> typeOptions = [
    "Sales Sample",
    "Pre-Shipment Sample",
    "Quality Evaluation Sample",
    "Calibration / Reference Sample",
    "Rejection Review Sample",
    "Stock Lot Coffee",
    "Others",
  ];

  final List<String> varietyOptions = [
    "Arabica",
    "Robusta",
    "Liberica",
    "Blend",
    "Others",
  ];

  final List<String> processingMethodOptions = [
    "Washed",
    "Honey",
    "Natural",
    "Anaerobic",
    "Experimental",
  ];

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String date) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ใช้ Flexible เพื่อป้องกันข้อความยาวเกินไปจนล้นหน้าจอ (Overflow)
            Flexible(
              child: Text(
                date,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Image.asset(
              'assets/icons/calendar.png', // เช็ค path รูปให้ถูกต้อง
              width: 18,
              height: 18,
              color: const Color(0xFF1D2A4D),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUpload() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.image_outlined,
            size: 40,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  // ย้ายฟังก์ชัน Dialog เข้ามาไว้ใน Class เพื่อให้เรียกใช้ Context และ State ได้อย่างปลอดภัย
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // ให้ขนาด Dialog พอดีกับเนื้อหา
              children: [
                // หัวข้อ Delete ด้านบนซ้าย
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Delete",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.white, thickness: 1),
                const SizedBox(height: 20),

                // ไอคอนวงกลมสีแดงกากบาท
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF3B30), // สีแดงสดตามรูป
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 20),

                // ข้อความคำถาม
                const Text(
                  "Are you sure you want to delete?",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // ปุ่ม Cancel และ Confirm
                Row(
                  children: [
                    // ปุ่ม Cancel (ขอบแดง)
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context); // ปิด Dialog
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFFF3B30)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Color(0xFFFF3B30),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),

                    // ปุ่ม Confirm (พื้นแดง)
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            // --- ใส่ Logic ลบข้อมูลจริงที่นี่ ---
                            print("Deleting Item...");

                            Navigator.pop(context); // ปิด Dialog
                            Navigator.pop(
                              context,
                            ); // ปิดหน้า Edit กลับไปหน้าก่อนหน้า
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF3B30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
