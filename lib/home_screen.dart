import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'settings_provider.dart';
import 'ai_scanner_page.dart';
import 'profile_page.dart';
import 'explore_page.dart';
import 'notifications_page.dart';
import 'animal_profile_page.dart';
import 'report_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Future<void> _openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo != null) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AiScannerPage(imagePath: photo.path),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF2E3440);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFFFAFB),
      extendBody: true,
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildHeader(textColor, isDark),
              const SizedBox(height: 20),
              _buildBanner(isDark),
              const SizedBox(height: 25),
              _buildStatsRow(isDark),
              const SizedBox(height: 25),
              _buildRecentCasesHeader(textColor),
              _buildHorizontalCases(isDark, textColor),
              const SizedBox(height: 20),
              _buildAIPromo(isDark, textColor),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildHeader(Color textColor, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Vet-Talk", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor)),
              const Text("Together We Care, They Survive 💛", style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w500)),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
            child: Stack(
              children: [
                Icon(Icons.notifications, size: 35, color: isDark ? Colors.white70 : const Color(0xFF2E3440)),
                Positioned(
                  right: 5, top: 5,
                  child: Container(height: 10, width: 10, decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 170,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFBEE),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            Positioned(
              left: 20, top: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Action\nSaves Lives 💛", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.1, color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(height: 8),
                  const Text("Report, support and make a\ndifference for stray animals.", style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.3)),
                ],
              ),
            ),
            Positioned(
              right: -10, bottom: -5,
              child: Image.asset('assets/images/home_banner.png', height: 150, fit: BoxFit.contain, errorBuilder: (c, e, s) => Icon(Icons.pets, size: 100, color: Colors.amber.withOpacity(0.5))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _statCard("Reported\nCases (5)", isDark ? const Color(0xFF2C1619) : const Color(0xFFFFEBEE), Icons.report_problem, Colors.red, isDark),
          const SizedBox(width: 15),
          _statCard("Resolved\nCases (10)", isDark ? const Color(0xFF142015) : const Color(0xFFE8F5E9), Icons.check_circle, Colors.green, isDark),
        ],
      ),
    );
  }

  Widget _statCard(String text, Color bg, IconData icon, Color iconColor, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 10),
            Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 1.2, color: isDark ? Colors.white : Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCasesHeader(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Recent Cases", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
          TextButton(onPressed: () {}, child: const Text("View All >", style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }

  Widget _buildHorizontalCases(bool isDark, Color textColor) {
    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        children: [
          _caseCard(
            "assets/images/dog_case.png", 
            "Dog", 
            "Food and Water", 
            "Kandy", 
            "A tired stray dog rests quietly on a doorstep after wandering the streets in search of food. His body shows signs of exhaustion.", 
            isDark, 
            textColor
          ),
          _caseCard(
            "assets/images/cat_case.png", 
            "Cat", 
            "Injured Kitty", 
            "Colombo", 
            "A small kitten was found near the park with a leg injury. Needs urgent medical attention and care.", 
            isDark, 
            textColor
          ),
        ],
      ),
    );
  }

  Widget _caseCard(String img, String animalType, String category, String loc, String desc, bool isDark, Color textColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalProfilePage(
              animalType: animalType,
              category: category,
              description: desc,
              imagePath: img,
            ),
          ),
        );
      },
      child: Container(
        width: 200, margin: const EdgeInsets.only(right: 20, bottom: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              child: Image.asset(img, height: 140, width: 200, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: Colors.grey.shade300, child: const Icon(Icons.image))),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                  const SizedBox(height: 5),
                  Row(children: [const Icon(Icons.location_on, size: 16, color: Colors.amber), Text(loc, style: const TextStyle(color: Colors.grey, fontSize: 14))]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIPromo(bool isDark, Color textColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20), padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF1E1E1E) : Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Colors.amber, size: 30),
          const SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("New ! AI Assistance", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)), const Text("Scan an animal and get instant help.", style: TextStyle(color: Colors.grey, fontSize: 12))])),
          
          // Learn more button with Navigation
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AiScannerPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : const Color(0xFFF0F0F0), 
                borderRadius: BorderRadius.circular(10)
              ), 
              child: Text("Learn more >", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor))
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return Container(
      height: 85, width: 85,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.4), spreadRadius: 8, blurRadius: 15)]),
      child: FloatingActionButton(
        onPressed: _openCamera, backgroundColor: Colors.amber, shape: const CircleBorder(), elevation: 0,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.camera_alt, color: Color(0xFF2E3440), size: 35), Text("AI Scan", style: TextStyle(color: Color(0xFF2E3440), fontSize: 12, fontWeight: FontWeight.bold))]),
      ),
    );
  }

  Widget _buildBottomNav(bool isDark) {
    return BottomAppBar(
      height: 80, shape: const CircularNotchedRectangle(), notchMargin: 12.0,
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white, elevation: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [_buildNavItem(Icons.home, "Home", 0, isDark), const SizedBox(width: 15), _buildNavItem(Icons.location_on_outlined, "Explore", 1, isDark)]),
          Row(children: [_buildNavItem(Icons.assignment_outlined, "Reports", 2, isDark), const SizedBox(width: 15), _buildNavItem(Icons.person_outline, "Profile", 3, isDark)]),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isDark) {
    bool isSel = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (isSel) return;
        if (Navigator.canPop(context)) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
        if (index == 0) {
          setState(() { _selectedIndex = 0; });
        } 
        else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ExplorePage()));
        } 
        else if (index == 2) { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportPage()));
        } 
        else if (index == 3) {
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