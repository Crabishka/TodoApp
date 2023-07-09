import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist_for_fittin/pages/main_todo_page/main_todo_page.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF9900),
            primary: const Color(0xFFFF9900),
            background: const Color(0xFFEDEDED),
            error: const Color(0xFFF85535),
            secondary: const Color(0xFF45B443),
            onBackground: const Color(0xFF000000),
            tertiary: const Color(0xFFAEAEAE),
            surface: Colors.white,
          ),
          textTheme: TextTheme(
            headlineSmall: GoogleFonts.montserrat(
                fontSize: 24, height: 32 / 24,
                fontWeight: FontWeight.bold
            ),
            headlineLarge: GoogleFonts.montserrat(
                fontSize: 32, height: 40 / 32,
                fontWeight: FontWeight.bold
            ),
            bodyLarge: GoogleFonts.montserrat(
              fontSize: 16,
              height: 20 / 16,
            ),
            bodyMedium: GoogleFonts.montserrat(
              fontSize: 14,
              height: 20 / 14,
            ),
          )),
      home: MainTodoPage(),
    );
  }
}
