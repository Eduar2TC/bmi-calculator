import 'package:bmi_calculator/pages/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFAFAFA);
    const fontColor = Color(0xFF3D4852);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
            /*primary: primaryColor,
            secondary: Colors.green,
            onPrimary: Colors.red,
            onSecondary: Colors.white,
            onBackground: Colors.black,
            primaryContainer: Colors.purple,
            */
            ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.purple,
          ),
          headlineMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: fontColor,
          ),
          bodyLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
