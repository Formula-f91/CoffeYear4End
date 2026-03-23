
import 'package:coffee/farm/profile/branch/Branchdetailpage%20.dart';
import 'package:coffee/farm/profile/branch/allBranchesSheet.dart';
import 'package:flutter/material.dart';
import 'package:coffee/profile/userGuidePage.dart';
import 'package:coffee/profile/faqPage.dart';
import 'package:coffee/profile/aboutUsPage.dart';
import 'package:coffee/profile/termsOfServicePage.dart';
import 'package:coffee/profile/setting/settingPage.dart';
import 'package:coffee/profile/cupping/recentCuppingPage.dart';


class ProfilePageWithoutOrders extends StatelessWidget {
  const ProfilePageWithoutOrders({super.key});

  static const List<Map<String, String>> _previewBranches = [
    {'name': 'Growing Area1', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
    {'name': 'Growing Area2', 'owner': 'Owner: Mr. C D', 'location': 'Location: doichang2'},
    {'name': 'Growing Area3', 'owner': 'Owner: Mr. E F', 'location': 'Location: doichang3'},
    {'name': 'Growing Area4', 'owner': 'Owner: Mr. G H', 'location': 'Location: doichang4'},
  ];

  void _showAllBranches(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, scrollController) => const AllBranchesSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. Header ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF8D6E63), Color(0xFFC07651)],
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "XXXXXXXXXX",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountSettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 2. Branch List Section ---
                  _buildSectionHeader(
                    "Branch List",
                    onViewAll: () => _showAllBranches(context),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: List.generate(_previewBranches.length, (index) {
                        final branch = _previewBranches[index];
                        return Column(
                          children: [
                            if (index != 0) _buildDivider(),
                            _buildBranchItem(
                              name: branch['name']!,
                              owner: branch['owner']!,
                              location: branch['location']!,
                              onView: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BranchDetailV2(
                                      branchName: branch['name']!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- 3. Recent Cuppings Section ---
                  _buildSectionHeader(
                    "Recent Cuppings",
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecentCuppingsPage(),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => _buildCuppingEventItem(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- 4. Support Section ---
                  _buildSectionHeader("Support"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildHelpItem(
                          "User Guide",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserGuidePage(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(),
                        _buildHelpItem(
                          "FAQs",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FaqsPage(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(),
                        _buildHelpItem(
                          "About Us",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutUsPage(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(),
                        _buildHelpItem(
                          "Terms of Service",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TermsOfServicePage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey.shade100);
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A56DB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBranchItem({
    required String name,
    required String owner,
    required String location,
    required VoidCallback onView,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(owner,
                    style: const TextStyle(
                        color: Color(0xFF1A56DB), fontSize: 12)),
                Text(location,
                    style: const TextStyle(
                        color: Color(0xFF1A56DB), fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onView,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A56DB),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              elevation: 0,
            ),
            child: const Text('View',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildCuppingEventItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cupping Event",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("Location",
                  style: TextStyle(color: Color(0xFF947257), fontSize: 12)),
            ],
          ),
          Text("70 %",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      title: Text(title,
          style: const TextStyle(fontSize: 16, color: Colors.black87)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}