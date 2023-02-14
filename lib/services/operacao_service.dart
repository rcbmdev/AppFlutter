import 'dart:convert';

import 'package:flutter_gastos/models/operacao.dart';
import 'package:flutter_gastos/services/conta_service.dart';
import 'package:flutter_gastos/utils/db_util.dart';
import 'package:flutter_gastos/utils/util_rest.dart';

class OperacaoService {
  List<Operacao> _operacaoList = [];
  ContaService cs = ContaService();

  void addOperacao(Operacao operacao){
    DbUtil.insertData('operacao', operacao.toMap());
    cs.atualizaValorConta(operacao.conta, operacao.custo, operacao.tipo);
  }
  Future<List> getAllOperacoes() async {
    final dataList = await DbUtil.getData('operacao');
    _operacaoList = dataList.map((operacoes) => Operacao.fromMap(operacoes)).toList();
    return _operacaoList;
  }

  Future<List> getOperacoesConta(int id) async {
    String whereString = "conta = ?";
    List<dynamic> whereArguments = [id];
    final dataList = await DbUtil.getDataWhere(
        'operacao',
        whereString,
        whereArguments);
    return dataList.map((operacoes) => Operacao.fromMap(operacoes)).toList();
  }



}