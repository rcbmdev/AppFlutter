class Operacao {
  late String nome, resumo, tipo, data;
  late int ? id;
  late int ? conta;
  late double custo;

  Operacao({this.id, required this.nome, required this.resumo, required this.data,
    required this.conta, required this.custo, required this.tipo
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'tipo':tipo,
      'conta':conta,
      'nome':nome,
      'resumo':resumo,
      'data':data,
      'custo':custo
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'conta_id': conta,
      'nome': nome,
      'resumo': resumo,
      'data': data,
      'custo': custo
    };
  }

  Operacao.fromMap(Map map){
    id = map['id'];
    tipo = map['tipo'];
    conta = map['conta'];
    nome = map['nome'];
    resumo = map['resumo'];
    data = map['data'];
    custo = map['custo'];
  }

  Operacao.fromJson(Map json){
    id = json['id'];
    tipo = json['tipo'];
    conta = json['conta_id'];
    nome = json['nome'];
    resumo = json['resumo'];
    data = json['data'];
    custo = json['custo'];
  }

  Operacao.fromJsonNested(Map json){
    tipo = json['tipo'];
    nome = json['nome'];
    resumo = json['resumo'];
    data = json['data'];
    custo = json['custo'];
  }
}