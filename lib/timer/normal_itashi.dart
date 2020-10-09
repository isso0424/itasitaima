import 'dart:async';

import 'package:flutter/material.dart';

class NormalItashi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NormalItashiState();
}

class NormalItashiState extends State<NormalItashi> {
  Timer _timer;

  int _time = 0;
  bool _isDone = false;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _time += 1;
      });
    });
    super.initState();
  }

  String _formatTime() {
    int sec, hour, min;

    hour = _time ~/ 3600;
    min = (_time - (hour * 3600)) ~/ 60;
    sec = (_time - (hour * 3600) - (min * 60));

    String s, h, m;

    h = hour < 10 ? "0$hour" : "$hour";
    m = min < 10 ? "0$min" : "$min";
    s = sec < 10 ? "0$sec" : "$sec";

    return "$h : $m : $s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("普通に致す")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Text(
                "${_formatTime()}",
                style: TextStyle(fontSize: 60),
              ),
            ),
            _isDone
                ? Flexible(
                    child: Text(
                      "お前の致し時間\n ${_formatTime()}",
                      style: TextStyle(fontSize: 50),
                    ),
                  )
                : Container(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    child: Text("リセット"),
                    onPressed: () {
                      if (!_timer.isActive)
                        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                          setState(() {
                            _time += 1;
                          });
                        });
                      setState(() {
                        _isDone = false;
                        _time = 0;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("致し終わった"),
                    onPressed: () {
                      _timer.cancel();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        child: AlertDialog(
                          title: Text("十分に致せましたか？"),
                          content: Text("まだ続けるというのなら続けてどうぞ"),
                          actions: [
                            FlatButton(
                              child: Text("続ける"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text("終了"),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _isDone = true;
                                  _time = 0;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
