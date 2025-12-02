// Singleton:

/*class DatabaseHelper {
    static const _databaseName = "ExemploDB.db";
    static const _databaseVersion = 1;
    static const table = 'TBPessoa';
    
    DatabaseHelper._privateConstructor(); // construtor privado

    static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
    
    // garante somente uma referência ao banco de dados
    static Database? _database;
}
*/

/*
// Singleton - desenvolvido:

class DatabaseHelper {
  static const _databaseName = "AniverDB.db";
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
    if (_database != null) return _database!;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database!;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
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
}
*/
