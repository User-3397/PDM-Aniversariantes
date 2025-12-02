import 'dart:convert';
import 'package:http/http.dart' as http;

class Produto {
  final int id;
  final String nome;
  final int quantidade;

  Produto({required this.id, required this.nome, required this.quantidade});

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      quantidade: json['quantidade'],
    );
  }
}

Future<List<Produto>> listarProdutos() async {
  final response = await http.get(Uri.parse("http://localhost:8080/produtos"));

  if (response.statusCode == 200) {
    Iterable lista = json.decode(response.body);
    return lista.map((json) => Produto.fromJson(json)).toList();
  } else {
    throw Exception("Erro ao carregar produtos");
  }
}
