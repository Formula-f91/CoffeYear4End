// import 'package:coffee/constants.dart';
// import 'package:coffee/cupping/Combinedform/combined_assessment_screen.dart';
// import 'package:coffee/cupping/Combinedform/combined_assessment_screen_step3.dart';
// import 'package:coffee/cupping/formdescriptor/FragranceAromaDescriptorData.dart';
// import 'package:coffee/cupping/formdescriptor/main_tastes_descriptor_sheet.dart';
// import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CombinedAssessmentScreenStep2 extends StatefulWidget {
//   const CombinedAssessmentScreenStep2({super.key});

//   @override
//   State<CombinedAssessmentScreenStep2> createState() =>
//       _CombinedAssessmentScreenStep2State();
// }

// class _CombinedAssessmentScreenStep2State
//     extends State<CombinedAssessmentScreenStep2> {
//   bool isDescriptiveMode = true;

//   // ── Flavor Descriptors state (เหมือนหน้าแรก) ──
//   List<String> selectedFlavorDescriptors = [];

//   final TextEditingController _noteController = TextEditingController();

//   final Color themeColor = const Color(0xFFC67C4E);
//   final Color activeOrange = const Color(0xFFFF8D28);
//   final Color boxBorderColor = const Color(0xFF947257);

//   int? selectedFragrance;
//   int? selectedAroma;

//   List<String> selectedMainTastes = [];

//   @override
//   void dispose() {
//     _noteController.dispose();
//     super.dispose();
//   }

//   void _showFlavorSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => FragranceAromaDescriptorSheet(
//         initialSelected: List.from(selectedFlavorDescriptors),
//         onApply: (selected) {
//           setState(() => selectedFlavorDescriptors = selected);
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }

//   void _showMainTastesSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => MainTastesDescriptorSheet(
//         initialSelected: List.from(selectedMainTastes),
//         onApply: (selected) {
//           setState(() => selectedMainTastes = selected);
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CuppingProvider>(
//       builder: (context, provider, child) {
//         final cupData = provider.currentCupData;

//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             scrolledUnderElevation: 0,
//             centerTitle: true,
//             automaticallyImplyLeading: false,
//             title: const Text(
//               "Combined Form",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),

//           // ✅ เพิ่ม bottomNavigationBar
//           bottomNavigationBar: SafeArea(
//             child: Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(
//                   top: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: secondaryColor2),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: Text(
//                         "Back",
//                         style: TextStyle(color: secondaryColor2, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     flex: 2,
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               const CombinedAssessmentScreenStep3(),
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: secondaryColor2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 18),
//                       ),
//                       child: const Text(
//                         "Next",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           body: Column(
//             children: [
//               _buildProgressBar(),
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildHeaderCard(),
//                       const SizedBox(height: 22),
//                       isDescriptiveMode
//                           ? _buildSelectCoffeeCardDescription(provider)
//                           : _buildSelectCoffeeCardAffective(provider),
//                       const SizedBox(height: 20),
//                       _buildTabSwitcher(),
//                       const SizedBox(height: 16),
//                       isDescriptiveMode
//                           ? _buildDescriptiveAssessmentBox(provider, cupData)
//                           : _buildAffectiveAssessmentBox(provider, cupData),
//                     ],
//                   ),
//                 ),
//               ),
//               // ✅ ลบ _buildFooterButtons() ออกแล้ว
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // --- Tab Switcher ---
//   Widget _buildTabSwitcher() {
//     return Row(
//       children: [
//         Expanded(
//           child: GestureDetector(
//             onTap: () => setState(() => isDescriptiveMode = true),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 border: Border(
//                   bottom: BorderSide(
//                     color: isDescriptiveMode
//                         ? primaryColor2
//                         : Colors.transparent,
//                     width: 2.0, // ความหนาของเส้นใต้
//                   ),
//                 ),
//               ),
//               child: Text(
//                 "Descriptive",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: isDescriptiveMode
//                       ? primaryColor2
//                       : Colors.grey.shade600,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: GestureDetector(
//             onTap: () => setState(() => isDescriptiveMode = false),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 border: Border(
//                   bottom: BorderSide(
//                     color: !isDescriptiveMode
//                         ? primaryColor2
//                         : Colors.transparent,
//                     width: 2.0, // ความหนาของเส้นใต้
//                   ),
//                 ),
//               ),
//               child: Text(
//                 "Affective",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: !isDescriptiveMode
//                       ? primaryColor2
//                       : Colors.grey.shade600,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // --- Select Coffee Cards ---
//   Widget _buildSelectCoffeeCardDescription(CuppingProvider provider) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(0),
//         border: Border.all(color: const Color(0xFFA2A2A2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Coffee Name",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       "Roast level",
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//               _buildDividerLine(),
//               const Column(
//                 children: [
//                   Text(
//                     "Total Cup",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     "5",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Select coffee",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           const SizedBox(height: 12),
//           _buildCupSelectionRow(provider),
//         ],
//       ),
//     );
//   }

