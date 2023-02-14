import 'package:flutter/material.dart';
import 'package:flutter_gastos/screens/operacao/components/body.dart';

class OperacaoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Body()
    );
  }
}
