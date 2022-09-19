import 'package:crud/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final radiusBorder = BorderRadius.circular(20);
    const sideBorder = BorderSide(color: Colors.white);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            animationDuration: const Duration(microseconds: 10),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
            borderRadius: radiusBorder,
            borderSide: sideBorder,
          ),
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: radiusBorder,
            borderSide: sideBorder,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: radiusBorder,
            borderSide: sideBorder,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: radiusBorder,
            borderSide: sideBorder,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
