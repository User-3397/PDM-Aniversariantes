class Pessoa {
  int? id;
  String? nome;
  String? email;
  String? telefone;
  String? aniversario;
  String? categoria;

  Pessoa();

  Pessoa.comParametros({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.aniversario,
    required this.categoria,
  });

  Pessoa.fromMap(Map map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    telefone = map['telefone'];
    aniversario = map['aniversario'];
    categoria = map['categoria'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'aniversario': aniversario,
      'categoria': categoria,
    };

    // O id pode ser nulo caso o registro esteja sendo criado já que é o banco de dados que
    // atribui o ID ao registro no ato de salvar. Por isso devemos testar antes de atribuir
    if (id != null) {
      map['id'] = id;
    }
    return map;
  } //Fecha toMap

  @override
  String toString() {
    return ("Id: $id, Nome: $nome, Email: $email, Telefone: $telefone, Aniversario: $aniversario, Categoria: $categoria");
  }
} // Fecha class
