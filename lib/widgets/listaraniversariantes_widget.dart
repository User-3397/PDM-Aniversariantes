import '/models/pessoa.dart';
import '/utils/database_helper.dart';
import '/views/detalhes_aniversario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaAniversariosWidget {
  FutureBuilder<List<Pessoa>?> montarListaAniversarios(
      BuildContext context, bool apenasAniversariantes) {
    Pessoa? pessoa;

    return FutureBuilder<List<Pessoa>?>(
      future: _consultar(apenasAniversariantes),
      initialData: List.empty(), //Cria uma lista vazia
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  pessoa = snapshot.data![i];
                  return _buildRow(context, pessoa!);
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  _buildRow(BuildContext context, Pessoa pessoa) {
    return Column(
      children: [
        ListTile(
          leading: ClipOval(
            child: Container(
              color: Colors.blue,
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  pessoa.id.toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(pessoa.nome!),
          dense: true,
          onTap: () {
            Navigator.pushNamed(
              context,
              DetalhesAniversario.nomeRota,
              arguments: pessoa,
            );
          },
        ),
      ],
    );
  }

  Future<List<Pessoa>?> _consultar(bool apenasAniversariantes) async {
    var db = DatabaseHelper.instance;
    List<Pessoa>? pessoas = await db.pesquisarTodasPessoas();
    if (apenasAniversariantes) {
      DateTime hoje = DateTime.now();
      int dia = (hoje.day);
      int mes = (hoje.month);

      print("Dia/mes de hoje = $dia " '/' " $mes");

      List<Pessoa> aniversariantes = [];
      DateFormat df = DateFormat("dd/MM/yyyy");

      if (pessoas != null) {
        for (var item in pessoas) {
          Pessoa p = item;
          String data = p.aniversario!;
          print("Data do aniversario = $data");

          DateTime dt = df.parse(data);
          if (dia == dt.day && mes == dt.month) {
            aniversariantes.add(p);
          }
        }
      }
      return aniversariantes;
    } else {
      return pessoas;
    }
  }

  bool _ehAniversariante(Pessoa p) {
    DateTime hoje = DateTime.now();
    var customFormatter = DateFormat('dd/MM/yyyy');
    DateTime dataAniversario = customFormatter.parse(p.aniversario!);
    bool teste = (hoje.day == dataAniversario.day &&
        hoje.month == dataAniversario.month);
    assert(teste == true, "Erro ao verificar aniversariante");
    return teste;
  }
}
