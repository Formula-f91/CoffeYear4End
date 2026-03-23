import 'package:coffee/constants.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/CoffeeDetailScreen2.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/add_coffee_info_page.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/add_news_screen.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/editnew.dart';
import 'package:coffee/farm/%E0%B9%89homefarm/newdetail.dart';
import 'package:coffee/farm/profile/branch/Branchdetailpage%20.dart';
import 'package:coffee/farm/profile/branch/allBranchesSheet.dart';
import 'package:flutter/material.dart';

class FarmHomePage extends StatefulWidget {
  const FarmHomePage({super.key});

  @override
  State<FarmHomePage> createState() => _FarmHomePageState();
}

class _FarmHomePageState extends State<FarmHomePage> {
  bool isProductSelected = true;
  final FocusNode _searchFocus = FocusNode();

  static const List<Map<String, String>> _previewBranches = [
    {'name': 'Growing Area1', 'owner': 'Owner: Mr. A B', 'location': 'Location: doichang1'},
 
  ];

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

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
    return GestureDetector(
      onTap: () => _searchFocus.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _searchFocus.unfocus();
            if (isProductSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCoffeeInfoPage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddNewsScreen()),
              );
            }
          },
          backgroundColor: secondaryColor2,
          shape: const CircleBorder(),
          child: Image.asset(
            "assets/icon/plusname.png",
            width: 30,
            height: 30,
            color: Colors.white,
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              "assets/images/head.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
            ),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHeader(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          _buildSearchBar(),
                          const SizedBox(height: 24),

                          // --- Branch List Section ---
                          _buildSectionHeader(
                            "Branch List",
                            onViewAll: () => _showAllBranches(context),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            // decoration: BoxDecoration(
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.circular(15),
                            //   border: Border.all(color: Colors.grey.shade200),
                            // ),
                            child: Column(
                              children: List.generate(_previewBranches.length, (index) {
                                final branch = _previewBranches[index];
                                return Column(
                                  children: [
                                    if (index != 0)
                                      Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
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

                          const SizedBox(height: 12),
                          _buildToggleSwitch(),
                          const SizedBox(height: 24),
                          isProductSelected ? _buildProductGrid() : _buildNewsList(),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white24,
            backgroundImage: AssetImage("assets/icon/Avatar.png"),
          ),
          const SizedBox(width: 16),
          const Text(
            'XXXXXXXXXX',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      focusNode: _searchFocus,
      decoration: InputDecoration(
        hintText: 'Search coffee',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset("assets/Search.png", width: 16, height: 16, color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color.fromARGB(255, 49, 49, 49)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFC67C4E), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: secondaryColor2,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: const Text(
                  "View All",
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
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
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 2),
                Text(owner, style: TextStyle(color: secondaryColor2, fontSize: 12)),
                Text(location, style: TextStyle(color: primaryColor2, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onView,
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor2,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              elevation: 0,
            ),
            child: const Text('View', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSwitch() {
  return Row(
    children: [
      _buildToggleButton('Product', isProductSelected, () {
        _searchFocus.unfocus();
        setState(() => isProductSelected = true);
      }),
      Container(width: 0, height: 40, color: Colors.grey.shade300),
      _buildToggleButton('News', !isProductSelected, () {
        _searchFocus.unfocus();
        setState(() => isProductSelected = false);
      }),
    ],
  );
}

Widget _buildToggleButton(String title, bool isSelected, VoidCallback onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF1A56DB) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF1A56DB) : Colors.grey.shade500,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  );
}

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) => _buildProductCard(context),
    );
  }

  Widget _buildProductCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CoffeeDetailScreen2()),
      );
    },
    child: Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 126,
            child: Image.asset(
              "assets/icon/coffeproduct.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Coffee Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const Text('xxxxxxxxxxxxxx\nxxxxxxxxxxxx',
                    style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget _buildNewsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  "assets/images/coffee.png",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('News 101', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 4),
                    const Text('Description', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    const Text(
                      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EditNewsPage()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: secondaryColor2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          ),
                          child: Text('Edit', style: TextStyle(color: secondaryColor2)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NewsDetailScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          ),
                          child: const Text('Read More', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}