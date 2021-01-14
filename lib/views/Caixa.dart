import 'package:finan_app/views/ContasPagar.dart';
import 'package:flutter/material.dart';
import 'package:finan_app/helpers/CustomDrawer.dart';
import 'package:finan_app/helpers/Helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Caixa extends StatefulWidget {
  @override
  _CaixaState createState() => _CaixaState();
}

class _CaixaState extends State<Caixa> {
  bool _isLoading = true;
  bool _error = false;
  String _valorReceberTotal = "0.00";
  String _valorReceberDinheiro = "0.00";
  String _valorReceberBoleto = "0.00";
  String _valorReceberCartaoCredito = "0.00";
  String _valorReceberCartaoDebito = "0.00";
  String _valorReceberTransferenciaBancaria = "0.00";
  String _valorPagarTotal = "0.00";
  String _valorPagarDinheiro = "0.00";
  String _valorPagarBoleto = "0.00";
  String _valorPagarCartaoCredito = "0.00";
  String _valorPagarCartaoDebito = "0.00";
  String _valorPagarTransferenciaBancaria = "0.00";
  String _saldo = "0.00";

  Future<Map> _getSaldos() async {
    setState(() { _isLoading = true; });
    http.Response response = await http.get(Helper.urlBase + '/api/caixa');

    if(response.statusCode == 200) {
      setState(() { _isLoading = false; });
      Map jsonDados = json.decode(response.body);

      _valorReceberTotal = jsonDados["valoresReceber"]["total"];
      _valorReceberDinheiro = jsonDados["valoresReceber"]["totalDinheiro"];
      _valorReceberBoleto = jsonDados["valoresReceber"]["totalBoleto"];
      _valorReceberCartaoCredito = jsonDados["valoresReceber"]["totalCartaoCredito"];
      _valorReceberCartaoDebito = jsonDados["valoresReceber"]["totalCartaoDebito"];
      _valorReceberTransferenciaBancaria = jsonDados["valoresReceber"]["totalTransferenciaBancaria"];

      _valorPagarTotal = jsonDados["valoresPagar"]["total"];
      _valorPagarDinheiro = jsonDados["valoresPagar"]["totalDinheiro"];
      _valorPagarBoleto = jsonDados["valoresPagar"]["totalBoleto"];
      _valorPagarCartaoCredito = jsonDados["valoresPagar"]["totalCartaoCredito"];
      _valorPagarCartaoDebito = jsonDados["valoresPagar"]["totalCartaoDebito"];
      _valorPagarTransferenciaBancaria = jsonDados["valoresPagar"]["totalTransferenciaBancaria"];

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
    _getSaldos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Caixa"),
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
          padding: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _cardInfos("Entradas", _valorReceberDinheiro, _valorReceberBoleto, _valorReceberCartaoCredito, _valorReceberCartaoDebito, _valorReceberTransferenciaBancaria, _valorReceberTotal, color: Colors.green),
                SizedBox(height: 10),
                _cardInfos("Saídas", _valorPagarDinheiro, _valorPagarBoleto, _valorPagarCartaoCredito, _valorPagarCartaoDebito, _valorPagarTransferenciaBancaria, _valorPagarTotal, color: Colors.red),
                SizedBox(height: 10),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Helper.primaryColor, width: 0.8),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Helper.primaryColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))
                        ),
                        child: Text("Saldo", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Text("Total: R\$ $_saldo", style: TextStyle(color: Helper.primaryColor, fontSize: 21, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
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

  Widget _cardInfos(String titulo, String dinheiro, String boleto, String cartaoCredito, String cartaoDebito, String transferencia, String total, {Color color = Helper.primaryColor}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color, width: 0.8),
        borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))
            ),
            child: Text(titulo, style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text("Dinheiro: R\$ $dinheiro", style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text("Boleto: R\$ $boleto", style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text("Cartão de crédito: R\$ $cartaoCredito", style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text("Cartão de débito: R\$ $cartaoDebito", style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text("Transferência bancária: R\$ $transferencia", style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Text("Total: R\$ $total", style: TextStyle(color: color, fontSize: 21, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
