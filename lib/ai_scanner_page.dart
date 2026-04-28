import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; 
import 'success_page.dart'; 

class AiScannerPage extends StatelessWidget {
  final String? imagePath;

  const AiScannerPage({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.isDarkMode;

    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFDDE0E3);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "AI Assist Scanner",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: textColor,
              ),
            ),
            const SizedBox(width: 8),
            const Text("🤖", style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: imagePath != null
                        ? Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/injured_dog.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: isDark ? Colors.grey[800] : Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              );
                            },
                          ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Auto AI >",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("🤖", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Text(
                        "Analyzing...",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -30,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: cardColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.amber, size: 35),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Results :",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.amber, thickness: 1.5, endIndent: 20),
                  const SizedBox(height: 15),
                  _buildDataRow("🐾", "Animal : ", "Dog", textColor),
                  _buildDataRow("🚨", "Condition : ", "Critical", textColor, isCritical: true),
                  _buildDataRow("📍", "Location : ", "Auto Detected GPS", textColor),
                  const Spacer(),
                  Center(
                    child: Text(
                      "Please review and submit the report.",
                      style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            side: BorderSide(color: isDark ? Colors.white24 : Colors.grey.shade400),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text("Edit", style: TextStyle(color: textColor, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SuccessPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFC107),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String emoji, String label, String value, Color textColor, {bool isCritical = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 15),
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isCritical ? Colors.red : textColor,
            ),
          ),
        ],
      ),
    );
  }
}