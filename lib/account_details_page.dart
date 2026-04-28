import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'screens/welcome_screen.dart';

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({super.key});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Delete Account"),
          content: const Text(
            "Are you sure you want to delete your account? This action cannot be undone.",
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  (route) => false,
                );
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFFFAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Account Details',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          
          _buildDetailTile(Icons.edit, "Edit Profile", null, isDark, () {}),
          
          _buildDetailTile(Icons.email_outlined, "Email Address", "perera@gmail.com", isDark, () {}),
          
          _buildDetailTile(Icons.phone_android_outlined, "Phone Number", "+94 71 234 5678", isDark, () {}),
          
          _buildDetailTile(Icons.key_outlined, "Change Password", null, isDark, () {}),
          
          _buildDetailTile(
            Icons.delete_outline, 
            "Delete Account", 
            "Permanently remove account", 
            isDark, 
            () => _showDeleteDialog(context),
            isDelete: true
          ),

          const Spacer(),
          
          // Bottom Logo
          Column(
            children: [
              Image.asset(
                'assets/images/logo.png', 
                height: 80, 
                errorBuilder: (c, e, s) => const Icon(Icons.pets, size: 60, color: Colors.blueGrey)
              ),
              const Text(
                "Vet-Talk",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String title, String? subtitle, bool isDark, VoidCallback onTap, {bool isDelete = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, color: isDelete ? Colors.redAccent.withOpacity(0.6) : (isDark ? Colors.white70 : Colors.black87), size: 30),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold, 
            color: isDelete ? Colors.redAccent.withOpacity(0.6) : (isDark ? Colors.white : Colors.black)
          ),
        ),
        subtitle: subtitle != null 
          ? Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)) 
          : null,
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: isDark ? Colors.white38 : Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
