import 'package:flutter/material.dart';
import 'asset.dart';


class SearchBarDemo extends StatefulWidget{

  @override
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo>{

  @override
  Widget build(BuildContext context){
    return Scaffold( //
      appBar: AppBar(
        title: Text('SearchBardemo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              print('search');
              // showSearch 是个顶级方法，调用 SearchDelegate<T> 显示搜索窗口
              showSearch(context: context, delegate: SearchBarDelegate(), );
            },

          ),
        ],
      ),
      // 这里不加body，也能正常显示
      body: Center(
        child: Text('search bar demo'),
      ),
    );
  }
}

// 目前没有实现，点推荐项后，自动完成搜索
// 回车完成搜索
class SearchBarDelegate extends SearchDelegate<String>{

  // 输入框右侧，构建一个叉，点后清空输入内容
  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),

    ];
  }

  //
  // 左侧的返回按钮，动画，关闭窗口
  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
      icon: AnimatedIcon(
        // 这是左侧返回的图标样式
        icon: AnimatedIcons.menu_arrow,
        //icon: AnimatedIcons.home_menu,
        progress: transitionAnimation,
      ),
      onPressed:() {
          print('close search');
          close(context, null);
        },
    );
  }

  // 搜到内容后，显示在页面中
  // ctrl +   厅厅厅厅厅how are youds对方的的xxxx
  @override
  Widget buildResults(BuildContext context){
    return Container(
      width: 100,
      height:100,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  // 根据输入内容，自动显示推荐列表
  @override
  Widget buildSuggestions(BuildContext context){
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder:(context, index) => ListTile(
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ]
          ),
        ),
      ),
    );
  }


}
