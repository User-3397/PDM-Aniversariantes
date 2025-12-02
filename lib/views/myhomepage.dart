import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cadastrarpessoa.dart';
import 'listaraniversarios.dart';

import '/models/pessoa.dart';
import '/utils/database_helper.dart';

class MyHomePage extends StatefulWidget {
  static const nomeRota = "/myhomepage"; //ESSE É O NOME DA ROTA

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff2b1f00),
      drawer: _buildMenu(),
      appBar: AppBar(title: const Text("Aniversariantes de Hoje!")),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/ruidos-01.jpg'), // Caminho da imagem
            fit: BoxFit.cover, // Ajusta a imagem para cobrir toda a tela
          ),
        ),
        child: Center(
          child: FutureBuilder<List?>(
            future: _consultar(),
            initialData: List.empty(), //Cria uma lista vazia
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      final Pessoa p = snapshot.data![i];
                      if (_isToday(p)) {
                        //assert(pessoa!.id != null, "Id da pessoa é nulo");
                        return _buildRow(context, p);
                      }
                    });
              } else {
                return const Text("Nenhum aniversariante hoje.",
                    style: TextStyle(
                      color: Color(0xffcfcfcf),
                      shadows: [
                        Shadow(
                          blurRadius: 7.0,
                          color: Color(0xff000000),
                          offset: Offset(3.0, 3.0),
                        ),
                      ],
                    ));
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildMenu() {
    return Drawer(
      backgroundColor: const Color(0xba616161),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height:
                80.0, //Se não colocar isso, a barra azul fica muito grande (altura)
            child: DrawerHeader(
              decoration: BoxDecoration(color: Color(0xff004e8e)),
              child: Text('Opções'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.blue),
            title: const Text(
              'Cadastrar Pessoa',
              style: TextStyle(color: Color(0xffcdcdcd)),
            ),
            onTap: () {
              Navigator.pushNamed(context, CadastrarPessoa.nomeRota);
            },
          ),
          ListTile(
            leading: const Icon(Icons.list, color: Colors.blue),
            title: const Text(
              'Listar Aniversarios',
              style: TextStyle(color: Color(0xffcdcdcd)),
            ),
            onTap: () {
              Navigator.pushNamed(context, ListarAniversarios.nomeRota);
            },
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          // https://api.flutter.dev/flutter/material/Icons-class.html
          icon: Icon(Icons.email),
          label: 'Email',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Telefone'),
      ],
      backgroundColor: Color(0xff334b5f),
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xff7dade3),
      onTap: _onItemTapped,
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
            const Text("indisponivel");
            /*Navigator.pushNamed(
              context,
              DetalhesAniversario.nomeRota,
              arguments: pessoa,
            );*/
          },
        ),
      ],
    );
  }

  Future<List<Pessoa>?> _consultar() async {
    var db = DatabaseHelper.instance;
    return db.pesquisarTodasPessoas();
  }

  bool _isToday(Pessoa p) {
    DateTime hoje = DateTime.now();
    var customFormatter = DateFormat('dd/MM/yyyy');
    DateTime dataAniversario =
        customFormatter.parse(p.aniversario!); // de String para DateTime
    bool resultado = (hoje.day == dataAniversario.day &&
        hoje.month == dataAniversario.month);
    assert(
        resultado == true, /*modo debug: */ "Erro ao verificar aniversariante");
    return resultado;
  }
}
