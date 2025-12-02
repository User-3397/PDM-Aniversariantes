import 'package:flutter/material.dart';
import '../widgets/listaraniversariantes_widget.dart';

class ListarAniversarios extends StatefulWidget {
  static const nomeRota = "/listaraniversarios";

  const ListarAniversarios({super.key});

  @override
  _ListarAniversarioState createState() => _ListarAniversarioState();
}

class _ListarAniversarioState extends State<ListarAniversarios> {
  ListaAniversariosWidget listaAniversariosWidget = ListaAniversariosWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aniversários Cadastrados')),
      body: listaAniversariosWidget.montarListaAniversarios(context, false),
    );
  }
}
