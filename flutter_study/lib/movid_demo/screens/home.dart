
import 'package:flutter/material.dart';

import 'hot.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: '正在热映',),
            Tab(text: 'TOP 250',),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Hot(),
          Hot(history: true,),
        ],
      ),
    );
  }


}