import 'package:finan_app/helpers/CustomDrawer.dart';
import 'package:finan_app/helpers/Helper.dart';
import 'package:finan_app/models/ContaPagar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ContasPagar extends StatefulWidget {
  @override
  _ContasPagarState createState() => _ContasPagarState();
}

class _ContasPagarState extends State<ContasPagar> {
  bool _isLoading = true;
  bool _error = false;
  List<ContaPagar> _listContaPagar = List<ContaPagar>();

  Future _getDados() async {
    setState(() { _isLoading = true; });
    http.Response response = await http.get(Helper.urlBase + "/api/contas-pagar");

    if(response.statusCode == 200) {
      setState(() { _isLoading = false; });
      List jsonDados = json.decode(response.body);

      for(var item in jsonDados) {
        ContaPagar contaPagar = ContaPagar();
        contaPagar.id = item["id"];
        contaPagar.data = item["data"];
        contaPagar.valor = item["valor"];
        contaPagar.formaPagamento = item["forma_pagamento"];
        contaPagar.observacoes = item["observacoes"];
        _listContaPagar.add(contaPagar);
      }
    }
    else {
      setState(() {
        _isLoading = false;
        _error = true;
      });
    }
  }

  _onRefresh() {
    setState(() {
      _listContaPagar.clear();
      _getDados();
    });
  }

  @override
  void initState() {
    super.initState();
    _getDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
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
        return RefreshIndicator(
          onRefresh: () async {
            _onRefresh();
          },
          child: ListView.builder(
            itemCount: _listContaPagar.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.remove, color: Colors.red),
                title: Text("R\$ " + _listContaPagar[index].valor, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_listContaPagar[index].data + " - " + _listContaPagar[index].formaPagamento),
                  ],
                )
              );
            }
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