//   Widget _buildSelectCoffeeCardAffective(CuppingProvider provider) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(0),
//         border: Border.all(color: const Color(0xFFA2A2A2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Expanded(
//                 flex: 3,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Coffee Name",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       "Roast level",
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//               _buildDividerLine(),
//               const Expanded(
//                 flex: 2,
//                 child: Column(
//                   children: [
//                     Text(
//                       "Total Cup",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "5",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               _buildDividerLine(),
//               const Expanded(
//                 flex: 2,
//                 child: Column(
//                   children: [
//                     Text(
//                       "Total Score",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "xx",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Select coffee",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           const SizedBox(height: 12),
//           _buildCupSelectionRow(provider),
//         ],
//       ),
//     );
//   }

//   Widget _buildCupSelectionRow(CuppingProvider provider) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: List.generate(5, (index) {
//         int cupNum = index + 1;
//         bool isSelected = provider.currentCupNumber == cupNum;
//         return GestureDetector(
//           onTap: () => provider.selectCup(cupNum),
//           child: Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isSelected ? secondaryColor2 : Colors.white,
//               border: Border.all(
//                 color: isSelected ? secondaryColor2 : Colors.grey.shade300,
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 "$cupNum",
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   // --- ASSESSMENT BOX: Descriptive ---
//   Widget _buildDescriptiveAssessmentBox(
//     CuppingProvider provider,
//     CupData cupData,
//   ) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(16, 38, 16, 16),
//       // decoration: BoxDecoration(
//       //   color: Colors.white,
//       //   borderRadius: BorderRadius.circular(16),
//       //   border: Border.all(color: Colors.grey.shade300),
//       //   boxShadow: [
//       //     BoxShadow(
//       //       color: Colors.black.withOpacity(0.05),
//       //       blurRadius: 10,
//       //       offset: const Offset(0, 4),
//       //     ),
//       //   ],
//       // ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Sliders ──
//           _buildCustomSlider(
//             "Flavor",
//             cupData.flavor,
//             (val) => provider.updateFlavor(val),
//           ),
//           const SizedBox(height: 30),
//           _buildCustomSlider(
//             "Aftertaste",
//             cupData.aftertaste,
//             (val) => provider.updateAftertaste(val),
//           ),
//           const SizedBox(height: 40),

