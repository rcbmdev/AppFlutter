import 'dart:convert';

import 'package:flutter_gastos/models/conta.dart';
import 'package:flutter_gastos/utils/util_rest.dart';
import 'package:http/http.dart';

class ContaRestService {
  Future<void> addConta(Conta conta) async {
    final Response response = await RestUtil.addData(
        '/contas',
        conta.toJson()
    );
  }

  Future<List<Conta>> getContas() async {
    final Response response = await RestUtil.getData('contas');
    if(response.statusCode == 201){
      List<dynamic> conteudo = jsonDecode(response.body);
      List<Conta> contas = conteudo.map((dynamic conta) =>
          Conta.fromJson(conta)).toList();
      return contas;
    } else {
      throw Exception("Erro ao listar contas");
    }

  }

  Future<Conta> getContaId(String id) async {
    final Response response = await RestUtil.getDataId('contas', id);
    if (response.statusCode == 200) {
      return Conta.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao buscar a conta selecionada");
    }
  }
  Future<void> removeConta(String id) async {
    final Response response = await RestUtil.removeDataId('contas', id);
    if(response.statusCode == 204){
      print("Conta removida");
    } else {
      throw Exception("Erro ao remover conta");
    }

  }

}