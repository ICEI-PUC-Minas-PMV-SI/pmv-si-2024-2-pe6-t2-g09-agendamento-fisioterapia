import 'dart:math';

/// Cria uma frase aleatória
String getRandomPhrase() {
  List<String> phrases = [
    "Hoje estou feliz pois fez Sol",
    "Não estou tão bem, choveu",
  ];

  Random rng = Random();
  return phrases[rng.nextInt(phrases.length - 1)];
}
