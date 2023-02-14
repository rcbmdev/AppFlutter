import 'package:flutter/material.dart';
import 'package:flutter_gastos/models/conta.dart';
import 'package:flutter_gastos/models/operacao.dart';
import 'package:flutter_gastos/screens/home/home_screen.dart';
import 'package:flutter_gastos/services/conta_rest_service.dart';
import 'package:flutter_gastos/services/conta_service.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_gastos/services/operacao_rest_service.dart';
import 'package:flutter_gastos/services/operacao_service.dart';

class CadastrarOperacaoScreen extends StatefulWidget {

  late final String tipoOperacao;

  CadastrarOperacaoScreen({required this.tipoOperacao});

  @override
  State<CadastrarOperacaoScreen> createState() => _CadastrarOperacaoState();
}

class _CadastrarOperacaoState extends State<CadastrarOperacaoScreen> {
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

  Conta ? _contaSelecionada;

  @override
  void initState(){
    _carregaContas = _getContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tipoOperacao == "entrada" ? "Cadastro de Entrada" : "Cadastro de Saída"
        ),
        backgroundColor: widget.tipoOperacao == "entrada" ? Colors.green : Colors.red,
      ),
      body: FutureBuilder(
        future: _carregaContas,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            _contas = snapshot.data;
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
                      DropdownButtonFormField(
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
                                    tipo: widget.tipoOperacao,
                                    conta: _contaSelecionada!.id,
                                    custo: double.parse(_custoController.text)
                                );
                                //os.addOperacao(novaOperacao);
                                ors.addOperacao(novaOperacao);
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => HomeScreen())
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: widget.tipoOperacao == "entrada" ? Colors.green : Colors.red
                            ),
                            child: Text("Cadastrar")
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
