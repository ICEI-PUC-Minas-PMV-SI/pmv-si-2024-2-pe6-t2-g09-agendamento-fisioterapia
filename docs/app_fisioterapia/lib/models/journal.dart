import 'package:uuid/uuid.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class Journal {
  String id;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  Time? time;

  // Construtor principal
  Journal({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.status = 'pendente',
    this.time,
  });

  // Construtor para um Journal vazio
  Journal.empty()
      : id = const Uuid().v1(),
        content = "",
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        status = 'pendente',
        time = null;

  // Construtor de fábrica para criar um Journal a partir de um mapa (geralmente usado para ler dados de uma API ou banco de dados)
  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id']?.toString() ?? '',
      content: map['nomePaciente'] ??
          '', // Agora 'content' recebe o nome do paciente
      createdAt: DateTime.parse(
          map['dataAtendimento'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.now(),
      status: map['status'] ?? 'pendente',
      time: map['time'] != null
          ? Time(
              hour: map['time']['hour'] ?? 0,
              minute: map['time']['minute'] ?? 0,
            )
          : null,
    );
  }

  // Método para converter o Journal de volta para um mapa
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
          : null,
    };
  }

  // Método toString para exibir o conteúdo do Journal de forma legível
  @override
  String toString() {
    return "$content \ncreated_at: $createdAt\nupdated_at:$updatedAt\nstatus: $status\nTime: ${time?.hour ?? 'Não definido'}:${time?.minute.toString().padLeft(2, '0') ?? '00'}";
  }

  // Método para verificar se o status é 'pendente'
  bool get isPending => status == 'pendente';

  // Formatar a data e hora para exibição (por exemplo, para exibir no UI)
  String formattedDate() {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  String formattedTime() {
    return '${time?.hour ?? 0}:${time?.minute?.toString().padLeft(2, '0') ?? '00'}';
  }
}
