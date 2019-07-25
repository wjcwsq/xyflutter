
import 'package:flutter/material.dart';
import 'package:flutter_study/movid_demo/screens/home.dart';
import 'package:flutter_study/movid_demo/screens/movie_detail.dart';
import 'package:flutter_study/movid_demo/utils/video_page.dart';



Route generateRoute(RouteSettings settings){
  print('generateRoute: ${settings.name}');

  // 主页时，会传参 /, 这里放在 default 中处理了
  switch(settings.name){
    //case '/':
    //  return MaterialPageRoute(builder: (context) => Home());
    // 详情页，传入一个id
    case 'detail':
      return MaterialPageRoute(builder: (context)=>MovieDetail(id: settings.arguments));

    // 视频播放页，要传一个url
    case 'video':
      return MaterialPageRoute(builder: (context) => VideoPage(url: settings.arguments)  );

      // 其他情况下，都返回主页面
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }

}