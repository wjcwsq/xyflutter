import 'package:flutter/material.dart';

///**
// * 圆形进度条
// * 可以在外面包一层SizedBox，间接改变进度条的大小
// *const CircularProgressIndicator({
//    Key key,
//    double value,//0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
//    Color backgroundColor,//背景颜色
//    Animation<Color> valueColor,//animation类型的参数，用来设定进度值的颜色，默认为主题色
//    this.strokeWidth = 4.0,//进度条宽度
//    String semanticsLabel,
//    String semanticsValue,
//    })
//
//原文：https://blog.csdn.net/weixin_34038652/article/details/88179780
//
//*/
class ProgressBarDemo extends StatefulWidget {
  @override
  _ProgressBarDemoState createState() => _ProgressBarDemoState();
}

class _ProgressBarDemoState extends State<ProgressBarDemo> {

  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('progress bar demo'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 150,
            top: 20,
            // 默认，主题颜色，会一直转
            child: CircularProgressIndicator(),
          ),
          Positioned(
            left: 150,
            top: 70,
            child: CircularProgressIndicator(
              value: 0.3, // 设了值后，它就不动了，相当于圆已经画的长度
              backgroundColor: Colors.red, // 颜色没用
            ),
          ),
          Positioned(
            left: 150,
            top: 120,
            child: CircularProgressIndicator(
              strokeWidth: 8, // 这个是线条的宽度，默认值为4
              backgroundColor: Color(0xffff0000),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red), // 这个是圆圈的颜色
            ),
          ),
          Positioned(
            left: 150,
            top: 220,
            // 要想自定义大小的话，可以加SizedBox
            child: SizedBox(
              width: 150,
              height: 50, // 宽，高不一样，就会是椭圆形
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 270,
            height: 10,
            width: 300, // 宽度必须充置，不然出错
            child: LinearProgressIndicator(
              // value: 0.5, // 若设置，则静止不动
              backgroundColor: Colors.blue,
              valueColor: AlwaysStoppedAnimation(Colors.red),
            ),
          ),
          Positioned(
            left: 10,
            top: 340,
            width: 300,
            height: 100,

            child: Slider(
              min: 0,
              max: 100,
              value: sliderValue,
              divisions: 1000, // 这个设了后，才会有小水滴数值显示
              label: 'v: $sliderValue',
              inactiveColor: Colors.black12,
              activeColor: Colors.red,
              onChanged: (value){
                setState((){
                  sliderValue = value.roundToDouble(); // 四舍五入后，以浮点形式表示
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
