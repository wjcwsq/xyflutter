
### alignment
默认是居中的
```
Alignment center = Alignment(0.0, 0.0);
```

以下在body中直接用，会铺满空间，且左上角（默认是居中的）
```
      body: Align(
        alignment: Alignment.topLeft,
        child: Text('hello'),
      ),
```
下方居中
```
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Text('hello'),
      ),
```
以下设置了widthFactor=1 则Algin的宽度和子控件一样大小，高度是整屏
而Align直接在body内，是从左上角定位的（100，height)
因此，此时，将靠左上角显示，相当于 Alienment.leftTop
若 widthFactor = 2，则Align(200, height)，子将在右上角
```
      body: Align(
        alignment: Alignment.topRight,
        widthFactor: 1,
        heightFactor: null,
        child: Container(
          width: 100,
          height: 50,
          color: Colors.red,
        ),
      ),
```
以下 Align 是 300， 150， 子居右下角，相当于左上角定位的(200, 100)
```
      body: Align(
        alignment: Alignment.bottomRight,
        widthFactor: 3,
        heightFactor: 3,
        child: Container(
          width: 100,
          height: 50,
          color: Colors.red,
        ),
      ),
```
