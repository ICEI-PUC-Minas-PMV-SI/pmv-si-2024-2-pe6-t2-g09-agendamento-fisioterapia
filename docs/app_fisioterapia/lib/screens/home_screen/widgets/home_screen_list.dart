import 'package:flutter/material.dart';
import '../../../models/journal.dart';
import 'package:clinica_fisioterapia/screens/home_screen/widgets/journal_card.dart';

Future<List<JournalCard>> generateListJournalCards({
  required DateTime currentDay,
  required Function refreshFunction,
  required Future<List<Journal>> Function() buscaAgendamentos,
}) async {
  DateTime startOfMonth = DateTime(currentDay.year, currentDay.month, 1);
  DateTime endOfMonth = DateTime(currentDay.year, currentDay.month + 1, 0);

  int daysInMonth = endOfMonth.day;

  List<JournalCard> list = List.generate(
    daysInMonth,
    (index) => JournalCard(
      refreshFunction: refreshFunction,
      showedDate: DateTime(startOfMonth.year, startOfMonth.month, index + 1),
      nomePaciente: "",
      journal: null,
    ),
  );

  try {
    List<Journal> agendamentos = await buscaAgendamentos();

    Map<int, Journal> agendamentosPorDia = {
      for (var agendamento in agendamentos)
        agendamento.createdAt.day: agendamento,
    };

    for (int i = 0; i < daysInMonth; i++) {
      DateTime diaAtual =
          DateTime(startOfMonth.year, startOfMonth.month, i + 1);
      if (agendamentosPorDia.containsKey(diaAtual.day)) {
        Journal journal = agendamentosPorDia[diaAtual.day]!;
        list[i] = JournalCard(
          refreshFunction: refreshFunction,
          showedDate: diaAtual,
          nomePaciente: journal.nomePaciente,
          journal: journal,
        );
      }
    }
  } catch (e) {
    print('Erro ao buscar agendamentos: $e');
  }

  return list;
}
