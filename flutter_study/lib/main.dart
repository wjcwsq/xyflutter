import 'package:flutter/material.dart';
import 'package:flutter_study/bloc/bloc_demo.dart';
import 'package:flutter_study/grid_demo/grid_view_demo.dart';
import 'package:flutter_study/keep_state/keep_alive.dart';
import 'package:flutter_study/navigator_demo/navigator_demo.dart';
import 'package:flutter_study/scroll_demo/scroll_view_demo.dart';
import 'package:flutter_study/test/test_demo.dart';
import 'package:flutter_study/tooltip/tooltip.dart';
import 'package:flutter_study/bottom_navi/bottom_navigation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'movid_demo/movie_demo.dart';
import 'progress_bar/indicator_demo.dart';
import 'progress_bar/indicator_demo2.dart';
import 'search_bar/search_bar_demo.dart';
import 'progress_bar/progress_bar_demo.dart';
import 'dialog_demo/dialog_demo.dart';
import 'input_demo/input_demo.dart';

void main() => runApp(MyApp());

Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
  //Navigator.defaultRouteName: (context) => MyHomePage(title: 'demo page',),
  //Navigator.defaultRouteName: (context) => IndicatorDemo(),
  Navigator.defaultRouteName: (context) => MovieDemo(),
  //Navigator.defaultRouteName: (context) => IndicatorDemo2(),

};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: _routes,
      //initialRoute: Navigator.defaultRouteName,

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            // 默认，水平方向子控件居中，设置start则靠左显示
            crossAxisAlignment: CrossAxisAlignment.start,
            // stretch，则子控件会铺满整行，但是还居中
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              Container(
                // 用Container来包一个ToolTip
                child: Row(children: [
                  Tooltip(
                    message: 'tooltip input show',
                    child: RaisedButton(
                      child: Text('input test'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputDemo(),
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    child: Text('scroll view'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScrollViewDemo(),
                          ));
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    child: Text('navi route'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigatorDemo(),
                        ),
                      );
                    },
                  )
                ]),
              ),
              Container(
                child: Row(
                  children: [
                    // 直接用一个ToolTip
                    Tooltip(
                      message: "only a tooltip ",
                      child: RaisedButton(
                        child: Text('tooltip raisedbutton'),
                        onPressed: () => print('tooltip raisedbutton pressed'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    RaisedButton(
                      child: Text('grid view'),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> GridViewDemo(),
                        ));
                      },
                    ),
                    SizedBox(width: 10,),
                    RaisedButton(
                      child: Text('test demo'),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TestDemo(),
                        ));
                      },
                    ),
                  ],
                  ),),
              // RaisedButton内部是没办法用ToolTip的
              RaisedButton(
                textColor: Colors.blue,
                child: Text(
                  'button with no tooltip',
                ),
                onPressed: () => print('press raisedbutton!'),
              ),
              Divider(),
              // Tooltip 测试
              Tooltip(
                message: 'tooltip test',
                child: RaisedButton(
                  child: Text('tooltip test'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TooltipTest(),
                        ));
                  },
                ),
              ),
              Divider(),
              RaisedButton(
                child: Text('底部导航'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavigationWidget(),
                      ));
                },
              ),
              Divider(),
              RaisedButton(
                child: Text('保持状态'),
                onPressed: () {
                  Fluttertoast.showToast(msg: '保持状态');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KeepAliveApp(),
                      ));
                },
              ),
              Divider(),
              RaisedButton(
                child: Text('搜索条'),
                onPressed: () {
                  Fluttertoast.showToast(msg: '这是搜索条');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchBarDemo(),
                      ));
                },
              ),
              Divider(),
              RaisedButton(
                child: Text('progress bar demo'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProgressBarDemo()),
                  );
                },
              ),
              Divider(),
              RaisedButton(
                child: Text('dialog demo'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DialogDemo(),
                      ));
                },
              ),
              Divider(),
              RaisedButton(
                child: Text('test'),
                onPressed: () {

                },
              ),
              Divider(),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                color: Colors.red,
                height: 50, // 高度不设，则不显示
                //width: 100, // 宽度不设，则水平占满
              ),
              RaisedButton(
                child: Text('bloc'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> BlocDemo(),
                  ));
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
