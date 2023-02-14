import 'package:flutter/material.dart';
import 'package:flutter_gastos/screens/components/card_conta.dart';
import 'package:flutter_gastos/screens/components/card_operacao.dart';
import 'package:flutter_gastos/services/conta_rest_service.dart';
import 'package:flutter_gastos/services/conta_service.dart';
import 'package:flutter_gastos/services/operacao_service.dart';
import 'package:flutter_gastos/models/conta.dart';
import 'package:flutter_gastos/models/operacao.dart';

class Body extends StatefulWidget {
  late final int id;

  Body({required this.id});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  OperacaoService os = OperacaoService();
  ContaService cs = ContaService();
  ContaRestService crs = ContaRestService();
  late Future<List> _carregaOperacoes;
  late Future<Conta> _carregaConta;
  late Conta _conta;
  late List<Operacao> _operacoes;

  @override
  void initState(){
    _carregaOperacoes = _getOperacoes(widget.id);
    _carregaConta = _getConta(widget.id);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _carregaConta,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            _conta = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top:70, bottom: 20),
                    child: Container(
                      height: 175,
                      width: double.infinity,
                      child: cardConta(context, _conta),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 30, bottom: 15, right: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Todas as Operações",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color:  Colors.black
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _conta.operacoes!.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index){
                        return cardOperacao(context, index, _conta.operacoes![index]);
                      }
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }
        }
    );
  }

  Future<Conta> _getConta(int id) async {
    //return await cs.getConta(id);
    return await crs.getContaId(id.toString());
  }

  Future<List> _getOperacoes(int id) async {
    return await os.getOperacoesConta(id);
  }

}
