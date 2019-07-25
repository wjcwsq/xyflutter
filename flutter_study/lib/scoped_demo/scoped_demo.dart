import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'count_model.dart';
import 'top_screen.dart';

// 教程
// https://juejin.im/post/5b97fa0d5188255c5546dcf8

void main(){
  runApp(ScopedModelDemo());
}

class ScopedModelDemo extends StatelessWidget{

  // 创建顶层状态
  CountModel countModel = CountModel();

  @override
  Widget build(BuildContext context) {

    return ScopedModel<CountModel>(
      // 这里的model会传给所有了类
      model: countModel,
      child: MaterialApp(
        title: 'scoped model',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TopScreen(),
      ),
    );
  }
}