import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());

    final session = Supabase.instance.client.auth.currentSession;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: GoogleFonts.googleSans().fontFamily,
        brightness: Brightness.light,
        primaryColor: const Color(0xFF1ABC9C),
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
      ),

      darkTheme: ThemeData(
        fontFamily: GoogleFonts.googleSans().fontFamily,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 52, 56),
      ),

      themeMode: ThemeMode.system,

      home: session == null ? const LoginPage() : const HomePage(),
    );
  }
}
