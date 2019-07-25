
### SingleChildScrollView

如果只是拖文字，则最简单的就是 加一个column
```

class _ScrollViewDemoState extends State<ScrollViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scroll view demo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: List.generate(100, (index) => Text('index $index')),
        ),
      ),
    );
  }
}


```

如果只是单独用这个，里面加一个column，则超过高度后，不会自动滚动
但是，设置 crossAxisAlignment: CrossAxisAlignment.stretch,
就能在整行的每个地方拖动滚了

```
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: List.generate(100, (index) {
            // 为了让子行能够在作何地方都能用手指滚动，所以加上Row
            // Row中若只有一个Text，则只有文字的地方才能拖
            // 加上一个Expanded，就能扩充至整行，空白地方也能拖了
            return Row(
              children: <Widget>[
                Expanded(
                  child: Text('index $index'),
                ),
              ],
            );
          },),
        ),
      ),

```

以上是没有滚动条的，可用以下加入：
```
class _ScrollViewDemoState extends State<ScrollViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scroll view demo'),
      ),
      body: Scrollbar(
        child: Center(

          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: List.generate(100, (index) => Text('index $index')),
            ),
          ),
        ),
      ),
    );
  }
}

```
