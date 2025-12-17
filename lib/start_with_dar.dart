import 'package:async/async.dart'show StreamGroup;

extension StartWith<T> on Stream<T>{
  Stream<T> startWith(T value)=> StreamGroup.me
}
6.16