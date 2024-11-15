import 'package:flutter/material.dart';
import '../../../models/journal.dart';
import 'package:clinica_fisioterapia/screens/home_screen/widgets/cardAgendamento.dart';

Future<List<CardAgendamento>> generateListJournalCards({
  required DateTime currentDay,
  required Function refreshFunction,
  required Future<List<Journal>> Function() buscaAgendamentos,
}) async {
  DateTime startOfMonth = DateTime(currentDay.year, currentDay.month, 1);
  DateTime endOfMonth = DateTime(currentDay.year, currentDay.month + 1, 0);

  int daysInMonth = endOfMonth.day;

  List<CardAgendamento> list = List.generate(
    daysInMonth,
    (index) => CardAgendamento(
      refreshFunction: refreshFunction,
      showedDate: DateTime(startOfMonth.year, startOfMonth.month, index + 1),
      nomePaciente: "",
      journals: [],
      emailMedico: '',
      emailPaciente: '',
    ),
  );

  try {
    List<Journal> agendamentos = await buscaAgendamentos();

    Map<int, List<Journal>> agendamentosPorDia = {};

    for (var agendamento in agendamentos) {
      int dia = agendamento.createdAt.day;
      if (agendamentosPorDia.containsKey(dia)) {
        agendamentosPorDia[dia]!.add(agendamento);
      } else {
        agendamentosPorDia[dia] = [agendamento];
      }
    }

    for (int i = 0; i < daysInMonth; i++) {
      DateTime diaAtual =
          DateTime(startOfMonth.year, startOfMonth.month, i + 1);
      if (agendamentosPorDia.containsKey(diaAtual.day)) {
        List<Journal> journals = agendamentosPorDia[diaAtual.day]!;
        list[i] = CardAgendamento(
          refreshFunction: refreshFunction,
          showedDate: diaAtual,
          nomePaciente: journals.isNotEmpty ? journals.first.nomePaciente : "",
          journals: journals,
          emailMedico: journals.isNotEmpty ? journals.first.emailMedico : '',
          emailPaciente:
              journals.isNotEmpty ? journals.first.emailPaciente : '',
        );
      }
    }
  } catch (e) {
    print('Erro ao buscar agendamentos: $e');
  }

  return list;
}
