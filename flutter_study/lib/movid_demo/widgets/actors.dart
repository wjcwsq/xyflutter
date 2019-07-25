import 'package:flutter/material.dart';

class Actors extends StatelessWidget{

  List casts;
  // List<dynamic>
  // 子项 ：Map<String, dynamic>
  List directors;
  Actors({Key key, this.directors, this.casts}):super(key: key);



  @override
  Widget build(BuildContext context) {

    print('------------');

    // List<dynamic>
    // 子项：MappedListIterable<dynamic, dynamic>
//    List actorsList = [
//      directors.map((item){
//        item['director'] = true;
//        return item;
//      }),
//      casts.map((item){
//        item['director'] = false;
//        return item;
//      }),
//    ];

    List actorsList = directors.map((item){
      item['director'] = true;
      return item;
    }).toList();
    var castsNew = casts.map((item){
      item['director'] = false;
      return item;
    }).toList();
    actorsList.addAll(castsNew);

    Widget actorItem(image, name, action){
      return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                image,
                width: 100,
              ),
            ),
            Text(name),
            Text(action, style: TextStyle(fontSize: 12, color: Colors.grey),),
          ],
        ),
      );
    }


    return Column(

      children: <Widget>[
        ListTile(
          title: Text('演职人员'),
          trailing: Text('全部>'),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actorsList.length,
            itemBuilder: (context, index){
              print('count: $index len:${actorsList.length}');
              print(actorsList);
              var actor = actorsList[index];
              print(actor);
              return actorItem(
                actor['avatars']['small'],
                actor['name'],
                actor['director'] ? '导演' : '主演',
              );
            },
          ),
        ),
      ],
    );
  }



}