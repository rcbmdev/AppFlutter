import 'package:flutter/material.dart';
import 'package:flutter_gastos/models/conta.dart';
import 'package:flutter_gastos/models/operacao.dart';
import 'package:flutter_gastos/screens/home/home_screen.dart';
import 'package:flutter_gastos/services/conta_rest_service.dart';
import 'package:flutter_gastos/services/conta_service.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_gastos/services/operacao_rest_service.dart';
import 'package:flutter_gastos/services/operacao_service.dart';

class EditarOperacaoScreen extends StatefulWidget {

  late final String idOperacao;

  EditarOperacaoScreen({required this.idOperacao});

  @override
  State<EditarOperacaoScreen> createState() => _EditarOperacaoState();
}

class _EditarOperacaoState extends State<EditarOperacaoScreen> {
  final _nomeController = TextEditingController();
  final _resumoController = TextEditingController();
  final _custoController = TextEditingController();
  final _tipoController = TextEditingController();
  final _dataController = TextEditingController();
  ContaService cs = ContaService();
  ContaRestService crs = ContaRestService();
  OperacaoService os = OperacaoService();
  OperacaoRestService ors = OperacaoRestService();
  DateTime selectDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();


  late Future<List> _carregaContas;
  late List<Conta> _contas;
  late Operacao _operacao;
  late Future<Operacao> _carregaOperacao;

  Conta ? _contaSelecionada;

  @override
  void initState(){
    _carregaContas = _getContas();
    _carregaOperacao = _getOperacao(widget.idOperacao);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Operação")
        ),
        body: FutureBuilder(
            future: _carregaOperacao,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                _operacao = snapshot.data;
                _nomeController.text = _operacao.nome;
                _resumoController.text = _operacao.resumo;
                _custoController.text = _operacao.custo.toString();
                _dataController.text = _operacao.data;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _nomeController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: "Nome"),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Preencha o campo Nome";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: _resumoController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: "Resumo"),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Preencha o campo Resumo";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: _custoController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: "Custo"),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Preencha o campo Custo";
                              } else {
                                return null;
                              }
                            },
                          ),
                          GestureDetector(
                              onTap:() => _selectDate(context),
                              child:AbsorbPointer(
                                  child: TextFormField(
                                    controller: _dataController,
                                    decoration: InputDecoration(
                                        labelText: formatDate(
                                            selectDate, [dd, '/', mm, '/', yyyy]
                                        )
                                    ),
                                  )
                              )
                          ),
                          FutureBuilder(
                            future: _carregaContas,
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              if(snapshot.hasData){
                                _contas = snapshot.data;
                                var indice = _contas.indexWhere((conta) => conta.id == _operacao.conta);
                                _contaSelecionada = _contas[indice];
                                return DropdownButtonFormField(
                                  value: _contaSelecionada,
                                  onChanged: (Conta ? conta){
                                    setState((){
                                      _contaSelecionada = conta;
                                    });
                                  },
                                  validator: (value){
                                    if(value == null){
                                      return "Selecione uma Conta";
                                    } else {
                                      return null;
                                    }
                                  },
                                  items: _contas.map((conta) {
                                    return DropdownMenuItem(
                                        value: conta,
                                        child: Text(conta.nome)
                                    );
                                  }).toList(),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },

                          ),
                          Padding(
                            padding: EdgeInsets.only(top:20, bottom: 20),
                            child: Container(
                                height: 40,
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: (){
                                      if(_formKey.currentState!.validate()){
                                        Operacao novaOperacao = Operacao(
                                            nome: _nomeController.text,
                                            resumo: _resumoController.text,
                                            data: formatDate(
                                                selectDate,
                                                [yyyy, '-', mm, '-', dd]).toString(),
                                            tipo: _operacao.tipo,
                                            conta: _contaSelecionada!.id,
                                            custo: double.parse(_custoController.text)
                                        );
                                        //os.addOperacao(novaOperacao);
                                        ors.editOperacao(novaOperacao, _operacao.id.toString());
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => HomeScreen())
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueAccent
                                    ),
                                    child: Text("Atualizar")
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        )
    );
  }

  Future<List> _getContas() async{
    //return await cs.getAllContas();
    return await crs.getContas();
  }

  Future<Operacao> _getOperacao(String id) async {
    return await ors.getOperacaoId(id);
  }

  Future<void> _selectDate(BuildContext context) async{
    final DateTime ? picked = await showDatePicker(
        context: context,
        initialDate: selectDate,
        firstDate: DateTime(2022, 01),
        lastDate: DateTime(2030, 01)
    );
    if(picked != null && picked != selectDate) {
      setState((){
        selectDate = picked;
      });
    }
  }
}
