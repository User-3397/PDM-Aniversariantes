import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import '../models/pessoa.dart';
//import '/atualizar_pessoa.dart';
import '../views/myhomepage.dart';

class DetalhesAniversario extends StatelessWidget {
  static const nomeRota = "/detalharaniversario";

  @override
  Widget build(BuildContext context) {
    // Recebe os argumentos passados na navegação de forma segura
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! Pessoa) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Dados do Aniversariante'),
          automaticallyImplyLeading:
              false, // Remove o botão de voltar automático
        ),
        body: const Center(
          child: Text('Dados do aniversariante não fornecidos.'),
        ),
      );
    }
    final Pessoa argumentos = args;

    // String nome = argumentos!.nome ?? "Nome não informado";
    // String email = argumentos.email ?? "Email não informado";
    // String telefone = argumentos.telefone ?? "Telefone não informado";
    // String aniversario = argumentos.aniversario ?? "Aniversário não informado";
    // String categoria = argumentos.categoria ?? "Categoria não informada";

    final TextScaler textScaler = MediaQuery.textScalerOf(context);

    // 2. Usar o método .scale() para calcular o novo tamanho
    final double baseFontSize = 16.0;
    final double scaledFontSize = textScaler.scale(baseFontSize);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do Aniversariante'),
        automaticallyImplyLeading: false, // Remove o botão de voltar automático
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                argumentos.id != null
                    ? argumentos.id.toString()
                    : argumentos.nome!.substring(0, 1),
                style: TextStyle(fontSize: scaledFontSize * 4),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              argumentos.nome!,
              style: TextStyle(fontSize: scaledFontSize * 2),
            ),
            const SizedBox(height: 20),
            Text(argumentos.email!, style: TextStyle(fontSize: scaledFontSize)),
            const SizedBox(height: 20),
            Text(
              argumentos.telefone!,
              style: TextStyle(fontSize: scaledFontSize),
            ),
            const SizedBox(height: 20),
            Text(
              argumentos.aniversario!,
              style: TextStyle(fontSize: scaledFontSize),
            ),
            const SizedBox(height: 20),
            Text(
              argumentos.categoria!,
              style: TextStyle(fontSize: scaledFontSize),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildButtons(context, argumentos),
            ),
          ],
        ),
      ),
    );
  } // build

  List<Widget> _buildButtons(BuildContext context, Pessoa argumentos) {
    List<Widget> buttons = [];
    buttons.add(
      ElevatedButton(
        child: const Text('Excluir'),
        onPressed: () async {
          final dbHelper = DatabaseHelper.instance;
          int reg = await dbHelper.delete(argumentos.id!);
          if (reg != -1)
            _avisarSucesso(context);
          else
            _avisarFalha(context);
        },
      ),
    );
    buttons.add(const SizedBox(height: 20));
    buttons.add(
      ElevatedButton(
        child: const Text('Editar'),
        onPressed: () async {
          //Navigator.pushReplacementNamed(
          //  context,
          //  AtualizarPessoa.nomeRota,
          //  arguments: argumentos,
          //);
        },
      ),
    );
    buttons.add(const SizedBox(height: 20));
    buttons.add(
      ElevatedButton(
        child: const Text('Voltar'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    return buttons;
  }

  void _avisarSucesso(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastro de Aniversários'),
          content: const Text('Operação Efetuada Com Sucesso !'),
          actions: [
            TextButton(
              child: const Text('Voltar para a tela inicial'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, MyHomePage.nomeRota);
              },
            ),
          ],
        );
      },
    );
  }

  void _avisarFalha(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastro de Aniversários'),
          content: const Text('Erro no Cadastro !'),
          actions: [
            TextButton(
              child: const Text('Voltar para o cadastro'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
} // class
