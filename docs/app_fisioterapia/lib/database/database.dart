import 'dart:math';
import 'package:uuid/uuid.dart';
import '../models/journal.dart';
import 'package:clinica_fisioterapia/helpers/phrases.dart';

Map<String, Journal> generateRandomDatabase({
  required int maxGap, // Tamanho máximo da janela de tempo
  required int amount, // Entradas geradas
}) {
  Random rng = Random();
  var uuid = const Uuid(); // Inicializa o UUID
  Map<String, Journal> map = {};

  for (int i = 0; i < amount; i++) {
    int timeGap = rng.nextInt(maxGap); // Define uma distância do hoje
    DateTime date = DateTime.now().subtract(
      Duration(days: timeGap),
    ); // Gera um dia

    String id = uuid.v1(); // Gera um UUID versão 1

    map[id] = Journal(
      id: id,
      content: getRandomPhrase(),
      createdAt: date,
      updatedAt: date,
    );
  }
  return map;
}
