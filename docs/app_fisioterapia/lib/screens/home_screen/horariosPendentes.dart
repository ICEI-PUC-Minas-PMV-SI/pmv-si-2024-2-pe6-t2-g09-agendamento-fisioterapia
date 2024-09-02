import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/services/journal_service.dart';
import 'package:clinica_fisioterapia/models/journal.dart';

class PendingSchedulesScreen extends StatefulWidget {
  const PendingSchedulesScreen({Key? key}) : super(key: key);

  @override
  _PendingSchedulesScreenState createState() => _PendingSchedulesScreenState();
}

class _PendingSchedulesScreenState extends State<PendingSchedulesScreen> {
  late Future<List<Journal>> _pendingSchedules;

  @override
  void initState() {
    super.initState();
    _pendingSchedules = JournalService().getPendingSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horários Pendentes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "home");
          },
        ),
      ),
      body: FutureBuilder<List<Journal>>(
        future: _pendingSchedules,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Erro ao carregar os horários pendentes.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum horário pendente.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Journal journal = snapshot.data![index];
                return ListTile(
                  title: Text(journal.content),
                  subtitle: Text(
                    'Solicitado: ${journal.updatedAt}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.check_box,
                          color: Colors.green,
                        ),
                        onPressed: () => _acceptSchedule(journal),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () => _rejectSchedule(journal),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _acceptSchedule(Journal journal) async {
    bool success = await JournalService().acceptSchedule(journal);
    if (success) {
      setState(() {
        _pendingSchedules = JournalService().getPendingSchedules();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Horário aceito com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao aceitar o horário.')),
      );
    }
  }

  Future<void> _rejectSchedule(Journal journal) async {
    bool success = await JournalService().rejectSchedule(journal);
    if (success) {
      setState(() {
        // Atualiza a lista de horários pendentes após a rejeição
        _pendingSchedules = JournalService().getPendingSchedules();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Horário recusado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao recusar o horário.')),
      );
    }
  }
}
