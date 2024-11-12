import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/helpers/weekday.dart'; // Verifique se esse arquivo existe e está correto
import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart'; // Para formatação da hora

enum DisposeStatus { exit, error, success }

class JournalCard extends StatelessWidget {
  final Journal? journal;
  final DateTime showedDate;
  final Function refreshFunction;

  const JournalCard({
    Key? key,
    this.journal,
    required this.showedDate,
    required this.refreshFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPending = journal?.isPending ?? false;

    String formattedTime = '';
    if (journal?.time != null) {
      final timeOfDay = DateTime(
        0,
        1,
        1,
        journal!.time!.hour,
        journal!.time!.minute,
      );

      final dateFormat = DateFormat('HH:mm');
      formattedTime = ' - ${dateFormat.format(timeOfDay)}';
    }

    if (journal != null) {
      return InkWell(
        onTap: () {},
        child: Container(
          height: 115,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.lightBlue,
            ),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      border: Border(
                        right: BorderSide(color: Colors.lightBlue),
                        bottom: BorderSide(color: Colors.lightBlue),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      journal!.createdAt.day.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 38,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.lightBlue),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      WeekDay(journal!.createdAt).short,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        journal!.content + formattedTime,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      if (isPending) // Adiciona um indicador visual se estiver pendente
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.warning_amber,
                                  color: Colors.orange, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'Pendente aprovação',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          callAddJournalScreen(context);
        },
        child: Container(
          height: 115,
          alignment: Alignment.center,
          child: Text(
            "${WeekDay(showedDate).short} - ${showedDate.day}",
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Future<void> callAddJournalScreen(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      'add-journal',
      arguments: Journal(
        id: const Uuid().v1(),
        content: "",
        createdAt: showedDate,
        updatedAt: showedDate,
      ),
    );

    refreshFunction();

    if (result == DisposeStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("registarAgendamento salvo com sucesso."),
        ),
      );
    } else if (result == DisposeStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Houve uma falha ao registrar."),
        ),
      );
    }
  }
}
