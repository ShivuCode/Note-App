import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:try_new/noteModel.dart';
import 'package:try_new/noteTile.dart';
import 'DbHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> notes = [];

  List colors = [
    Colors.purpleAccent.shade100,
    Colors.blueGrey.shade200,
    Colors.redAccent.shade100,
    Colors.greenAccent.shade100,
    Colors.deepPurpleAccent.shade100,
    Colors.orange.shade100,
    Colors.pinkAccent.shade100,
    Colors.blue.shade100,
    Colors.yellowAccent.shade100,
    Colors.teal.shade200

  ];

  void fetchData() async {
    final data = await DbHelper.getAllRecords();
    setState(() {
      notes = data;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Notes",
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              var note=notes;
              DbHelper.deleteAllNote();
              fetchData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('All Deleted'),action: SnackBarAction(label: 'Undo',onPressed: (){
                  DbHelper.insertAll(note);
                  fetchData();
                },),),
              );
            },
            child: Text("Delete All".toUpperCase(),style: const TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400))
          )
        ],
      ),
      body: notes.isEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: MasonryGridView.builder(
                  itemCount: notes.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  itemBuilder: (_, i) {
                    int j = 0 + Random().nextInt(colors.length - 1 + 1);
                    var note=notes[i];
                    String item = notes[i]['id'].toString();
                    return Dismissible(
                      key: Key(item),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        DbHelper.deleteNote(int.parse(item));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text('Deleted'),action: SnackBarAction(label: 'Undo',onPressed: (){
                            DbHelper.insertNote(Note(title: note["title"], desc: note["desc"], date: note["date"]));
                            fetchData();
                          },),),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colors[j]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notes[i]['title'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1)),
                            const SizedBox(height: 10),
                            Text(notes[i]['desc'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.8)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  notes[i]["date"],
                                  softWrap: true,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          // DbHelper.insertNote(Note(title: "Yoy", desc: "This is message jhg hkg  j jhg  jhhg jk j  kgg hkg khhg  gh hg  gf hhfjf f j  g ", date: "12/08/2003"));
          // fetchData();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => NoteTile()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
