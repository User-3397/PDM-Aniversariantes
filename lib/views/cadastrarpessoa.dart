import 'package:flutter/material.dart';
import '/utils/categorias.dart';
import 'confirma_cadastro.dart';
import '/models/pessoa.dart';
import '/utils/validador.dart' as val;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastrarPessoa extends StatefulWidget {
  static const nomeRota = "/cadastrarpessoa";

  const CadastrarPessoa({super.key});

  @override
  _CadastrarPessoaState createState() => _CadastrarPessoaState();
}

class _CadastrarPessoaState extends State<CadastrarPessoa> {
  String? nome, email, aniversario, telefone;
  String categoria = Categorias.amigo.name;
  final _formKey = GlobalKey<FormState>();

  late final controllerNome = TextEditingController();
  late final controllerEmail = TextEditingController();
  late final controllerAniversario = TextEditingController();
  late final controllerTelefone = TextEditingController();

  var maskFormatterData = MaskTextInputFormatter(
    mask: '##/##/####',
    type: MaskAutoCompletionType.lazy,
  );

  var maskFormatterFone = MaskTextInputFormatter(
    mask: '(##)#####-####',
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controllerNome.dispose();
    controllerEmail.dispose();
    controllerAniversario.dispose();
    controllerTelefone.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controllerNome.addListener(() {
      nome = controllerNome.text;
    });
    controllerEmail.addListener(() {
      email = controllerEmail.text;
    });
    controllerAniversario.addListener(() {
      aniversario = controllerAniversario.text;
    });
    controllerTelefone.addListener(() {
      telefone = controllerTelefone.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Aniversários')),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: _montaFormulario(),
          ), //Se não colocar a key, não valida
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              //NOVO
              _sendForm();
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _montaFormulario() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Nome'),
            controller: controllerNome,
            autovalidateMode: AutovalidateMode.onUnfocus,
            //se não setar autovalidateMode, validação só ocorre ao enviar o form
            validator: val.validarNome(),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            controller: controllerEmail,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: val.validarEmail(),
          ),
          TextFormField(
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              hintText: "(##)#####-####",
            ),
            inputFormatters: [maskFormatterFone],
            controller: controllerTelefone,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: val.validarTelefone(),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Aniversário',
              hintText: "dd/MM/yyyy",
            ),
            inputFormatters: [maskFormatterData],
            controller: controllerAniversario,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: val.validarData(),
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Categoria'),
            value: categoria,
            //initialValue: categoria,
            items: Categorias.values.map((Categorias categoria) {
              return DropdownMenuItem<String>(
                value: categoria.name,
                child: Text(categoria.name),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                categoria = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }

  void _sendForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // NOVO
      Pessoa p = Pessoa.comParametros(
        nome: nome,
        email: email,
        telefone: telefone,
        aniversario: aniversario,
        categoria: categoria,
      );
      Navigator.pushNamed(context, ConfirmaCadastro.nomeRota, arguments: p);
    } else {
      // Erros na validação
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Corrija os erros no formulário'),
          backgroundColor: Color.fromARGB(255, 21, 54, 218),
        ),
      );
    }
  }
}
