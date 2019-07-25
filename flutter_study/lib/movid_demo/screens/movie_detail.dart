import 'package:flutter/material.dart';
import 'package:flutter_study/movid_demo/widgets/actors.dart';
import 'package:flutter_study/movid_demo/widgets/comments.dart';
import 'package:flutter_study/movid_demo/widgets/photos.dart';
import 'package:flutter_study/movid_demo/widgets/rating.dart';
import '../utils/api.dart' as api;
import 'package:flutter_study/movid_demo/widgets/movie_detail_top.dart';

class MovieDetail extends StatefulWidget {
  final int id;
  MovieDetail({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieDetailState();
  }
}

class _MovieDetailState extends State<MovieDetail> {
  // 这里必须先赋一下值，不然在获取数据之前会先刷一下，那时此值为null，会调用出错
  // 当然，如果为空的话，也是可以判断的，
  // 不过这是大神的操作，以后再研究原理
  var _data = {};

  @override
  void initState() {
    super.initState();

    print('detail: initState');
    init();
  }

  init() async {
    var res = await api.getMovieDetail(widget.id);
    setState(() {
      _data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('movie detail build: $_data');

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('detail'),
      ),
      // 如果没有数据，就出现加载页面，有数据，再刷新有数据页
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator(), )
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  MovieDetailTop( data: _data,),
                  Rating(rating: _data['rating'], count: _data['ratings_count'],),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(_data['summary']),
                  ),
                  Actors(directors: _data['directors'], casts: _data['casts'],),
                  Photos(photos: _data['photos']),
                  Comments(comments: _data['popular_comments']),
                ],
              ),
            ),
    );
  }
}
