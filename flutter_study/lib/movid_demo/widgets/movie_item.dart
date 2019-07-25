import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final Map<String, dynamic> data;
  MovieItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'detail',
            arguments: int.parse(data['id']));
      },
      child: Container(
        height: 130,
        //width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Image.network(
              data['images']['small'],
              width: 100,
            ),
            // 在column外加一层expanded，这样就不会出现溢出提示
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('豆瓣评分：' + data['rating']['average'].toString()),
                  Text('主演：' +
                      data['directors']
                          .map(
                            (item) => item['name'],
                          )
                          .join(' ,')),
                  Text(
                    '时长 ：' + data['durations'].join(','),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('类型：' + data['genres'].join(',')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
