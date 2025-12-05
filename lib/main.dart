import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/bloc/bloc_actions.dart';
import 'package:state_management/bloc/person.dart';
import 'package:state_management/bloc/persons_bloc.dart';

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
      home: BlocProvider(
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

const List<String> names = ['Foo', 'Bar'];

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

extension SubScript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
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
          TextButton(onPressed: () {
            context.read<PersonBloc>().add(
              const LoadPersonAction(url: person1Url, loader: getPersons));
          }, child: Text('Load Text #1')),
          TextButton(onPressed: () {
            context.read<PersonBloc>().add(
              const LoadPersonAction(url: person2Url, loader: getPersons));
          }, child: const Text("Load Text #2")),
        ],
      ),
    );
  } 
}

//1.49