//           // ── Select Up To Five That Apply (เหมือนหน้าแรก) ──
//           Row(
//             // ✅ ใช้ Row แทน เพื่อบังคับให้อยู่บรรทัดเดียวกัน
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // ✅ เอา Expanded มาครอบ Text เพื่อให้ข้อความย่อหรือขึ้นบรรทัดใหม่เองถ้าจอแคบ
//               const Expanded(
//                 child: Text(
//                   "Frvor / Aftertaste",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//                 ),
//               ),
//               // ✅ เพิ่ม SizedBox เว้นระยะห่างระหว่างข้อความกับปุ่ม เพื่อไม่ให้ชิดกันเกินไป
//               const SizedBox(width: 12),
//               ElevatedButton(
//                 onPressed: _showFlavorSheet,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: secondaryColor2,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 8,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(0),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text('Add', style: TextStyle(fontSize: 13)),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           // ── Descriptor display box ──
//           Container(
//             width: double.infinity,
//             constraints: const BoxConstraints(minHeight: 172),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: selectedFlavorDescriptors.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'Descriptor is not added yet, click add descriptor\nto add',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   )
//                 : Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: selectedFlavorDescriptors.map((d) {
//                       return GestureDetector(
//                         onTap: () =>
//                             setState(() => selectedFlavorDescriptors.remove(d)),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: primaryColor2.withOpacity(0.12),
//                             border: Border.all(
//                               color: primaryColor2,
//                               width: 0.5,
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 d,
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               Container(
//                                 width: 16,
//                                 height: 16,
//                                 decoration: BoxDecoration(
//                                   color: primaryColor2,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.close,
//                                   size: 10,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//           ),
//           const SizedBox(height: 24),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Expanded(
//                 child: Text(
//                   "Main Tastes (select up to 2)",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               ElevatedButton(
//                 onPressed: _showMainTastesSheet,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: secondaryColor2,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 8,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(0),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text('Add', style: TextStyle(fontSize: 13)),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           Container(
//             width: double.infinity,
//             constraints: const BoxConstraints(minHeight: 172),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: selectedMainTastes.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'Descriptor is not added yet, click add descriptor\nto add',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   )
//                 : Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: selectedMainTastes.map((d) {
//                       return GestureDetector(
//                         onTap: () =>
//                             setState(() => selectedMainTastes.remove(d)),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: primaryColor2.withOpacity(0.12),
//                             border: Border.all(
//                               color: primaryColor2,
//                               width: 0.5,
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 d,
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               Container(
//                                 width: 16,
//                                 height: 16,
//                                 decoration: BoxDecoration(
//                                   color: primaryColor2,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.close,
//                                   size: 10,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//           ),

//           const Text(
//             'Note',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: _noteController,
//             maxLines: 4,
//             decoration: InputDecoration(
//               hintText: '',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               contentPadding: const EdgeInsets.all(12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- ASSESSMENT BOX: Affective ---
//   Widget _buildAffectiveAssessmentBox(
//     CuppingProvider provider,
//     CupData cupData,
//   ) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         // border: Border.all(color: Colors.grey.shade300),
//         // boxShadow: [
//         //   BoxShadow(
//         //     color: Colors.black.withOpacity(0.05),
//         //     blurRadius: 10,
//         //     offset: const Offset(0, 4),
//         //   ),
//         // ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           const Text(
//             "INITIAL ASSESSMENT (1-9)",
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: Colors.black54,
//               letterSpacing: 0.3,
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Fragrance
//           _buildNumberSelector(
//             label: "Flavor",
//             selectedValue: selectedFragrance,
//             onSelect: (val) => setState(() => selectedFragrance = val),
//           ),
//           const SizedBox(height: 24),

//           // Aroma
//           _buildNumberSelector(
//             label: "Afterlate",
//             selectedValue: selectedAroma,
//             onSelect: (val) => setState(() => selectedAroma = val),
//           ),
//           const SizedBox(height: 32),

//           // Note
//           const Text(
//             'Note',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: _noteController,
//             maxLines: 4,
//             decoration: InputDecoration(
//               hintText: '',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               contentPadding: const EdgeInsets.all(12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNumberSelector({
//     required String label,
//     required int? selectedValue,
//     required ValueChanged<int> onSelect,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(9, (index) {
//             final int num = index + 1;
//             final bool isSelected = selectedValue == num;
//             return GestureDetector(
//               onTap: () => onSelect(num),
//               child: Container(
//                 width: 34,
//                 height: 34,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isSelected ? primaryColor2 : Colors.white,
//                   border: Border.all(
//                     color: isSelected ? primaryColor2 : Colors.grey.shade400,
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "$num",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? Colors.white : Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   Widget _buildCustomSlider(
//     String label,
//     double value,
//     Function(double) onChanged,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//         ),
//         const SizedBox(height: 10),
//         Stack(
//           alignment: Alignment.centerLeft,
//           children: [
//             SliderTheme(
//               data: SliderTheme.of(context).copyWith(
//                 activeTrackColor: secondaryColor2,
//                 inactiveTrackColor: const Color(0xFFF0E5DE),
//                 trackHeight: 14.0,
//                 thumbShape: BalloonSliderShape(
//                   thumbRadius: 10,
//                   thumbValue: value.toInt(),
//                   color: secondaryColor2,
//                 ),
//               ),
//               child: Slider(
//                 value: value,
//                 min: 0,
//                 max: 15,
//                 onChanged: onChanged,
//               ),
//             ),
//             IgnorePointer(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 24.0),
//                 child: Container(
//                   width: 20,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: secondaryColor2,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.white, width: 3),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         LayoutBuilder(
//           builder: (context, constraints) {
//             final double trackWidth = constraints.maxWidth - 48;
//             double getPos(double val) => 24 + (val / 10 * trackWidth);
//             return SizedBox(
//               height: 40,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned(
//                     left: getPos(3.0),
//                     top: -12,
//                     child: _buildTickMark(),
//                   ),
//                   Positioned(
//                     left: getPos(7.0),
//                     top: -12,
//                     child: _buildTickMark(),
//                   ),
//                   Positioned(
//                     left: getPos(1.5) - 25,
//                     top: 12,
//                     width: 50,
//                     child: const Text(
//                       "Low",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: getPos(5.0) - 25,
//                     top: 12,
//                     width: 50,
//                     child: const Text(
//                       "Medium",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: getPos(8.5) - 25,
//                     top: 12,
//                     width: 50,
//                     child: const Text(
//                       "High",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildProgressBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Row(
//         children: List.generate(
//           6,
//           (index) => Expanded(
//             child: Container(
//               height: 10,
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               decoration: BoxDecoration(
//                 color: index <= 1 ? secondaryColor2 : Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderCard() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: secondaryColor2,
//         borderRadius: BorderRadius.circular(0),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 46,
//             height: 46,
//             decoration: const BoxDecoration(shape: BoxShape.circle),
//             padding: const EdgeInsets.all(2),
//             child: ClipOval(
//               child: Image.asset(
//                 'assets/photo/coffepro.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             // ✅ ครอบด้วย Expanded
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   isDescriptiveMode
//                       ? "Descriptive Assessment"
//                       : "Affective Assessment",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 20,
//                   ),
//                   overflow: TextOverflow.ellipsis, // ✅ ตัดข้อความถ้ายาวเกิน
//                   maxLines: 1,
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   "Name : xxxxxxx   |   Date : 26.01.23",
//                   style: TextStyle(color: Colors.white, fontSize: 12),
//                   overflow: TextOverflow.ellipsis, // ✅
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDividerLine() => Container(
//     height: 40,
//     width: 1,
//     color: primaryColor2,
//     margin: const EdgeInsets.symmetric(horizontal: 16),
//   );

//   Widget _buildTickMark() =>
//       Container(width: 1.5, height: 25, color: primaryColor2);
// }
