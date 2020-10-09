import 'package:flutter/material.dart';

class LammineChinchinAttack extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LammineChinchinAttackState();
}

class LammineChinchinAttackState extends State<LammineChinchinAttack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {

            },
            child: Text("刃牙(1min)"),
          ),
          RaisedButton(
            onPressed: () {

            },
            child: Text("ウルトラマン(3min)"),
          )
        ],
      ),
    );
  }
}

class Baki extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BakiState();
}

class BakiState extends State<Baki> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Ultra extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class UltraState extends State<Ultra> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}