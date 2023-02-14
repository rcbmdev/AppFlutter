import 'package:flutter/material.dart';
import 'package:flutter_gastos/models/conta.dart';
import 'package:flutter_gastos/screens/conta/conta_screen.dart';
import 'package:flutter_gastos/services/conta_rest_service.dart';

Widget cardConta(BuildContext context, Conta conta){
  return InkWell(
    onTap: (){
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => ContaScreen(id: conta.id))
      );
    },
    onLongPress: (){
      showDialogAlert(context, conta);
    },
    child: Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
        boxShadow: [
          BoxShadow(
            color: Color(0x100000),
            blurRadius: 10,
            spreadRadius: 4,
            offset: Offset(0.0, 0.8)
          )
        ]
      ),
      child: Stack(
        children: [
          Positioned(
              top:14,
              right: 12,
              child: Text(
                conta.nome,
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              ),
          ),
          Positioned(
              top: 63,
              left: 16,
              child: Text(
                  'Saldo em Conta',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              )
          ),
          Positioned(
              top: 81,
              left: 16,
              child: Text(
                  'R\$ ' +conta.valor.toString(),
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w900,
                    color: Colors.white
                ),
              )
          )
        ],
      ),
    ),
  );
}

showDialogAlert(BuildContext context, Conta conta){
  ContaRestService crs = ContaRestService();
  Widget botaoRemover = TextButton(
      onPressed: (){
        crs.removeConta(conta.id.toString());
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Text("Remover")
  );
  Widget botaoCancelar = TextButton(
      onPressed: (){
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Text('Cancelar')
  );

  AlertDialog alerta = AlertDialog(
    title: Text("Deseja remover essa conta?"),
    content: Text("Essa ação não pode ser desfeita"),
    actions: [
      botaoRemover,
      botaoCancelar
    ],
  );
  showDialog(context: context, builder: (BuildContext context){
    return alerta;
  });
}