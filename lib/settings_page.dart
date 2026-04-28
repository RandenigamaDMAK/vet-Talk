import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: settings.isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: settings.isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: settings.isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Dark Mode Tile
          _buildSettingTile(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLeading(Icons.wb_sunny_outlined, "Dark Mode", settings.isDarkMode),
                Switch(
                  value: settings.isDarkMode,
                  onChanged: (val) => settings.toggleDarkMode(val),
                  activeColor: Colors.amber,
                ),
              ],
            ),
            isDarkMode: settings.isDarkMode,
          ),
          
          // Language Tile
          _buildSettingTile(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeading(Icons.language, "Language", settings.isDarkMode),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLanguageOption("සිංහල", "Sinhala", settings),
                    _buildLanguageOption("தமிழ்", "Tamil", settings),
                    _buildLanguageOption("English", "English", settings),
                  ],
                ),
              ],
            ),
            isDarkMode: settings.isDarkMode,
          ),

          // Location Tile
          _buildSettingTile(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLeading(Icons.location_on, "Location Settings", settings.isDarkMode),
                Switch(
                  value: settings.isLocationEnabled,
                  onChanged: (val) => settings.toggleLocation(val),
                  activeColor: Colors.amber,
                ),
              ],
            ),
            isDarkMode: settings.isDarkMode,
          ),

          const Spacer(),
          // Bottom Logo
          Column(
            children: [
              Image.asset('assets/images/logo.png', height: 80, errorBuilder: (c, e, s) => const Icon(Icons.pets, size: 60, color: Colors.blueGrey)),
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

  Widget _buildSettingTile({required Widget child, required bool isDarkMode}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDarkMode ? Colors.white24 : Colors.grey.shade200),
      ),
      child: child,
    );
  }

  Widget _buildLeading(IconData icon, String title, bool isDarkMode) {
    return Row(
      children: [
        Icon(icon, size: 28, color: isDarkMode ? Colors.white : Colors.black),
        const SizedBox(width: 15),
        Text(
          title,
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageOption(String label, String value, SettingsProvider settings) {
    bool isSelected = settings.language == value;
    return GestureDetector(
      onTap: () => settings.setLanguage(value),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            size: 18,
            color: isSelected ? Colors.amber : Colors.grey,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? (settings.isDarkMode ? Colors.white : Colors.black) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}