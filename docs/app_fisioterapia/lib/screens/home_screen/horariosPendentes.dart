import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:clinica_fisioterapia/services/apiService.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Horários Pendentes',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
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

                final time = journal.time;
                final formattedTime = time != null
                    ? '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'
                    : 'Não definido';

                return ListTile(
                  title: Text(
                    '${journal.nomePaciente} - $formattedTime',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Solicitado: ${DateFormat('HH:mm:ss').format(DateTime.now())}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.check_box,
                          color: Colors.green,
                        ),
                        onPressed: () => {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () => {},
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
}
