import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  bool isOngoingSelected = true;

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.isDarkMode;
    final textColor = isDark ? Colors.white : const Color(0xFF2E3440);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFFFAFB),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Reports',
          style: TextStyle(
            color: textColor, 
            fontWeight: FontWeight.bold, 
            fontSize: 24
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/user_profile.png'),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildTabButton("Ongoing\nCases(1)", isOngoingSelected, () {
                  setState(() => isOngoingSelected = true);
                }, isDark),
                const SizedBox(width: 15),
                _buildTabButton("Resolved\nCases(2)", !isOngoingSelected, () {
                  setState(() => isOngoingSelected = false);
                }, isDark),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: isOngoingSelected ? _buildOngoingList(isDark) : _buildResolvedList(isDark),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildAiScanButton(isDark),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildTabButton(String title, bool isSelected, VoidCallback onTap, bool isDark) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? (isSelected ? Colors.white10 : Colors.black26) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? (isDark ? Colors.amber : Colors.black) : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? (isDark ? Colors.amber : Colors.black) : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOngoingList(bool isDark) {
    return [
      _buildCaseCard(
        "Medical Emergency",
        "Injured dog near school",
        "30 mins ago",
        "0.5km",
        "Ongoing",
        "Reported",
        "assets/images/ongoing_dog.png", 
        Colors.green,
        isDark,
        hasHeartIcon: true,
      ),
    ];
  }

  List<Widget> _buildResolvedList(bool isDark) {
    return [
      _buildCaseCard("Food and Water", "Stray cat wandering at the streets", "2 hours ago", "0.5 km", "Resolved", "Distance", "assets/images/resolved_cat.png", Colors.grey, isDark),
      _buildCaseCard("Medical Emergency", "Injured dog near park", "4 hours ago", "1.5 km", "Resolved", "Distance", "assets/images/resolved_dog.png", Colors.grey, isDark),
    ];
  }

  Widget _buildCaseCard(String title, String desc, String time, String dist, 
      String status, String subStatus, String imgPath, Color statusColor, bool isDark, {bool hasHeartIcon = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(imgPath, width: 100, height: 100, fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(width: 100, height: 100, color: Colors.grey[300], child: const Icon(Icons.image_not_supported))),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                    if (hasHeartIcon) const Icon(Icons.favorite, color: Colors.red, size: 18),
                  ],
                ),
                Text(desc, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(time, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isDark ? Colors.white70 : Colors.black)),
                    Text(dist, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isDark ? Colors.white70 : Colors.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(status, style: TextStyle(fontSize: 13, color: statusColor, fontWeight: FontWeight.bold)),
                    Text(subStatus, style: TextStyle(fontSize: 13, color: isDark ? Colors.white60 : Colors.black)),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text("View Location", style: TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAiScanButton(bool isDark) {
    return Container(
      height: 85, width: 85,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.4), spreadRadius: 8, blurRadius: 15)]),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber,
        shape: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.camera_alt, color: Color(0xFF2E3440), size: 35),
            Text("AI Scan", style: TextStyle(color: Color(0xFF2E3440), fontSize: 12, fontWeight: FontWeight.bold)),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [ _navItem(Icons.home_outlined, "Home", false, isDark), _navItem(Icons.location_on_outlined, "Explore", false, isDark) ]),
          Row(children: [ _navItem(Icons.assignment, "Reports", true, isDark), _navItem(Icons.person_outline, "Profile", false, isDark) ]),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isSelected, bool isDark) {
    return SizedBox(
      width: 70, 
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Icon(icon, color: isSelected ? Colors.amber : (isDark ? Colors.white38 : Colors.grey), size: 28),
          Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.amber : (isDark ? Colors.white38 : Colors.grey))),
        ]
      )
    );
  }
}