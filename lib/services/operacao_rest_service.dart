import 'dart:convert';

import 'package:flutter_gastos/utils/util_rest.dart';
import 'package:http/http.dart';
import 'package:flutter_gastos/models/operacao.dart';

class OperacaoRestService {

  Future<void> addOperacao(Operacao operacao) async {
    final response = await RestUtil.addData(
        'operacoes',
        operacao.toJson()
    );
  }

  Future<List<Operacao>> getOperacoes() async {
    final response = await RestUtil.getData('operacoes');
    if(response.statusCode == 201){
      List<dynamic> conteudo = jsonDecode(response.body);
      List<Operacao> operacoes = conteudo.map((dynamic operacao) =>
        Operacao.fromJson(operacao)).toList();
      return operacoes;
    } else {
      throw Exception("Erro ao listar operações");
    }
  }

  Future<Operacao> getOperacaoId(String id) async {
    final response = await RestUtil.getDataId(
        'operacoes',
        id);
    if(response.statusCode == 200){
      return Operacao.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao buscar operação");
    }
  }

  Future<Operacao?> editOperacao(Operacao operacao, String id) async {
    final novaOperacao = {
      'nome':operacao.nome,
      'resumo':operacao.resumo,
      'custo':operacao.custo,
      'data':operacao.data,
      'conta_id':operacao.conta,
      'tipo':operacao.tipo
    };
    final response = await RestUtil.editData(
        'operacoes',
        novaOperacao,
        id
    );
    if(response.statusCode == 200){
      print("Operação atualizada");
    } else {
      throw Exception("Erro ao atualizar Operação");
    }
  }

  Future<void> removeOperacao(String id) async {
    final response = await RestUtil.removeDataId(
        'operacoes',
        id
    );
    if(response.statusCode == 204){
      print("Operação excluída com sucesso");
    } else {
      throw Exception("Erro ao remover Operação");
    }
  }

}