import 'package:flutter/material.dart';

import 'bean/ItemInfo.dart';
import 'listitems/home_list_item.dart';

class IndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IndicatorDemoState();
  }
}

class _IndicatorDemoState extends State<IndicatorDemo> {

  List<ItemInfo> list = [];
  // 目前这个没用
  int page = 0;
  // 是否正在请求数据
  bool isLoading = false;
  // 是否显示底部加载中提示
  bool showMore = false;
  // 是否显示进入页面时的圆形进度条，默认值是false，会在首次加载时显示widget，加载完后置为true
  bool offState = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    print('initState 初始化');

    scrollController.addListener((){
      //print('scroll listener: ${scrollController.position.pixels} ${scrollController.position.maxScrollExtent}');
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        print('滑动到了最底部，像素值：${scrollController.position.pixels}');

        // 上推时，刷新一下，最后加上三个字：加载中
        setState(() {
          showMore = true;
        });

        // 刷新完了界面，就查更多数据
        getMoreData();
      }
    });

    getInitListData();

  }

  @override
  void dispose(){
    // 停止滑动监听
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('refresh indicator'),
      ),
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            child: ListView.builder(
              controller: scrollController,
              itemCount: list.length + 1,
              itemBuilder: choiceItemWidget,
            ),
            onRefresh: _onRefresh, // 下拉ListView时，会自动触发，只用在其中加载数据就行了
          ),
          Offstage(
            offstage: offState, // true不显示，若是第一次加载数据，则显示这个居中的动画圆，加载完后就不再显示了
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  // 创建ListView中的每一项，每次刷新时都会建一遍
  Widget choiceItemWidget(BuildContext context, int position){
    //print('choiceItemWidget $position');
    // 若是本职工作，则创建此行
    if(position < list.length) {
      return HomeListItem(position, list[position], (position) {
        print('点击了第$position条');
      });
    }

//    }else if(showMore){
//      return showMoreLoadingWidget();
//    }else{
//      return null;
//    }
    // showMore 是在上推的时候，置 true 的
    // list的下一个，是三个字 加载中
    if(showMore) {
      return showMoreLoadingWidget();
    }

    return null;
  }

  // 从下往上加载的时候底部显示这个
  // 底部的提示控件：加载中
  Widget showMoreLoadingWidget(){
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('加载中...', style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }

  // 模拟进入页面时获取数据，只在首次进入页面时调用
  // 阻塞3秒，然后加上20条数据
  void getInitListData() async{
    print('getListData: isLoading: $isLoading');
    if(isLoading){
      return;
    }

    // 启动后，会首先调用 initState() 所以，这里就不用再刷新了
//    setState(() {
//      isLoading = true;
//    });

    // 置值，禁止后面的各种刷新
    isLoading = true;

    // 等3秒后，关闭CircularProgressIndicator，产生20条数据，并刷新列表
    await Future.delayed(Duration(seconds: 3), (){
      setState(() {
        isLoading = false;
        offState = true; // 取到了数据，所以CircularProgressIndicator 可以隐藏了
        list = List.generate(20, (i){
          return ItemInfo(title: 'ListView的一条数据：$i');
        });
      });
    });
  }

  // 在上推时，刷完主界面，会调用此函数
  // 模拟 到底部加载更多数据
  void getMoreData() async{
    print('getMoreData');
    // 这个判断必须，在上滑过程中进入async时，依然可以多次调用，奇怪了
    if(isLoading){
      return;
    }

    // 上推事件中，已经显示 加载中 这三个字了，这里不再需要重复刷新了
    isLoading = true;
//    setState(() {
//      isLoading = true;
//      page++;
//    });

    print('上拉刷新开始：page = $page');
    // 等3秒，在此期间，底部会出现 加载中 这三个字
    await Future.delayed(Duration(seconds: 3),(){
      setState(() {
        isLoading = false; // 刷新完毕，则改变状态
        showMore = false; // 不再显示 加载中 三个字
        list.addAll(List.generate(3, (i){
          bottomAddedCount++;
          return  ItemInfo(title: '上拉向ListView中添加一行数据：$bottomAddedCount');
        }));
      });
      print('上拉刷新结束， page = $page');
    });
  }

  // 下拉时，出现Indicator圆圈，持续时间 由 此函数运行时间决定
  // 模拟下拉刷新
  Future<void> _onRefresh() async{
    print('_onRefresh loading: $isLoading');
    // 这行代码，是不会执行的。因为_onRefresh()执行结束前时，再次下拉，是不会调用此函数的
    // 但上推的异步执行却可以多次调用，这个是啥原理？难道人家优化过了？
    // 重复下拉忽略
    if(isLoading){
      return;
    }


    // 这行代码有什么用？为什么要刷新界面
//    setState(() {
//      isLoading = true;
//      page = 0;
//    });


    print('下拉刷新开始：page = $page');

    await Future.delayed(Duration(seconds: 3), (){
      setState(() {
        isLoading = false;

        List<ItemInfo> tempList = List.generate(3, (i){
          topAddedCount++;
          return ItemInfo(title: '下拉添加ListView的一条数据：  $topAddedCount');
        });
        //tempList.addAll(list);
        tempList.forEach((item){
          list.insert(0, item);
        });
        //list = tempList;
        print('下拉刷新结束: page = $page');
      });
    });

  }
  int topAddedCount = 0;
  int bottomAddedCount = 0;
}
