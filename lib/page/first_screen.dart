import 'package:creative_notepad/components/note_model.dart';
import 'package:flutter/material.dart';
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
       notes.add(addNoteText);
       deadlines.add(addDeadlinesText);
       noteTextController.clear();
       deadlineController.clear();
      });
  }

  void saveNotes() async {
final SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setStringList('notes', notes);
  }

  void getNotes () async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getStringList('notes');
}


  void getDeadLines () async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getStringList('deadlines');
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
            child: ListView (
              children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: noteTextController,
                decoration: const InputDecoration(
                    labelText: 'Note Text'),
              ),
              TextField(
                keyboardType: TextInputType.datetime,
                controller: deadlineController,
                decoration: const InputDecoration(
                    labelText: 'Calendar for deadline'
                ),
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

      body: notes.isEmpty ? const Center(
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
                title: Text(notes[index]),
                subtitle: Text(deadlines[index]),
                trailing: IconButton(onPressed: (){
              //TODO Vitalik Logic for delete this note

                },
                    icon: const Icon(Icons.delete_forever)),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed:  _showDialogForAddNote,
          child: const Icon(Icons.edit_note),

        // TODO TextField with Calendar for deadline

      ),
    );
  }
}
