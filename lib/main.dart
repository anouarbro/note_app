import 'package:flutter/material.dart';

// Dans le code ci-dessus, nous avons créé une application simple de prise de notes qui permet aux utilisateurs d'ajouter, de modifier et de supprimer des notes.
// L'application se compose de deux écrans :  NoteList et NoteEditor .
// L'écran NoteList affiche une liste de notes avec leur titre.
// Les utilisateurs peuvent appuyer sur une note pour en modifier le contenu.
// L'écran NoteEditor permet aux utilisateurs de modifier le contenu d'une note.
// L'écran NoteList utilise un constructeur ListView pour afficher la liste des notes. Chaque note est affichée sous la forme d'un ListTile avec un titre et un bouton de suppression.
// En tapant sur une note, l'écran NoteEditor s'ouvre et permet aux utilisateurs de modifier le contenu de la note.
// L'écran NoteEditor contient un widget TextField qui permet aux utilisateurs de modifier le contenu de la note.
// L'écran comporte également une barre d'application avec un bouton d'enregistrement qui enregistre le contenu modifié et fait apparaître l'écran.

void main() {
  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: 'Note App',
      home: NoteList(),
    );
  }
}

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  // A list to store notes
  List<String> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          String note = notes[index];
          return ListTile(
            title: Text(note),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  notes.removeAt(index);
                });
              },
            ),
            onTap: () async {
              String? updatedContent = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteEditor(content: notes[index]),
                ),
              );
              if (updatedContent != null) {
                setState(() {
                  notes[index] = updatedContent;
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          String? newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditor(content: ''),
            ),
          );
          if (newNote != null) {
            setState(() {
              notes.add(newNote);
            });
          }
        },
      ),
    );
  }
}

class NoteEditor extends StatelessWidget {
  final String content;

  NoteEditor({required this.content});

  @override
  Widget build(BuildContext context) {
    TextEditingController _contentController =
        TextEditingController(text: content);

    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la note'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context, _contentController.text);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _contentController,
          decoration: InputDecoration(
            hintText: 'Saisissez le contenu de votre note ici',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
