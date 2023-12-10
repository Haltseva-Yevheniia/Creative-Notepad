import 'package:creative_notepad/components/note_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final noteTextController = TextEditingController();
  final deadlineController = TextEditingController();

  List<String> notes = [];
  List<String> deadlines = [];
  List<NoteModel> notesToScreen = [];

   void _addNote() {
    setState(() {
       String addNoteText = noteTextController.text;
       String addDeadlinesText = deadlineController.text;

       if (addNoteText.isNotEmpty){

         notes.add(addNoteText);
         noteTextController.clear();
       }
       deadlines.add(addDeadlinesText);
       deadlineController.clear();
      });
      saveNotes();
      saveDeadlines();
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notes', notes);
  }

  Future<void> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notes = prefs.getStringList('notes') ??
          []; // Читаєм список по ключу і відразу записуєм значення з локальної бази в нашу зміну
    });
  }

  void saveDeadlines() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('deadlines', deadlines);
  }

  void getDeadLines() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deadlines = prefs.getStringList('deadlines') ?? [];
    });
  }

  void _showDialogForAddNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: SizedBox(
            width: 300,
            height: 130,
            child: ListView(
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  controller: noteTextController,
                  decoration: const InputDecoration(labelText: 'Note Text'),
                ),
                TextField(
                  //keyboardType: TextInputType.datetime,
                  controller: deadlineController,
                  decoration:
                      const InputDecoration(labelText: 'Calendar for deadline'),
                  onTap: selectDate,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addNote();
                Navigator.pop(context);
              },
              child: const Text('add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes();
    getDeadLines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          'Notepad',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
          ),
        ),
        actions: const [
          Icon(Icons.event_note_outlined, size: 30.0),
          Icon(Icons.note_alt_sharp, size: 30.0),
        ],
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text(
                'Ваш нотаток пустий, додайте замітку',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
           itemCount: notes.length,
           itemBuilder: (context, index){
             return ListTile(
                leading: const Icon(Icons.star_purple500),
                title: Text(notes[index]),
                subtitle: Text(deadlines[index]),
                trailing: IconButton(onPressed: (){
                  setState(() {
                    notes.removeAt(index);
                    deadlines.removeAt(index);
                  });
               },
                    icon: const Icon(Icons.delete_forever)),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogForAddNote,
        child: const Icon(Icons.edit_note),
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
       deadlineController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }
}
