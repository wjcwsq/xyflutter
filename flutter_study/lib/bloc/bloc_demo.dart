import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

//
// example:
// https://blog.csdn.net/mint_sprite/article/details/89708863
//
class BlocDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //var controller = StreamController<String>();
    //var streamObservable = Observable(controller.stream);

    //
    // 教程：https://juejin.im/post/5bcea438e51d4536c65d2232
    // create Observable from stream

    var obs = Observable(Stream.fromIterable([1, 2, 3, 4, 5, 6]));
    print('type:${obs.runtimeType}'); // Observable<int>
    obs.listen(print); // 一行一个字

    // print 是按顺序来的，但listen中的print却是异步的
    print('----------future');
    var obs1 = Observable.fromFuture(Future.value('Hello'));
    print('type:${obs1.runtimeType}'); // Observable<String>
    obs1.listen(print); // Hello

    var obs2 = Observable.fromIterable([1, 2, 3, 4, 5]);
    obs2.listen(print);

    var obs3 =
        Observable.fromIterable([1, 2, 3, 4, 5]).interval(Duration(seconds: 1));
    obs3.listen(print); // 一秒一行，输出每个数字

    var obs4 = Observable.fromIterable([1, 2, 3, 4, 5])
        .map((item) => ++item); // 这里要换成item++，就没效果了
    obs4.listen(print); // 2,3,4,5,6

    // 扩展为2个流
    var obs5 = Observable.fromIterable([1, 2, 3, 4, 5])
        .expand((item) => [item, item.toDouble()]);
    obs5.listen(print); // 1,1.0,2,2.0,....

    // 合并成一个流
    var obs6 = Observable.merge([
      Stream.fromIterable([1, 2, 3]),
      Stream.fromIterable([4, 5, 6]),
      Stream.fromIterable([7, 8, 9]),
    ]);
    obs6.listen(print); // 1,4,7,2,5,8,3,6,9

    // 按顺序执行流
    var obs7 = Observable.concat([
      Stream.fromIterable([1, 2, 3]),
      Stream.fromIterable([4, 5, 6]),
      Stream.fromIterable([7, 8, 9]),
    ]);
    obs7.listen(print); // 1,2,3,4,5,6,7,8,9

    // 检查每个item
    var obs8 = Observable.fromIterable([
      1,
      2,
      3,
      4,
      5,
    ]);
    obs8.every((item) => item < 10).asObservable().listen(print); // true

    var obs9 = Observable.fromIterable([1, 2, 3, 4, 5]).asBroadcastStream();
    obs9.interval(Duration(seconds: 1)).map((item) => 10 * item).listen(print);
    obs9.listen(print); // 先打印1，2，3，4，5，再1秒间隔打出10,20,30,40,50

    // 缓存最后一次事件的广播流控制器
    var subject = BehaviorSubject<int>();
    subject.add(1);
    subject.add(2);
    subject.add(3);
    subject.stream.listen(print);
    subject.stream.listen(print);
    subject.stream.listen(print);
    // 输出三行3

    var subject2 = BehaviorSubject<int>.seeded(1);
    subject2.stream.listen(print);
    subject2.stream.listen(print);
    subject2.stream.listen(print);
    // 输出三行1，初始值，会被当作最后一次的value发送给所有收听者

    // ReplaySubject 默认缓存所有值
    var subject3 = ReplaySubject<int>();
    subject3.add(1);
    subject3.add(2);
    subject3.add(3);
    subject3.stream.listen(print);
    subject3.stream.listen(print);
    subject3.stream.listen(print);
    // 1,1,1,2,2,2,3,3,3

    // ReplaySubject 默认缓存所有值, maxSize控制缓存数量
    var subject4 = ReplaySubject<int>(maxSize: 2);
    subject4.add(1);
    subject4.add(2);
    subject4.add(3);
    subject4.stream.listen(print);
    subject4.stream.listen(print);
    subject4.stream.listen(print);
    // 2,2,2,3,3,3

    return _BlocDemoState();
  }
}

class _BlocDemoState extends State<BlocDemo> {
  StreamSubscription _streamSubscription;
  StreamController<String> _streamDemo;
  StreamSink<String> _streamSink;

  void onData(String data) => print('onData $data');
  void onData2(String data) => print('onData2 $data');

  void onError(error) => print('error $error');
  void onDone() => print('done ');

  void _pauseStream() {
    print('pause stream');
    _streamSubscription.pause();
  }

  void _resumeStream() {
    print('resule stream');
    _streamSubscription.resume();
  }

  void _cancelStream() {
    print('cancel stream');
    _streamSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();

    print('create stream');
    // 订阅模式，合名构造
    _streamDemo = StreamController.broadcast();
    _streamSink = _streamDemo.sink;
    print('start listening stream');
    _streamSubscription =
        _streamDemo.stream.listen(onData, onError: onError, onDone: onDone);

    _streamDemo.stream.listen(onData2, onError: onError, onDone: onDone);
    print('initialize complete');
  }

  @override
  void dispose() {
    _streamDemo.close();
    super.dispose();
  }

  Future<String> fetchDate() async {
    await Future.delayed(Duration(seconds: 6));
    //throw 44; //测试异常
    print('fetchData return');
    return 'hello~';
  }

  // add一次，会调用用一次onData, onData2
  // 如果cancel一个，则只会调用onDats2
  void _addAataToStream() async {
    print('_addAataToStream');
    String data = await fetchDate();
    print('_addAataToStream after fetchData');

    _streamSink.add(data);
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('bloc demo'),
        elevation: 0,
      ),
      // use liseview to automatically scroll the contenet
      // but the child will be fill all the row
      // so, here place a wiget row
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Pause'),
                onPressed: _pauseStream,
              ),
              RaisedButton(
                child: Text('resume'),
                onPressed: _resumeStream,
              ),
              RaisedButton(
                child: Text('cancel'),
                onPressed: _cancelStream,
              ),
              RaisedButton(
                child: Text('add'),
                onPressed: _addAataToStream,
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              // 这个比较高级，build 并没有重新调用，但StreamBuilder.builder却调用了，内容传进来了
              StreamBuilder(
                stream: _streamDemo.stream,
                builder: (context, snapshot) {
                  print('StreamBuilder builder');
                  return Text('${snapshot.data}');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BlocDemoState1 extends State<BlocDemo> {
  StreamSubscription _streamSubscription;

  void onData(String data) => print('$data');
  void onError(error) => print('error $error');
  void onDone() => print('done ');

  void _pauseStream() {
    print('pause stream');
    _streamSubscription.pause();
  }

  void _resumeStream() {
    print('resule stream');
    _streamSubscription.resume();
  }

  void _cancelStream() {
    print('cancel stream');
    _streamSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();

    print('create stream');
    Stream<String> _streamDemo = Stream.fromFuture(fetchDate());
    print('start listening stream');
    _streamSubscription =
        _streamDemo.listen(onData, onError: onError, onDone: onDone);
  }

  Future<String> fetchDate() async {
    await Future.delayed(Duration(seconds: 6));
    //throw 44; //测试异常
    return 'hello~';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('bloc demo'),
        elevation: 0,
      ),
      // use liseview to automatically scroll the contenet
      // but the child will be fill all the row
      // so, here place a wiget row
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Pause'),
                onPressed: _pauseStream,
              ),
              RaisedButton(
                child: Text('resume'),
                onPressed: _resumeStream,
              ),
              RaisedButton(
                child: Text('cancel'),
                onPressed: _cancelStream,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
