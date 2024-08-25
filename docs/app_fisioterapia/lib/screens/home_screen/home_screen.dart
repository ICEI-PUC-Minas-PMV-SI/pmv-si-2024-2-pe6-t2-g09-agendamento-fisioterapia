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
  // O primeiro e o último dia do mês atual
  DateTime startOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  // O dia atual
  DateTime currentDay = DateTime.now();

  // A base de dados mostrada na lista
  Map<String, Journal> database = {};

  // Controlador de rolagem
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
        // Título baseado no dia, mês e ano atual
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
      body: ListView(
        controller: _listScrollController,
        children: home_screen_list.generateListJournalCards(
          currentDay: currentDay,
          database: database,
          refreshFunction: refresh,
        ),
      ),
    );
  }

  void refresh() async {
    List<Journal> listJournal = await _journalService.getAll(context);

    setState(() {
      database = {};
      for (Journal journal in listJournal) {
        database[journal.id] = journal;
      }

      // Rola para o dia atual após a atualização da lista
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToCurrentDay();
      });
    });
  }

  void scrollToCurrentDay() {
    int indexOfToday = currentDay.day - 1;

    // Verifica se o índice está dentro dos limites da lista
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
    // Cria uma lista de itens para o diálogo
    List<String> ids = database.keys.toList();

    if (ids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Nenhum agendamento disponível para remover.')),
      );
      return;
    }

    // Exibe o diálogo de seleção
    String? selectedId = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Escolha o agendamento para remover',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Define o texto como negrito
            ),
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

    // Verifica se um ID foi selecionado e remove o diário
    if (selectedId != null) {
      bool wasDeleted = await _journalService.remove(selectedId);
      if (wasDeleted) {
        setState(() {
          database.remove(selectedId); // Remove do estado local
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
