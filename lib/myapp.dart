//import 'dart:html';
//import 'dart:io';

import 'package:flutter/material.dart';
import '/views/cadastrarpessoa.dart';
import '/views/confirma_cadastro.dart';
import '/views/detalhes_aniversario.dart';
import '/views/listaraniversarios.dart';
import '/views/myhomepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Aniversários',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primaryColor: Colors.red, // Cor principal
        //primarySwatch: Color(0xff283846),
        scaffoldBackgroundColor: Color(0xff2b2b2b), // Fundo padrão

        textTheme: const TextTheme(

            //bodySmall: TextStyle(fontSize: 25, color: Colors.yellow),
            //bodyLarge: TextStyle(fontSize: 18, color: Color(0xffdef8df)),
            //bodyMedium: TextStyle(fontSize: 16, color: Color(0xddb06969)),
            //titleLarge: TextStyle(fontWeight: FontWeight.bold),
            //titleSmall: TextStyle(fontSize: 25, color: Colors.yellow),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff585858),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
      // SAi o home e entram as rotas de navegação
      initialRoute: MyHomePage.nomeRota,
      routes: {
        //CadastrarPessoa.nomeRota: (context) => CadastrarPessoa(),
        CadastrarPessoa.nomeRota: (context) => CadastrarPessoa(),
        ConfirmaCadastro.nomeRota: (context) => ConfirmaCadastro(),
        DetalhesAniversario.nomeRota: (context) => DetalhesAniversario(),
        ListarAniversarios.nomeRota: (context) => ListarAniversarios(),
        MyHomePage.nomeRota: (context) => MyHomePage(),
      },
    );
  }
}
