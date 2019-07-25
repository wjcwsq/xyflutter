import 'package:flutter/material.dart';

class TestDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestDemoState();
  }

}

class TestDemoState extends State<TestDemo>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('test demo'),
      ),
      body: Align(
        alignment: Alignment.bottomRight,
        //widthFactor: 3,
        //heightFactor: 3,
        child: Container(
          width: 200,
          height: 100,
          color: Colors.red,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              //width: 50, height: 50,
              color: Colors.blue,
              child: Text('hello'),
            ),
          ),
        ),
      ),
    );
  }

}