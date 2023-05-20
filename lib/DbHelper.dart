import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'noteModel.dart';

class DbHelper {
  static Future<Database> openDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'notes.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, desc TEXT, date TEXT)');
        });
  }
  //INSERTING NOTES
  static Future<void> insertNote(Note note)async{
    final database=await openDb();
    await database.insert('note', {'title':note.title,'desc':note.desc,'date':note.date});
    print("inserted");
  }
  //INSERTING ALL NOTES
  static Future<void> insertAll(List<Map<String, dynamic>> notes)async{
    final db=await openDb();
    await db.transaction((txn) async {
      for (final Map<String, dynamic> data in notes) {
        await txn.insert('note', data);
      }
    });
  }
  //FETCHING ALL NOTES
  static Future<List<Map<String, dynamic>>> getAllRecords() async {
    final database = await openDb();
    final records = await database.query('note');
    await database.close();
    return records;
  }
  //DELETE NOTE
  static Future<void> deleteNote(int id)async{
    final db=await openDb();
    await db.delete('note',where: 'id=?',whereArgs: [id]);
  }
  //DELETE ALL NOTES
  static Future<void> deleteAllNote()async{
    final db=await openDb();
    await db.delete('note');
  }
}
