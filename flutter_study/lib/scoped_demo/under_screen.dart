
import 'package:flutter/material.dart';
import 'package:flutter_study/scoped_demo/count_model.dart';
import 'package:scoped_model/scoped_model.dart';


class UnderScreen extends StatefulWidget{

  String title;

  UnderScreen({Key key, this.title}): super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _UnderScreenState();
  }
}

class _UnderScreenState extends State<UnderScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<CountModel>(
      builder: (context, child, model)=>Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.close),
          title: Text(widget.title),
        ),
        body: Center(
          child: Text(
            '${model.count}',
            style: TextStyle(fontSize: 36),
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'click in under screen',
          onPressed: () => model.increment(),

        ),
      ),
    );
  }
}