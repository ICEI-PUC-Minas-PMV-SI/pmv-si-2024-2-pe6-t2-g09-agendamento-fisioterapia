import 'package:clinica_fisioterapia/models/user/dataUser.dart';
import 'package:flutter/material.dart';
import '../../services/apiService.dart' as journal_service;
import '../../models/journal.dart';
import '/screens/home_screen/widgets/home_screen_list.dart' as home_screen_list;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  final DataUser _dataUser = DataUser();
  DateTime startOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endOfMonth =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  DateTime currentDay = DateTime.now();
  Map<String, Journal> database = {};
  final ScrollController _listScrollController = ScrollController();
  final journal_service.ApiService _apiService = journal_service.ApiService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    refresh();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToCurrentDay();
    });
  }

  void scrollToCurrentDay() {
    int indexOfToday = currentDay.day - 1;

    if (indexOfToday >= 0 && indexOfToday < endOfMonth.day) {
      if (_listScrollController.hasClients) {
        _listScrollController.animateTo(
          _listScrollController.position.maxScrollExtent *
              (indexOfToday / (endOfMonth.day - 1)),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Future<void> _loadUserData() async {
    String? storedUsername = await _dataUser.getUsername();
    if (storedUsername != null) {
      setState(() {
        username = _capitalizeFirstLetter(storedUsername);
      });
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
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
            fontSize: 17,
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
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Olá $username',
                  style: const TextStyle(
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: Icon(
                      Icons.warning_amber,
                      size: 40,
                    ),
                    title: Text(
                      'Horários Pendentes',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  );
                }

                return ListTile(
                  leading: const Icon(
                    Icons.delete,
                    size: 40,
                  ),
                  title: const Text(
                    'Apagar usuários',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "apagarUsuarios");
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
      body: FutureBuilder<List<Widget>>(
        future: _generateJournalCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar agendamentos'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView(
              controller: _listScrollController,
              children: snapshot.data!,
            );
          } else {
            return const Center(child: Text('Nenhum agendamento encontrado'));
          }
        },
      ),
    );
  }

  Future<List<Widget>> _generateJournalCards() async {
    return home_screen_list.generateListJournalCards(
      currentDay: currentDay,
      refreshFunction: refresh,
      buscaAgendamentos: _apiService.buscaAgendamentos,
    );
  }

  Future<void> refresh() async {
    try {
      List<Journal> listJournal = await _apiService.buscaAgendamentos();

      setState(() {
        database = {};

        for (Journal journal in listJournal) {
          database[journal.id] = journal;
        }

        currentDay = DateTime.now();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToCurrentDay();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar os agendamentos: $e')),
      );
    }
  }

  Future<bool> _hasPendingSchedules() async {
    List<Journal> listJournal = await _apiService.buscaAgendamentos();
    return listJournal.isNotEmpty;
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Nenhum agendamento disponível para remover.')));
      ;
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
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ids.map((id) {
                final journal = database[id];
                String formattedTime = '';
                String formattedDate = '';

                if (journal?.time != null) {
                  final timeOfDay = DateTime(
                    0,
                    1,
                    1,
                    journal!.time!.hour,
                    journal.time!.minute,
                  );

                  final dateFormat = DateFormat('HH:mm');
                  formattedTime = ' - ${dateFormat.format(timeOfDay)}';
                }

                if (journal?.createdAt != null) {
                  final dateFormat = DateFormat('dd/MM/yyyy');
                  formattedDate = dateFormat.format(journal!.createdAt);
                }
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        '${journal?.nomePaciente} -',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'dia: $formattedDate$formattedTime',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context, id);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedId != null) {
      final journal = database[selectedId];
      if (journal != null) {
        final formattedDateTime = journal.time != null
            ? DateFormat('yyyy-MM-ddTHH:mm:ss').format(
                DateTime(0, 1, 1, journal.time!.hour, journal.time!.minute),
              )
            : '';

        bool wasDeleted = await _apiService.apagarAgendamento(
            journal, formattedDateTime, context);

        if (wasDeleted) {
          setState(() {
            database.remove(selectedId);
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Agendamento removido com sucesso')),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erro ao remover agendamento')),
            );
          }
        }
      }
    }
  }
}
