import 'package:clinica_fisioterapia/screens/home_screen/horariosPendentes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/journal.dart';
import 'screens/add_journal_screen/add_journal_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      initialRoute: "login",
      routes: {
        "login": (context) => Login(),
        "home": (context) => const HomeScreen(),
        "horariosPendentes": (context) => const PendingSchedulesScreen(),
      },
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == "add-journal") {
          final journal = routeSettings.arguments as Journal;
          return MaterialPageRoute(
            builder: (context) {
              return AddJournalScreen(journal: journal);
            },
          );
        }
        return null;
      },
    );
  }
}
