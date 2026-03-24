import 'package:coffee/constants.dart';
import 'package:coffee/cupping/createcupping/editsample.dart';
import 'package:coffee/model/session_model.dart';
import 'package:flutter/material.dart';

class SampleInfoPage extends StatefulWidget {
  final List<SampleModel>? initialSamples;

  const SampleInfoPage({super.key, this.initialSamples});

  @override
  State<SampleInfoPage> createState() => _SampleInfoPageState();
}

class _SampleInfoPageState extends State<SampleInfoPage> {
  late List<SampleModel> _samples;

  @override
  void initState() {
    super.initState();
    _samples = widget.initialSamples != null
        ? List.from(widget.initialSamples!)
        : [];
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
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Sample Info",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text(
              "Sample Information",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),

          // ── Add Sample Button ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push<SampleModel>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditSamplePage(
                        sampleNumber: "Sample #${_samples.length + 1}",
                        isAddMode: true,
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() => _samples.add(result));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Add Sample",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Sample List ──────────────────────────────────────────────────
          Expanded(
            child: _samples.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    itemCount: _samples.length,
                    separatorBuilder:
                        (context, index) =>
                            Divider(color: Colors.grey.shade200, height: 32),
                    itemBuilder:
                        (context, index) =>
                            _buildSampleItem(index, _samples[index]),
                  ),
          ),

          // ── Save Button — returns List<SampleModel> ──────────────────────
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.coffee_outlined, size: 56, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            "No samples yet\nTap \"Add Sample\" to begin",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleItem(int index, SampleModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "#${index + 1}  ${data.name}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: secondaryColor2.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                data.roastLevel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "Type : ${data.type}",
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        if (data.species.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            "Species : ${data.species}",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
        if (data.country.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            "Country : ${data.country}",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
        const SizedBox(height: 12),

        // Action buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 30,
              child: OutlinedButton(
                onPressed: () {
                  setState(() => _samples.removeAt(index));
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red.shade400, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () async {
                  // Navigate to edit and replace on return
                  final result = await Navigator.push<SampleModel>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditSamplePage(
                        sampleNumber: "Sample #${index + 1}",
                        isAddMode: false,
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() => _samples[index] = result);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            if (_samples.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please add at least 1 sample'),
                ),
              );
              return;
            }
            // Return all samples to AddCoffeeInfoPage
            Navigator.pop(context, _samples);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0,
          ),
          child: Text(
            "Save  (${_samples.length} sample${_samples.length != 1 ? 's' : ''})",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}