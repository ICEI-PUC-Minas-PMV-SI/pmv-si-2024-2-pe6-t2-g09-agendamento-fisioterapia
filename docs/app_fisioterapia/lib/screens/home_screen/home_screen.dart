import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '/services/journal_service.dart' as journal_service;
import '../../models/journal.dart';
import '/screens/home_screen/widgets/home_screen_list.dart' as home_screen_list;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime startOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  DateTime currentDay = DateTime.now();
  Map<String, Journal> database = {};
  final ScrollController _listScrollController = ScrollController();
  final journal_service.JournalService _journalService =
      journal_service.JournalService();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "${currentDay.day} de ${getMonthName(currentDay.month)} de ${currentDay.year}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _showDeleteDialog(context);
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(),
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Olá Davi Aburjeli!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, size: 40),
              title: const Text(
                'Página Inicial',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            FutureBuilder<bool>(
              future: _hasPendingSchedules(),
              builder: (context, snapshot) {
                Color iconColor = Colors.grey; // Cor padrão para o ícone
                Color textColor = Colors.grey; // Cor padrão para o texto

                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Mostra um indicador de carregamento enquanto verifica
                  iconColor = Colors.grey;
                  textColor = Colors.grey;
                } else if (snapshot.hasData) {
                  bool hasPending = snapshot.data!;
                  iconColor = hasPending ? Colors.orange : Colors.grey;
                  textColor = hasPending ? Colors.orange : Colors.grey;
                }

                return ListTile(
                  leading: Icon(
                    Icons.warning_amber,
                    size: 40,
                    color: iconColor,
                  ),
                  title: Text(
                    'Horários Pendentes',
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "horariosPendentes");
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, size: 40),
              title: const Text(
                'Sair',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "login");
              },
            ),
          ],
        ),
      ),
      body: ListView(
        controller: _listScrollController,
        children: _generateJournalCards(),
      ),
    );
  }

  List<Widget> _generateJournalCards() {
    return home_screen_list
        .generateListJournalCards(
          currentDay: currentDay,
          database: database,
          refreshFunction: refresh,
        )
        .cast<Widget>();
  }

  Future<void> refresh() async {
    List<Journal> listJournal =
        await _journalService.carregaCalendario(context);

    setState(() {
      database = {};
      for (Journal journal in listJournal) {
        database[journal.id] = journal;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToCurrentDay();
      });
    });
  }

  Future<bool> _hasPendingSchedules() async {
    List<Journal> listJournal =
        await _journalService.carregaCalendario(context);
    return listJournal
        .isNotEmpty; // Retorna verdadeiro se houver algum horário pendente
  }

  void scrollToCurrentDay() {
    int indexOfToday = currentDay.day - 1;

    if (indexOfToday >= 0 && indexOfToday < endOfMonth.day) {
      _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent *
            (indexOfToday / (endOfMonth.day - 1)),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  String getMonthName(int month) {
    const List<String> months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];
    return months[month - 1];
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    List<String> ids = database.keys.toList();

    if (ids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Nenhum agendamento disponível para remover.')),
      );
      return;
    }

    String? selectedId = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Escolha o agendamento para remover',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ids.map((id) {
              return ListTile(
                title: Text(
                  database[id]?.content ?? 'Sem Conteúdo',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, id);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedId != null) {
      bool wasDeleted = await _journalService.remove(selectedId);
      if (wasDeleted) {
        setState(() {
          database.remove(selectedId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Agendamento removido com sucesso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao remover agendamento')),
        );
      }
    }
  }
}
