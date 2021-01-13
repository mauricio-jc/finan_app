import 'package:finan_app/helpers/CustomDrawer.dart';
import 'package:finan_app/helpers/Helper.dart';
import 'package:flutter/material.dart';

class ContasReceber extends StatefulWidget {
  @override
  _ContasReceberState createState() => _ContasReceberState();
}

class _ContasReceberState extends State<ContasReceber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a receber"),
        backgroundColor: Helper.primaryColor,
      ),
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}
