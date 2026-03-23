import 'package:flutter/material.dart';
import 'package:coffee/constants.dart';

class AddProducerInfo extends StatefulWidget {
  const AddProducerInfo({super.key});

  @override
  State<AddProducerInfo> createState() => _AddProducerInfoState();
}

class _AddProducerInfoState extends State<AddProducerInfo> {
  final TextEditingController _detailController = TextEditingController();

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildTextField({String? hint, int maxLines = 1, String? suffixIcon}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(suffixIcon, width: 20),
              )
            : null,
        border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  Widget _buildDetailField() {
    return Stack(
      children: [
        TextField(
          controller: _detailController,
          maxLines: 4,
          maxLength: 200,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
            contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 30),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 12,
          child: Text(
            '${_detailController.text.length}/200',
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add Producer Information",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Farm Name"),
            _buildTextField(),

            _buildLabel("Location"),
            _buildTextField(),

            _buildLabel("Altitude"),
            _buildTextField(),

            _buildLabel("Detail"),
            _buildDetailField(),

            _buildLabel("Contact"),
            _buildTextField(),

            _buildLabel("Upload Farm Image"),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.zero,
              ),
              child: Center(
                child: Image.asset(
                  'assets/icon/imageiconv3.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_outlined,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor2,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}