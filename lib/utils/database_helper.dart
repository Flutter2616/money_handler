import 'dart:io';
import 'dart:ui';
import 'package:money_handler/expanse_modal/budgetmodal.dart';
import 'package:money_handler/expanse_modal/modal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  Database? db;
  Database? budgetdb;
  final String database_name = "expanse.db";
  final String budget_database_name = "budget.db";
  String datatable_name = "expansetable";
  String budgettable_name = "expansetable";

  Future<Database?> checkdb() async {
    if (db != null) {
      return db;
    } else {
      return await initdb();
    }
  }


  Future<Database> initdb() async {
    String query =
        "CREATE TABLE $datatable_name (id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT,amount INTEGER,title TEXT,note TEXT,time TEXT,date TEXT,status INTEGER)";
    Directory file = await getApplicationDocumentsDirectory();
    String path = join(file.path, database_name);
    return db = await openDatabase(path, onCreate: (db, version) async {
      await db.execute(query);
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

//===========================================================================//
  //budgetdatabase
  // Future<Database?> check_budget_db() async {
  //   if (budgetdb != null) {
  //     return budgetdb;
  //   } else {
  //     return await initdb();
  //   }
  // }
  //
  // Future<Database> init_budget_db() async {
  //   String budgetquery="CREATE TABLE $budgettable_name (id INTEGER PRIMARY KEY AUTOINCREMENT,categoryname TEXT,budget INTEGER)";
  //   Directory file = await getApplicationDocumentsDirectory();
  //   String path = join(file.path, budget_database_name);
  //   return budgetdb = await openDatabase(path, onCreate: (budgetdb, version) async {
  //     await budgetdb.execute(budgetquery);
  //   }, version: 1);
  // }
  //
  // Future<void> budgetinsertdb(Budgetmodal b)
  // async {
  //   budgetdb=await check_budget_db();
  //   await budgetdb!.insert("$budgettable_name", {"categoryname":b.category});
  // }
  //
  // Future<void> budgetupdate()
  // async {
  //   budgetdb=await check_budget_db();
  //   await budgetdb!.update("$budgettable_name",{});
  // }
  //
  // Future<List<Map>> budgetread()
  // async{
  //   budgetdb=await check_budget_db();
  //   String budgetquery="SELECT * FROM $budgettable_name";
  //   List<Map> budgetlist =await budgetdb!.rawQuery(budgetquery);
  //   return budgetlist;
  // }
}
