
import 'package:flutter/material.dart';
import 'package:flutter_study/movid_demo/widgets/movie_item.dart';
import '../utils/api.dart' as api;

class Hot extends StatefulWidget{
  final bool history;
  Hot({Key key, this.history = false}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotState();
  }

}

// AutomaticKeepAliveClientMixin 加上这个，2个标签页只会创建一次
// wantKeepAlive = true 必须设这个值
// 不然的话，每次切换页面，都要重建下页面，明显不好
class _HotState extends State<Hot> with AutomaticKeepAliveClientMixin{

  List _movieList = [];
  ScrollController _scrollController = ScrollController();
  // 下次请求时的索引值
  int start = 0;
  // 列表中一共存有多少个数据了
  int total = 0;

  @override
  void initState(){
    super.initState();

    // 滚动到最下方时，要查询10条
    _scrollController.addListener((){
      if(_scrollController.position.maxScrollExtent == _scrollController.position.pixels){
        print('start get more');
        getMore();
      }
    });

    // query 是异步函数，不会阻塞主线程，因此，启动时会完成initState()，并执行build()
    // 显示出 CircularProgressIndicator() 小圆圈，直到下个setState()被调用
    query(init: true);
    print('initState');
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

  // init = true，表示从0开始查10条，适用于下拉，或首次加载
  // 上推时，init = false
  query({init = false}) async{
    print('start: ${this.start}  total: ${this.total}');
    // 这里必须加await，不然会直接执行下一句，res 是 Future<dynamic>
    // 加了 await 之后，返回一个 map
    var res = await api.getMovieList(history: widget.history, start: init ? 0 : this.start);
    //print('res:${res.runtimeType}');
    var start = res['start'];
    var total = res['total'];
    // 返回的count字段，每次都是10，就算是最后只有4条，依然这样，这玩意有问题，所以不能用
    var count = res['count'];
    //print('queryed count: $count');
    var subjects = res['subjects'];
    //print('init: $init start:$start total:$total');

    // 下拉，说明是刷新，所有数据全部换一遍
    if(init){
      _movieList = subjects;
    }else{
      _movieList.addAll(subjects);
    }
    //print('length: ${_movieList.length}');

    // 数据查询完毕，更新界面
    setState(() {
      this.start = start + 10;
      this.total = total;
    });
  }

  getMore(){
    // 如果还有数据未加载，则加载之
    if(start < total) {
      // query 会异步执行查询(把 await 放入event队列中)，执行完了才调用 setState
      query(init: false);
    }
  }

  // 因为 _onRefresh 是下拉时的调用，查最新的第0条开始共10条数据，
  // 所以，这里传参：init: true
  Future<void> _onRefresh() async{
    print('_onRefresh');
    //await Future.delayed(Duration(seconds: 10));
    await query(init: true);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build hot ${_movieList.length}');

    //getMovieList(history: false, start:  0, count:10);

    // TODO: implement build
    return  _movieList.length == 0
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _movieList.length,
              itemBuilder: (context, index) => MovieItem(data: _movieList[index]),
            ),
        );
  }


}

