import 'dart:io';
import 'dart:ui';
import 'package:money_handler/expanse_modal/budgetmodal.dart';
import 'package:money_handler/expanse_modal/modal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  Database? db;
  final String database_name = "expanse.db";
  String datatable_name = "expansetable";
  String budgettable_name = "budgettable";

  Future<Database?> checkdb() async {
    if (db != null) {
      return db;
    } else {
      return await initdb();
    }
  }

  Future<Database> initdb() async {
    Directory file = await getApplicationDocumentsDirectory();
    String path = join(file.path, database_name);
    return db = await openDatabase(path, onCreate: (db, version) async {
      String query =
          "CREATE TABLE $datatable_name (id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT,amount INTEGER,title TEXT,note TEXT,time TEXT,date TEXT,status INTEGER)";
      String budgetquery =
          "CREATE TABLE $budgettable_name(id INTEGER PRIMARY KEY AUTOINCREMENT,categoryname TEXT,budget INTEGER)";
      await db
        ..execute(query);
      await db.execute(budgetquery);
    }, version: 1);
  }

  Future<void> insertdb(Expansemodal e) async {
    db = await checkdb();
    await db!.insert("$datatable_name", {
      "category": e.category,
      "title": e.title,
      "amount": e.amount,
      "note": e.note,
      "time": e.time,
      "date": e.date,
      "status": e.status
    });
  }

  Future<List<Map>> readdb() async {
    db = await checkdb();
    String query = "SELECT * FROM $datatable_name";
    List<Map> l1 = await db!.rawQuery(query);
    return l1;
  }

  Future<void> updatedb(Expansemodal e) async {
    db = await checkdb();
    await db!.update(
        "$datatable_name",
        {
          "category": e.category,
          "title": e.title,
          "amount": e.amount,
          "note": e.note,
          "time": e.time,
          "date": e.date,
          "status": e.status
        },
        where: 'id=?',
        whereArgs: [e.id]);
  }

  Future<void> deletedb(int id) async {
    db = await checkdb();
    await db!.delete("$datatable_name", where: "id=?", whereArgs: [id]);
  }

  Future<List<Map>> filterdata({type, category}) async {
    db = await checkdb();
    // print("type database:$type $category");
    String query = '';
    if (type == null && category == null) {
      query = "SELECT * FROM $datatable_name";
      print("null,null=================");
    } else if (type != null && category == null) {
      query = "SELECT * FROM $datatable_name WHERE status ='$type'";
      print("$type,null=================");
    } else if (type == null && category != null) {
      query = "SELECT * FROM $datatable_name WHERE category ='$category'";
      print("null,$category=================");
    } else if (type != null && category != null) {
      query = "SELECT * FROM $datatable_name WHERE category ='$category' AND status='$type'";
      print("$type,$category=================");
    }
    print("==$query==");
    List<Map> list = await db!.rawQuery(query);
    print("==================List:$list===================");
    return list;
  }

//===========================================================================//

  Future<void> budgetinsert(Budgetmodal b) async {
    db = await checkdb();
    await db!.insert(
        budgettable_name, {"categoryname": b.category, "budget": b.amount});
  }

  Future<List<Map>> budgetread() async {
    db = await checkdb();
    String query = "SELECT * FROM $budgettable_name";
    List<Map> budgetlist = await db!.rawQuery(query);
    return budgetlist;
  }

  Future<void> budgetupdate(Budgetmodal b) async {
    db = await checkdb();
    await db!.update(
        budgettable_name, {"categoryname": b.category, "budget": b.amount},
        where: "id=?", whereArgs: [b.id]);
  }
}
