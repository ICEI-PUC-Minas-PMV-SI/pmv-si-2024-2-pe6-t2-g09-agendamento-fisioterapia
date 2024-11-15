import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/helpers/weekday.dart';
import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum DisposeStatus { exit, error, success }

class CardAgendamento extends StatelessWidget {
  final List<Journal> journals;
  final DateTime showedDate;
  final Function refreshFunction;
  final String nomePaciente;
  final String emailMedico;
  final String emailPaciente;

  const CardAgendamento({
    Key? key,
    required this.journals,
    required this.showedDate,
    required this.refreshFunction,
    required this.nomePaciente,
    required this.emailMedico,
    required this.emailPaciente,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (journals.isNotEmpty) {
      return InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('d').format(showedDate),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('MMMM', 'pt_BR').format(showedDate),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                    child: Text(
                      WeekDay(showedDate).short,
                      style: const TextStyle(
                        fontSize: 15,
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
                    children: journals.map((journal) {
                      final formattedTime = (journal.createdAt != null)
                          ? DateFormat('HH:mm').format(
                              DateTime(
                                0,
                                1,
                                1,
                                journal.time?.hour ?? journal.createdAt.hour,
                                journal.time?.minute ??
                                    journal.createdAt.minute,
                              ),
                            )
                          : 'Horário não disponível';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            journal.nomePaciente,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            'Horário: $formattedTime',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    }).toList(),
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
      'adicionarAgendamento',
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
