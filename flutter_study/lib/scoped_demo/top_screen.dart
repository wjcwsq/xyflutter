
import 'package:flutter/material.dart';
import 'package:flutter_study/scoped_demo/under_screen.dart';
import 'count_model.dart';
import 'package:scoped_model/scoped_model.dart';

class TopScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return _TopScreenState();
  }
}

class _TopScreenState extends State<TopScreen>{

  //  此方法只是演示，不用
  // 静态获取model实例
  Model getModel(BuildContext context){

    // 用静态方法 of
    final countModel1 = ScopedModel.of<CountModel>(context);
    // 使用实体类中重写的 of
    final countModel2 = CountModel().of(context);

    countModel1.increment();
    countModel2.increment();

    return countModel1;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<CountModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text('top screen'),
          ),
          body: Center(
            child: Text(
              model.count.toString(),
              style: TextStyle(fontSize: 48),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              //model.increment();
              // 路由到的新窗口，同样是ScopedModel的子类
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UnderScreen(title: 'under screen',),
              ));
            },
          ),
        );
      },
    );
  }

}


