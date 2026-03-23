import 'package:coffee/constants.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/AddProducerInfo%20.dart';
import 'package:coffee/farm/profile/branch/Branchdetailpage%20.dart';
import 'package:flutter/material.dart';

class AllBranchesSheet extends StatelessWidget {
  const AllBranchesSheet({super.key});

  // Mock data — replace with real data later
  static const List<Map<String, String>> _branches = [
    {'name': 'Growing Area1', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area2', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area3', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area4', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area5', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area6', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area7', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area8', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area9', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
            child: Row(
              children: [
                const Text(
                  'All Branches',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Branch list
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: _branches.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              itemBuilder: (context, index) {
                final branch = _branches[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              branch['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              branch['owner']!,
                              style: const TextStyle(
                                color: Color(0xFF1A56DB),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              branch['location']!,
                              style: const TextStyle(
                                color: Color(0xFF1A56DB),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BranchDetailV2(
                                branchName: branch['name']!,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor2,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'View',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                 onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddProducerInfo(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor2,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  ),
                  child: const Text(
                    'Add New',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}