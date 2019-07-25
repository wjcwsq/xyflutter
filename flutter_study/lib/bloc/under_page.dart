
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/bloc/blocs/bloc_provider.dart';

class UnderPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text('under page'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: bloc.stream,
          initialData: bloc.value,
          builder: (context, snapshot) => Text(
            'under clicked: ${snapshot.data}',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> bloc.increment(),
        child: Icon(Icons.add),
      ),
    );
  }


}