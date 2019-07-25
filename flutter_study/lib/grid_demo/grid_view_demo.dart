import 'package:flutter/material.dart';
//
// 示例：
// https://blog.csdn.net/duo_shine/article/details/81261112
//
class GridViewDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GridViewDemoState();
  }
}

class _GridViewDemoState extends State<GridViewDemo>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('grid view demo'),
      ),
      body: Center(
        child: _buildGrid3(),
      ),
    );
  }

  Widget _buildGrid1(){
    return GridView.extent(
      // 每个图片的宽度，总宽除此值，有余，则列数加1，不余，则刚好几列
      maxCrossAxisExtent: 300,
      padding: EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: List.generate(30, (index) => Container(
        child: Image.network('https://c-ssl.duitang.com/uploads/item/201511/06/20151106220848_Nh4tj.jpeg'),
      )),
    );
  }

  Widget _buildGrid2(){
    return GridView.count(
      crossAxisCount: 3, // 每行显示几个
      padding: EdgeInsets.all(4),
      mainAxisSpacing: 5, // 垂直间隔
      crossAxisSpacing: 10, // 水平间隔
      children: List.generate(30, (index) => Container(
        //child: Image.network('https://c-ssl.duitang.com/uploads/item/201511/06/20151106220848_Nh4tj.jpeg'),
        child: Image.network('https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3757458942,1250865407&fm=26&gp=0.jpg'),
      )),
    );
  }

  // 大在大在大在大在大在
  Widget _buildGrid3(){
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            children: List.generate(30, (index) => Container(
              child: Image.network('https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3757458942,1250865407&fm=26&gp=0.jpg'),
            ),),
          ),
        ),
      ],
    );
  }

}


