import 'package:finan_app/views/Caixa.dart';
import 'package:finan_app/views/ContasPagar.dart';
import 'package:finan_app/views/ContasReceber.dart';
import 'package:flutter/material.dart';
import 'package:finan_app/helpers/CustomDrawer.dart';
import 'package:finan_app/helpers/Helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;
  bool _error = false;
  String _saldo = "0.00";

  Future<Map> _getSaldo() async {
    setState(() { _isLoading = true; });
    http.Response response = await http.get(Helper.urlBase + '/api/caixa');

    if(response.statusCode == 200) {
      setState(() { _isLoading = false; });
      Map jsonDados = json.decode(response.body);
      _saldo = jsonDados["saldo"];
    }
    else {
      setState(() {
        _isLoading = false;
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getSaldo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Olá Usuário"),
        backgroundColor: Helper.primaryColor,
      ),
      drawer: CustomDrawer(),
      body: _body()
    );
  }

  Widget _body() {
    if(_isLoading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else {
      if(_error == false) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Text("R\$ $_saldo", style: TextStyle(color: Helper.primaryColor, fontSize: 24, fontWeight: FontWeight.w500),),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Caixa()),
                      (route) => false,
                    );
                  },
                  child: Card(
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
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ContasReceber()),
                      (route) => false,
                    );
                  },
                  child: Card(
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
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ContasPagar()),
                      (route) => false,
                    );
                  },
                  child: Card(
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
                )
              ],
            ),
          )
        );
      }
      else {
        return Container(
          child: Center(
            child: Text("Problemas ao carregar os dados.")
          ),
        );
      }
    }
  }
}
