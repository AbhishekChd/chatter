import 'package:chatter/theme.dart';
import 'package:flutter/material.dart';
import 'package:chatter/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      title: "Chatter",
      home: HomeScreen(),
    );
  }
}
