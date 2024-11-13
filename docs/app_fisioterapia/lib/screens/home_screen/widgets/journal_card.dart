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
                      // Exibe o conteúdo do agendamento e hora
                      Text(
                        journal!.nomePaciente + formattedTime,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      // Exibe a indicação de pendente, se aplicável
                      if (isPending)
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
      // Caso não haja agendamento, exibe um card vazio com a data
      return InkWell(
        onTap: () {
          // Passando o nome do paciente ao chamar a função
          callAddJournalScreen(
            context,
            nomePaciente,
            emailMedico,
            emailPaciente,
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

  // Corrigindo a função para passar o nome do paciente para a tela add-journal
  Future<void> callAddJournalScreen(BuildContext context, String nomePaciente,
      String emailMedico, String emailPaciente) async {
    DateTime showedDate = DateTime.now(); // Data para o agendamento

    final result = await Navigator.pushNamed(
      context,
      'add-journal',
      arguments: Journal(
        id: const Uuid().v1(),
        createdAt: showedDate,
        updatedAt: showedDate,
        nomePaciente: nomePaciente, emailMedico: emailMedico,
        emailPaciente: emailPaciente, // Nome do paciente
      ),
    );

    // Chamando a função de atualização depois que o resultado for retornado
    refreshFunction();

    // Verificando o resultado da navegação e exibindo o snack bar adequado
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
