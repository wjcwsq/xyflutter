import 'package:flutter/material.dart';
import 'keep_alive_page.dart';

class KeepAliveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 这里返回的是MaterialApp，相当于一个新的应用，所以没有左上角的返回箭头
    return MaterialApp(
      title: 'keep alive app',
      // 这个值，可以省略，源码中会自动检查，若为空，自动赋值为 Colors.blue
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _KeepAliveDemo(),
    );
  }
}

class _KeepAliveDemo extends StatefulWidget {
  @override
  _KeepAliveDemoState createState() => _KeepAliveDemoState();
}

class _KeepAliveDemoState extends State<_KeepAliveDemo>
    with SingleTickerProviderStateMixin { // 1. with 继承
  TabController _tabController; // 2. 定义controller

  @override
  void initState() {
    super.initState();
    _tabController = TabController( // 3. 重写initState()，并实始化
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose(); // 4. dispose()
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('keep alive demo'),
        bottom: TabBar( // 5. 加tabbar
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: 'CAR', icon: Icon(Icons.directions_car),),
            Tab(text: 'TRANSIT', icon: Icon(Icons.directions_transit)),
            Tab(text: 'BIKE', icon: Icon(Icons.directions_bike)),
          ],
        ),
      ),
      body: TabBarView( // 6. 加 TabBarView
        controller: _tabController,
        children: <Widget>[
          KeepAlivePage(), // 7. 子页面，不要加  appBar
          KeepAlivePage(),
          KeepAlivePage(),
        ],
      ),
    );
  }
}
