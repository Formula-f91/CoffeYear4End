import 'package:coffee/constants.dart';
import 'package:coffee/cupping/Descriptive/Descriptivechart.dart';
import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescriptiveSuccess extends StatefulWidget {
  const DescriptiveSuccess({super.key});

  @override
  State<DescriptiveSuccess> createState() => _DescriptiveSuccessState();
}

class _DescriptiveSuccessState extends State<DescriptiveSuccess> {
  final Color themeColor = const Color(0xFFC67C4E);
  final Color successGreen = const Color(0xFF75F94C);

  @override
  Widget build(BuildContext context) {
    return Consumer<CuppingProvider>(
      builder: (context, provider, child) {
        final allCups = provider.allCups;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text(
              "Select Coffee",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: secondaryColor2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "Back",
                        style: TextStyle(color: secondaryColor2, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DescriptiveChart(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: allCups.length,
            itemBuilder: (context, index) {
              final cupData = allCups[index];
              final cupNumber = index + 1;
              final score = cupData.totalScore.toStringAsFixed(1);
              return _buildCoffeeItem(context, provider, cupNumber, score);
            },
          ),
        );
      },
    );
  }

  Widget _buildCoffeeItem(
    BuildContext context,
    CuppingProvider provider,
    int cupNumber,
    String score,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: successGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: successGreen, size: 24),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cup #$cupNumber",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Score: $score",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Ready",
                      style: TextStyle(
                        color: successGreen.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          OutlinedButton(
            onPressed: () {
              // provider.selectCup(cupNumber);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const DescriptiveChart(),
              //   ),
              // );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: secondaryColor2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(
              "Edit",
              style: TextStyle(color: secondaryColor2, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
