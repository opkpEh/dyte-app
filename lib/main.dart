import 'package:dyte/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 251, 251, 251),
  ),
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    bodyLarge: TextStyle(
      color: Colors.white
    ),
    bodyMedium: TextStyle(
      color: Colors.white
    ),
    bodySmall: TextStyle(
      color: Colors.white
    ),
  ),
);

void main() {
      runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const TabsScreen(),
    );
  }
}