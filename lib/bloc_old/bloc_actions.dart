import 'package:flutter/cupertino.dart';
import 'package:state_management/bloc_old/person.dart';

import 'package:state_management/main.dart';

enum PersonUrl { persons1, persons2 }
const person1Url = "https://127.0.0.1:5500/api/persons1.json";
const person2Url = "https://127.0.0.1:5500/api/persons2.json";

typedef  PersonsLoader =  Future<Iterable<Person>> Function (String url);

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.persons1:
        return "https://127.0.0.1:5500/api/persons1.json";
      case PersonUrl.persons2:
        return "https://127.0.0.1:5500/api/persons2.json";
    }
  }
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction extends LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonAction({required this.url, required this.loader}): super();
}