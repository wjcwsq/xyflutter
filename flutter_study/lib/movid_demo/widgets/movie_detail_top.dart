import 'package:flutter/material.dart';

class MovieDetailTop extends StatelessWidget {
  final data;

  MovieDetailTop({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('data: $data');

    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      height: 130,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Stack(
              children: <Widget>[
                Image.network(
                  data['images']['small'],
                  width: 100,
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data['title']),
              Text(data['aka'][0]),
              Text(data['genres'].join(',')),
              Text('中国大陆/' +
                  data['mainland_pubdate'] +
                  '/' +
                  data['durations'][0]),
              //Text(data['wish_count'].toString() + '人想看'),
              // 这玩意这么费事，何不直接用一个Text ?
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: data['wish_count'].toString(),
                    ),
                    TextSpan(text: '人想看'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
