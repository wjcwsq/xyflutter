

import 'package:flutter/cupertino.dart';
import 'package:flutter_study/bloc/blocs/count_bloc.dart';

class BlocProvider extends InheritedWidget{
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  final CountBloc bloc = CountBloc();
  BlocProvider({Key  key, Widget child}): super(key: key, child: child);

  static CountBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
}