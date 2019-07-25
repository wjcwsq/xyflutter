import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TooltipTest extends StatelessWidget{

  // 这个子页面，要直接返回一个Scaffold，才有左上角的返回箭头
  // 如果返回一个MaterialApp，就没有返回箭头了
  // 具体原因还未深究
  @override
  Widget build(BuildContext context){


    // Scaffold不能直接使用


    var _scaffoldkey = new GlobalKey<ScaffoldState>();
    return Scaffold( //
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text('app bar tooltip'),
        ),
        // 这个Center默认是内部控件居中显示，
        // 但若内部是个Column，则内容是靠上显示的
        //   需要在Column中指定居中显示
        //   似乎column是自动铺满整个Center控件
        body: Center(
          // 如果只是一个Text，则其会居中显示
//          child: Text('center'),
          child:  Column(
            // 加上这个，才会居中显示，不然只是靠上显示
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('tooltip test demo', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500,),),
              Divider(),
              Container(
                child: Tooltip(
                  message: "Container包一个Tooltip",
                  child: RaisedButton(
                    child: Text('Container tooltip'),
                    onPressed: ()=> Fluttertoast.showToast(msg: 'this is a container tool tip'),
                  ),
                ),
              ),
              Divider(),
              Tooltip(
                message: 'buttn tooltip 下面显示',
                child: RaisedButton(
                  child: Text('raised button tooltip'),
                  onPressed: () => print('raisedbutton onpress'),
                ),
              ),
              Divider(),
              Tooltip(
                message: 'icon tool tip 上面显示',
                preferBelow: false,
                child: Icon(
                  Icons.delete,
                  color: Colors.blue,
                ),
              ),
              Divider(),
              // toast 显示内容
              Tooltip(
                message: 'toast',
                child: RaisedButton(
                  child: Text('toast show and snackBar'),
                  onPressed: (){
                    Fluttertoast.showToast(msg: 'this is a toast');

                    _scaffoldkey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('这是snack bar'),
                        action: SnackBarAction(
                          label: 'snackbar scaffold key',
                          onPressed: (){
                            print('pressed snackbar');
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(

                child: Builder(
                  builder: (context){
                    return GestureDetector(
                      child: Text('snackbar gesture',),
                      onTap: (){
                        final snackBar = SnackBar(
                          content: Text('这是snackbar gesture，3秒后自动关闭'),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 3),
                          action: SnackBarAction(
                            label: '撤消',
                            textColor: Colors.white,
                            // 这里点了之后，会直接关闭这个snackBar，不管有没有执行事件
                            onPressed: (){
                              print('close snackbar');
                            },
                          ),
                        );

                        Scaffold.of(context).showSnackBar(snackBar);
                      },

                    );
                  },
                ),
              ),

            ],
          ),
        ),

    );
  }
}
