import 'package:uuid/uuid.dart';

class Journal {
  String id;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  String status; // Novo campo para status

  // Construtor padrão
  Journal({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.status = 'pendente', // Valor padrão para status
  });

  // Construtor vazio para novos objetos
  Journal.empty()
      : id = const Uuid().v1(),
        content = "",
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        status = 'pendente'; // Valor padrão para status

  // Construtor para criar um objeto a partir de um mapa
  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      status:
          map['status'] ?? 'pendente', // Valor padrão se não estiver presente
    );
  }

  get selectedDate => null;

  @override
  String toString() {
    return "$content \ncreated_at: $createdAt\nupdated_at:$updatedAt\nstatus: $status";
  }

  // Converte o objeto para um mapa para serialização JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status, // Inclui o status no mapa
    };
  }
}
