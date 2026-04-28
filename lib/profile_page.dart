import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'explore_page.dart';
import 'account_details_page.dart';
import 'my_reports_page.dart';
import 'settings_page.dart';
import 'login_page.dart';
import 'report_page.dart'; // Import the new ReportPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _selectedIndex = 3;

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
          "Profile",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.purple.shade50,
                    backgroundImage: const AssetImage('assets/user_profile.png'),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Clara",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
                  ),
                  const Text(
                    "clara.admin@pawcare.com",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard("12", "Animals Reported", isDark),
                _buildStatCard("05", "Animals Helped", isDark),
                _buildStatCard("03", "Animals Adopted", isDark),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  _buildListTile(
                    Icons.description_outlined, 
                    "My Reports", 
                    isDark, 
                    () {
                      // This correctly goes to the history/list page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyReportsPage()), 
                      );
                    },
                  ),
                  _buildListTile(Icons.settings_outlined, "Settings", isDark, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
                  }),
                  _buildListTile(Icons.person_outline, "Account Details", isDark, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountDetailsPage()),
                    );
                  }),
                  _buildListTile(Icons.logout, "Logout", isDark, () {
                    _showLogoutDialog(context);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildStatCard(String value, String label, bool isDark) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, bool isDark, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isDark ? Colors.amber : const Color(0xFF2E3440)),
        title: Text(
          title,
          style: TextStyle(color: isDark ? Colors.white : const Color(0xFF2E3440), fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text(
              "Logout", 
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return Container(
      height: 85,
      width: 85,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.4), spreadRadius: 8, blurRadius: 15)],
      ),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber,
        shape: const CircleBorder(),
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.camera_alt, color: Color(0xFF2E3440), size: 35),
            Text(
              "AI Scan",
              style: TextStyle(color: Color(0xFF2E3440), fontSize: 12, fontWeight: FontWeight.bold),
            )
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
          Row(
            children: [
              _buildNavItem(Icons.home_outlined, "Home", 0, isDark),
              const SizedBox(width: 15),
              _buildNavItem(Icons.location_on_outlined, "Explore", 1, isDark),
            ],
          ),
          Row(
            children: [
              _buildNavItem(Icons.assignment_outlined, "Reports", 2, isDark),
              const SizedBox(width: 15),
              _buildNavItem(Icons.person, "Profile", 3, isDark),
            ],
          ),
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

        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ExplorePage()));
        } else if (index == 2) {
          // Now points to the Create Report page, not the history list
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportPage()));
        }
      },
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSel ? Colors.amber : (isDark ? Colors.white38 : Colors.black45), size: 28),
            Text(
              label,
              style: TextStyle(
                fontSize: 12, 
                color: isSel ? Colors.amber : (isDark ? Colors.white38 : Colors.black45)
              ),
            ),
          ],
        ),
      ),
    );
  }
}