import 'dart:async';

import 'package:flutter/material.dart';

class LammineChinchinAttack extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LammineChinchinAttackState();
}

class LammineChinchinAttackState extends State<LammineChinchinAttack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LCA"),),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LCATimer(maxSeconds: 60, title: "刃牙",)));
            },
            child: Text("刃牙(1min)"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LCATimer(maxSeconds: 180, title: "ウルトラマン",)));
            },
            child: Text("ウルトラマン(3min)"),
          )
        ],
      ),
    );
  }
}

class LCATimer extends StatefulWidget {
  final int maxSeconds;
  final String title;
  LCATimer({@required this.maxSeconds, @required this.title});
  @override
  State<StatefulWidget> createState() => LCATimerState();
}

class LCATimerState extends State<LCATimer> {
  double remainSeconds;
  bool isStart = false;
  bool isFinish = false;

  void updateTime() {
    setState(() {
      this.remainSeconds -= 0.01;
    });
  }
  @override
  void initState() {
    super.initState();
    remainSeconds = widget.maxSeconds.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LCA"),),
      body: Column(
        children: [
          Text(remainSeconds.toStringAsFixed(4)),
          RaisedButton(
            onPressed: () {
              if (isStart) isFinish = true;
              isStart = true;
              Timer.periodic(
                Duration(milliseconds: 10),
                (timer) {
                  updateTime();
                  if (isFinish) {
                    timer.cancel();
                    final isWin = remainSeconds >= 0;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(isWin ? "win!!!" : "lose..."),
                        content: Text(
                            "あなたは${(widget.maxSeconds - remainSeconds).toString()}秒で致しました!!!\n"
                            "${isWin ? '挑戦成功!!!${widget.title}に認定します!!!' : '挑戦失敗です...'}"
                        ),
                        actions: [
                          RaisedButton(
                            child: Text("Return to title"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    }).then((_) => Navigator.pop(context));
                  }
                }
              );
            },
            child: Text("Start!!!"),
          ),
        ],
      )
    );
  }
}
