import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '/models/pessoa.dart';
import '/utils/categorias.dart';
import '/utils/validador.dart' as val;
import '/views/confirma_cadastro.dart';

class AtualizarPessoa extends StatefulWidget {
  static const routeName = "/atualizarpessoa";

  const AtualizarPessoa({super.key});

  @override
  _AtualizarPessoaState createState() => _AtualizarPessoaState();
}

class _AtualizarPessoaState extends State<AtualizarPessoa> {
  String? nome, email, aniversario, telefone;
  String? categoria = Categorias.amigo.name;
  int? id;
  final _formKey = GlobalKey<FormState>();
  Pessoa? pessoa;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Pessoa) {
        pessoa = args;
        id = pessoa!.id;
        controllerNome.text = pessoa!.nome ?? '';
        controllerEmail.text = pessoa!.email ?? '';
        controllerTelefone.text = pessoa!.telefone ?? '';
        controllerAniversario.text = pessoa!.aniversario ?? '';
        categoria = pessoa!.categoria ?? categoria;
        setState(() {}); // Atualiza a UI com os dados carregados
      }
    });

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
      appBar: AppBar(
        title: const Text('Atualização de Cadastro'),
        //automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Form(key: _formKey, child: _montaFormulario()),
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
            decoration: const InputDecoration(labelText: 'Id'),
            initialValue: id.toString(),
            enabled: false,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Nome'),
            controller: controllerNome,
            autovalidateMode: AutovalidateMode.onUnfocus,
            //se não setar autovalidateMode, validação só ocorre ao enviar o form
            validator: val.validarNome(),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            controller: controllerEmail,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: val.validarEmail(),
          ),
          TextFormField(
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(labelText: 'Telefone'),
            inputFormatters: [maskFormatterFone],
            controller: controllerTelefone,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: val.validarTelefone(),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Aniversário'),
            inputFormatters: [maskFormatterData],
            controller: controllerAniversario,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: val.validarData(),
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Categoria'),
            value: categoria,
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
        id: id,
        nome: nome,
        email: email,
        telefone: telefone,
        aniversario: aniversario,
        categoria: categoria,
      );
      Navigator.pushReplacementNamed(
        context,
        ConfirmaCadastro.nomeRota,
        arguments: p,
      );
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
