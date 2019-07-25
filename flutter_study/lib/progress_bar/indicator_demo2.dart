import 'package:flutter/material.dart';

class IndicatorDemo2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IndicatorDemoState();
  }

}
// 问题：加上scrollcontroller之后，如果初始化时，列表数量不到一屏，则下拉时
// RefreshIndicator就拉不出来了，如可处理？
//
class _IndicatorDemoState extends State<IndicatorDemo2>{

  ScrollController _scrollController = ScrollController();
  @override
  void initState(){
    super.initState();

    _scrollController.addListener((){

      print('listener: ${_scrollController.offset}');
    });

  }

  Future<void>  _onRefresh() async{
    await Future.delayed(Duration(seconds: 8));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('只测 indicator'),
      ),
      body: RefreshIndicator(
          child: ListView(
            controller: _scrollController,
            children: List.generate(30, (index){
              return Text('row: $index');
            }),
          ),
          onRefresh: _onRefresh,

      ),
    );
  }

}