import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clinica_fisioterapia/services/api_service.dart';

class EditJournalScreen extends StatefulWidget {
  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  ApiService apiService = ApiService();
  late Future<List<Journal>> _journalsFuture;

  @override
  void initState() {
    super.initState();
    _journalsFuture = apiService.buscaAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Agendamentos',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<Journal>>(
        future: _journalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar agendamentos.'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhum agendamento encontrado.'),
            );
          } else {
            final journals = snapshot.data!;
            return ListView.builder(
              itemCount: journals.length,
              itemBuilder: (context, index) {
                final journal = journals[index];
                return ListTile(
                  title: Text(
                    journal.nomePaciente!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    'Data: ${DateFormat('dd/MM/yyyy').format(journal.createdAt)}\n',
                  ),
                  onTap: () => _editarAgendamento(journal),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _editarAgendamento(Journal journal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgendamentoFormScreen(journal: journal),
      ),
    );
  }
}

String _formatDateTimeForApi(DateTime date, TimeOfDay time) {
  final formattedDate = DateFormat('dd-MM-yyyy').format(date);
  final formattedTime =
      '${time.hour.toString().padLeft(2, '0')}-${time.minute.toString().padLeft(2, '0')}';
  return '$formattedDate-$formattedTime';
}

class AgendamentoFormScreen extends StatefulWidget {
  final Journal journal;

  AgendamentoFormScreen({Key? key, required this.journal}) : super(key: key);

  @override
  State<AgendamentoFormScreen> createState() => _AgendamentoFormScreenState();
}

class _AgendamentoFormScreenState extends State<AgendamentoFormScreen> {
  late TextEditingController _nomePacienteController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _nomePacienteController =
        TextEditingController(text: widget.journal.nomePaciente);
    _selectedDate = widget.journal.createdAt;
    _selectedTime = widget.journal.time != null
        ? TimeOfDay(
            hour: widget.journal.time!.hour,
            minute: widget.journal.time!.minute)
        : const TimeOfDay(hour: 9, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Agendamento',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Nome do Paciente: ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  widget.journal.nomePaciente!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Data'),
              subtitle: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
              onTap: _pickDate,
            ),
            ListTile(
              title: const Text('Horário'),
              subtitle: Text(_selectedTime.format(context)),
              onTap: _pickTime,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarEdicao,
              child: const Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _salvarEdicao() async {
    widget.journal.nomePaciente = _nomePacienteController.text;
    widget.journal.updatedAt = DateTime.now();
    widget.journal.createdAt = _selectedDate;

    final formattedDateTime =
        _formatDateTimeForApi(_selectedDate, _selectedTime);
    print(formattedDateTime);

    final success = await apiService.editarDataAgendamento(
        widget.journal, formattedDateTime, context);

    if (success) {
      Navigator.pop(context, widget.journal);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao atualizar o agendamento."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
