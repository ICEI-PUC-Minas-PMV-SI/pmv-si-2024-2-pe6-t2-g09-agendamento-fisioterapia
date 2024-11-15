import 'package:intl/intl.dart';
import '../../../models/journal.dart';
import 'package:clinica_fisioterapia/screens/home_screen/widgets/cardAgendamento.dart';

Future<List<CardAgendamento>> generateListJournalCards({
  required DateTime currentDay,
  required Function refreshFunction,
  required Future<List<Journal>> Function() buscaAgendamentos,
}) async {
  DateTime startOfDay =
      DateTime(currentDay.year, currentDay.month, currentDay.day);
  DateTime nextMonth = DateTime(currentDay.year, currentDay.month + 1, 1);
  DateTime endOfNextMonth = DateTime(nextMonth.year, nextMonth.month + 1, 0);
  int totalDays = endOfNextMonth.difference(startOfDay).inDays + 1;

  List<CardAgendamento> list = List.generate(totalDays, (index) {
    DateTime date = startOfDay.add(Duration(days: index));

    String formattedDate =
        DateFormat('d MMMM').format(date); // Ex: "15 Novembro"
    String formattedDay = DateFormat('d').format(date); // Ex: "15"
    String formattedMonth = DateFormat('MMMM').format(date); // Ex: "Novembro"

    return CardAgendamento(
      refreshFunction: refreshFunction,
      showedDate: date,
      nomePaciente: "",
      journals: [],
      emailMedico: '',
      emailPaciente: '',
    );
  });

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

    for (int i = 0; i < totalDays; i++) {
      DateTime diaAtual = startOfDay.add(Duration(days: i));
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

  List<CardAgendamento> finalList = [];

  List<CardAgendamento> currentMonthList = list.where((item) {
    return item.showedDate.month == currentDay.month;
  }).toList();

  List<CardAgendamento> nextMonthList = list.where((item) {
    return item.showedDate.month == currentDay.month + 1;
  }).toList();

  finalList.addAll(currentMonthList);

  if (nextMonthList.isNotEmpty && nextMonthList.first.showedDate.day != 1) {
    finalList.add(CardAgendamento(
      refreshFunction: refreshFunction,
      showedDate: DateTime(currentDay.year, currentDay.month + 1, 1),
      nomePaciente:
          "Agendamentos de ${DateFormat('MMMM yyyy').format(nextMonth)}",
      journals: [],
      emailMedico: '',
      emailPaciente: '',
    ));
  }

  finalList.addAll(nextMonthList.where((item) {
    return !finalList.any((finalItem) =>
        finalItem.showedDate.day == item.showedDate.day &&
        finalItem.showedDate.month == item.showedDate.month);
  }));

  return finalList;
}
