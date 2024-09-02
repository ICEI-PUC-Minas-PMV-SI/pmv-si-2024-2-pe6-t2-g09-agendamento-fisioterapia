import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/helpers/weekday.dart'; // Verifique se esse arquivo existe e está correto
import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:clinica_fisioterapia/screens/add_journal_screen/add_journal_screen.dart';
import 'package:uuid/uuid.dart';

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
    if (journal != null) {
      return InkWell(
        onTap: () {},
        child: Container(
          height: 115,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
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
                    child: Text(WeekDay(journal!.createdAt).short),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    journal!.content,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
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
          content: Text("Registro salvo com sucesso."),
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
