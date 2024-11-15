import 'package:intl/intl.dart';
import '../../../models/journal.dart';
import 'package:clinica_fisioterapia/screens/home_screen/widgets/card_agendamento.dart';

Future<List<CardAgendamento>> generateListJournalCards({
  required DateTime currentDay,
  required Function refreshFunction,
  required String formattedMonth,
  required Future<List<Journal>> Function() buscaAgendamentos,
}) async {
  DateTime startOfDay = DateTime(currentDay.year, currentDay.month, 1);
  DateTime endOfDay = DateTime(currentDay.year, currentDay.month + 1, 0);

  List<Journal> agendamentos = await buscaAgendamentos();

  List<Journal> agendamentosDoMes = agendamentos.where((journal) {
    return journal.createdAt
            .isAfter(startOfDay.subtract(const Duration(days: 1))) &&
        journal.createdAt.isBefore(endOfDay.add(const Duration(days: 1)));
  }).toList();

  List<CardAgendamento> journalCards = [];

  for (int i = currentDay.day - 1; i < endOfDay.day; i++) {
    DateTime diaAtual = startOfDay.add(Duration(days: i));

    if (diaAtual.isBefore(currentDay)) {
      continue;
    }

    List<Journal> journalsDoDia = agendamentosDoMes.where((journal) {
      return journal.createdAt.day == diaAtual.day;
    }).toList();

    journalCards.add(CardAgendamento(
      refreshFunction: refreshFunction,
      showedDate: diaAtual,
      nomePaciente:
          journalsDoDia.isNotEmpty ? journalsDoDia.first.nomePaciente! : '',
      journals: journalsDoDia,
      emailMedico:
          journalsDoDia.isNotEmpty ? journalsDoDia.first.emailMedico! : '',
      emailPaciente:
          journalsDoDia.isNotEmpty ? journalsDoDia.first.emailPaciente! : '',
    ));
  }

  return journalCards;
}
