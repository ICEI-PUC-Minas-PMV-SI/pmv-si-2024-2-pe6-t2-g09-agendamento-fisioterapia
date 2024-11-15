import 'package:clinica_fisioterapia/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:clinica_fisioterapia/services/apiService.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:intl/intl.dart';

class AdicionarAgendamento extends StatefulWidget {
  final Journal journal;
  const AdicionarAgendamento({Key? key, required this.journal})
      : super(key: key);

  @override
  State<AdicionarAgendamento> createState() => _AdicionarAgendamentoState();
}

class _AdicionarAgendamentoState extends State<AdicionarAgendamento> {
  TextEditingController nomePacienteController = TextEditingController();
  TextEditingController emailPacienteController = TextEditingController();
  TextEditingController emailMedicoController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Time _time = Time(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  @override
  void initState() {
    super.initState();
    nomePacienteController.text = widget.journal.nomePaciente;
    selectedDate = widget.journal.createdAt.isBefore(DateTime(2000))
        ? DateTime.now()
        : widget.journal.createdAt;
    _time = widget.journal.time ?? _time;
  }

  String _formatDateTimeForApi(DateTime date, Time time) {
    final formattedDate = DateFormat('dd-MM-yyyy').format(date);
    final formattedTime =
        '${time.hour.toString().padLeft(2, '0')}-${time.minute.toString().padLeft(2, '0')}';
    return '$formattedDate-$formattedTime';
  }

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Adicionar agendamento",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              registerJournal(context);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatDateInPortuguese(selectedDate),
                      style: const TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                          widget.journal.createdAt = selectedDate;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Alterar Data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Horário: ',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          TextSpan(
                            text:
                                '${_time.hour}:${_time.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: _time,
                          onChange: onTimeChanged,
                          sunrise: Time(hour: 6, minute: 0),
                          sunset: Time(hour: 18, minute: 0),
                          duskSpanInMinutes: 120,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Escolha o horário",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nomePacienteController,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontSize: 20),
                maxLines: null,
                minLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  hintText: 'Digite o nome do paciente',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailPacienteController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  hintText: 'Digite o email do paciente',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailMedicoController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  hintText: 'Digite o email do médico responsável',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateInPortuguese(DateTime date) {
    final formatter = DateFormat('d MMMM yyyy', 'pt_BR');
    return formatter.format(date);
  }

  Future<void> registerJournal(BuildContext context) async {
    ApiService apiService = ApiService();
    widget.journal.nomePaciente = nomePacienteController.text;
    widget.journal.emailPaciente = emailPacienteController.text;
    widget.journal.emailMedico = emailMedicoController.text;
    widget.journal.updatedAt = DateTime.now();
    widget.journal.time = _time;
    widget.journal.createdAt = selectedDate;

    if (selectedDate
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Não é permitido agendar para dias anteriores ao dia atual.')),
      );
      return;
    }

    String formattedDateTime = _formatDateTimeForApi(selectedDate, _time);

    bool success = await apiService.registrarAgendamento(
        widget.journal, formattedDateTime, context);

    if (success) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao registrar o agendamento')),
        );
      }
    }
  }
}
