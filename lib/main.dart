import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zwpgocbrfuxiephfmiip.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp3cGdvY2JyZnV4aWVwaGZtaWlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMxMzU2NjIsImV4cCI6MjA4ODcxMTY2Mn0.8Tf9IhFdHWaJIAHm2isyKY4QaP0F6APuccg8L5q6J6s',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your Wish',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),

      themeMode: ThemeMode.light,

      home: const LoginPage(),
    );
  }
}