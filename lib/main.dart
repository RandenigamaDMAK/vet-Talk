import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // 1. Firebase Core Import එක
import 'firebase_options.dart'; // 2. Generate වුණු options ෆයිල් එක
import 'package:vet_talk/screens/welcome_screen.dart';
import 'settings_provider.dart';

void main() async {
  // 3. Flutter Engine එක සූදානම් කරනවා (Async වැඩ වලදී මේක අනිවාර්යයි)
  WidgetsFlutterBinding.ensureInitialized();
  
  // 4. Firebase Initialize කරනවා
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: 'Vet-Talk',
      debugShowCheckedModeBanner: false,
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFAFB),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}