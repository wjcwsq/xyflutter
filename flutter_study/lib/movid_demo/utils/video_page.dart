
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget{
  final String url;
  VideoPage({Key key, this.url}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoPageState();
  }


}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('video'),
      ),
      body: Center(
        child: Text('video page'),
      ),
    );
  }
}