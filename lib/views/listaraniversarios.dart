import 'package:flutter/material.dart';
import 'detalhes_aniversario.dart';
import '/utils/database_helper.dart';
import '/models/pessoa.dart';

class ListarAniversarios extends StatefulWidget {
  static const nomeRota = "/listaraniversarios";

  const ListarAniversarios({Key? key}) : super(key: key);

  _ListarAniversarioState createState() => _ListarAniversarioState();
}

class _ListarAniversarioState extends State<ListarAniversarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aniversários Cadastrados')),
      body: FutureBuilder<List?>(
        future: _consultar(),
        initialData: List.empty(), //Cria uma lista vazia
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  Pessoa p = snapshot.data![i];
                  return _buildRow(context, p /*!*/);
                });
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro: ${snapshot.error}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.amber,
                      /*shadows: [
                        Shadow(
                          blurRadius: 3.0,
                          color: Color(0xfff9e900),
                          offset: Offset(0.0, 0.0),
                        ),
                      ],*/
                    )));
          }

          return const Center(child: Text("Nenhum item encontrado."));
        },
      ),
    );
  }

  Column _buildRow(BuildContext context, Pessoa pessoa) {
    //var nomeInicial = pessoa.nome![0].toUpperCase();
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

  Future<List<Pessoa>?> _consultar() async {
    //print("pre");
    var db = DatabaseHelper.instance;
    //print("pos");
    return db.pesquisarTodasPessoas();
  }
}
