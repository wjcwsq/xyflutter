import 'package:flutter/material.dart';

class ScrollViewDemo extends StatefulWidget {
  @override
  _ScrollViewDemoState createState() => _ScrollViewDemoState();
}

class _ScrollViewDemoState extends State<ScrollViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scroll view demo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          //
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(100, (index) {

            // 1.为了让子行能够在作何地方都能用手指滚动，所以加上Row
            // Row中若只有一个Text，则只有文字的地方才能拖
            // 加上一个Expanded，就能扩充至整行，空白地方也能拖了
//            return Row(
//              children: <Widget>[
//                Expanded(
//                  child: Text('index $index'),
//                ),
//              ],
//            );
            // 2.加上divicer也可以拖动
            //if(index % 2 == 0)
              return Text('index $index');
            //else
            //  return Divider();
          },),
        ),
      ),
    );
  }
}
