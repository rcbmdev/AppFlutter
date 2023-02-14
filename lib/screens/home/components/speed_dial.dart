import 'package:flutter/material.dart';
import 'package:flutter_gastos/screens/cadastrar_operacao/cadastrar_operacao_screen.dart';
import 'package:flutter_gastos/screens/cadastrar_conta/cadastrar_conta_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDial buildSpeedDial(BuildContext context){
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 22),
    children: [
      SpeedDialChild(
        child: Icon(Icons.add, color:Colors.white),
        backgroundColor: Colors.green,
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => CadastrarOperacaoScreen(tipoOperacao: "entrada")
            )
          );
        },
        label: "Entrada",
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white
        ),
        labelBackgroundColor: Colors.green
      ),
      SpeedDialChild(
          child: Icon(Icons.remove, color:Colors.white),
          backgroundColor: Colors.red,
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => CadastrarOperacaoScreen(tipoOperacao: "saida")
                )
            );
          },
          label: "Saída",
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
          labelBackgroundColor: Colors.red
      ),
      SpeedDialChild(
          child: Icon(Icons.account_balance, color:Colors.white),
          backgroundColor: Colors.blue,
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => CadastrarContaScreen()
                )
            );
          },
          label: "Conta",
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
          labelBackgroundColor: Colors.blue
      ),
    ],
  );
}