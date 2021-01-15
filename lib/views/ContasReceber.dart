import 'package:finan_app/models/ContaReceber.dart';
import 'package:flutter/material.dart';
import 'package:finan_app/helpers/CustomDrawer.dart';
import 'package:finan_app/helpers/Helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ContasReceber extends StatefulWidget {
  @override
  _ContasReceberState createState() => _ContasReceberState();
}

class _ContasReceberState extends State<ContasReceber> {
  bool _isLoading = true;
  bool _error = false;
  List<ContaReceber> _listContaReceber = List<ContaReceber>();

  Future _getDados() async {
    setState(() { _isLoading = true; });
    http.Response response = await http.get(Helper.urlBase + "/api/contas-receber");

    if(response.statusCode == 200) {
      setState(() { _isLoading = false; });
      List jsonDados = json.decode(response.body);

      for(var item in jsonDados) {
        ContaReceber contaReceber = ContaReceber();
        contaReceber.id = item["id"];
        contaReceber.cliente = item["cliente"];
        contaReceber.data = item["data"];
        contaReceber.valor = item["valor"];
        contaReceber.formaPagamento = item["forma_pagamento"];
        contaReceber.observacoes = item["observacoes"];
        _listContaReceber.add(contaReceber);
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
      _listContaReceber.clear();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Contas a receber"),
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
            itemCount: _listContaReceber.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.add, color: Colors.green),
                title: Text("R\$ " + _listContaReceber[index].valor, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_listContaReceber[index].data + " - " + _listContaReceber[index].formaPagamento),
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
