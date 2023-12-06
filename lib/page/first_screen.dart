
import 'package:creative_notepad/components/note_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  TextEditingController noteTextController = TextEditingController();
  List<String> notes = ['buy', 'prise'];
  List<String> deadlines=['02/01/2024', '20/12/2023'];
  List<NoteModel> notesToScreen = [];

  void saveNotes() async {
final SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setStringList('notes', notes);
  }

void getNotes () async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getStringList('notes');
}

  void saveDeadlines() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('deadlines', deadlines);
  }

  void getDeadLines () async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getStringList('deadlines');
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

            //TODO Oleg change icons to notes or notepad or paper
            Icon(Icons.ac_unit, size: 30.0),
            Icon(Icons.account_balance_sharp, size: 30.0),
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
  //TODO ??? Logic for delete this note

}, icon: const Icon(Icons.delete_forever)),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
       // TODO Oleg Add icon to this button

        // TODO Vitalik function showDialog... with AlertDialog with TextField for noteText and TextField with Calendar for deadline


      }),
    );
  }
}
