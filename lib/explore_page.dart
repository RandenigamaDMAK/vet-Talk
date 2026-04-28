import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'settings_provider.dart';
import 'profile_page.dart';
import 'ai_scanner_page.dart';
import 'report_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final int _selectedIndex = 1;
  bool _isMapView = true;

  final List<Map<String, String>> pets = const [
    {"name": "Rosi", "image": "assets/images/cat1.jpg"},
    {"name": "Tomy", "image": "assets/images/dog1.jpg"},
    {"name": "Garfield", "image": "assets/images/cat2.jpg"},
    {"name": "Tobey", "image": "assets/images/dog2.jpg"},
    {"name": "Turbo", "image": "assets/images/dog3.jpg"},
    {"name": "Randy", "image": "assets/images/dog4.jpg"},
  ];

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
        title: Text(
          "Explore",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/user_profile.png'),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _buildToggleTabs(isDark),
          Expanded(
            child: _isMapView 
              ? _buildMapView(isDark) 
              : _buildAdoptionGallery(isDark),
          ),
          const SizedBox(height: 100),
        ],
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildToggleTabs(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            _tabButton("Map View", _isMapView, () => setState(() => _isMapView = true), isDark),
            _tabButton("Adoption", !_isMapView, () => setState(() => _isMapView = false), isDark),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String label, bool isActive, VoidCallback onTap, bool isDark) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? const Color(0xFF2E3440) : (isDark ? Colors.white70 : Colors.black54),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapView(bool isDark) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.grey),
                hintText: "Search by animal type or location",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                'assets/images/map_view.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.map_outlined, size: 80, color: Colors.amber.withOpacity(0.5)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdoptionGallery(bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        return _buildPetCard(pet, isDark);
      },
    );
  }

  Widget _buildPetCard(Map<String, String> pet, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                pet['image']!,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(color: Colors.grey[300], child: const Icon(Icons.pets)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2E3440)),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3440),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("View Profile", style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ),
              ],
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
        onPressed: _openCamera,
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
            _buildNavItem(Icons.location_on, "Explore", 1, isDark),
          ]),
          Row(children: [
            _buildNavItem(Icons.assignment_outlined, "Reports", 2, isDark),
            const SizedBox(width: 15),
            _buildNavItem(Icons.person_outline, "Profile", 3, isDark),
          ]),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isDark) {
    bool isSel = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (isSel) return;
        
        Navigator.popUntil(context, (route) => route.isFirst);

        if (index == 0) {
          // Home is already the first route in most cases
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportPage()));
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