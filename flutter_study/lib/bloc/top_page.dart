

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/bloc/blocs/bloc_provider.dart';
import 'package:flutter_study/bloc/under_page.dart';

class TopPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('top page'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.stream,
          initialData: bloc.value,
          builder: (context, AsyncSnapshot<int> snapshot) => Text(
            'clicked ${snapshot.data}',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UnderPage()));
        },
      ),
    );
  }


}