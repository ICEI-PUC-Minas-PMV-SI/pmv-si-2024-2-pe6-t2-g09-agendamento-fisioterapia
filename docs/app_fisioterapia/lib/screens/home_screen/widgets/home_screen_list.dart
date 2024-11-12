import '../../../models/journal.dart';
import 'package:clinica_fisioterapia/screens/home_screen/widgets/journal_card.dart';

List<JournalCard> generateListJournalCards({
  required DateTime currentDay,
  required Map<String, Journal> database,
  required Function refreshFunction,
}) {
  // Determina o primeiro e o último dia do mês atual
  DateTime startOfMonth = DateTime(currentDay.year, currentDay.month, 1);
  DateTime endOfMonth = DateTime(currentDay.year, currentDay.month + 1, 0);

  // Calcula o número de dias no mês
  int daysInMonth = endOfMonth.day;

  // Cria uma lista de JournalCards para todos os dias do mês
  List<JournalCard> list = List.generate(
    daysInMonth,
    (index) => JournalCard(
      refreshFunction: refreshFunction,
      showedDate: DateTime(startOfMonth.year, startOfMonth.month, index + 1),
      journal: null, // Inicialmente nenhum journal
    ),
  );

  // Preenche os espaços com entradas existentes no banco de dados
  database.forEach(
    (key, value) {
      // Verifica se o journal pertence ao mês atual
      if (value.createdAt.month == currentDay.month &&
          value.createdAt.year == currentDay.year) {
        int dayOfMonth =
            value.createdAt.day - 1; // Ajusta o índice, pois o dia começa de 1

        // Verifica se o dia existe na lista
        if (dayOfMonth >= 0 && dayOfMonth < list.length) {
          // Atualiza o JournalCard correspondente no índice
          list[dayOfMonth] = JournalCard(
            showedDate: list[dayOfMonth].showedDate, // Preserva a data mostrada
            journal: value, // Passa o agendamento recuperado do banco de dados
            refreshFunction: refreshFunction,
          );
        }
      }
    },
  );

  return list;
}
