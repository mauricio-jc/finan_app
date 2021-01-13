import 'package:finan_app/helpers/Helper.dart';
import 'package:finan_app/views/Caixa.dart';
import 'package:finan_app/views/ContasPagar.dart';
import 'package:finan_app/views/ContasReceber.dart';
import 'package:finan_app/views/Home.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  _navigatorReplace(BuildContext context, Widget tela) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => tela),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10, left: 20),
              height: 100,
              decoration: BoxDecoration(
                color: Helper.primaryColor,
              ),
              child: Text("Menu de opções".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Início"),
              onTap: () {
                _navigatorReplace(context, Home());
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Caixa"),
              onTap: () {
                _navigatorReplace(context, Caixa());
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Contas a receber"),
              onTap: () {
                _navigatorReplace(context, ContasReceber());
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Contas a pagar"),
              onTap: () {
                _navigatorReplace(context, ContasPagar());
              },
            ),
          ],
        ),
      )
    );
  }
}
