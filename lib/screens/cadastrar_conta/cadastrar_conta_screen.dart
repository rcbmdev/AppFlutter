import 'package:flutter/material.dart';
import 'package:flutter_gastos/models/conta.dart';
import 'package:flutter_gastos/screens/home/home_screen.dart';
import 'package:flutter_gastos/services/conta_rest_service.dart';
import 'package:flutter_gastos/services/conta_service.dart';

class CadastrarContaScreen extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  ContaService cs = ContaService();
  ContaRestService crs = ContaRestService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Conta"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child:Padding(
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
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Valor"),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Preencha o campo Valor";
                    }
                    return null;
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()) {
                            Conta novaConta = Conta(
                                nome: _nomeController.text,
                                valor: double.parse(_valorController.text)
                            );
                            //cs.adicionarConta(novaConta);
                            crs.addConta(novaConta);
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen())
                            );
                          }
                        },
                        child: Text(
                            "Cadastrar",
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        )
                      ),
                    ),
                 )
                )
              ],
            ),
          )
        )
      )
    );
  }
}
