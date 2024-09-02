import 'package:flutter/material.dart';
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
        title: Text(
          "${currentDay.day} de ${getMonthName(currentDay.month)}, ${currentDay.year}",
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
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Olá Davi Aburjeli!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Página Inicial'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                // Adicione navegação para a página inicial, se necessário
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning_amber),
              title: const Text('Horários pendentes'),
              onTap: () {
                Navigator.pushNamed(context, "horariosPendentes");
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                Navigator.pushNamed(context, "login");
              },
            ),
            // Adicione mais itens conforme necessário
          ],
        ),
      ),
      body: ListView(
        controller: _listScrollController,
        children: _generateJournalCards(), // Use a função aqui
      ),
    );
  }

  List<Widget> _generateJournalCards() {
    // Converte o mapa de diários para uma lista de widgets
    return home_screen_list
        .generateListJournalCards(
          currentDay: currentDay,
          database: database,
          refreshFunction: refresh,
        )
        .cast<Widget>(); // Converte para List<Widget> explicitamente
  }

  void refresh() async {
    List<Journal> listJournal = await _journalService.getAll(context);

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
                title: Text(database[id]?.content ?? 'Sem Conteúdo'),
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
