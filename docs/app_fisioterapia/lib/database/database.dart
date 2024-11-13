import 'dart:math';
import 'package:uuid/uuid.dart';
import '../models/journal.dart';
import 'package:clinica_fisioterapia/helpers/phrases.dart';

Map<String, Journal> generateRandomDatabase({
  required int maxGap,
  required int amount,
}) {
  Random rng = Random();
  var uuid = const Uuid();
  Map<String, Journal> map = {};

  for (int i = 0; i < amount; i++) {
    int timeGap = rng.nextInt(maxGap);
    DateTime date = DateTime.now().subtract(
      Duration(days: timeGap),
    );

    String id = uuid.v1();

    map[id] = Journal(
      id: id,
      createdAt: date,
      updatedAt: date,
      nomePaciente: '',
      emailMedico: '',
      emailPaciente: '',
    );
  }
  return map;
}
