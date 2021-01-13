import 'package:finan_app/helpers/CustomDrawer.dart';
import 'package:finan_app/helpers/Helper.dart';
import 'package:flutter/material.dart';

class ContasPagar extends StatefulWidget {
  @override
  _ContasPagarState createState() => _ContasPagarState();
}

class _ContasPagarState extends State<ContasPagar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
        backgroundColor: Helper.primaryColor,
      ),
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}
