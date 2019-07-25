
import 'package:rxdart/rxdart.dart';

class CountBloc{
  int _count = 0;
  var _subject = BehaviorSubject<int>();

  Stream<int> get stream => _subject.stream;
  int get value => _count;

  void increment() => _subject.add((++_count));
  void dispose(){

    _subject.close();
  }

}