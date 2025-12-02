import 'dart:io';
import '/models/pessoa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "AniverDB2.db";
  static const _databaseVersion = 1;
  static const table = 'TBPessoa';
  static const columnId = 'id';
  static const columnNome = 'nome';
  static const columnEmail = 'email';
  static const columnTelefone = 'telefone';
  static const columnAniversario = 'aniversario';
  static const columnCategoria = 'categoria';

  String? path;

  // torna esta classe singleton
  DatabaseHelper._privateConstructor(); //Construtor privado. Tem que ter no DataBaseHelper.
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // tem somente uma referência ao banco de dados
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      // _deleteDataBase();
      return _database!;
    }
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database!;
  }

  // abre o banco de dados e o cria se ele não existir
  Future<Database> _initDatabase() async {
    try {
      // Tenta usar o diretório de documentos da aplicação (Flutter)
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      path = join(documentsDirectory.path, _databaseName);
    } catch (e) {
      // Fallback: usa o diretório padrão de bancos do sqflite (quando disponível)
      try {
        final databasesPath = await getDatabasesPath();
        path = join(databasesPath, _databaseName);
      } catch (e2) {
        // Último recurso: usa o diretório atual do processo
        final cwd = Directory.current.path;
        path = join(cwd, _databaseName);
      } finally {
        print('Usando caminho do banco de dados: $path');
      }
    }

    try {
      return await openDatabase(
        path!,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    } on DatabaseException catch (dbErr) {
      // Repassa com contexto para facilitar diagnóstico
      throw Exception('Falha ao abrir/criar o banco em "$path": $dbErr');
    }
  }

  // Future<void> _deleteDataBase() async {
  //   await deleteDatabase(path!);
  // }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnNome TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnTelefone TEXT NOT NULL,
            $columnAniversario TEXT NOT NULL,
            $columnCategoria TEXT NOT NULL
          )
          ''');
  }

  // métodos CRUD de Pessoa
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id do registro inserido.
  // Se ocorrer um erro, retorna -1.
  // C ----------------------------------
  Future<int> inserirPessoa(Pessoa pessoa) async {
    try {
      Database db = await instance.database;
      int reg = await db.insert(table, pessoa.toMap() as dynamic);
      pessoa.id = reg;
      return reg;
    } on DatabaseException {
      return -1; //! Indica erro na inserção
    }
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  // R --------------------------------
  Future<List<Pessoa>?> pesquisarTodasPessoas() async {
    Database db = await instance.database;
    List result = await db.query(table);
    List<Pessoa>? list = result.isNotEmpty
        ? result.map((c) => Pessoa.fromMap(c)).toList()
        : null;
    if (list != null) {
      print('Achou = $list');
    } else {
      // Forma mais limpa e comum:
      print('\x1B[31mNão achou nada\x1B[0m');
    }
    return list;
  }

  Future<Pessoa?> pesquisarPessoa(int id) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(
      table,
      columns: [
        columnId,
        columnNome,
        columnEmail,
        columnTelefone,
        columnAniversario,
        columnCategoria,
      ],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Pessoa.fromMap(maps.first as dynamic);
    }
    return null;
  }

  // U -------------------------------------
  // Extra:
  Future<int> updatePessoa(Pessoa pessoa) async {
    Database db = await instance.database;
    return await db.update(
      table,
      pessoa.toMap() as dynamic,
      where: '$columnId = ?',
      whereArgs: [pessoa.id],
    );
  }

  // D -----------------------------------------
  //
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
