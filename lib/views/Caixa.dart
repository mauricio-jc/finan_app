import 'package:finan_app/helpers/CustomDrawer.dart';
import 'package:finan_app/helpers/Helper.dart';
import 'package:flutter/material.dart';

class Caixa extends StatefulWidget {
  @override
  _CaixaState createState() => _CaixaState();
}

class _CaixaState extends State<Caixa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caixa"),
        backgroundColor: Helper.primaryColor,
      ),
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}
