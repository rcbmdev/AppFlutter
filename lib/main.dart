import 'package:flutter/material.dart';
import 'package:flutter_gastos/screens/cadastrar_conta/cadastrar_conta_screen.dart';
import 'package:flutter_gastos/screens/cadastrar_operacao/cadastrar_operacao_screen.dart';
import 'package:flutter_gastos/screens/home/home_screen.dart';

void main()=> runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      //home: CadastrarOperacaoScreen(tipoOperacao: "saida",),
      home: HomeScreen()
    );
  }
}
