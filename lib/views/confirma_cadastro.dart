import 'package:flutter/material.dart';
import '/utils/database_helper.dart';
import 'myhomepage.dart';
import '/models/pessoa.dart';

class ConfirmaCadastro extends StatelessWidget {
  static const nomeRota = "/confirmacadastro";

  const ConfirmaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    //NOVO - Recebe os argumentos passados na navegação
    RouteSettings? route = ModalRoute.of(context)!.settings;
    Pessoa? argumentos = route.arguments as Pessoa; // NOVO

    // String nome = argumentos!.nome ?? "Nome não informado";
    // String email = argumentos.email ?? "Email não informado";
    // String telefone = argumentos.telefone ?? "Telefone não informado";
    // String aniversario =
    //     argumentos.aniversario ?? "Aniversário não informado";
    // String categoria = argumentos.categoria ?? "Categoria não informada";

    //NOVO - Exemplo de TextScaler
    /*O TextScaler é uma classe introduzida no Flutter (a partir da versão 3.16) 
    para substituir o antigo textScaleFactor do MediaQueryData. Seu principal objetivo é 
    descrever como o texto deve ser dimensionado (escalado) para fins de acessibilidade,
     em resposta à configuração de tamanho de texto do sistema operacional do usuário.*/
    // 1. Obter o TextScaler atual, que reflete as configurações de acessibilidade do usuário
    final TextScaler textScaler = MediaQuery.textScalerOf(context);

    // 2. Usar o método .scale() para calcular o novo tamanho
    /*final*/ const double baseFontSize = 16.0;
    final double scaledFontSize = textScaler.scale(baseFontSize);

    return Scaffold(
      appBar: AppBar(title: const Text('Dados do Aniversariante')),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                argumentos.nome!.substring(0, 1),
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
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final dbHelper = DatabaseHelper.instance;
                    // Captura o contexto antes da operação assíncrona
                    final currentContext = context;
                    int reg = await dbHelper.inserirPessoa(argumentos);
                    // Verifica se o widget ainda está montado
                    if (!currentContext.mounted) return;
                    if (reg != -1) {
                      _avisarSucesso(currentContext);
                    } else {
                      _avisarFalha(currentContext);
                    }
                  },
                  child: const Text('Salvar'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } // build

  void _avisarSucesso(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastro de Aniversários'),
          content: const Text('Cadastro Efetuado Com Sucesso !'),
          actions: [
            TextButton(
              child: const Text('Voltar para a tela inicial'),
              onPressed: () {
                Navigator.pushNamed(context, MyHomePage.nomeRota);
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

  TextStyle _txtStl_01(double x) {
    return TextStyle(
      color: const Color(0xffd3d3d3),
      fontSize: 20.0 * x,
    );
  }

  Text _txtFill(String t, double x) {
    return Text(
      t,
      style: _txtStl_01(x),
    );
  }
} // class
