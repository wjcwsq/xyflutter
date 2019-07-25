import 'package:flutter/material.dart';
import 'package:flutter_study/bloc/blocs/bloc_provider.dart';
import 'package:flutter_study/bloc/top_page.dart';

void main() => runApp(MyApp());

// 一个BlocProvider管理一个CountBloc
// App中生成BlocProvider，MaterialApp是其子
// 下层page的build时，取出bloc，用StreamBuilder，取值，改动
//

class MyApp  extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    


    return BlocProvider(
      child: MaterialApp(
        title: 'bloc demo',
        home: TopPage(),
      ),
    );
  }
}

