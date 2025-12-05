import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  BlocProvider(
  create: (context) => PersonBloc(),
  child: MyHomePage(),
),
    );
  }
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() => emit(names.getRandomElement());
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction extends LoadAction {
  final PersonUrl url;

  const LoadPersonAction({required this.url}) : super();
}

enum PersonUrl { persons1, persons2 }


const List<String> names = ['Foo', 'Bar'];


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
class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});

  Person.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      age = json['age'] as int;
}

Future<Iterable<Person>>getPersons(String url)=> HttpClient()
    .getUrl(Uri.parse(url))
    .then((req)=> req.close())
    .then((resp)=> resp.transform(utf8.decoder).join())
    .then((str)=>json.decode(str) as List<dynamic>)
    .then((list)=> list.map((e)=> Person.fromJson(e)));

@immutable
class FetchResults {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;
  FetchResults({required this.persons,
  required this.isRetrievedFromCache});



  @override
  String toString()=> "Fetch result is (isCache = ${isRetrievedFromCache}, persons =${persons}";
}

extension SubScript<T> on Iterable<T> {
  T? operator [](int index)=> length > index ? elementAt(index): null;
}

class PersonBloc extends Bloc<LoadAction, FetchResults?>{
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonBloc(): super(null){
    on<LoadPersonAction>((event, emit)async{
     final url = event.url;
     if(_cache.containsKey(url)){
     //   we have the value in the cache
        final cachedPersons = _cache[url]!;
        final result = FetchResults(persons: cachedPersons, isRetrievedFromCache: true);
        emit(result);
     }else {
       final persons = await getPersons(url.urlString);
       _cache[url]=  persons;
       final result = FetchResults(persons: persons, isRetrievedFromCache: false);
       emit(result);
     }
    });

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    late final Bloc myBloc;
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: (){}  , child: Text('Load Text #1')),
          TextButton(onPressed: (){}, child: const Text("Load Text #2"))
          
        ],
      ),
    );
  }
}
