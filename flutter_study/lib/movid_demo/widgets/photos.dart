import 'package:flutter/material.dart';

class Photos extends StatelessWidget {
  final List photos;
  Photos({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //var x = MediaQuery.of(context).size;
    //print(x);

    return Column(
      children: <Widget>[
        ListTile(
          title: Text('剧照'),
          trailing: Text('全部剧照>'),
        ),
        Container(
            height: 100,
            // 水平ListView上面必须要有高度，宽度不用设
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(photos.length, (index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Image.network(
                    photos[index]['thumb'],
                    fit: BoxFit.cover,
                  ),
                );
              }),
            )),
      ],
    );
  }
}
