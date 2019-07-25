import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apikey = '0b2bdeda43b5688921839c8ecb20399b';

getMovieList({history = false, start = 0,count = 10}) async{
  var url =
      'https://api.douban.com/v2/movie/${history ? 'top250' : 'in_theaters'}?apikey=$apikey&city=%E5%8D%97%E4%BA%AC&start=$start&count=$count';
  //debugPrint('url: $url');

  var res = await http.get(url);
  if(res.statusCode == 200){
    //debugPrint(res.body);
    var ret = convert.jsonDecode(res.body);
    //debugPrint('type: ${ret.runtimeType}');
    //debugPrint('ret: $ret');
    return ret;
  }
  else{
    print('查询数据出错：${res.statusCode}');
  }

  print('return: ${res.body}');

}
// 参数不设类型，则是dynamic，可传任何类型
getMovieDetail(id) async{
  var url = 'https://api.douban.com/v2/movie/subject/$id?apikey=$apikey';
  print('url detail: $url');
  var res = await http.get(url);
  if(res.statusCode == 200){
    var ret = convert.jsonDecode(res.body);
    debugPrint('detail:$ret');
    return ret;
  }

  print('查询详情页出错：${res.statusCode}');
}