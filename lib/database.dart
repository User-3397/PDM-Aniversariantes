//import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';
//import 'dart:async';

// Pesquisa modelo:
//
// Inicialize o banco de dados
/*
Future<Database> initDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'meubanco.db');

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tarefas(id INTEGER PRIMARY KEY, titulo TEXT, feito INTEGER)',
      );
    },
  );
}

// Operações CRUD:
Future<void> inserirTarefa(Database db, String titulo) async {
  await db.insert(
    'tarefas',
    {'titulo': titulo, 'feito': 0},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Map<String, dynamic>>> listarTarefas(Database db) async {
  return await db.query('tarefas');
}

Future<void> atualizarTarefa(Database db, int id, bool feito) async {
  await db.update(
    'tarefas',
    {'feito': feito ? 1 : 0},
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> excluirTarefa(Database db, int id) async {
  await db.delete(
    'tarefas',
    where: 'id = ?',
    whereArgs: [id],
  );
}
*/
