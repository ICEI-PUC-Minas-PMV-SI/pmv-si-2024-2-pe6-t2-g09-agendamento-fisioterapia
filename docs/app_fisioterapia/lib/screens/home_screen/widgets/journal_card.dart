import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/helpers/weekday.dart';
import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum DisposeStatus { exit, error, success }

class JournalCard extends StatelessWidget {
  final Journal? journal;
  final DateTime showedDate;
  final Function refreshFunction;
  final String nomePaciente;
  final String emailMedico;
  final String emailPaciente;

  const JournalCard({
    Key? key,
    this.journal,
    required this.showedDate,
    required this.refreshFunction,
    required this.nomePaciente,
    required this.emailMedico,
    required this.emailPaciente,
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
    } else {
      formattedTime = ' - Hora não definida';
    }

    String formatHoraAtendimento(DateTime data) {
      final DateFormat dateFormat = DateFormat('HH:mm');
      return dateFormat.format(data);
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
                  ),
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
                        journal!.nomePaciente,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        'Horário: ${formatHoraAtendimento(journal!.createdAt)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      if (isPending)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: const [
                              Icon(Icons.warning_amber,
                                  color: Colors.orange, size: 16),
                              Text(
                                'Pendente aprovação',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
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
          callAddJournalScreen(
            context,
            nomePaciente,
            emailMedico,
            emailPaciente,
            showedDate,
          );
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

  Future<void> callAddJournalScreen(
    BuildContext context,
    String nomePaciente,
    String emailMedico,
    String emailPaciente,
    DateTime showedDate,
  ) async {
    final result = await Navigator.pushNamed(
      context,
      'add-journal',
      arguments: Journal(
        id: const Uuid().v1(),
        createdAt: showedDate,
        updatedAt: showedDate,
        nomePaciente: nomePaciente,
        emailMedico: emailMedico,
        emailPaciente: emailPaciente,
      ),
    );

    refreshFunction();

    if (result == DisposeStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Agendamento salvo com sucesso."),
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
