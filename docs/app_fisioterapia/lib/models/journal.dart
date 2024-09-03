import 'package:uuid/uuid.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart'; // Verifique se a importação está correta

class Journal {
  String id;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  Time? time;

  // Construtor padrão
  Journal({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.status = 'pendente',
    this.time,
  });

  // Construtor vazio para novos objetos
  Journal.empty()
      : id = const Uuid().v1(),
        content = "",
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        status = 'pendente',
        time = null;

  // Construtor para criar um objeto a partir de um mapa
  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'] ??
          const Uuid().v1(), // Valor padrão para id, se não estiver presente
      content: map['content'] ?? '',
      createdAt: DateTime.parse(map['created_at'] ??
          DateTime.now().toIso8601String()), // Valor padrão para createdAt
      updatedAt: DateTime.parse(map['updated_at'] ??
          DateTime.now().toIso8601String()), // Valor padrão para updatedAt
      status: map['status'] ?? 'pendente', // Valor padrão para status
      time: map['time'] != null
          ? Time(
              hour: map['time']['hour'] ?? 0,
              minute: map['time']['minute'] ?? 0,
            )
          : null, // Se o horário não estiver presente, define como nulo
    );
  }

  @override
  String toString() {
    return "$content \ncreated_at: $createdAt\nupdated_at:$updatedAt\nstatus: $status\nTime: ${time?.hour ?? 'Não definido'}:${time?.minute.toString().padLeft(2, '0') ?? '00'}";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status,
      'time': time != null
          ? {
              'hour': time!.hour,
              'minute': time!.minute,
            }
          : null, // Adiciona o horário ao mapa, se disponível
    };
  }

  bool get isPending => status == 'pendente';
}
