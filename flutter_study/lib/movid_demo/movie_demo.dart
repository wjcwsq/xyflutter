import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'utils/router.dart' as router;

class MovieDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '电影',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      // 这里只需要提供此回调即可，在启动时，会自动调用 ／ 这个路由
      // 因此 home, routes, initialRoute 都不必再提供了
      // 此回调，是在 routes 中查不到的时候才调用的
      onGenerateRoute: router.generateRoute,
      //initialRoute: '/',
      //home: Home(),
    );
  }

}