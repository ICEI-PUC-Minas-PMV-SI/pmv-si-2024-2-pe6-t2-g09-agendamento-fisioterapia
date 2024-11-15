import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/journal.dart';
import 'screens/Agendamento/adicionarAgendamento.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/login/login.dart';
import 'screens/home_screen/apagarUsuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
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
        "login": (context) => const Login(),
        "home": (context) => const HomeScreen(),
        "apagarUsuarios": (context) => const ApagarUsuario(),
      },
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == "adicionarAgendamento") {
          final journal = routeSettings.arguments as Journal;
          return MaterialPageRoute(
            builder: (context) {
              return AdicionarAgendamento(journal: journal);
            },
          );
        }
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Rota desconhecida')),
            body: const Center(child: Text('Rota desconhecida')),
          ),
        );
      },
    );
  }
}
