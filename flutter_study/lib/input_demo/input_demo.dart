import 'package:flutter/material.dart';

// 官网说明
// https://flutterchina.club/text-input/
//
class InputDemo extends StatefulWidget {
  @override
  _InputDemoState createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('input demo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
            // 水平方向，默认是居中，这里设置为左对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '请输入内容',
                style:
                    TextStyle(fontSize: 15.5, height: 1.2, color: Colors.blue),
                textAlign: TextAlign.start,
              ),
              TextField(
                maxLength: 20,
                onChanged: (input) => print('onChanged: $input'),
                onSubmitted: (input) => print('onSubmitted: $input'),
              ),
              Divider(),
              Text('复杂一点的'),
              TextField(
                //obscureText: true, // 密码显示
                keyboardType: TextInputType.number,
                onChanged: (input) => print('onchange: $input'),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  // 获取焦点后，变色，且labelText会移动
                  icon: Icon(Icons.directions_bike),
                  labelText: '请输入你的姓名',
                  helperText: '请输入你的真实姓名',
                  hintText: 'hint text', // 为空时显示的灰色背景
                ),
                // 自动弹出输入键盘
                autofocus: true,
              ),
              Divider(),
              // 点击 显示，隐藏密码
              TextField(
                obscureText: _obscure,
                autofocus: true,
                maxLength: 20,
                decoration: InputDecoration(
                  labelText: '请输入密码',
                  hintText: 'your password',
                  helperText: '?您之前设置的密码，若无，则不用填',
                  icon: Icon(
                    Icons.lock,
                    color: Colors.red,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _obscure ? Colors.grey : Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  ),
                ),
                onChanged: (input) {
                  print('onChanged: $input');
                },
              ),
            ]),
      ),
    );
  }
}
