import 'package:flutter/material.dart';
import 'package:clinica_fisioterapia/helpers/weekday.dart';
import 'package:clinica_fisioterapia/models/journal.dart';
import 'package:clinica_fisioterapia/services/journal_service.dart';
import 'package:intl/intl.dart'; // Importa a biblioteca para formatação de data

class AddJournalScreen extends StatefulWidget {
  final Journal journal;
  const AddJournalScreen({Key? key, required this.journal}) : super(key: key);

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  TextEditingController contentController = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Data selecionada

  @override
  void initState() {
    super.initState();
    contentController.text = widget.journal.content;
    selectedDate = widget.journal.createdAt.isBefore(DateTime(2000))
        ? DateTime.now()
        : widget.journal
            .createdAt; // Inicializa com a data do diário existente ou com a data atual
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WeekDay(widget.journal.createdAt).toString()),
        actions: [
          IconButton(
            onPressed: () {
              registerJournal(context);
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField deve ter um tamanho definido
            Expanded(
              child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontSize: 20),
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite o conteúdo do agendamento',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${DateFormat('dd').format(selectedDate)} de ${DateFormat('MMMM').format(selectedDate)}, ${DateFormat('yyyy').format(selectedDate)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                    width: 8), // Adiciona um espaço entre o texto e o botão
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
                    'Selecionar Data',
                    style: TextStyle(
                      color: Colors.white, // Define a cor do texto como branco
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerJournal(BuildContext context) async {
    JournalService journalService = JournalService();
    widget.journal.content = contentController.text;
    widget.journal.updatedAt = DateTime.now(); // Atualiza a data de atualização

    bool success = await journalService.register(widget.journal, context);
    Navigator.pop(
        context, success ? DisposeStatus.success : DisposeStatus.error);
  }
}

enum DisposeStatus { exit, error, success }
