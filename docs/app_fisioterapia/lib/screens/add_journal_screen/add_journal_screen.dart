import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:clinica_fisioterapia/services/apiService.dart';
import 'package:clinica_fisioterapia/screens/home_screen/horariosPendentes.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:intl/intl.dart'; // Importa a biblioteca intl

class AddJournalScreen extends StatefulWidget {
  final Journal journal;
  const AddJournalScreen({Key? key, required this.journal}) : super(key: key);

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  TextEditingController contentController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Time _time = Time(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  @override
  void initState() {
    super.initState();
    contentController.text = widget.journal.content;
    selectedDate = widget.journal.createdAt.isBefore(DateTime(2000))
        ? DateTime.now()
        : widget.journal.createdAt;
    _time = widget.journal.time ?? _time;
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
          "Solicitar agendamento",
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
                controller: contentController,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontSize: 20, color: Colors.blue),
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
                  hintText: 'Digite o conteúdo do agendamento',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Formata a data no formato português
  String _formatDateInPortuguese(DateTime date) {
    final formatter = DateFormat('d MMMM yyyy', 'pt_BR');
    return formatter.format(date);
  }

  Future<void> registerJournal(BuildContext context) async {
    ApiService apiService = ApiService();
    widget.journal.content = contentController.text;
    widget.journal.updatedAt = DateTime.now();
    widget.journal.time = _time; 

    bool success = await apiService.registarAgendamento(widget.journal, context);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PendingSchedulesScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao registrar o agendamento')),
      );
    }
  }
}
