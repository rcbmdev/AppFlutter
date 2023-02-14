import 'package:flutter/material.dart';
import 'package:flutter_gastos/screens/conta/components/body.dart';

class ContaScreen extends StatelessWidget {

  late final int ? id;

  ContaScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id!)
    );
  }
}
