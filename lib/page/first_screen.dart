
import 'package:creative_notepad/components/note_model.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  TextEditingController noteTextController = TextEditingController();
  List<NoteModel> notes = [];



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
             return const ListTile(

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
