import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool sendNotifications = true;
  bool allRead = false;

  final List<Map<String, dynamic>> notifications = [
    {
      "title": "New Case Reported",
      "desc": "Injured dog reported in Kandy",
      "time": "2 min ago",
      "icon": Icons.pets,
      "color": Colors.amber
    },
    {
      "title": "Case Resolved",
      "desc": "Your reported case has been resolved",
      "time": "1 hour ago",
      "icon": Icons.check_circle,
      "color": Colors.green
    },
    {
      "title": "Case Update",
      "desc": "Vet assigned to your report",
      "time": "10 min ago",
      "icon": Icons.pets,
      "color": Colors.amber
    },
    {
      "title": "Nearby Alert",
      "desc": "Animal in need near your area",
      "time": "30 min ago",
      "icon": Icons.location_on,
      "color": Colors.orange
    },
    {
      "title": "Emergency",
      "desc": "Critical injured animal nearby!",
      "time": "Just now",
      "icon": Icons.warning_amber_rounded,
      "color": Colors.red,
      "isEmergency": true
    },
    {
      "title": "Community",
      "desc": "Someone liked your report",
      "time": "15 min ago",
      "icon": Icons.notifications,
      "color": Colors.black
    },
  ];

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.isDarkMode;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => setState(() => allRead = true),
              child: const Text("Mark all as read", style: TextStyle(color: Colors.grey)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemBuilder: (context, index) {
                return _buildNotificationCard(notifications[index], isDark, cardColor, textColor);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Send me notifications", style: TextStyle(color: textColor, fontSize: 16)),
                Switch(
                  value: sendNotifications,
                  activeColor: Colors.amber,
                  onChanged: (value) => setState(() => sendNotifications = value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item, bool isDark, Color cardColor, Color textColor) {
    bool isEmergency = item['isEmergency'] ?? false;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetailPage(notification: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          border: isEmergency ? Border.all(color: Colors.red.withOpacity(0.5), width: 1.5) : null,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Opacity(
          opacity: allRead ? 0.6 : 1.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item['icon'], color: item['color'], size: 28),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['title'], style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(item['desc'], style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(item['time'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Detail Page inside the same file
class NotificationDetailPage extends StatelessWidget {
  final Map<String, dynamic> notification;
  const NotificationDetailPage({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Details", style: TextStyle(color: Colors.grey)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: notification['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(notification['icon'], color: notification['color'], size: 40),
            ),
            const SizedBox(height: 25),
            Text(
              notification['title'],
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 10),
            Text(notification['time'], style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),
            Text(
              notification['desc'],
              style: TextStyle(fontSize: 18, color: textColor.withOpacity(0.8), height: 1.5),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Back to Notifications", 
                  style: TextStyle(color: Color(0xFF2E3440), fontWeight: FontWeight.bold)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}