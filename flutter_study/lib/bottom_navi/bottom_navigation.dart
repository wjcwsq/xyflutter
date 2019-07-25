import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'email_screen.dart';
import 'pages_screen.dart';
import 'alipay_screen.dart';


class BottomNavigationWidget extends StatefulWidget {
  
  @override
  _BottomNavigationWidgetState createState() {
    // TODO: implement createState
    return _BottomNavigationWidgetState();
  }

}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.blue;

  // 这个值必须初始化，不然就是个null，在build时，调用list[_currentIndex]出错
  int _currentIndex = 0;
  // 可以这样来初始化，这样就无需写initState()函数了
  //final List<Widget> list = [HomeScreen(), EmailScreen(), PagesScreen(), AlipayScreen(),];

  List<Widget> list;

  @override
  void initState() {
    // TODO: implement initState

    list = [HomeScreen(), EmailScreen(), PagesScreen(), AlipayScreen(),];
//    list..add(HomeScreen())
//    ..add(EmailScreen())
//    ..add(PagesScreen())
//    ..add(AlipayScreen());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 这里只是做一个框架，只显示最下方的按钮而已。而每个页面都有了自己的appbar
      // 所以，这里不能再显示，否则就会显示2个appbar了
//      appBar: AppBar(
//        title: Text('底部导航'),
//      ),
      // 每次创建的时候，选一个页面显示，具有appbar
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 这个值，不设时，在<=3时，为Fixed,  否则是Shifting
        // fixed: 一直显示文字
        // shifting: 只有选中的项才显示文字
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'home',
              style: TextStyle(
                color: _bottomNavigationColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.email,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'email',
              style: TextStyle(
                color: _bottomNavigationColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages, color: _bottomNavigationColor,),
            title: Text(
              'pages',
              style: TextStyle(color:_bottomNavigationColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplay,  color: _bottomNavigationColor,),
            title: Text(
              'airplay',
              style: TextStyle(color:_bottomNavigationColor),
            ),
          ),
        ],
        onTap: (index){
          print('bottom click: $index');
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
