import 'package:flutter/material.dart';


//
// https://www.jianshu.com/p/cb0af52376ba
// code https://github.com/jzoom/flutter-example/blob/master/flutter_navigator/lib/main.dart
// 启动时，显示FirstPage
// SecondPage 是 命名路由 跳转来的
// ThirdPage 因为有返回值，所以，只能通过构建路由跳转
//
class NavigatorDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'navigator demo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'secondPage': (BuildContext context) => _NaviSecondPage(),
      },
      home:  _NaviFirstPage(),
    );
  }
}

class _NaviFirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NaviFirstPageState();
  }
}

class _NaviFirstPageState extends State<_NaviFirstPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('navi demo first page'),
      ),
      body: Column(

        children: <Widget>[
          FlatButton(
            child: Text('name 跳转'),
            onPressed: (){
              Navigator.pushNamed(context, 'secondPage');
            },
          ),
          Divider(),
          FlatButton(
            child: Text('跳转传参并返回'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return NaviThirdPage(title:'要输入昵称');
                },
              )).then((onValue) {
                print('then');
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text('输入的昵称是：$onValue'),
                        ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

class _NaviSecondPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('nave second page'),
      ),
      body: Center(
        child:  FlatButton(
          child: Text('return'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class NaviThirdPage extends StatefulWidget{
  final String title;
  NaviThirdPage({this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NaviThirdPageState();
  }



}

class _NaviThirdPageState extends State<NaviThirdPage>{

  TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: '请输入昵称',
              helperText: '帮助：昵称',
              icon: Icon(Icons.home),
            ),
          ),
          FlatButton(
            child: Text('ok'),
            onPressed: (){
              if(controller.text == ''){
                showDialog(
                  context: context,
                  builder: (context) =>  AlertDialog(
                    title: new Text('必须输入昵称'),
                    content: Text('content'),
                  ),
                );
                return;
              }
              Navigator.pop(context, controller.text);
            },
          ),
        ],
      ),
    );
  }

}

