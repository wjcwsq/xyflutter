
import 'package:flutter/material.dart';
import 'package:flutter_study/progress_bar/bean/ItemInfo.dart';

typedef OnItemClickListener = void Function(int position);

// 每一行的widget
class HomeListItem extends StatelessWidget{
  // 为了点击时显示序号
  int position;
  // 只用了字段 title
  final ItemInfo itemInfo;
  OnItemClickListener listener;

  HomeListItem(this.position, this.itemInfo, this.listener);

  @override
  Widget build(BuildContext context) {

    var widget = Column(
      children: <Widget>[
        Container(
          height: 50,
          color: Color.fromARGB(255, 241, 251, 241),
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    itemInfo.title,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff999999),
                    ),
                  ),

                ],

              ),
            ],
          ),
        ),
        // 用Container实现分割线
//        Container(
//          height: 1,
//          color: Color.fromARGB(255, 230, 230, 230),
//        ),
        // 这里为何还有个分割线？
        Divider(),
      ],
    );

    // TODO: implement build
    return InkWell(
      child: widget,
      onTap: ()=>listener(position),
    );

  }


}