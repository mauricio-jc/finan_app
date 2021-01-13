import 'package:finan_app/helpers/CustomDrawer.dart';
import 'package:finan_app/helpers/Helper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Olá Usuário"),
        backgroundColor: Helper.primaryColor,
      ),
      drawer: CustomDrawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: Text("R\$ 604,85", style: TextStyle(color: Helper.primaryColor, fontSize: 24, fontWeight: FontWeight.w500),),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Helper.primaryColor, width: 0.8),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.attach_money, size: 120, color: Helper.primaryColor),
                      Text("Caixa", style: TextStyle(color: Helper.primaryColor, fontSize: 30))
                    ],
                  ),
                )
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Helper.primaryColor, width: 0.8),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.attach_money, size: 120, color: Helper.primaryColor),
                      Text("Contas a receber", style: TextStyle(color: Helper.primaryColor, fontSize: 30))
                    ],
                  ),
                )
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Helper.primaryColor, width: 0.8),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.attach_money, size: 120, color: Helper.primaryColor),
                      Text("Contas a pagar", style: TextStyle(color: Helper.primaryColor, fontSize: 30))
                    ],
                  ),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
