import 'package:flutter/material.dart';

class KeepAlivePage extends StatefulWidget{

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
  with AutomaticKeepAliveClientMixin{

  int  _counter = 0;
  @override
  bool get wantKeepAlive => true;

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext contexct){

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点一下加1，点一下加1'),
            Text('$_counter', style: Theme.of(context).textTheme.display1,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'increment',
        child: Icon(Icons.add),
        onPressed: _incrementCounter,
      ),

    );
  }
}
