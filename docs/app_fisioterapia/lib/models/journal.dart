import 'package:uuid/uuid.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class Journal {
  String id;
  String nomePaciente;
  String emailPaciente;
  String emailMedico;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  Time? time;

  Journal({
    required this.id,
    required this.nomePaciente,
    required this.emailPaciente,
    required this.emailMedico,
    required this.createdAt,
    required this.updatedAt,
    this.status = 'pendente',
    this.time,
  });

  // Construtor vazio para criar instâncias "em branco"
  Journal.empty()
      : id = const Uuid().v1(),
        nomePaciente = "",
        emailPaciente = "",
        emailMedico = "",
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        status = 'pendente',
        time = null;

  // Método de fábrica para criar o objeto a partir de um mapa JSON
  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id']?.toString() ?? '',
      nomePaciente: map['nomePaciente'] ?? '',
      emailPaciente: map['emailPaciente'] ?? '',
      emailMedico: map['emailMedico'] ?? '',
      createdAt: map['dataAtendimento'] != null
          ? DateTime.parse(map['dataAtendimento'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
      status: map['status'] ?? 'pendente',
      time: map['time'] != null
          ? Time(
              hour: map['time']['hour'] ?? 0,
              minute: map['time']['minute'] ?? 0,
            )
          : null,
    );
  }

  @override
  String toString() {
    return "$nomePaciente\n"
        "Created at: $createdAt\n"
        "Updated at: $updatedAt\n"
        "Status: $status\n"
        "Time: ${time?.hour ?? 'Não definido'}:${time?.minute.toString().padLeft(2, '0') ?? '00'}";
  }

  // Método para converter o objeto de volta para um mapa, para salvar ou enviar à API
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomePaciente': nomePaciente,
      'emailPaciente': emailPaciente,
      'emailMedico': emailMedico,
      'dataAtendimento': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'time': time != null
          ? {
              'hour': time!.hour,
              'minute': time!.minute,
            }
          : null,
    };
  }

  // Retorna um valor booleano para verificar se o status é 'pendente'
  bool get isPending => status == 'pendente';
}
