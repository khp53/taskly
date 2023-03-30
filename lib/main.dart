import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskly_new/screen/auth/auth_view.dart';
import 'package:taskly_new/screen/home/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        unselectedWidgetColor: const Color(0xFF9CB6CA),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith(
                (states) => const Color(0xffEA0247),
          ),
        ),
        colorScheme: const ColorScheme(
          background: Colors.white,
          primary: Color(0xffEA0247),
          secondary: Color(0xFF0288EA),
          tertiary: Color(0xFF9CB6CA),
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFF222222),
          onBackground: Color(0xFF222222),
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xffF4F4F4),
      ),
      home: const AuthView(),
    );
  }
}
