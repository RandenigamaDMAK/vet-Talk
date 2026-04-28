import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'explore_page.dart';
import 'profile_page.dart';
import 'report_details_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String selectedType = "Dog";
  String selectedCategory = "Food";

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFFFAFB);

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Report", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/user_profile.png'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Photo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/dog_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E3440)),
                  child: const Text("Upload", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Animal Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterChip("Dog"),
                _buildFilterChip("Cat"),
                _buildFilterChip("Bird"),
                _buildFilterChip("Other"),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryChip("Food"),
                _buildCategoryChip("Medical"),
                _buildCategoryChip("Adopt"),
                _buildCategoryChip("NGO"),
              ],
            ),
            const SizedBox(height: 25),
            _buildShelterCard("Animal Wellness Trust SL", "4.8", "Paragasthota. 071 769 7643", isDark),
            _buildShelterCard("Charlie's Home by 'save a paw'", "4.2", "Ragama. 071 248 3342", isDark),
            
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReportDetailsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E3440),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 2,
                ),
                child: const Text(
                  "Next", 
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                ),
              ),
            ),
            
            const SizedBox(height: 110),
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = selectedType == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) => setState(() => selectedType = label),
      selectedColor: Colors.amber,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.grey),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) => setState(() => selectedCategory = label),
      selectedColor: Colors.amber,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.grey),
    );
  }

  Widget _buildShelterCard(String name, String rating, String sub, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Row(children: [const Icon(Icons.star, color: Colors.amber, size: 18), Text(rating)]),
            ],
          ),
          Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          Row(
            children: [
              _iconBtn(Icons.language, "Website"),
              const SizedBox(width: 10),
              _iconBtn(Icons.directions, "Directions"),
            ],
          )
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue.shade200), borderRadius: BorderRadius.circular(20)),
      child: Row(children: [Icon(icon, size: 16, color: Colors.blue), const SizedBox(width: 5), Text(label, style: const TextStyle(color: Colors.blue, fontSize: 12))]),
    );
  }

  Widget _buildFab() {
    return Container(
      height: 85, width: 85,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.4), spreadRadius: 8, blurRadius: 15)]),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber,
        shape: const CircleBorder(),
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.camera_alt, color: Color(0xFF2E3440), size: 35),
            Text("AI Scan", style: TextStyle(color: Color(0xFF2E3440), fontSize: 12, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(bool isDark) {
    return BottomAppBar(
      height: 80,
      shape: const CircularNotchedRectangle(),
      notchMargin: 12.0,
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      elevation: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            _buildNavItem(Icons.home_outlined, "Home", 0, isDark),
            const SizedBox(width: 15),
            _buildNavItem(Icons.location_on_outlined, "Explore", 1, isDark),
          ]),
          Row(children: [
            _buildNavItem(Icons.assignment, "Reports", 2, isDark),
            const SizedBox(width: 15),
            _buildNavItem(Icons.person_outline, "Profile", 3, isDark),
          ]),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isDark) {
    bool isSel = index == 2;

    return GestureDetector(
      onTap: () {
        if (isSel) return;
        Navigator.popUntil(context, (route) => route.isFirst);
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ExplorePage()));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
        }
      },
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSel ? Colors.amber : (isDark ? Colors.white38 : Colors.black45), size: 28),
            Text(label, style: TextStyle(fontSize: 12, color: isSel ? Colors.amber : (isDark ? Colors.white38 : Colors.black45))),
          ],
        ),
      ),
    );
  }
}