import 'package:flutter/material.dart';


class DialogDemo extends StatefulWidget{

  @override
  _DialogDemoState createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('dialog demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('alert dialog'),
              onPressed: (){
                _showAlert();
                print('after alert'); // 异步，窗口弹出后，会直接执行此句
              },
            ),
            RaisedButton(
              child: Text('alert dialog async'),
              onPressed:() async {
                String result = await _showAlert();
                print('after async alert: $result'); // 同步，只有窗口关闭后，才会执行此取值
              }
            ),

            RaisedButton(
              child: Text('simple dialog'),
              onPressed:(){
                showSimpleDialog();
              },
            ),

          ],
        ),
      ),
    );
  }

  // 弹出alert
  Future _showAlert() async{
    return showDialog(
      context: context,
      barrierDismissible: false, // 默认true,点窗外地方，会关闭界面
      builder: (context){
        return AlertDialog(
          title: Text('alert title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: List.generate(30, (index) => Text('this is alert item: $index'), ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('关闭'),
              onPressed: (){
                Navigator.pop(context, 'close alert');
              },
            )
          ],
        );
      },

    );
  }

  Future showSimpleDialog(){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return SimpleDialog(
          title: Text('simple dialog'),

          children: <Widget>[
            SimpleDialogOption(
              child: Text('选项1'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text('选项2'),
              onPressed:(){
                Navigator.pop(context, '选项2');
              }
            ),
          ],
        );
      },
    );
  }
}