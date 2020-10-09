import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class LammineChinchinAttack extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LammineChinchinAttackState();
}

class LammineChinchinAttackState extends State<LammineChinchinAttack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LCA"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "†Laminne ChinChin Attack†",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LCATimer(maxSeconds: 60, title: "刃牙",)));
                },
                color: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Text("刃牙(1min)", style: TextStyle(fontSize: 40),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LCATimer(maxSeconds: 180, title: "ウルトラマン",)));
                },
                color: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Text("ウルトラマン(3min)", style: TextStyle(fontSize: 40)),
              ),
            )
          ],
        ),
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
      this.remainSeconds -= 0.1;
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
      appBar: AppBar(title: Text("LCA ${widget.title} Challenge"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("残り時間", style: TextStyle(fontSize: 40),),
            Text("${remainSeconds.toStringAsFixed(1)}sec", style: TextStyle(fontSize: 60,),),
            RaisedButton(
              onPressed: () {
                if (isStart) isFinish = true;
                isStart = true;
                Timer.periodic(
                  Duration(milliseconds: 100),
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
                              "あなたは${(widget.maxSeconds - remainSeconds).toStringAsFixed(1)}秒で致しました!!!\n"
                              "${isWin ? '挑戦成功!!!${widget.title}に認定します!!!' : '挑戦失敗です...'}"
                          ),
                          actions: [
                            IconButton(
                              icon: Icon(Icons.home),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                Share.share(
                                    "私は${(widget.maxSeconds - remainSeconds).toString()}秒で致して"
                                    "${widget.title}の挑戦に${isWin ? "成功しました!!!" : "失敗しました..."}\n"
                                    "#itashitaima"
                                );
                              },
                            )
                          ],
                        );
                      }).then((_) => Navigator.pop(context));
                    }
                  }
                );
              },
              child: Text(isStart ? "Finish!!!" : "Start!!!", style: TextStyle(fontSize: 20),),
              color: Colors.white,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ],
        ),
      )
    );
  }
}
